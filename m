Message-ID: <39B40FF1.AD58B2F5@ncal.verio.com>
Date: Mon, 04 Sep 2000 14:11:13 -0700
From: root <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Towards PowerMac SMP G4
Content-Type: multipart/mixed;
 boundary="------------2025AF628825A5CF110E8C57"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------2025AF628825A5CF110E8C57
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi all,

The attached patch to prom.c (against 2.2.18pre2-benh)
allows SMP kernels to boot on the SMP PowerMac G4.
But, of course, the second CPU isn't started. The
change is to breakout the CHRP SMP code in
prom_init() as a seperate function and to change
the CHRP test from the simple test for the presence
of a device_type property in the root node, which
the new-world Macs pass, to a test similar to that
in setup.c. This needs to be tested on an SMP CHRP.

I've noticed that /proc/device-tree/cpus has duplicate
directory names for the two CPU's of "PowerPC,G4", rather
then something like "PowerPC,G4@1" for the second.
Printing out the node name and full_name in finish_node()
shows them to have values of "PowerPC,G4" and
"/cpus/PowerPC,G4", respectively, for both CPU's.
Should this be fixed-up during the OF devtree copy
or in procfs?

Is anyone else working on these basic boot and devtree
init cleanups yet (fewer things todo when someone
figures out the startup sequences, or they show up
in Darwin)? If not, I'll continue looking into them
as I have time.

The only functional problem I've run into so
far are is that VT-switching doesn't work once
xpmac is started in anything other than 8-bit depth.
That may have been a result of trying to trim out some
of the fbcon chipset drivers from .config (I'll be
trying a clean build later), but perhaps this is a
general SMP kernel fbcon problem? There are several
messages like the following in dmesg after X startup:

   fbcon_setup: No support for fontwidth 8
   fbcon_setup: type 0 (aux 0, depth 32) not supported


Henry
--------------2025AF628825A5CF110E8C57
Content-Type: text/plain; charset=us-ascii;
 name="smp.1"
Content-Disposition: inline;
 filename="smp.1"
Content-Transfer-Encoding: 7bit

--- linux-pmac-benh/arch/ppc/kernel/prom.c	Thu Aug 31 08:54:10 2000
+++ linux-pmac-smp/arch/ppc/kernel/prom.c	Mon Sep  4 11:00:32 2000
@@ -325,6 +325,101 @@

 unsigned long smp_ibm_chrp_hack __initdata = 0;

+#ifdef CONFIG_SMP
+__init
+void
+prom_smp_init(void)
+{
+	/*
+	 * With CHRP SMP we need to use the OF to start the other
+	 * processors so we can't wait until smp_boot_cpus (the OF is
+	 * trashed by then) so we have to put the processors into
+	 * a holding pattern controlled by the kernel (not OF) before
+	 * we destroy the OF.
+	 *
+	 * This uses a chunk of high memory, puts some holding pattern
+	 * code there and sends the other processors off to there until
+	 * smp_boot_cpus tells them to do something.  We do that by using
+	 * physical address 0x0.  The holding pattern checks that address
+	 * until its cpu # is there, when it is that cpu jumps to
+	 * __secondary_start().  smp_boot_cpus() takes care of setting those
+	 * values.
+	 *
+	 * We also use physical address 0x4 here to tell when a cpu
+	 * is in its holding pattern code.
+	 *
+	 * -- Cort
+	 */
+	extern void __secondary_hold(void);
+	int cpu = 0, chrp = 0, i;
+	phandle node;
+	unsigned long offset = reloc_offset();
+	unsigned long mem = (unsigned long) RELOC(klimit) + offset;
+	char prop[16], *path;
+
+        /*
+	 * New-world SMP PowerMac has a device_type property at
+	 * at the root, so a more complete check for chrp is needed.
+	 */
+	prom_print(RELOC("Checking for CHRP SMP...\n"));
+	node = call_prom(RELOC("finddevice"), 1, 1, RELOC("/"));
+	if ( (int)call_prom(RELOC("getprop"), 4, 1, node,
+			    RELOC("device_type"), prop, sizeof(prop)) > 0) {
+		if (strncmp(prop,RELOC("chrp"),4) == 0)
+			chrp = 1;
+		else
+			if ((int)call_prom(RELOC("getprop"), 4, 1, node,
+					RELOC("model"), prop, sizeof(prop)) > 0)
+				if (strncmp(prop,RELOC("IBM"),3) == 0)
+					chrp = 1;
+	}
+	if ( chrp ) {
+		prom_print(RELOC("CHRP OF start processors...\n"));
+
+	 	/* copy the holding pattern code to someplace safe (8M) */
+		memcpy( (void *)(8<<20), RELOC(__secondary_hold), 0x100 );
+		for (i = 8<<20; i < ((8<<20)+0x100); i += 32)
+		{
+			asm volatile("dcbf 0,%0" : : "r" (i) : "memory");
+			asm volatile("icbi 0,%0" : : "r" (i) : "memory");
+		}
+
+		/* look for cpus */
+		for (node = 0; prom_next_node(&node);)
+		{
+			prop[0] = 0;
+			call_prom(RELOC("getprop"), 4, 1, node,
+					RELOC("device_type"),
+					prop, sizeof(prop));
+			if (strcmp(prop, RELOC("cpu")) != 0)
+				continue;
+			path = (char *) mem;
+			memset(path, 0, 256);
+			if ((int) call_prom(RELOC("package-to-path"), 3, 1,
+				    node, path, 255) < 0)
+				continue;
+			/* XXX: hack - don't start cpu 0, this cpu -- Cort */
+			if ( cpu++ == 0 )
+				continue;
+			RELOC(smp_ibm_chrp_hack) = 1;
+			prom_print(RELOC("starting cpu "));
+			prom_print(path);
+			*(unsigned long *)(0x4) = 0;
+			asm volatile("dcbf 0,%0": : "r" (0x4) : "memory");
+			call_prom(RELOC("start-cpu"), 3, 0, node, 8<<20, cpu-1);
+			for ( i = 0 ; (i < 10000) &&
+			      (*(ulong *)(0x4) == (ulong)0); i++ )
+				;
+			if (*(ulong *)(0x4) == (ulong)cpu-1 )
+				prom_print(RELOC("...ok\n"));
+			else
+				prom_print(RELOC("...failed\n"));
+	 	}
+	}
+}
+#endif
+
+
 /*
  * We enter here early on, when the Open Firmware prom is still
  * handling exceptions and the MMU hash table for us.
@@ -333,11 +428,6 @@
 unsigned long
 prom_init(int r3, int r4, prom_entry pp)
 {
-#ifdef CONFIG_SMP
-	int cpu = 0, i;
-	phandle node;
-	char type[16], *path;
-#endif
 	int chrp = 0;
 	unsigned long mem;
 	ihandle prom_rtas, prom_mmu, prom_op;
@@ -588,81 +678,7 @@
 #endif

 #ifdef CONFIG_SMP
-	/*
-	 * With CHRP SMP we need to use the OF to start the other
-	 * processors so we can't wait until smp_boot_cpus (the OF is
-	 * trashed by then) so we have to put the processors into
-	 * a holding pattern controlled by the kernel (not OF) before
-	 * we destroy the OF.
-	 *
-	 * This uses a chunk of high memory, puts some holding pattern
-	 * code there and sends the other processors off to there until
-	 * smp_boot_cpus tells them to do something.  We do that by using
-	 * physical address 0x0.  The holding pattern checks that address
-	 * until its cpu # is there, when it is that cpu jumps to
-	 * __secondary_start().  smp_boot_cpus() takes care of setting those
-	 * values.
-	 *
-	 * We also use physical address 0x4 here to tell when a cpu
-	 * is in its holding pattern code.
-	 *
-	 * -- Cort
-	 */
-	{
-		extern void __secondary_hold(void);
-		unsigned long i;
-		char type[16];
-
-
-		/*
-		 * XXX: hack to make sure we're chrp, assume that if we're
-		 *      chrp we have a device_type property -- Cort
-		 */
-		node = call_prom(RELOC("finddevice"), 1, 1, RELOC("/"));
-		if ( (int)call_prom(RELOC("getprop"), 4, 1, node,
-			    RELOC("device_type"),type, sizeof(type)) <= 0)
-			return phys;
-
-		/* copy the holding pattern code to someplace safe (8M) */
-		memcpy( (void *)(8<<20), RELOC(__secondary_hold), 0x100 );
-		for (i = 8<<20; i < ((8<<20)+0x100); i += 32)
-		{
-			asm volatile("dcbf 0,%0" : : "r" (i) : "memory");
-			asm volatile("icbi 0,%0" : : "r" (i) : "memory");
-		}
-	}
-
-	/* look for cpus */
-	for (node = 0; prom_next_node(&node);)
-	{
-		type[0] = 0;
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
-			  type, sizeof(type));
-		if (strcmp(type, RELOC("cpu")) != 0)
-			continue;
-		path = (char *) mem;
-		memset(path, 0, 256);
-		if ((int) call_prom(RELOC("package-to-path"), 3, 1,
-				    node, path, 255) < 0)
-			continue;
-		/* XXX: hack - don't start cpu 0, this cpu -- Cort */
-		if ( cpu++ == 0 )
-			continue;
-		RELOC(smp_ibm_chrp_hack) = 1;
-		prom_print(RELOC("starting cpu "));
-		prom_print(path);
-		*(unsigned long *)(0x4) = 0;
-		asm volatile("dcbf 0,%0": : "r" (0x4) : "memory");
-		call_prom(RELOC("start-cpu"), 3, 0, node, 8<<20, cpu-1);
-		for ( i = 0 ; (i < 10000) &&
-			      (*(ulong *)(0x4) == (ulong)0); i++ )
-			;
-		if (*(ulong *)(0x4) == (ulong)cpu-1 )
-			prom_print(RELOC("...ok\n"));
-		else
-			prom_print(RELOC("...failed\n"));
-	}
-
+	prom_smp_init();
 #endif
 	/* If OpenFirmware version >= 3, then use quiesce call */
 	if (RELOC(prom_version) >= 3) {



--------------2025AF628825A5CF110E8C57--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

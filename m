Return-Path: <jschopp@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 266DCB7CF2
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 07:41:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0EKa9C1029617
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 13:36:09 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o0EKfFV0218020
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 13:41:17 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0EKhJr1027033
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 13:43:19 -0700
Subject: [PATCH 2/2] Update ibm,client-architecture call field based on
	device tree
From: Joel Schopp <jschopp@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1263501508.4869.133.camel@jschopp-laptop>
References: <1263501508.4869.133.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jan 2010 14:41:14 -0600
Message-ID: <1263501674.4869.142.camel@jschopp-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the previous patch the client-architecture field for the number of
cores supported is set statically as high as is possible.  However, that
static setting could be too high if the system supports smt, resulting
in cpus assigned to Linux that are not booted.  This patch reads the
device tree (before it is unflattened) to determine the amount of smt.
It then dynamically updates the entires in the array with the proper
number of cores supported.  Tests show this correctly detecting SMT4 on
a Power7 and still booting all the supported cores on a large machine.


Signed-off-by:Joel Schopp<jschopp@austin.ibm.com> 
Index: linux-2.6.git/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.git/arch/powerpc/kernel/prom_init.c
@@ -141,6 +141,8 @@ typedef u32 cell_t;
 
 extern void __start(unsigned long r3, unsigned long r4, unsigned long r5);
 
+static int __init prom_smt_way(void);
+
 #ifdef CONFIG_PPC64
 extern int enter_prom(struct prom_args *args, unsigned long entry);
 #else
@@ -811,9 +813,17 @@ static void __init prom_send_capabilitie
 {
 	ihandle elfloader, root;
 	prom_arg_t ret;
+	u32 *cores;
 
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
+		/*
+		 * If you add to the struct, please be sure the 100 index
+		 * didn't change.  The BUILD_BUG_ON is a reminder.
+		 */
+		BUILD_BUG_ON(sizeof(ibm_architecture_vec) != 108);
+		cores = (u32 *) &ibm_architecture_vec[100];
+		*cores = (u32) (NR_CPUS/prom_smt_way());
 		/* try calling the ibm,client-architecture-support method */
 		prom_printf("Calling ibm,client-architecture-support...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
@@ -1031,6 +1041,45 @@ static void __init reserve_mem(u64 base,
 	RELOC(mem_reserve_cnt) = cnt + 1;
 }
 
+
+static int __init prom_smt_way(void)
+{
+	phandle node;
+	char type[64];
+	unsigned int plen;
+
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = 0;
+		prom_getprop(node, "device_type", type, sizeof(type));
+
+		if (type[0] == 0) {
+			/*
+			 * CHRP Longtrail machines have no device_type
+			 * on the memory node, so check the name instead...
+			 */
+			prom_getprop(node, "name", type, sizeof(type));
+		}
+		if (strcmp(type, RELOC("cpu")))
+			continue;
+
+		/*
+		 * There is an entry for each smt thread, each entry being
+		 * 4 bytes long.  All cpus should have the same number of
+		 * smt threads, so return after finding the first.
+		 */
+		plen = prom_getproplen(node, "ibm,ppc-interrupt-server#s");
+		prom_debug("smt %x\n", (unsigned long) plen);
+		if (plen >= 4)
+			return plen / 4;
+	}
+	/*
+	 * If things go wrong and we get here fallback to SMT1
+	 */
+	prom_debug("unable to determine smt from device tree, guessing smt1\n");
+	return 1;
+
+}
+
 /*
  * Initialize memory allocation mechanism, parse "memory" nodes and
  * obtain that way the top of memory and RMO to setup out local allocator

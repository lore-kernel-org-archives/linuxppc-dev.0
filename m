Return-Path: <bbeare@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 50745DE159
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 01:47:14 +1000 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m83FXPE1012528
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 08:33:25 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com
	[171.70.151.144])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m83FXP28011372
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 15:33:25 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] ppc: prep_setup (QEMU) does not correctly calculate
	decrementer value
Date: Wed, 3 Sep 2008 08:31:33 -0700
Message-ID: <E23056347B7FF446B369619CF6AAED9C06573599@xmb-sjc-218.amer.cisco.com>
From: "Bruce Beare (bbeare)" <bbeare@cisco.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The problem:
  The system clock under QEMU (PREP architecture) increments at four
  times the correct wall clock rate.

Comments:
  prep_calibrate_decr() hardcoded the divisor for the timebase to be
  '4'. This value should be read from the residual data that is provided
  by PREP at boot.  QEMU for example provides '1000' for this value.
  The other constants in the calculation have been adjusted to correct
  account for the scaling (x1000).

  If the residual data is not correct, the problem can also be
  worked around by specifying 'noresidual' on the command line. This
  specification forces the code to use the real time clock to calculate
  the correct decrementer value.

  Also provided is the inclusion of some additional debug data (printk)
  and the correction of an unrelated printk to include KERN_CRIT.
  These printk statements are only executed on a PREP machine boot.

Tested on:
  QEMU
  This fix has not been tested on real PREP hardware. If it doesn't
appear
  to work on such hardware, please return the kernel boot printk's to
  the patch author for further work.

Test:
  # Watch the ticks... they should be 1/second.=20
  while :
  do
    sleep 1
    echo -n .
  done

Note:
  This code is ppc (not powerpc) architure -- and is in neither -tip nor
  -mm tree.  The patch is directly useful for the 2.6.27 prepatch tree
  and for 2.6.26 and below.  It may be necessary to re-work the patch
  for the tip tree... once PREP is added to it.


Signed-off-by: Bruce Beare <bbeare@cisco.com>



--- linux-2.6.26/arch/ppc/platforms/prep_setup.orig.c	Wed Aug 13
15:29:04 2008
+++ linux-2.6.26/arch/ppc/platforms/prep_setup.c	Wed Aug 13
16:17:41 2008
@@ -847,15 +847,19 @@ static void __init
 prep_calibrate_decr(void)
 {
 	if (have_residual_data) {
-		unsigned long freq, divisor =3D 4;
+		unsigned long freq, divisor;
=20
 		if ( res->VitalProductData.ProcessorBusHz ) {
+			divisor =3D res->VitalProductData.TimeBaseDivisor;
 			freq =3D res->VitalProductData.ProcessorBusHz;
-			printk("time_init: decrementer frequency =3D
%lu.%.6lu MHz\n",
-					(freq/divisor)/1000000,
-					(freq/divisor)%1000000);
-			tb_to_us =3D mulhwu_scale_factor(freq/divisor,
1000000);
-			tb_ticks_per_jiffy =3D freq / HZ / divisor;
+			tb_to_us =3D mulhwu_scale_factor(freq/divisor,
1000);
+			tb_ticks_per_jiffy =3D freq / HZ / divisor * 1000;
+
+			printk(KERN_CRIT "prep_calibrate_decr: "
+				"frequency =3D %lu.%.6lu MHz,"
+				" tb_to_us: %d, tb_ticks_per_jiffy:
%d\n",
+				(freq/divisor)/1000,
(freq/divisor)%1000,
+				tb_to_us, tb_ticks_per_jiffy);
 		}
 	}
 	else
@@ -914,7 +918,7 @@ smp_prep_kick_cpu(int nr)
 {
 	*(unsigned long *)KERNELBASE =3D nr;
 	asm volatile("dcbf 0,%0"::"r"(KERNELBASE):"memory");
-	printk("CPU1 released, waiting\n");
+	printk(KERN_CRIT "CPU1 released, waiting\n");
 }
=20
 static void __init
@@ -972,6 +976,13 @@ prep_init(unsigned long r3, unsigned lon
 		memcpy((void *)res,(void *)(r3+KERNELBASE),
 			 sizeof(RESIDUAL));
 	}
+	if (have_residual_data)
+	    printk(KERN_INFO "Residual data for model: %s, "
+		"TimeBaseDivisor: %lu, ProcHz: %lu, BusHz: %lu\n",
+		res->VitalProductData.PrintableModel,
+		res->VitalProductData.TimeBaseDivisor,
+		res->VitalProductData.ProcessorHz,
+		res->VitalProductData.ProcessorBusHz);
 #endif
=20
 	isa_io_base =3D PREP_ISA_IO_BASE;
@@ -996,8 +1007,10 @@ prep_init(unsigned long r3, unsigned lon
=20
 #ifdef CONFIG_PREP_RESIDUAL
 	/* Switch off all residual data processing if the user requests
it */
-	if (strstr(cmd_line, "noresidual") !=3D NULL)
-			res =3D NULL;
+	if (strstr(cmd_line, "noresidual") !=3D NULL) {
+		printk(KERN_INFO "Disabled PREP residual data\n");
+		res =3D NULL;
+	}
 #endif
=20
 	/* Initialise progress early to get maximum benefit */

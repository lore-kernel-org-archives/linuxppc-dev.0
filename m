Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 25D7967A76
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 06:09:29 +1100 (EST)
Date: Fri, 4 Mar 2005 13:09:18 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org, greg@kroah.com
Message-ID: <Pine.LNX.4.61.0503041303290.18551@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: trivial fix for e500 oprofile build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew, Greg

Here is a patch for the new 2.6.11 release tree and for Linus.

Fix for trivial fix for 2.6.11 oprofile compilation on e500 based ppc.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
--- a/arch/ppc/oprofile/op_model_fsl_booke.c	2005-03-04 13:02:52 -06:00
+++ b/arch/ppc/oprofile/op_model_fsl_booke.c	2005-03-04 13:02:52 -06:00
@@ -150,7 +150,6 @@
 	int is_kernel;
 	int val;
 	int i;
-	unsigned int cpu = smp_processor_id();
 
 	/* set the PMM bit (see comment below) */
 	mtmsr(mfmsr() | MSR_PMM);
@@ -162,7 +161,7 @@
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_sample(pc, is_kernel, i, cpu);
+				oprofile_add_pc(pc, is_kernel, i);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);

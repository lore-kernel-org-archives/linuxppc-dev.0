Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 203C95137E
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:25:53 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n46KLjj8020811
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 16:21:45 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n46KPn3l155634
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 16:25:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n46KNtDv014579
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 16:23:55 -0400
Subject: [PATCH] powerpc: Fix oprofile sampling of marked events on  POWER7
From: Mike Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 06 May 2009 15:25:46 -0500
Message-Id: <1241641546.7044.20.camel@mx3>
Mime-Version: 1.0
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From Maynard Johnson <maynardj@us.ibm.com>

Description
-----------
Change ppc64 oprofile kernel driver to use the SLOT bits (MMCRA[37:39]only on
older processors where those bits are defined.

Background
----------
The performance monitor unit of the 64-bit POWER processor family has the
ability to collect accurate instruction-level samples when profiling on marked
events (i.e., "PM_MRK_<event-name>").  In processors prior to POWER6, the MMCRA
register contained "slot information" that the oprofile kernel driver used to
adjust the value latched in the SIAR at the time of a PMU interrupt.  But as of
POWER6, these slot bits in MMCRA are no longer necessary for oprofile to use,
since the SIAR itself holds the accurate sampled instruction address.  With
POWER6, these MMCRA slot bits were zero'ed out by hardware so oprofile's use of
these slot bits was, in effect, a NOP.  But with POWER7, these bits are no
longer zero'ed out; however, they serve some other purpose rather than slot
information.  Thus, using these bits on POWER7 to adjust the SIAR value results
in samples being attributed to the wrong instructions.  The attached patch
changes the oprofile kernel driver to ignore these slot bits on all newer
processors starting with POWER6.

Signed-off-by: Michael Wolf <mjw@linux.vnet.ibm.com>

---

diff -paur linux/arch/powerpc/oprofile/op_model_power4.c linux-p7-oprofile-patch//arch/powerpc/oprofile/op_model_power4.c
--- linux/arch/powerpc/oprofile/op_model_power4.c	2009-05-01 08:20:21.000000000 -0500
+++ linux-p7-oprofile-patch//arch/powerpc/oprofile/op_model_power4.c	2009-05-01 08:20:05.000000000 -0500
@@ -26,6 +26,7 @@
 static unsigned long reset_value[OP_MAX_COUNTER];

 static int oprofile_running;
+static int use_slot_nums;

 /* mmcr values are set in power4_reg_setup, used in power4_cpu_setup */
 static u32 mmcr0_val;
@@ -61,6 +62,12 @@ static int power4_reg_setup(struct op_co
 	else
 		mmcr0_val |= MMCR0_PROBLEM_DISABLE;

+	if (__is_processor(PV_POWER4) || __is_processor(PV_POWER4p) ||
+	    __is_processor(PV_970) || __is_processor(PV_970FX) ||
+	    __is_processor(PV_970MP) || __is_processor(PV_970GX) ||
+	    __is_processor(PV_POWER5) || __is_processor(PV_POWER5p))
+		use_slot_nums = 1;
+
 	return 0;
 }

@@ -206,7 +213,7 @@ static unsigned long get_pc(struct pt_re

 	mmcra = mfspr(SPRN_MMCRA);

-	if (mmcra & MMCRA_SAMPLE_ENABLE) {
+	if (use_slot_nums && (mmcra & MMCRA_SAMPLE_ENABLE)) {
 		slot = ((mmcra & MMCRA_SLOT) >> MMCRA_SLOT_SHIFT);
 		if (slot > 1)
 			pc += 4 * (slot - 1);

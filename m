Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 498D4DDF82
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 01:48:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n47Fk1gN029907
	for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2009 09:46:01 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n47FmZL0056686
	for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2009 09:48:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n47FmYMS027612
	for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2009 09:48:34 -0600
Received: from [9.65.81.158] (sig-9-65-81-158.mts.ibm.com [9.65.81.158])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n47FmX4h027488
	for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2009 09:48:33 -0600
Subject: [PATCH] powerpc: Fix oprofile sampling of marked events on  POWER7
From: Mike Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 07 May 2009 10:48:32 -0500
Message-Id: <1241711312.13502.5.camel@mx3>
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

From: Maynard Johnson <maynardj@us.ibm.com>

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

Signed-off-by: Maynard Johnson <maynardj@us.ibm.com>
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

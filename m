Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D07D0DDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 02:13:05 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5QF9jbn025948
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 11:09:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5QGCxOB520316
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 12:12:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5QGCwPZ007418
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 12:12:59 -0400
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] [POWERPC] Oprofile enhanced instruction sampling support
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Date: Tue, 26 Jun 2007 11:12:33 -0500
Message-ID: <20070626161233.14372.56506.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: will_schmidt@vnet.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Oprofile enhanced instruction sampling support.

When performing instruction sampling, the mmcra[SLOT] field can be used to
more accurately identify the address of the sampled instruction.

Tested on power4, js20, power5 and power5+.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Maynard Johnson <maynardj@us.ibm.com>
---

 arch/powerpc/oprofile/op_model_power4.c |   14 ++++++++++++++
 include/asm-powerpc/reg.h               |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
index fe597a1..a7c206b 100644
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Added mmcra[slot] support:
+ * Copyright (C) 2006-2007 Will Schmidt <willschm@us.ibm.com>, IBM
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -181,11 +183,17 @@ static void __attribute_used__ kernel_unknown_bucket(void)
  * On GQ and newer the MMCRA stores the HV and PR bits at the time
  * the SIAR was sampled. We use that to work out if the SIAR was sampled in
  * the hypervisor, our exception vectors or RTAS.
+ * If the MMCRA_SAMPLE_ENABLE bit is set, we can use the MMCRA[slot] bits
+ * to more accurately identify the address of the sampled instruction. The
+ * mmcra[slot] bits represent the slot number of a sampled instruction
+ * within an instruction group.  The slot will contain a value between 1
+ * and 5 if MMCRA_SAMPLE_ENABLE is set, otherwise 0.
  */
 static unsigned long get_pc(struct pt_regs *regs)
 {
 	unsigned long pc = mfspr(SPRN_SIAR);
 	unsigned long mmcra;
+	unsigned long slot;
 
 	/* Cant do much about it */
 	if (!cur_cpu_spec->oprofile_mmcra_sihv)
@@ -193,6 +201,12 @@ static unsigned long get_pc(struct pt_regs *regs)
 
 	mmcra = mfspr(SPRN_MMCRA);
 
+	if (mmcra & MMCRA_SAMPLE_ENABLE) {
+		slot = ((mmcra & MMCRA_SLOT) >> MMCRA_SLOT_SHIFT);
+		if (slot > 1)
+			pc += 4 * (slot - 1);
+	}
+
 	/* Were we in the hypervisor? */
 	if (firmware_has_feature(FW_FEATURE_LPAR) &&
 	    (mmcra & cur_cpu_spec->oprofile_mmcra_sihv))
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index 749c7f9..281011e 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -453,6 +453,8 @@
 #define SPRN_MMCRA	0x312
 #define   MMCRA_SIHV	0x10000000UL /* state of MSR HV when SIAR set */
 #define   MMCRA_SIPR	0x08000000UL /* state of MSR PR when SIAR set */
+#define   MMCRA_SLOT	0x07000000UL /* SLOT bits (37-39) */
+#define   MMCRA_SLOT_SHIFT	24
 #define   MMCRA_SAMPLE_ENABLE 0x00000001UL /* enable sampling */
 #define   POWER6_MMCRA_SIHV   0x0000040000000000ULL
 #define   POWER6_MMCRA_SIPR   0x0000020000000000ULL

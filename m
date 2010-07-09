Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5AEE100862
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:03 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696GpuH023524
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H3NX1630238
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:03 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H253013242
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:03 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/13] powerpc/oprofile: Don't build server oprofile drivers
	on 64-bit BookE
Date: Fri,  9 Jul 2010 16:16:55 +1000
Message-Id: <1278656215-24705-13-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-12-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-10-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-11-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-12-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

They will fail to build due to the lack of mtmsrd, and wouldn't
be useful anyways

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/oprofile/Makefile |    2 +-
 arch/powerpc/oprofile/common.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index 73e1c2c..e219ca4 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -16,6 +16,6 @@ oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
 oprofile-$(CONFIG_OPROFILE_CELL) += op_model_cell.o \
 		cell/spu_profiler.o cell/vma_map.o \
 		cell/spu_task_sync.o
-oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o op_model_pa6t.o
+oprofile-$(CONFIG_PPC_BOOK3S_64) += op_model_rs64.o op_model_power4.o op_model_pa6t.o
 oprofile-$(CONFIG_FSL_EMB_PERFMON) += op_model_fsl_emb.o
 oprofile-$(CONFIG_6xx) += op_model_7450.o
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
index 21f16ed..d65e68f 100644
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -199,7 +199,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 		return -ENODEV;
 
 	switch (cur_cpu_spec->oprofile_type) {
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 #ifdef CONFIG_OPROFILE_CELL
 		case PPC_OPROFILE_CELL:
 			if (firmware_has_feature(FW_FEATURE_LPAR))
-- 
1.6.3.3

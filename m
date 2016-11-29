Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSj8d4VY9zDvrs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 23:12:01 +1100 (AEDT)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tSj8d0VK9z9t2T
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 23:12:01 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 144so8284002pfv.0
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 04:12:00 -0800 (PST)
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] PPC/CAS Add support for power9 in ibm_architecture_vec
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <9b7467b2-a9f3-07a2-f32c-4f8d64735057@gmail.com>
Date: Tue, 29 Nov 2016 23:11:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



The PVR list has been updated and IBM_ARCH_VEC_NRCORES_OFFSET.
This provides the cpu versions supported to the hypervisor and in this case
tells the hypervisor that the guest supports ISA 3.0 and Power9.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/prom.h | 2 ++
 arch/powerpc/kernel/prom_init.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba..785bc6b 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -121,6 +121,8 @@ struct of_drconf_cell {
 #define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
 #define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
 
+#define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
+
 /* Option vector 2: Open Firmware options supported */
 #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 88ac964..2a8d6b0 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -659,6 +659,8 @@ unsigned char ibm_architecture_vec[] = {
 	W(0xffff0000), W(0x004b0000),	/* POWER8E */
 	W(0xffff0000), W(0x004c0000),   /* POWER8NVL */
 	W(0xffff0000), W(0x004d0000),	/* POWER8 */
+	W(0xffff0000), W(0x004e0000),	/* POWER9 */
+	W(0xffffffff), W(0x0f000005),	/* all 3.00-compliant */
 	W(0xffffffff), W(0x0f000004),	/* all 2.07-compliant */
 	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
@@ -666,10 +668,11 @@ unsigned char ibm_architecture_vec[] = {
 	NUM_VECTORS(6),			/* 6 option vectors */
 
 	/* option vector 1: processor architectures supported */
-	VECTOR_LENGTH(2),		/* length */
+	VECTOR_LENGTH(3),		/* length */
 	0,				/* don't ignore, don't halt */
 	OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
 	OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
+	OV1_PPC_3_00,
 
 	/* option vector 2: Open Firmware options supported */
 	VECTOR_LENGTH(33),		/* length */
@@ -720,7 +723,7 @@ unsigned char ibm_architecture_vec[] = {
 	 * must match by the macro below. Update the definition if
 	 * the structure layout changes.
 	 */
-#define IBM_ARCH_VEC_NRCORES_OFFSET	133
+#define IBM_ARCH_VEC_NRCORES_OFFSET	150
 	W(NR_CPUS),			/* number of cores supported */
 	0,
 	0,
-- 
2.5.5

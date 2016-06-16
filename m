Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVWJF4L4rzDqt0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 14:54:21 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ts6so2877931pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 21:54:21 -0700 (PDT)
Subject: [PATCH][V2] Add support for power9 in ibm_architecture_vec
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <900d62c2-8bdf-839a-49fa-99aff00a4d87@gmail.com>
 <87k2hqaegk.fsf@skywalker.in.ibm.com>
 <CAKTCnzmLQoBLTyE+bDqwbCTJ+zDLih1Xzm17Qf3M=8v2MBAptQ@mail.gmail.com>
 <87h9cua1fl.fsf@skywalker.in.ibm.com>
 <8d2526bd-1f31-bcfc-d188-5b15cb0624e8@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <c624cbd5-0017-5408-a146-949f3950ba69@gmail.com>
Date: Thu, 16 Jun 2016 14:54:14 +1000
MIME-Version: 1.0
In-Reply-To: <8d2526bd-1f31-bcfc-d188-5b15cb0624e8@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/06/16 10:09, Balbir Singh wrote:
> Yes, my bad.. I'll respin. I thought I had it, but I clearly did not
>

V2: Update the vector length for OV1 after adding 3.0 support

The PVR list has been updated and IBM_ARCH_VEC_NRCORES_OFFSET.
This provides the cpu version supported to the hypervisor

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/prom.h | 5 ++++-
 arch/powerpc/kernel/prom_init.c | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba..da0c98e 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -111,7 +111,7 @@ struct of_drconf_cell {
 #define OV_IGNORE		0x80	/* ignore this vector */
 #define OV_CESSATION_POLICY	0x40	/* halt if unsupported option present*/
 
-/* Option vector 1: processor architectures supported */
+/* Option vector 1: byte 2, processor architectures supported */
 #define OV1_PPC_2_00		0x80	/* set if we support PowerPC 2.00 */
 #define OV1_PPC_2_01		0x40	/* set if we support PowerPC 2.01 */
 #define OV1_PPC_2_02		0x20	/* set if we support PowerPC 2.02 */
@@ -121,6 +121,9 @@ struct of_drconf_cell {
 #define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
 #define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
 
+/* Option vector 1: byte 3, processor architectures supported */
+#define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
+
 /* Option vector 2: Open Firmware options supported */
 #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6ee4b72..900c6e1 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -658,6 +658,8 @@ unsigned char ibm_architecture_vec[] = {
 	W(0xffff0000), W(0x004b0000),	/* POWER8E */
 	W(0xffff0000), W(0x004c0000),   /* POWER8NVL */
 	W(0xffff0000), W(0x004d0000),	/* POWER8 */
+	W(0xffff0000), W(0x004e0000),	/* POWER9 */
+	W(0xffffffff), W(0x0f000005),	/* all 3.0-compliant */
 	W(0xffffffff), W(0x0f000004),	/* all 2.07-compliant */
 	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
@@ -665,10 +667,11 @@ unsigned char ibm_architecture_vec[] = {
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
@@ -719,7 +722,7 @@ unsigned char ibm_architecture_vec[] = {
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

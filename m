Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D815E1A1BF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:51:24 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D05A1402BF
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 22 Jul 2015 15:51:24 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B1733357804F
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:21 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6M5pDik59506838
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:21 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6M5omvB015094
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:50:49 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au
Subject: [PATCH V4 1/2] powerpc/kexec: Reset secondary cpu endianess before
 kexec
Date: Wed, 22 Jul 2015 15:50:50 +1000
Message-Id: <1437544251-19016-2-git-send-email-sam.mj@au1.ibm.com>
In-Reply-To: <1437544251-19016-1-git-send-email-sam.mj@au1.ibm.com>
References: <1437544251-19016-1-git-send-email-sam.mj@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the target kernel does not inlcude the FIXUP_ENDIAN check, coming
from a different-endian kernel will cause the target kernel to panic.
All ppc64 kernels can handle starting in big-endian mode, so return to
big-endian before branching into the target kernel.

This mainly affects pseries as secondaries on powernv are returned to
OPAL.

Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
 arch/powerpc/kernel/misc_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 4e314b9..6e4168c 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -475,9 +475,18 @@ _GLOBAL(kexec_wait)
 #ifdef CONFIG_KEXEC		/* use no memory without kexec */
 	lwz	r4,0(r5)
 	cmpwi	0,r4,0
-	bnea	0x60
+	beq	99b
+#ifdef CONFIG_PPC_BOOK3S_64
+	li	r10,0x60
+	mfmsr	r11
+	clrrdi	r11,r11,1	/* Clear MSR_LE */
+	mtsrr0	r10
+	mtsrr1	r11
+	rfid
+#else
+	ba	0x60
+#endif
 #endif
-	b	99b
 
 /* this can be in text because we won't change it until we are
  * running in real anyways
-- 
2.4.6

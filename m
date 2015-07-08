Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3D8E1A1A37
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 13:30:23 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C480D1402BD
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 13:30:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 8 Jul 2015 13:30:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B38793578052
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 13:30:19 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t683UBeG50856112
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 13:30:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t683Tlv6029951
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 13:29:47 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: anton@samba.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [kexec-lite PATCH V2] trampoline: Reset primary cpu endian to
 big-endian
Date: Wed,  8 Jul 2015 13:29:38 +1000
Message-Id: <1436326178-17021-1-git-send-email-sam.mj@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
meaning if we kexec from a little-endian kernel the target kernel will
fail to boot.
Returning to big-endian before we enter the target kernel ensures that
the target kernel can boot whether or not it includes FIXUP_ENDIAN.

Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
V2: As suggested by Anton take advantage of the rfid call and switch off
MSR_LE and branch to the target kernel in the same step.

 kexec_trampoline.S | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kexec_trampoline.S b/kexec_trampoline.S
index a3eb314..3751112 100644
--- a/kexec_trampoline.S
+++ b/kexec_trampoline.S
@@ -88,8 +88,15 @@ start:
 
 	li	r5,0
 
-	mtctr	r4
-	bctr
+	mtsrr0	r4
+
+	mfmsr	r5
+	clrrdi	r5,r5,1 	/* Clear MSR_LE */
+	mtsrr1	r5
+
+	li	r5,0
+
+	rfid
 
 . = KERNEL_ADDR_OFFSET
 kernel_addr:
-- 
2.4.5

Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA2DE1A196E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 11:26:30 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59E77140B0E
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 11:26:30 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 8 Jul 2015 11:26:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 41EFB3578048
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 11:26:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t681QG0h49873058
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 11:26:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t681PpmL020379
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 11:25:52 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: anton@samba.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [kexec-lite PATCH] trampoline: Reset primary cpu endian to big-endian
Date: Wed,  8 Jul 2015 11:25:42 +1000
Message-Id: <1436318742-13490-1-git-send-email-sam.mj@au1.ibm.com>
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
 kexec_trampoline.S |  9 ++++++++-
 kexec_trampoline.h | 17 +++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kexec_trampoline.S b/kexec_trampoline.S
index a3eb314..29537ab 100644
--- a/kexec_trampoline.S
+++ b/kexec_trampoline.S
@@ -41,6 +41,8 @@
 #define	r7	7
 #define	r8	8
 #define	r9	9
+#define	r10	10
+#define	r11	11
 
 #ifdef __powerpc64__
 #define LOAD	ld
@@ -50,8 +52,10 @@
 
 #if defined(__LITTLE_ENDIAN__)
 #define STWX_BE	stwbrx
+#define BCTR .long 0x2004804e
 #elif defined(__BIG_ENDIAN__)
 #define STWX_BE	stwx
+#define BCTR bctr
 #else
 #error no endianness defined!
 #endif
@@ -89,7 +93,10 @@ start:
 	li	r5,0
 
 	mtctr	r4
-	bctr
+
+	RESET_ENDIAN
+
+	BCTR
 
 . = KERNEL_ADDR_OFFSET
 kernel_addr:
diff --git a/kexec_trampoline.h b/kexec_trampoline.h
index 6485c88..909953b 100644
--- a/kexec_trampoline.h
+++ b/kexec_trampoline.h
@@ -27,7 +27,20 @@
 /* Fixed offset in device tree for storing the physical ID of the boot CPU */
 #define DT_CPU_OFFSET			28
 
-#ifndef __ASSEMBLY__
+#ifdef __ASSEMBLY__
+#define RESET_ENDIAN						   \
+	mfmsr	r9;						   \
+	clrldi.	r10,r9,63;					   \
+	beq	$+36;		/* Already big-endian */	   \
+	bcl	20,31,$+4;					   \
+	mflr	r10;						   \
+	addi	r10,r10,28;					   \
+	mfmsr	r11;						   \
+	xori	r11,r11,1;					   \
+	mtsrr0	r10;						   \
+	mtsrr1	r11;						   \
+	rfid;
+#else
 
 extern char __trampoline_start[];
 extern char __trampoline_end[];
@@ -48,6 +61,6 @@ static inline void trampoline_set_device_tree(void *p, unsigned long addr)
 	*v = addr;
 }
 
-#endif
+#endif /* !__ASSEMBLY__ */
 
 #endif
-- 
2.4.5

Return-Path: <clg@fr.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DFB6A140119
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:48:17 +1000 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 14 Apr 2014 08:48:14 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4EB822190056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 08:48:05 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3E7mBsE66191488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 07:48:11 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3E7mBqa029443
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 01:48:11 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 12/15] powerpc/boot: define a routine to enter prom
Date: Mon, 14 Apr 2014 09:47:11 +0200
Message-Id: <1397461634-20949-13-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
References: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch defines a 'prom' routine similar to 'enter_prom' in the
kernel.

The difference is in the MSR which is built before entering prom. Big
endian order is enforced as in the kernel but 32bit mode is not. It
prepares ground for the next patches which will introduce Little endian
order.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/crt0.S  |   71 +++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/oflib.c |    6 ++++
 2 files changed, 77 insertions(+)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 0f7428a37efb..dbd99d064828 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -126,3 +126,74 @@ RELACOUNT = 0x6ffffff9
 
 	/* Call start */
 	b	start
+
+#ifdef __powerpc64__
+
+#define PROM_FRAME_SIZE 512
+#define SAVE_GPR(n, base)       std     n,8*(n)(base)
+#define REST_GPR(n, base)       ld      n,8*(n)(base)
+#define SAVE_2GPRS(n, base)     SAVE_GPR(n, base); SAVE_GPR(n+1, base)
+#define SAVE_4GPRS(n, base)     SAVE_2GPRS(n, base); SAVE_2GPRS(n+2, base)
+#define SAVE_8GPRS(n, base)     SAVE_4GPRS(n, base); SAVE_4GPRS(n+4, base)
+#define SAVE_10GPRS(n, base)    SAVE_8GPRS(n, base); SAVE_2GPRS(n+8, base)
+#define REST_2GPRS(n, base)     REST_GPR(n, base); REST_GPR(n+1, base)
+#define REST_4GPRS(n, base)     REST_2GPRS(n, base); REST_2GPRS(n+2, base)
+#define REST_8GPRS(n, base)     REST_4GPRS(n, base); REST_4GPRS(n+4, base)
+#define REST_10GPRS(n, base)    REST_8GPRS(n, base); REST_2GPRS(n+8, base)
+
+/* prom handles the jump into and return from firmware.  The prom args pointer
+   is loaded in r3. */
+.globl prom
+prom:
+	mflr	r0
+	std	r0,16(r1)
+	stdu	r1,-PROM_FRAME_SIZE(r1) /* Save SP and create stack space */
+
+	SAVE_GPR(2, r1)
+	SAVE_GPR(13, r1)
+	SAVE_8GPRS(14, r1)
+	SAVE_10GPRS(22, r1)
+	mfcr    r10
+	std     r10,8*32(r1)
+	mfmsr   r10
+	std     r10,8*33(r1)
+
+	/* remove MSR_LE from msr but keep MSR_SF */
+	mfmsr	r10
+	rldicr	r10,r10,0,62
+	mtsrr1	r10
+
+	/* Load FW address, set LR to label 1, and jump to FW */
+	bl	0f
+0:	mflr	r10
+	addi	r11,r10,(1f-0b)
+	mtlr	r11
+
+	ld	r10,(p_prom-0b)(r10)
+	mtsrr0	r10
+
+	rfid
+
+1:	/* Return from OF */
+
+	/* Restore registers and return. */
+	rldicl  r1,r1,0,32
+
+	/* Restore the MSR (back to 64 bits) */
+	ld      r10,8*(33)(r1)
+	mtmsr	r10
+	isync
+
+	/* Restore other registers */
+	REST_GPR(2, r1)
+	REST_GPR(13, r1)
+	REST_8GPRS(14, r1)
+	REST_10GPRS(22, r1)
+	ld      r10,8*32(r1)
+	mtcr	r10
+
+	addi    r1,r1,PROM_FRAME_SIZE
+	ld      r0,16(r1)
+	mtlr    r0
+	blr
+#endif
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index cdfe762d2b2b..46c98a47d949 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -27,11 +27,17 @@ struct prom_args {
 	__be32 args[10];	/* Input/output arguments. */
 };
 
+#ifdef __powerpc64__
+extern int prom(void *);
+#else
 static int (*prom) (void *);
+#endif
 
 void of_init(void *promptr)
 {
+#ifndef __powerpc64__
 	prom = (int (*)(void *))promptr;
+#endif
 }
 
 #define ADDR(x)		(u32)(unsigned long)(x)
-- 
1.7.10.4

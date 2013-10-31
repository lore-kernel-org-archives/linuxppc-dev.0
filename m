Return-Path: <tommusta@gmail.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAF722C053E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 05:39:53 +1100 (EST)
Received: by mail-ob0-f169.google.com with SMTP id uz6so3529597obc.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 11:39:50 -0700 (PDT)
From: Tom <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [V2 PATCH 2/3] powerpc: Fix Unaligned Fixed Point Loads and Stores
Date: Thu, 31 Oct 2013 13:38:57 -0500
Message-Id: <1383244738-5986-3-git-send-email-tommusta@gmail.com>
In-Reply-To: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
Cc: Tom Musta <tommusta@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tom Musta <tommusta@gmail.com>

This patch modifies the unaligned access routines of the sstep.c
module so that it properly reverses the bytes of storage operands
in the little endian kernel kernel.

Signed-off-by: Tom Musta <tommusta@gmail.com>
---
 arch/powerpc/lib/sstep.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 7bfaa9d..c8743e1 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -212,11 +212,19 @@ static int __kprobes read_mem_unaligned(unsigned long *dest, unsigned long ea,
 {
 	int err;
 	unsigned long x, b, c;
+#ifdef __LITTLE_ENDIAN__
+	int len = nb; /* save a copy of the length for byte reversal */
+#endif
 
 	/* unaligned, do this in pieces */
 	x = 0;
 	for (; nb > 0; nb -= c) {
+#ifdef __LITTLE_ENDIAN__
+		c = 1;
+#endif
+#ifdef __BIG_ENDIAN__
 		c = max_align(ea);
+#endif
 		if (c > nb)
 			c = max_align(nb);
 		err = read_mem_aligned(&b, ea, c);
@@ -225,7 +233,24 @@ static int __kprobes read_mem_unaligned(unsigned long *dest, unsigned long ea,
 		x = (x << (8 * c)) + b;
 		ea += c;
 	}
+#ifdef __LITTLE_ENDIAN__
+	switch (len) {
+	case 2:
+		*dest = byterev_2(x);
+		break;
+	case 4:
+		*dest = byterev_4(x);
+		break;
+#ifdef __powerpc64__
+	case 8:
+		*dest = byterev_8(x);
+		break;
+#endif
+	}
+#endif
+#ifdef __BIG_ENDIAN__
 	*dest = x;
+#endif
 	return 0;
 }
 
@@ -273,9 +298,29 @@ static int __kprobes write_mem_unaligned(unsigned long val, unsigned long ea,
 	int err;
 	unsigned long c;
 
+#ifdef __LITTLE_ENDIAN__
+	switch (nb) {
+	case 2:
+		val = byterev_2(val);
+		break;
+	case 4:
+		val = byterev_4(val);
+		break;
+#ifdef __powerpc64__
+	case 8:
+		val = byterev_8(val);
+		break;
+#endif
+	}
+#endif
 	/* unaligned or little-endian, do this in pieces */
 	for (; nb > 0; nb -= c) {
+#ifdef __LITTLE_ENDIAN__
+		c = 1;
+#endif
+#ifdef __BIG_ENDIAN__
 		c = max_align(ea);
+#endif
 		if (c > nb)
 			c = max_align(nb);
 		err = write_mem_aligned(val >> (nb - c) * 8, ea, c);
-- 
1.7.1

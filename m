Return-Path: <tommusta@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32CE22C04FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 05:39:55 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id wm4so3462046obc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 11:39:53 -0700 (PDT)
From: Tom <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [V2 PATCH 3/3] powerpc: Fix Unaligned LE Floating Point Loads and
 Stores
Date: Thu, 31 Oct 2013 13:38:58 -0500
Message-Id: <1383244738-5986-4-git-send-email-tommusta@gmail.com>
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

This patch addresses unaligned single precision floating point loads
and stores in the single-step code.  The old implementation
improperly treated an 8 byte structure as an array of two 4 byte
words, which is a classic little endian bug.

Signed-off-by: Tom Musta <tommusta@gmail.com>
---
 arch/powerpc/lib/sstep.c |   52 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index c8743e1..1cfd150 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -355,22 +355,36 @@ static int __kprobes do_fp_load(int rn, int (*func)(int, unsigned long),
 				struct pt_regs *regs)
 {
 	int err;
-	unsigned long val[sizeof(double) / sizeof(long)];
+	union {
+		double dbl;
+		unsigned long ul[2];
+		struct {
+#ifdef __BIG_ENDIAN__
+			unsigned _pad_;
+			unsigned word;
+#endif
+#ifdef __LITTLE_ENDIAN__
+			unsigned word;
+			unsigned _pad_;
+#endif
+		} single;
+	} data;
 	unsigned long ptr;
 
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	if ((ea & 3) == 0)
 		return (*func)(rn, ea);
-	ptr = (unsigned long) &val[0];
+	ptr = (unsigned long) &data.ul;
 	if (sizeof(unsigned long) == 8 || nb == 4) {
-		err = read_mem_unaligned(&val[0], ea, nb, regs);
-		ptr += sizeof(unsigned long) - nb;
+		err = read_mem_unaligned(&data.ul[0], ea, nb, regs);
+		if (nb == 4)
+			ptr = (unsigned long)&(data.single.word);
 	} else {
 		/* reading a double on 32-bit */
-		err = read_mem_unaligned(&val[0], ea, 4, regs);
+		err = read_mem_unaligned(&data.ul[0], ea, 4, regs);
 		if (!err)
-			err = read_mem_unaligned(&val[1], ea + 4, 4, regs);
+			err = read_mem_unaligned(&data.ul[1], ea + 4, 4, regs);
 	}
 	if (err)
 		return err;
@@ -382,28 +396,42 @@ static int __kprobes do_fp_store(int rn, int (*func)(int, unsigned long),
 				 struct pt_regs *regs)
 {
 	int err;
-	unsigned long val[sizeof(double) / sizeof(long)];
+	union {
+		double dbl;
+		unsigned long ul[2];
+		struct {
+#ifdef __BIG_ENDIAN__
+			unsigned _pad_;
+			unsigned word;
+#endif
+#ifdef __LITTLE_ENDIAN__
+			unsigned word;
+			unsigned _pad_;
+#endif
+		} single;
+	} data;
 	unsigned long ptr;
 
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	if ((ea & 3) == 0)
 		return (*func)(rn, ea);
-	ptr = (unsigned long) &val[0];
+	ptr = (unsigned long) &data.ul[0];
 	if (sizeof(unsigned long) == 8 || nb == 4) {
-		ptr += sizeof(unsigned long) - nb;
+		if (nb == 4)
+			ptr = (unsigned long)&(data.single.word);
 		err = (*func)(rn, ptr);
 		if (err)
 			return err;
-		err = write_mem_unaligned(val[0], ea, nb, regs);
+		err = write_mem_unaligned(data.ul[0], ea, nb, regs);
 	} else {
 		/* writing a double on 32-bit */
 		err = (*func)(rn, ptr);
 		if (err)
 			return err;
-		err = write_mem_unaligned(val[0], ea, 4, regs);
+		err = write_mem_unaligned(data.ul[0], ea, 4, regs);
 		if (!err)
-			err = write_mem_unaligned(val[1], ea + 4, 4, regs);
+			err = write_mem_unaligned(data.ul[1], ea + 4, 4, regs);
 	}
 	return err;
 }
-- 
1.7.1

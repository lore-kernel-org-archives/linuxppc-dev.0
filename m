Return-Path: <tommusta@gmail.com>
Received: from mail-qc0-x22d.google.com (mail-qc0-x22d.google.com
 [IPv6:2607:f8b0:400d:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABC992C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 04:07:16 +1100 (EST)
Received: by mail-qc0-f173.google.com with SMTP id l13so2853508qcy.18
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 10:07:13 -0700 (PDT)
Received: from [9.10.80.32] (rchp4.rochester.ibm.com. [129.42.161.36])
 by mx.google.com with ESMTPSA id x1sm7273978qai.6.2013.10.18.10.07.11
 for <linuxppc-dev@lists.ozlabs.org>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Fri, 18 Oct 2013 10:07:12 -0700 (PDT)
Message-ID: <1382116030.2206.15.camel@tmusta-sc.rchland.ibm.com>
Subject: [PATCH 1/2] powerpc: Fix Handler of Unaligned Load/Store Strings
From: Tom Musta <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 18 Oct 2013 12:07:10 -0500
In-Reply-To: <1382115864.2206.12.camel@tmusta-sc.rchland.ibm.com>
References: <1382115864.2206.12.camel@tmusta-sc.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The alignment handler is incorrect for unaligned string instructions
in little endian mode.  These instructions access data as arrays of
bytes and thus are endian neutral.  However, the routine also handles
the load/store multiple instructions, which are NOT endian neutral.

This patch toggles the byte swapping flag for the string instructions
in little endian builds.  This effectively disables the byte swapping
logic.

Signed-off-by: Tom Musta <tmusta@gmail.com>
---
 arch/powerpc/kernel/align.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 6e3f977..a3169a9 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -254,15 +254,20 @@ static int emulate_dcbz(struct pt_regs *regs, unsigned char __user *addr)
  * bottom 4 bytes of each register, and the loads clear the
  * top 4 bytes of the affected register.
  */
+#ifdef __BIG_ENDIAN__
 #ifdef CONFIG_PPC64
 #define REG_BYTE(rp, i)		*((u8 *)((rp) + ((i) >> 2)) + ((i) & 3) + 4)
 #else
 #define REG_BYTE(rp, i)		*((u8 *)(rp) + (i))
 #endif
+#endif
+
+#ifdef __LITTLE_ENDIAN__
+#define REG_BYTE(rp, i)		(*(((u8 *)((rp) + ((i)>>2)) + ((i)&3))))
+#endif
 
 #define SWIZ_PTR(p)		((unsigned char __user *)((p) ^ swiz))
 
-#ifdef __BIG_ENDIAN__
 static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
 			    unsigned int reg, unsigned int nb,
 			    unsigned int flags, unsigned int instr,
@@ -304,6 +309,15 @@ static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
 			nb0 = nb + reg * 4 - 128;
 			nb = 128 - reg * 4;
 		}
+#ifdef __LITTLE_ENDIAN__
+		/*
+		 *  String instructions are endian neutral but the code
+		 *  below is not.  Force byte swapping on so that the
+		 *  effects of swizzling are undone in the load/store
+		 *  loops below.
+		 */
+		flags ^= SW;
+#endif
 	} else {
 		/* lwm, stmw */
 		nb = (32 - reg) * 4;
@@ -364,6 +378,7 @@ static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
  * Only POWER6 has these instructions, and it does true little-endian,
  * so we don't need the address swizzling.
  */
+#ifdef __BIG_ENDIAN__
 static int emulate_fp_pair(unsigned char __user *addr, unsigned int reg,
 			   unsigned int flags)
 {
@@ -882,13 +897,9 @@ int fix_alignment(struct pt_regs *regs)
 	 * function
 	 */
 	if (flags & M) {
-#ifdef __BIG_ENDIAN__
 		PPC_WARN_ALIGNMENT(multiple, regs);
 		return emulate_multiple(regs, addr, reg, nb,
 					flags, instr, swiz);
-#else
-		return -EFAULT;
-#endif
 	}
 
 	/* Verify the address of the operand */
-- 
1.7.1

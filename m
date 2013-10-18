Return-Path: <tommusta@gmail.com>
Received: from mail-qa0-x234.google.com (mail-qa0-x234.google.com
 [IPv6:2607:f8b0:400d:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F1442C011C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 04:08:26 +1100 (EST)
Received: by mail-qa0-f52.google.com with SMTP id w8so870383qac.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 10:08:24 -0700 (PDT)
Received: from [9.10.80.32] (rchp4.rochester.ibm.com. [129.42.161.36])
 by mx.google.com with ESMTPSA id fx6sm4524890qeb.1.2013.10.18.10.08.22
 for <linuxppc-dev@lists.ozlabs.org>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Fri, 18 Oct 2013 10:08:23 -0700 (PDT)
Message-ID: <1382116102.2206.16.camel@tmusta-sc.rchland.ibm.com>
Subject: [PATCH 2/2] powerpc: Enable Little Endian Alignment Handler for
 Float Pair Instructions
From: Tom Musta <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 18 Oct 2013 12:08:22 -0500
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

This patch enables alignment handling for the load/store floating point
pair instructions (lfdp, lfdpx, stfdp, stfdpx).  The handler routine
is properly coded and only needs to be enabled.

Signed-off-by: Tom Musta <tmusta@gmail.com>
---
 arch/powerpc/kernel/align.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index a3169a9..de91f3a 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -378,7 +378,6 @@ static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
  * Only POWER6 has these instructions, and it does true little-endian,
  * so we don't need the address swizzling.
  */
-#ifdef __BIG_ENDIAN__
 static int emulate_fp_pair(unsigned char __user *addr, unsigned int reg,
 			   unsigned int flags)
 {
@@ -406,7 +405,6 @@ static int emulate_fp_pair(unsigned char __user *addr, unsigned int reg,
 		return -EFAULT;
 	return 1;	/* exception handled and fixed up */
 }
-#endif
 
 #ifdef CONFIG_SPE
 
@@ -918,12 +916,8 @@ int fix_alignment(struct pt_regs *regs)
 
 	/* Special case for 16-byte FP loads and stores */
 	if (nb == 16) {
-#ifdef __BIG_ENDIAN__
 		PPC_WARN_ALIGNMENT(fp_pair, regs);
 		return emulate_fp_pair(addr, reg, flags);
-#else
-		return -EFAULT;
-#endif
 	}
 
 	PPC_WARN_ALIGNMENT(unaligned, regs);
-- 
1.7.1

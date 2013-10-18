Return-Path: <tommusta@gmail.com>
Received: from mail-oa0-x231.google.com (mail-oa0-x231.google.com
 [IPv6:2607:f8b0:4003:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5AB102C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 06:40:41 +1100 (EST)
Received: by mail-oa0-f49.google.com with SMTP id j10so3045311oah.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 12:40:37 -0700 (PDT)
Message-ID: <1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com>
Subject: [PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
From: Tom Musta <tommusta@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 18 Oct 2013 14:40:35 -0500
In-Reply-To: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>
References: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tmusta@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch modifies the endian chicken switch in the single step
emulation code (emulate_step()).  The old (big endian) code bailed
early if a load or store instruction was to be emulated in little
endian mode.

The new code modifies the check and only bails in a cross-endian
situation (LE mode in a kernel compiled for BE and vice verse).

Signed-off-by: Tom Musta <tmusta@gmail.com>
---
 arch/powerpc/lib/sstep.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index b1faa15..5e0d0e9 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1222,12 +1222,18 @@ int __kprobes emulate_step(struct pt_regs *regs,
unsigned int instr)
 	}
 
 	/*
-	 * Following cases are for loads and stores, so bail out
-	 * if we're in little-endian mode.
+	 * Following cases are for loads and stores and this
+	 * implementation does not support cross-endian.  So
+	 * bail out if this is the case.
 	 */
+#ifdef __BIG_ENDIAN__
 	if (regs->msr & MSR_LE)
 		return 0;
-
+#endif
+#ifdef __LITTLE_ENDIAN__
+	if (!regs->msr & MSR_LE)
+		return 0;
+#endif
 	/*
 	 * Save register RA in case it's an update form load or store
 	 * and the access faults.
-- 
1.7.1

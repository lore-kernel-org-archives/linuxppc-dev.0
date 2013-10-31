Return-Path: <tommusta@gmail.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABA532C0421
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 05:39:45 +1100 (EST)
Received: by mail-ob0-f178.google.com with SMTP id wm4so3524687obc.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 11:39:42 -0700 (PDT)
From: Tom <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [V2 PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
Date: Thu, 31 Oct 2013 13:38:56 -0500
Message-Id: <1383244738-5986-2-git-send-email-tommusta@gmail.com>
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

This patch modifies the endian chicken switch in the single step
emulation code (emulate_step()).  The old (big endian) code bailed
early if a load or store instruction was to be emulated in little
endian mode.

The new code modifies the check and only bails in a cross-endian
situation (LE mode in a kernel compiled for BE and vice verse).

V2: fixed bug in MSR[LE] check identified by Andreas Schwab and
Geert Uytterhoeven.

Signed-off-by: Tom Musta <tommusta@gmail.com>
---
 arch/powerpc/lib/sstep.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index b1faa15..7bfaa9d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1222,12 +1222,18 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
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
+	if (!(regs->msr & MSR_LE))
+		return 0;
+#endif
 	/*
 	 * Save register RA in case it's an update form load or store
 	 * and the access faults.
-- 
1.7.1

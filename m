Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9fzz2dNrzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 04:41:51 +1000 (AEST)
Date: Fri, 20 May 2016 04:41:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Improve comment explaining why we modify VRSAVE
Message-ID: <20160520044134.62712b79@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The comment explaining why we modify VRSAVE is misleading, glibc
does rely on the behaviour. Update the comment.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 1c2e7a3..3907fcf 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -70,10 +70,11 @@ _GLOBAL(load_up_altivec)
 	MTMSRD(r5)			/* enable use of AltiVec now */
 	isync
 
-	/* Hack: if we get an altivec unavailable trap with VRSAVE
-	 * set to all zeros, we assume this is a broken application
-	 * that fails to set it properly, and thus we switch it to
-	 * all 1's
+	/*
+	 * While userspace in general ignores VRSAVE, glibc uses it as a
+	 * boolean to optimise userspace context save/restore. Whenever we
+	 * take an altivec unavailable exception we must set VRSAVE to
+	 * something non zero. Set it to all 1s.
 	 */
 	mfspr	r4,SPRN_VRSAVE
 	cmpwi	0,r4,0

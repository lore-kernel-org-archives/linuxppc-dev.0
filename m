Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB350DE8E9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 22:50:28 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] math-emu: Fix compiler warnings
Date: Thu, 21 Aug 2008 07:50:20 -0500
Message-Id: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix warnings of the form:
arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f1' may be used uninitialized in this function
arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f0' may be used uninitialized in this function

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

I intend these patches to go via the powerpc.git tree if no one has issues.

- k

 include/math-emu/op-2.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/math-emu/op-2.h b/include/math-emu/op-2.h
index e193fb0..4f26ecc 100644
--- a/include/math-emu/op-2.h
+++ b/include/math-emu/op-2.h
@@ -25,7 +25,7 @@
 #ifndef __MATH_EMU_OP_2_H__
 #define __MATH_EMU_OP_2_H__
 
-#define _FP_FRAC_DECL_2(X)	_FP_W_TYPE X##_f0, X##_f1
+#define _FP_FRAC_DECL_2(X)	_FP_W_TYPE X##_f0 = 0, X##_f1 = 0
 #define _FP_FRAC_COPY_2(D,S)	(D##_f0 = S##_f0, D##_f1 = S##_f1)
 #define _FP_FRAC_SET_2(X,I)	__FP_FRAC_SET_2(X, I)
 #define _FP_FRAC_HIGH_2(X)	(X##_f1)
-- 
1.5.5.1

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F21E31A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:26:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/5] powerpc/rtas: Make enter_rtas() private
Date: Tue, 24 Nov 2015 22:26:12 +1100
Message-Id: <1448364372-28065-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
References: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are no longer any users of enter_rtas() outside of rtas.c, so make
it "private", by moving the declaration inside rtas.c. Hopefully this
will encourage people to use one of the wrappers which takes the sharp
edges off the RTAS calling sequence.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/rtas.h | 1 -
 arch/powerpc/kernel/rtas.c      | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 6db1d6977a0d..51400baa8d48 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -334,7 +334,6 @@ extern void (*rtas_flash_term_hook)(int);
 
 extern struct rtas_t rtas;
 
-extern void enter_rtas(unsigned long);
 extern int rtas_token(const char *service);
 extern int rtas_service_present(const char *service);
 extern int rtas_call(int token, int, int, int *, ...);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index f4fa137292c4..28736ff27fea 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -44,6 +44,9 @@
 #include <asm/mmu.h>
 #include <asm/topology.h>
 
+/* This is here deliberately so it's only used in this file */
+void enter_rtas(unsigned long);
+
 struct rtas_t rtas = {
 	.lock = __ARCH_SPIN_LOCK_UNLOCKED
 };
-- 
2.5.0

Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id DAFD01A0F81
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 15:38:32 +1000 (AEST)
Message-Id: <0636b88c7d11acb6a4d638e39bfcbb98c1d86045.1435036850.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1435036849.git.christophe.leroy@c-s.fr>
References: <cover.1435036849.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc32: checksum_wrappers_64 becomes
 checksum_wrappers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 23 Jun 2015 07:38:25 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc64 checksum wrapper functions adds the csum_and_copy_to_user() which
otherwise is implemented in include/net/checksum.h by using csum_partial() then
copy_to_user()

Those two wrapper fonctions are also applicable to powerpc32 as it is based on
the use of csum_partial_copy_generic() which also exists on powerpc32

This patch renames arch/powerpc/lib/checksum_wrappers_64.c to
arch/powerpc/lib/checksum_wrappers.c and
makes it non-conditional to CONFIG_WORD_SIZE

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change, patch reformatted with format-patch -M -C

 arch/powerpc/include/asm/checksum.h                              | 9 ---------
 arch/powerpc/lib/Makefile                                        | 3 +--
 arch/powerpc/lib/{checksum_wrappers_64.c => checksum_wrappers.c} | 0
 3 files changed, 1 insertion(+), 11 deletions(-)
 rename arch/powerpc/lib/{checksum_wrappers_64.c => checksum_wrappers.c} (100%)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 8251a3b..0ffd793 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -56,21 +56,12 @@ extern __wsum csum_partial_copy_generic(const void *src, void *dst,
 					      int len, __wsum sum,
 					      int *src_err, int *dst_err);
 
-#ifdef __powerpc64__
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				      int len, __wsum sum, int *err_ptr);
 #define HAVE_CSUM_COPY_USER
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 				    int len, __wsum sum, int *err_ptr);
-#else
-/*
- * the same as csum_partial, but copies from src to dst while it
- * checksums.
- */
-#define csum_partial_copy_from_user(src, dst, len, sum, errp)   \
-        csum_partial_copy_generic((__force const void *)(src), (dst), (len), (sum), (errp), NULL)
-#endif
 
 #define csum_partial_copy_nocheck(src, dst, len, sum)   \
         csum_partial_copy_generic((src), (dst), (len), (sum), NULL, NULL)
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a47e142..e46b068 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -22,8 +22,7 @@ obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 
 ifeq ($(CONFIG_GENERIC_CSUM),)
-obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
-obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
+obj-y			+= checksum_$(CONFIG_WORD_SIZE).o checksum_wrappers.o
 endif
 
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
diff --git a/arch/powerpc/lib/checksum_wrappers_64.c b/arch/powerpc/lib/checksum_wrappers.c
similarity index 100%
rename from arch/powerpc/lib/checksum_wrappers_64.c
rename to arch/powerpc/lib/checksum_wrappers.c
-- 
2.1.0

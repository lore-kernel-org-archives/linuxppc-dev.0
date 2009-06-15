Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81FFAB7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 12:16:45 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Jun 2009 12:16:10 +1000
Subject: [PATCH] powerpc: Add memory clobber to mtspr()
Message-Id: <20090615021645.7299DDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Without this clobber, mtspr can be re-ordered by gcc vs. surrounding
memory accesses. While this might be ok for some cases, it's not in
others and I'm not confident that all callers get it right (In fact
I'm sure some of them don't).

So for now, let's make mtspr() itself contain a memory clobber until
we can audit and fix everything, at which point we can remove it
if we think it's worth doing so.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/reg.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/reg.h	2009-06-15 12:01:06.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg.h	2009-06-15 12:01:17.000000000 +1000
@@ -755,7 +755,8 @@
 #define mfspr(rn)	({unsigned long rval; \
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
-#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
+#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v)\
+				     : "memory")
 
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_CELL

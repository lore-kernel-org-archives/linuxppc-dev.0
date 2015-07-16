Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7174D1A07F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 22:13:16 +1000 (AEST)
Date: Thu, 16 Jul 2015 22:12:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Use hardware RNG for arch_get_random_seed_* not
 arch_get_random_*
Message-ID: <20150716121259.GA18219@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hardware RNG on POWER8 and POWER7+ can be relatively slow, since
it can only supply one 64-bit value per microsecond.  Currently we
read it in arch_get_random_long(), but that slows down reading from
/dev/urandom since the code in random.c calls arch_get_random_long()
for every longword read from /dev/urandom.

Since the hardware RNG supplies high-quality entropy on every read, it
matches the semantics of arch_get_random_seed_long() better than those
of arch_get_random_long().  Therefore this commit makes the code use
the hardware RNG only for arch_get_random_seed_{long,int} and not for
arch_get_random_{long,int}.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/archrandom.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 0cc6eed..a4c3f54 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -7,13 +7,22 @@
 
 static inline int arch_get_random_long(unsigned long *v)
 {
+	return 0;
+}
+
+static inline int arch_get_random_int(unsigned int *v)
+{
+	return 0;
+}
+
+static inline int arch_get_random_seed_long(unsigned long *v)
+{
 	if (ppc_md.get_random_long)
 		return ppc_md.get_random_long(v);
 
 	return 0;
 }
-
-static inline int arch_get_random_int(unsigned int *v)
+static inline int arch_get_random_seed_int(unsigned int *v)
 {
 	unsigned long val;
 	int rc;
@@ -27,22 +36,13 @@ static inline int arch_get_random_int(unsigned int *v)
 
 static inline int arch_has_random(void)
 {
-	return !!ppc_md.get_random_long;
-}
-
-static inline int arch_get_random_seed_long(unsigned long *v)
-{
-	return 0;
-}
-static inline int arch_get_random_seed_int(unsigned int *v)
-{
 	return 0;
 }
+
 static inline int arch_has_random_seed(void)
 {
-	return 0;
+	return !!ppc_md.get_random_long;
 }
-
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
-- 
2.1.4

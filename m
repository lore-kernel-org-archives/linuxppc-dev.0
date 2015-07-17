Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43C981A0784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 20:11:48 +1000 (AEST)
Date: Fri, 17 Jul 2015 20:11:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Cc: tytso@mit.edu, keescook@chromium.org, hpa@linux.intel.com,
 mpe@ellerman.id.au, mpm@selenic.com, herbert@gondor.apana.org.au
Subject: [PATCH v2] powerpc: Use hardware RNG for arch_get_random_seed_* not
 arch_get_random_*
Message-ID: <20150717101143.GD5916@iris.ozlabs.ibm.com>
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
the POWER8/7+ hardware RNG only for arch_get_random_seed_{long,int}
and not for arch_get_random_{long,int}.

This won't affect any other PowerPC-based platforms because none of
them currently support a hardware RNG.  To make it clear that the
ppc_md function pointer is used for arch_get_random_seed_*, we rename
it from get_random_long to get_random_seed.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
v2: Rename the ppc_md hook too.

 arch/powerpc/include/asm/archrandom.h | 28 ++++++++++++++--------------
 arch/powerpc/include/asm/machdep.h    |  2 +-
 arch/powerpc/platforms/powernv/rng.c  |  2 +-
 arch/powerpc/platforms/pseries/rng.c  |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 0cc6eed..85e88f7 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -7,14 +7,23 @@
 
 static inline int arch_get_random_long(unsigned long *v)
 {
-	if (ppc_md.get_random_long)
-		return ppc_md.get_random_long(v);
-
 	return 0;
 }
 
 static inline int arch_get_random_int(unsigned int *v)
 {
+	return 0;
+}
+
+static inline int arch_get_random_seed_long(unsigned long *v)
+{
+	if (ppc_md.get_random_seed)
+		return ppc_md.get_random_seed(v);
+
+	return 0;
+}
+static inline int arch_get_random_seed_int(unsigned int *v)
+{
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
+	return !!ppc_md.get_random_seed;
 }
-
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 952579f..cab6753 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -249,7 +249,7 @@ struct machdep_calls {
 #endif
 
 #ifdef CONFIG_ARCH_RANDOM
-	int (*get_random_long)(unsigned long *v);
+	int (*get_random_seed)(unsigned long *v);
 #endif
 };
 
diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 6eb808f..5dcbdea 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -128,7 +128,7 @@ static __init int rng_create(struct device_node *dn)
 
 	pr_info_once("Registering arch random hook.\n");
 
-	ppc_md.get_random_long = powernv_get_random_long;
+	ppc_md.get_random_seed = powernv_get_random_long;
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index e096087..31ca557 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -38,7 +38,7 @@ static __init int rng_init(void)
 
 	pr_info("Registering arch random hook.\n");
 
-	ppc_md.get_random_long = pseries_get_random_long;
+	ppc_md.get_random_seed = pseries_get_random_long;
 
 	return 0;
 }
-- 
2.1.4

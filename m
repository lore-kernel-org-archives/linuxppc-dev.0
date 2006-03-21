Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 16:51:29 +1100
Subject: [RFC/PATCH] powerpc: Make BUG_ON & WARN_ON play nice with
	compile-time optimisations
In-Reply-To: <200603211445.32454.michael@ellerman.id.au>
Message-Id: <20060321055203.EF12167A39@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Although we could do this. It relys on firmware_has_feature() being a macro,
but perhaps that's ok. This isn't exactly ideal, as it encourages us to use
macros where we could otherwise use static inlines, but perhaps it's ok.

Given this:

void test(void)
{
       constant_false();
       BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));

       constant_true();
       BUG_ON(!firmware_has_feature(FW_FEATURE_ISERIES));

       non_constant();
       BUG_ON(firmware_has_feature(FW_FEATURE_SPLPAR));

       constant_false();
       WARN_ON(firmware_has_feature(FW_FEATURE_ISERIES));

       constant_true();
       WARN_ON(!firmware_has_feature(FW_FEATURE_ISERIES));

       non_constant();
       WARN_ON(firmware_has_feature(FW_FEATURE_SPLPAR));
}

I get assembly like so, which looks good to me:

        bl .constant_false
        bl .constant_true
        1:      twi 31,0,0
.section __bug_table,"a"
        .llong  1b,400,.LC12,__func__.21353
.previous
        bl .non_constant
        ld 9,.LC13@toc(2)
        ld 0,0(9)
        rldicl 0,0,44,63
        1:      tdnei   0,0
.section __bug_table,"a"
        .llong  1b,403,.LC12,__func__.21353
.previous
        bl .constant_false
        bl .constant_true
        1:      twi 31,0,0
.section __bug_table,"a"
        .llong  1b,16777625,.LC12,__func__.21353
.previous
        bl .non_constant
        ld 9,.LC13@toc(2)
        ld 0,0(9)
        rldicl 0,0,44,63
        1:      tdnei   0,0
.section __bug_table,"a"
        .llong  1b,16777628,.LC12,__func__.21353
.previous



 include/asm-powerpc/bug.h      |   24 ++++++++++++++++++++++--
 include/asm-powerpc/firmware.h |    8 +++-----
 2 files changed, 25 insertions(+), 7 deletions(-)

Index: to-merge/include/asm-powerpc/bug.h
===================================================================
--- to-merge.orig/include/asm-powerpc/bug.h
+++ to-merge/include/asm-powerpc/bug.h
@@ -40,17 +40,36 @@ struct bug_entry *find_bug(unsigned long
 } while (0)
 
 #define BUG_ON(x) do {						\
-	__asm__ __volatile__(					\
+	if (__builtin_constant_p(x)) {				\
+		if (x)						\
+			BUG();					\
+	} else {						\
+		__asm__ __volatile__(				\
 		"1:	"PPC_TLNEI"	%0,0\n"			\
 		".section __bug_table,\"a\"\n"			\
 		"\t"PPC_LONG"	1b,%1,%2,%3\n"		\
 		".previous"					\
 		: : "r" ((long)(x)), "i" (__LINE__),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
+	}							\
 } while (0)
 
-#define WARN_ON(x) do {						\
+#define WARN() do {						\
 	__asm__ __volatile__(					\
+		"1:	twi 31,0,0\n"				\
+		".section __bug_table,\"a\"\n"			\
+		"\t"PPC_LONG"	1b,%0,%1,%2\n"			\
+		".previous"					\
+		: : "i" (__LINE__ + BUG_WARNING_TRAP),		\
+		    "i" (__FILE__), "i" (__FUNCTION__));	\
+} while (0)
+
+#define WARN_ON(x) do {						\
+	if (__builtin_constant_p(x)) {				\
+		if (x)						\
+			WARN();					\
+	} else {						\
+		__asm__ __volatile__(				\
 		"1:	"PPC_TLNEI"	%0,0\n"			\
 		".section __bug_table,\"a\"\n"			\
 		"\t"PPC_LONG"	1b,%1,%2,%3\n"		\
@@ -58,6 +77,7 @@ struct bug_entry *find_bug(unsigned long
 		: : "r" ((long)(x)),				\
 		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
+	}							\
 } while (0)
 
 #define HAVE_ARCH_BUG
Index: to-merge/include/asm-powerpc/firmware.h
===================================================================
--- to-merge.orig/include/asm-powerpc/firmware.h
+++ to-merge/include/asm-powerpc/firmware.h
@@ -83,11 +83,9 @@ enum {
  */
 extern unsigned long	ppc64_firmware_features;
 
-static inline unsigned long firmware_has_feature(unsigned long feature)
-{
-	return (FW_FEATURE_ALWAYS & feature) ||
-		(FW_FEATURE_POSSIBLE & ppc64_firmware_features & feature);
-}
+#define firmware_has_feature(feature)					\
+	((FW_FEATURE_ALWAYS & (feature)) ||				\
+		(FW_FEATURE_POSSIBLE & ppc64_firmware_features & (feature)))
 
 extern void system_reset_fwnmi(void);
 extern void machine_check_fwnmi(void);

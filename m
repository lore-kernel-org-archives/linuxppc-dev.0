Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1126644202.11056.59.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 13 Sep 2005 15:43:22 -0500
Subject: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch to merge asm-ppc*/sections.h.

If anyone knows if we can do better here,
please feel free to abuse, er, let me know!

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

diff --git a/include/asm-powerpc/sections.h b/include/asm-powerpc/sections.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/sections.h
@@ -0,0 +1,62 @@
+#ifndef _ASM_POWERPC_SECTIONS_H
+#define _ASM_POWERPC_SECTIONS_H
+
+#ifdef __KERNEL__
+
+#include <asm-generic/sections.h>
+
+#ifdef __powerpc64__
+
+#define __pmac
+#define __pmacdata
+
+#define __prep
+#define __prepdata
+
+#define __chrp
+#define __chrpdata
+
+#define __openfirmware
+#define __openfirmwaredata
+
+extern char _end[];
+
+static inline int in_kernel_text(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
+		return 1;
+
+	return 0;
+}
+
+#else	/* __powerpc64__ */
+
+#define __pmac __attribute__ ((__section__ (".pmac.text")))
+#define __pmacdata __attribute__ ((__section__ (".pmac.data")))
+#define __pmacfunc(__argpmac) \
+	__argpmac __pmac; \
+	__argpmac
+	
+#define __prep __attribute__ ((__section__ (".prep.text")))
+#define __prepdata __attribute__ ((__section__ (".prep.data")))
+#define __prepfunc(__argprep) \
+	__argprep __prep; \
+	__argprep
+
+#define __chrp __attribute__ ((__section__ (".chrp.text")))
+#define __chrpdata __attribute__ ((__section__ (".chrp.data")))
+#define __chrpfunc(__argchrp) \
+	__argchrp __chrp; \
+	__argchrp
+
+/* this is actually just common chrp/pmac code, not OF code -- Cort */
+#define __openfirmware __attribute__ ((__section__ (".openfirmware.text")))
+#define __openfirmwaredata __attribute__ ((__section__ (".openfirmware.data")))
+#define __openfirmwarefunc(__argopenfirmware) \
+	__argopenfirmware __openfirmware; \
+	__argopenfirmware
+
+#endif	/* __powerpc64__ */
+	
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_SECTIONS_H */
diff --git a/include/asm-ppc/sections.h b/include/asm-ppc/sections.h
deleted file mode 100644
--- a/include/asm-ppc/sections.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _PPC_SECTIONS_H
-#define _PPC_SECTIONS_H
-
-#include <asm-generic/sections.h>
-
-#define __pmac __attribute__ ((__section__ (".pmac.text")))
-#define __pmacdata __attribute__ ((__section__ (".pmac.data")))
-#define __pmacfunc(__argpmac) \
-	__argpmac __pmac; \
-	__argpmac
-	
-#define __prep __attribute__ ((__section__ (".prep.text")))
-#define __prepdata __attribute__ ((__section__ (".prep.data")))
-#define __prepfunc(__argprep) \
-	__argprep __prep; \
-	__argprep
-
-#define __chrp __attribute__ ((__section__ (".chrp.text")))
-#define __chrpdata __attribute__ ((__section__ (".chrp.data")))
-#define __chrpfunc(__argchrp) \
-	__argchrp __chrp; \
-	__argchrp
-
-/* this is actually just common chrp/pmac code, not OF code -- Cort */
-#define __openfirmware __attribute__ ((__section__ (".openfirmware.text")))
-#define __openfirmwaredata __attribute__ ((__section__ (".openfirmware.data")))
-#define __openfirmwarefunc(__argopenfirmware) \
-	__argopenfirmware __openfirmware; \
-	__argopenfirmware
-	
-#endif /* _PPC_SECTIONS_H */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc64/sections.h b/include/asm-ppc64/sections.h
deleted file mode 100644
--- a/include/asm-ppc64/sections.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef _PPC64_SECTIONS_H
-#define _PPC64_SECTIONS_H
-
-extern char _end[];
-
-#include <asm-generic/sections.h>
-
-#define __pmac
-#define __pmacdata
-
-#define __prep
-#define __prepdata
-
-#define __chrp
-#define __chrpdata
-
-#define __openfirmware
-#define __openfirmwaredata
-
-
-static inline int in_kernel_text(unsigned long addr)
-{
-	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
-		return 1;
-
-	return 0;
-}
-
-#endif

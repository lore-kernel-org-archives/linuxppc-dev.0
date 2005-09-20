Return-Path: <galak@freescale.com>
Date: Tue, 20 Sep 2005 15:45:26 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509201544290.24915@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: merge include/asm-ppc*/auxvec.h into
 include/asm-powerpc/auxvec.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 40ec2534f42b5d38123c41858a3c85bc2eae272b
tree e13c35c52e65b3ac32a7d9bd37be9b45accb0631
parent e89b8279aafe3b896a1d1fbb4d10fbe91841d8e9
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 20 Sep 2005 15:31:13 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 20 Sep 2005 15:31:13 -0500

 include/asm-powerpc/auxvec.h |   19 +++++++++++++++++++
 include/asm-ppc/auxvec.h     |   14 --------------
 include/asm-ppc64/auxvec.h   |   19 -------------------
 3 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/include/asm-powerpc/auxvec.h b/include/asm-powerpc/auxvec.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/auxvec.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_POWERPC_AUXVEC_H
+#define _ASM_POWERPC_AUXVEC_H
+
+/*
+ * We need to put in some extra aux table entries to tell glibc what
+ * the cache block size is, so it can use the dcbz instruction safely.
+ */
+#define AT_DCACHEBSIZE		19
+#define AT_ICACHEBSIZE		20
+#define AT_UCACHEBSIZE		21
+/* A special ignored type value for PPC, for glibc compatibility.  */
+#define AT_IGNOREPPC		22
+
+/* The vDSO location. We have to use the same value as x86 for glibc's
+ * sake :-)
+ */
+#define AT_SYSINFO_EHDR		33
+
+#endif
diff --git a/include/asm-ppc/auxvec.h b/include/asm-ppc/auxvec.h
deleted file mode 100644
--- a/include/asm-ppc/auxvec.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef __PPC_AUXVEC_H
-#define __PPC_AUXVEC_H
-
-/*
- * We need to put in some extra aux table entries to tell glibc what
- * the cache block size is, so it can use the dcbz instruction safely.
- */
-#define AT_DCACHEBSIZE		19
-#define AT_ICACHEBSIZE		20
-#define AT_UCACHEBSIZE		21
-/* A special ignored type value for PPC, for glibc compatibility.  */
-#define AT_IGNOREPPC		22
-
-#endif
diff --git a/include/asm-ppc64/auxvec.h b/include/asm-ppc64/auxvec.h
deleted file mode 100644
--- a/include/asm-ppc64/auxvec.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __PPC64_AUXVEC_H
-#define __PPC64_AUXVEC_H
-
-/*
- * We need to put in some extra aux table entries to tell glibc what
- * the cache block size is, so it can use the dcbz instruction safely.
- */
-#define AT_DCACHEBSIZE		19
-#define AT_ICACHEBSIZE		20
-#define AT_UCACHEBSIZE		21
-/* A special ignored type value for PPC, for glibc compatibility.  */
-#define AT_IGNOREPPC		22
-
-/* The vDSO location. We have to use the same value as x86 for glibc's
- * sake :-)
- */
-#define AT_SYSINFO_EHDR		33
-
-#endif /* __PPC64_AUXVEC_H */

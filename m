Return-Path: <sfr@canb.auug.org.au>
Date: Sun, 11 Sep 2005 01:10:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050911011057.1e90fc41.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Merge include/asm-ppc*/a.out.h into
 include/asm-powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-powerpc/a.out.h |   36 ++++++++++++++++++++++++++++++++++++
 include/asm-ppc/a.out.h     |   26 --------------------------
 include/asm-ppc64/a.out.h   |   39 ---------------------------------------
 3 files changed, 36 insertions(+), 65 deletions(-)
 create mode 100644 include/asm-powerpc/a.out.h
 delete mode 100644 include/asm-ppc/a.out.h
 delete mode 100644 include/asm-ppc64/a.out.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

dba4294fb3e51dc6f30e1f6252a5e0ae583db91f
diff --git a/include/asm-powerpc/a.out.h b/include/asm-powerpc/a.out.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/a.out.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_POWERPC_A_OUT_H
+#define _ASM_POWERPC_A_OUT_H
+
+struct exec
+{
+	unsigned long a_info;	/* Use macros N_MAGIC, etc for access */
+	unsigned a_text;	/* length of text, in bytes */
+	unsigned a_data;	/* length of data, in bytes */
+	unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
+	unsigned a_syms;	/* length of symbol table data in file, in bytes */
+	unsigned a_entry;	/* start address */
+	unsigned a_trsize;	/* length of relocation info for text, in bytes */
+	unsigned a_drsize;	/* length of relocation info for data, in bytes */
+};
+
+#define N_TRSIZE(a)	((a).a_trsize)
+#define N_DRSIZE(a)	((a).a_drsize)
+#define N_SYMSIZE(a)	((a).a_syms)
+
+#ifdef __KERNEL__
+#ifdef __powerpc64__
+
+#define STACK_TOP_USER64 TASK_SIZE_USER64
+#define STACK_TOP_USER32 TASK_SIZE_USER32
+
+#define STACK_TOP (test_thread_flag(TIF_32BIT) ? \
+		   STACK_TOP_USER32 : STACK_TOP_USER64)
+
+#else /* __powerpc64__ */
+
+#define STACK_TOP TASK_SIZE
+
+#endif /* __powerpc64__ */
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_POWERPC_A_OUT_H */
diff --git a/include/asm-ppc/a.out.h b/include/asm-ppc/a.out.h
deleted file mode 100644
--- a/include/asm-ppc/a.out.h
+++ /dev/null
@@ -1,26 +0,0 @@
-#ifndef __PPC_A_OUT_H__
-#define __PPC_A_OUT_H__
-
-/* grabbed from the intel stuff  */
-#define STACK_TOP TASK_SIZE
-
-
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
-
-#endif
diff --git a/include/asm-ppc64/a.out.h b/include/asm-ppc64/a.out.h
deleted file mode 100644
--- a/include/asm-ppc64/a.out.h
+++ /dev/null
@@ -1,39 +0,0 @@
-#ifndef __PPC64_A_OUT_H__
-#define __PPC64_A_OUT_H__
-
-/*
- * c 2001 PPC 64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-struct exec
-{
-	unsigned long a_info;	/* Use macros N_MAGIC, etc for access */
-	unsigned a_text;	/* length of text, in bytes */
-	unsigned a_data;	/* length of data, in bytes */
-	unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-	unsigned a_syms;	/* length of symbol table data in file, in bytes */
-	unsigned a_entry;	/* start address */
-	unsigned a_trsize;	/* length of relocation info for text, in bytes */
-	unsigned a_drsize;	/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
-#ifdef __KERNEL__
-
-#define STACK_TOP_USER64 TASK_SIZE_USER64
-#define STACK_TOP_USER32 TASK_SIZE_USER32
-
-#define STACK_TOP (test_thread_flag(TIF_32BIT) ? \
-		   STACK_TOP_USER32 : STACK_TOP_USER64)
-
-#endif /* __KERNEL__ */
-
-#endif /* __PPC64_A_OUT_H__ */

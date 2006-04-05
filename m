Return-Path: <sfr@canb.auug.org.au>
From: sfr@canb.auug.org.au
To: paulus@samba.org
Subject: [PATCH 04/15] powerpc: move asm/bootinfo.h
Date: Wed, 05 Apr 2006 15:10:38 +1000
Message-Id: <11442138551674-git-send-email-sfr@canb.auug.org.au>
In-Reply-To: <11442138494042-git-send-email-sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>

Since files in arch/powerpc now depend on asm/bootinfo.h,
move it to include/asm-powerpc.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 include/asm-powerpc/bootinfo.h |   52 ++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/bootinfo.h     |   52 ----------------------------------------
 2 files changed, 52 insertions(+), 52 deletions(-)
 create mode 100644 include/asm-powerpc/bootinfo.h
 delete mode 100644 include/asm-ppc/bootinfo.h

355987a8cf0cf4b644e83b8268a9a34cf4524ee0
diff --git a/include/asm-powerpc/bootinfo.h b/include/asm-powerpc/bootinfo.h
new file mode 100644
index 0000000..231c534
--- /dev/null
+++ b/include/asm-powerpc/bootinfo.h
@@ -0,0 +1,52 @@
+#ifndef _ASM_POWERPC_BOOTINFO_H
+#define _ASM_POWERPC_BOOTINFO_H
+
+/*
+ * Non-machine dependent bootinfo structure.  Basic idea
+ * borrowed from the m68k.
+ *
+ * Copyright (C) 1999 Cort Dougan <cort@ppc.kernel.org>
+ */
+
+#ifdef __KERNEL__
+
+#include <asm/page.h>
+
+#if defined(CONFIG_APUS) && !defined(__BOOTER__)
+#include <asm-m68k/bootinfo.h>
+#else
+
+struct bi_record {
+	unsigned long tag;		/* tag ID */
+	unsigned long size;		/* size of record (in bytes) */
+	unsigned long data[0];		/* data */
+};
+
+#define BI_FIRST		0x1010  /* first record - marker */
+#define BI_LAST			0x1011	/* last record - marker */
+#define BI_CMD_LINE		0x1012
+#define BI_BOOTLOADER_ID	0x1013
+#define BI_INITRD		0x1014
+#define BI_SYSMAP		0x1015
+#define BI_MACHTYPE		0x1016
+#define BI_MEMSIZE		0x1017
+#define BI_BOARD_INFO		0x1018
+
+extern struct bi_record *find_bootinfo(void);
+extern void bootinfo_init(struct bi_record *rec);
+extern void bootinfo_append(unsigned long tag, unsigned long size, void * data);
+extern void parse_bootinfo(struct bi_record *rec);
+extern unsigned long boot_mem_size;
+
+static inline struct bi_record *
+bootinfo_addr(unsigned long offset)
+{
+
+	return (struct bi_record *)_ALIGN((offset) + (1 << 20) - 1,
+					  (1 << 20));
+}
+#endif /* CONFIG_APUS */
+
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_BOOTINFO_H */
diff --git a/include/asm-ppc/bootinfo.h b/include/asm-ppc/bootinfo.h
deleted file mode 100644
index 93d955c..0000000
--- a/include/asm-ppc/bootinfo.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Non-machine dependent bootinfo structure.  Basic idea
- * borrowed from the m68k.
- *
- * Copyright (C) 1999 Cort Dougan <cort@ppc.kernel.org>
- */
-
-#ifdef __KERNEL__
-#ifndef _PPC_BOOTINFO_H
-#define _PPC_BOOTINFO_H
-
-#include <linux/config.h>
-#include <asm/page.h>
-
-#if defined(CONFIG_APUS) && !defined(__BOOTER__)
-#include <asm-m68k/bootinfo.h>
-#else
-
-struct bi_record {
-	unsigned long tag;		/* tag ID */
-	unsigned long size;		/* size of record (in bytes) */
-	unsigned long data[0];		/* data */
-};
-
-#define BI_FIRST		0x1010  /* first record - marker */
-#define BI_LAST			0x1011	/* last record - marker */
-#define BI_CMD_LINE		0x1012
-#define BI_BOOTLOADER_ID	0x1013
-#define BI_INITRD		0x1014
-#define BI_SYSMAP		0x1015
-#define BI_MACHTYPE		0x1016
-#define BI_MEMSIZE		0x1017
-#define BI_BOARD_INFO		0x1018
-
-extern struct bi_record *find_bootinfo(void);
-extern void bootinfo_init(struct bi_record *rec);
-extern void bootinfo_append(unsigned long tag, unsigned long size, void * data);
-extern void parse_bootinfo(struct bi_record *rec);
-extern unsigned long boot_mem_size;
-
-static inline struct bi_record *
-bootinfo_addr(unsigned long offset)
-{
-
-	return (struct bi_record *)_ALIGN((offset) + (1 << 20) - 1,
-					  (1 << 20));
-}
-#endif /* CONFIG_APUS */
-
-
-#endif /* _PPC_BOOTINFO_H */
-#endif /* __KERNEL__ */
-- 
1.2.4

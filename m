Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GK12006@kryten>
Message-Id: <20090222115332.932267488@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:07 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 10/10] powerpc: Randomise PIEs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randomise ELF_ET_DYN_BASE, which is used when loading position independent
executables.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/include/asm/elf.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/elf.h	2009-02-22 21:18:04.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/elf.h	2009-02-22 21:34:49.000000000 +1100
@@ -178,7 +178,8 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         (0x20000000)
+extern unsigned long randomize_et_dyn(unsigned long base);
+#define ELF_ET_DYN_BASE		(randomize_et_dyn(0x20000000))
 
 /*
  * Our registers are always unsigned longs, whether we're a 32 bit
Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2009-02-22 21:21:14.000000000 +1100
+++ linux-2.6/arch/powerpc/kernel/process.c	2009-02-22 21:36:02.000000000 +1100
@@ -1154,3 +1154,13 @@
 
 	return ret;
 }
+
+unsigned long randomize_et_dyn(unsigned long base)
+{
+	unsigned long ret = PAGE_ALIGN(base + brk_rnd());
+
+	if (ret < base)
+		return base;
+
+	return ret;
+}

-- 

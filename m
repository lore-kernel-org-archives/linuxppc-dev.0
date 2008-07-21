Return-Path: <segher@gcc17.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	by ozlabs.org (Postfix) with ESMTP id A67EBDDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 09:56:33 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix build bug with binutils < 2.18 and GCC < 4.2
Date: Tue, 22 Jul 2008 01:03:45 +0200
Message-Id: <31a45a6b0f4087a6e54b05241eebc9f94202ffe5.1216681294.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

binutils < 2.18 has a bug that makes it misbehave when taking an
ELF file with all segments at load address 0 as input.  This
happens when running "strip" on vmlinux, because of the AT() magic
in this linker script.  People using GCC >= 4.2 won't run into
this problem, because the "build-id" support will put some data
into the "notes" segment (at a non-zero load address).

To work around this, we force some data into both the "dummy"
segment and the kernel segment, so the dummy segment will get a
non-zero load address.  It's not enough to always create the
"notes" segment, since if nothing gets assigned to it, its load
address will be zero.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Tested-By: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/kernel/vmlinux.lds.S |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 87a72c6..a914411 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -9,6 +9,25 @@
 
 ENTRY(_stext)
 
+PHDRS {
+	kernel PT_LOAD FLAGS(7); /* RWX */
+	notes PT_NOTE FLAGS(0);
+	dummy PT_NOTE FLAGS(0);
+
+	/* binutils < 2.18 has a bug that makes it misbehave when taking an
+	   ELF file with all segments at load address 0 as input.  This
+	   happens when running "strip" on vmlinux, because of the AT() magic
+	   in this linker script.  People using GCC >= 4.2 won't run into
+	   this problem, because the "build-id" support will put some data
+	   into the "notes" segment (at a non-zero load address).
+
+	   To work around this, we force some data into both the "dummy"
+	   segment and the kernel segment, so the dummy segment will get a
+	   non-zero load address.  It's not enough to always create the
+	   "notes" segment, since if nothing gets assigned to it, its load
+	   address will be zero.  */
+}
+
 #ifdef CONFIG_PPC64
 OUTPUT_ARCH(powerpc:common64)
 jiffies = jiffies_64;
@@ -50,7 +69,7 @@ SECTIONS
 		. = ALIGN(PAGE_SIZE);
 		_etext = .;
 		PROVIDE32 (etext = .);
-	}
+	} :kernel
 
 	/* Read-only data */
 	RODATA
@@ -62,7 +81,13 @@ SECTIONS
 		__stop___ex_table = .;
 	}
 
-	NOTES
+	NOTES :kernel :notes
+
+	/* The dummy segment contents for the bug workaround mentioned above
+	   near PHDRS.  */
+	.dummy : {
+		LONG(0xf177)
+	} :kernel :dummy
 
 /*
  * Init sections discarded at runtime
@@ -74,7 +99,7 @@ SECTIONS
 		_sinittext = .;
 		INIT_TEXT
 		_einittext = .;
-	}
+	} :kernel
 
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
-- 
1.5.6.4.gf1ba5

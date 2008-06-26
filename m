Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1D5FDDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 23:23:46 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/60] microblaze_v4: head.S + linker script
Date: Thu, 26 Jun 2008 14:29:46 +0200
Message-Id: <1214483429-32360-18-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-17-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<1214483429-32360-14-git-send-email-monstr@seznam.cz>
	<1214483429-32360-15-git-send-email-monstr@seznam.cz>
	<1214483429-32360-16-git-send-email-monstr@seznam.cz>
	<1214483429-32360-17-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/head.S        |   38 +++++++++
 arch/microblaze/kernel/vmlinux.lds.S |  143 ++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 arch/microblaze/kernel/head.S
 create mode 100644 arch/microblaze/kernel/vmlinux.lds.S

diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
new file mode 100644
index 0000000..8f87626
--- /dev/null
+++ b/arch/microblaze/kernel/head.S
@@ -0,0 +1,38 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Michal Simek <monstr@monstr.eu>
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ */
+
+#include <linux/linkage.h>
+#include <asm/thread_info.h>
+
+	.text
+ENTRY(_start)
+	mfs	r1, rmsr
+	andi	r1, r1, ~2
+	mts	rmsr, r1
+
+	/* Initialize small data anchors */
+	la	r13, r0, _KERNEL_SDA_BASE_
+	la	r2, r0, _KERNEL_SDA2_BASE_
+
+	/* Initialize stack pointer */
+	la	r1, r0, init_thread_union + THREAD_SIZE - 4
+
+	/* Initialize r31 with current task address */
+	la	r31, r0, init_task
+
+	/* Call platform dependent initialize function.
+	 * Please see $(ARCH)/mach-$(SUBARCH)/setup.c for
+	 * the function. */
+	la	r8, r0, machine_early_init
+	brald	r15, r8
+	nop
+
+	la	r15, r0, machine_halt
+	braid	start_kernel
+	nop
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..f31e7ef
--- /dev/null
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+OUTPUT_FORMAT("elf32-microblaze", "elf32-microblaze", "elf32-microblaze")
+OUTPUT_ARCH(microblaze)
+ENTRY(_start)
+
+#include <linux/autoconf.h>
+#include <asm-generic/vmlinux.lds.h>
+
+jiffies = jiffies_64 + 4;
+
+SECTIONS {
+	. = CONFIG_KERNEL_BASE_ADDR;
+
+	.text : {
+		_text = . ;
+		_stext = . ;
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		. = ALIGN (4) ;
+		_etext = . ;
+	}
+
+	. = ALIGN(16);
+	RODATA
+
+	/* sdata2 section can go anywhere, but must be word aligned
+	 and SDA2_BASE must point to the middle of it */
+	.sdata2 : {
+		_ssrw = .;
+		. = ALIGN(0x8);
+		*(.sdata2)
+	. = ALIGN(8);
+	_essrw = .;
+	_ssrw_size = _essrw - _ssrw;
+	_KERNEL_SDA2_BASE_ = _ssrw + (_ssrw_size / 2);
+	}
+
+	_sdata = . ;
+	.data ALIGN (0x4) : {
+		DATA_DATA
+	}
+	. = ALIGN(32);
+	.data.cacheline_aligned : { *(.data.cacheline_aligned) }
+	_edata = . ;
+
+	/* The initial task */
+	. = ALIGN(8192);
+	.data.init_task : { *(.data.init_task) }
+
+	/* Under the microblaze ABI, .sdata and .sbss must be contiguous */
+	. = ALIGN(8);
+	.sdata : {
+		_ssro = .;
+		*(.sdata)
+	}
+
+	.sbss :	{
+		_ssbss = .;
+		*(.sbss)
+		_esbss = .;
+		_essro = .;
+		_ssro_size = _essro - _ssro ;
+		_KERNEL_SDA_BASE_ = _ssro + (_ssro_size / 2) ;
+	}
+
+	. = ALIGN(16);
+	__start___ex_table = .;
+	__ex_table : { *(__ex_table) }
+	__stop___ex_table = .;
+
+	__init_begin = .;
+
+	. = ALIGN(4096);
+	.init.text : {
+		_sinittext = . ;
+		*(.init.text)
+		*(.exit.text)
+		*(.exit.data)
+		_einittext = .;
+	}
+
+	.init.data : { *(.init.data) }
+
+	. = ALIGN(4);
+	.init.ivt : {
+		__ivt_start = .;
+		*(.init.ivt)
+		__ivt_end = .;
+	}
+
+	.init.setup : {
+		__setup_start = .;
+		*(.init.setup)
+		__setup_end = .;
+	}
+
+	.initcall.init : {
+		__initcall_start = .;
+		INITCALLS
+		__initcall_end = .;
+	}
+
+	.con_initcall.init : {
+		__con_initcall_start = .;
+		*(.con_initcall.init)
+		__con_initcall_end = .;
+	}
+
+	__init_end_before_initramfs = .;
+
+	.init.ramfs ALIGN(4096) : {
+		__initramfs_start = .;
+		*(.init.ramfs)
+		__initramfs_end = .;
+		. = ALIGN(4);
+		LONG(0);
+		. = ALIGN(4096);/* Pad init.ramfs up to page boundary, so
+				that __init_end == __bss_start. This will
+				make image.elf consistent with the image.bin */
+	}
+
+	__init_end = .;
+
+	.bss ALIGN (4096) : {
+		__bss_start = . ;
+			*(.bss*)
+			*(COMMON)
+		. = ALIGN (4) ;
+		__bss_stop = . ;
+		_ebss = . ;
+	}
+	. = ALIGN(4096);
+	_end = .;
+}
+
-- 
1.5.4.GIT

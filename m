Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSjvv4SxszDvp4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 23:46:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com,
 stewart@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com
Subject: [PATCH v11 6/8] powerpc: Add purgatory for kexec_file_load()
 implementation.
Date: Tue, 29 Nov 2016 23:45:52 +1100
Message-Id: <1480423554-6411-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
References: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

This purgatory implementation is based on the versions from kexec-tools
and kexec-lite, with additional changes.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile                  |   1 +
 arch/powerpc/kernel/machine_kexec_64.c |   2 +-
 arch/powerpc/purgatory/.gitignore      |   2 +
 arch/powerpc/purgatory/Makefile        |  15 ++++
 arch/powerpc/purgatory/trampoline.S    | 128 +++++++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/purgatory/.gitignore
 create mode 100644 arch/powerpc/purgatory/Makefile
 create mode 100644 arch/powerpc/purgatory/trampoline.S

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 617dece67924..5e7dcdaf93f5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -249,6 +249,7 @@ core-y				+= arch/powerpc/kernel/ \
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
 core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
+core-$(CONFIG_KEXEC_FILE)	+= arch/powerpc/purgatory/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a205fa3d9bf3..5c12e21d0d1a 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -310,7 +310,7 @@ void default_machine_kexec(struct kimage *image)
 	if (!kdump_in_progress())
 		kexec_prepare_cpus();
 
-	pr_debug("kexec: Starting switchover sequence.\n");
+	printk("kexec: Starting switchover sequence.\n");
 
 	/* switch to a staticly allocated stack.  Based on irq stack code.
 	 * We setup preempt_count to avoid using VMX in memcpy.
diff --git a/arch/powerpc/purgatory/.gitignore b/arch/powerpc/purgatory/.gitignore
new file mode 100644
index 000000000000..e9e66f178a6d
--- /dev/null
+++ b/arch/powerpc/purgatory/.gitignore
@@ -0,0 +1,2 @@
+kexec-purgatory.c
+purgatory.ro
diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
new file mode 100644
index 000000000000..ac8793c13348
--- /dev/null
+++ b/arch/powerpc/purgatory/Makefile
@@ -0,0 +1,15 @@
+targets += trampoline.o purgatory.ro kexec-purgatory.c
+
+LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
+
+$(obj)/purgatory.ro: $(obj)/trampoline.o FORCE
+		$(call if_changed,ld)
+
+CMD_BIN2C = $(objtree)/scripts/basic/bin2c
+quiet_cmd_bin2c = BIN2C   $@
+      cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
+
+$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+	$(call if_changed,bin2c)
+
+obj-y	+= kexec-purgatory.o
diff --git a/arch/powerpc/purgatory/trampoline.S b/arch/powerpc/purgatory/trampoline.S
new file mode 100644
index 000000000000..f9760ccf4032
--- /dev/null
+++ b/arch/powerpc/purgatory/trampoline.S
@@ -0,0 +1,128 @@
+/*
+ * kexec trampoline
+ *
+ * Based on code taken from kexec-tools and kexec-lite.
+ *
+ * Copyright (C) 2004 - 2005, Milton D Miller II, IBM Corporation
+ * Copyright (C) 2006, Mohan Kumar M, IBM Corporation
+ * Copyright (C) 2013, Anton Blanchard, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License as published by the Free
+ * Software Foundation (version 2 of the License).
+ */
+
+#if defined(__LITTLE_ENDIAN__)
+#define STWX_BE	stwbrx
+#define LWZX_BE	lwbrx
+#elif defined(__BIG_ENDIAN__)
+#define STWX_BE	stwx
+#define LWZX_BE	lwzx
+#else
+#error no endianness defined!
+#endif
+
+	.machine ppc64
+	.balign 256
+	.globl purgatory_start
+purgatory_start:
+	b	master
+
+	/* ABI: possible run_at_load flag at 0x5c */
+	.org purgatory_start + 0x5c
+	.globl run_at_load
+run_at_load:
+	.long 0
+	.size run_at_load, . - run_at_load
+
+	/* ABI: slaves start at 60 with r3=phys */
+	.org purgatory_start + 0x60
+slave:
+	b .
+	/* ABI: end of copied region */
+	.org purgatory_start + 0x100
+	.size purgatory_start, . - purgatory_start
+
+/*
+ * The above 0x100 bytes at purgatory_start are replaced with the
+ * code from the kernel (or next stage) by setup_purgatory().
+ */
+
+master:
+	or	%r1,%r1,%r1	/* low priority to let other threads catchup */
+	isync
+	mr	%r17,%r3	/* save cpu id to r17 */
+	mr	%r15,%r4	/* save physical address in reg15 */
+
+	or	%r3,%r3,%r3	/* ok now to high priority, lets boot */
+	lis	%r6,0x1
+	mtctr	%r6		/* delay a bit for slaves to catch up */
+	bdnz	.		/* before we overwrite 0-100 again */
+
+	bl	0f		/* Work out where we're running */
+0:	mflr	%r18
+
+	/* load device-tree address */
+	ld	%r3, (dt_offset - 0b)(%r18)
+	mr	%r16,%r3	/* save dt address in reg16 */
+	li	%r4,20
+	LWZX_BE	%r6,%r3,%r4	/* fetch __be32 version number at byte 20 */
+	cmpwi	%r0,%r6,2	/* v2 or later? */
+	blt	1f
+	li	%r4,28
+	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */
+1:
+	/* load the kernel address */
+	ld	%r4,(kernel - 0b)(%r18)
+
+	/* load the run_at_load flag */
+	/* possibly patched by kexec */
+	ld	%r6,(run_at_load - 0b)(%r18)
+	/* and patch it into the kernel */
+	stw	%r6,(0x5c)(%r4)
+
+	mr	%r3,%r16	/* restore dt address */
+
+	li	%r5,0		/* r5 will be 0 for kernel */
+
+	mfmsr	%r11
+	andi.	%r10,%r11,1	/* test MSR_LE */
+	bne	.Little_endian
+
+	mtctr	%r4		/* prepare branch to */
+	bctr			/* start kernel */
+
+.Little_endian:
+	mtsrr0	%r4		/* prepare branch to */
+
+	clrrdi	%r11,%r11,1	/* clear MSR_LE */
+	mtsrr1	%r11
+
+	rfid			/* update MSR and start kernel */
+
+
+	.balign 8
+	.globl kernel
+kernel:
+	.llong  0x0
+	.size kernel, . - kernel
+
+	.balign 8
+	.globl dt_offset
+dt_offset:
+	.llong  0x0
+	.size dt_offset, . - dt_offset
+
+
+	.data
+	.balign 8
+.globl sha256_digest
+sha256_digest:
+	.skip	32
+	.size sha256_digest, . - sha256_digest
+
+	.balign 8
+.globl sha_regions
+sha_regions:
+	.skip	8 * 2 * 16
+	.size sha_regions, . - sha_regions
-- 
2.7.4

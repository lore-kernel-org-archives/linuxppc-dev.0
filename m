Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0083.outbound.protection.outlook.com [104.47.32.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGWBD0r9zzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:08:51 +1000 (AEST)
From: Brijesh Singh <brijesh.singh@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [RFC Part1 PATCH v3 14/17] x86/boot: Add early boot support when
 running with SEV active
Date: Mon, 24 Jul 2017 14:07:54 -0500
Message-Id: <20170724190757.11278-15-brijesh.singh@amd.com>
In-Reply-To: <20170724190757.11278-1-brijesh.singh@amd.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tom Lendacky <thomas.lendacky@amd.com>

Early in the boot process, add checks to determine if the kernel is
running with Secure Encrypted Virtualization (SEV) active.

Checking for SEV requires checking that the kernel is running under a
hypervisor (CPUID 0x00000001, bit 31), that the SEV feature is available
(CPUID 0x8000001f, bit 1) and then check a non-interceptable SEV MSR
(0xc0010131, bit 0).

This check is required so that during early compressed kernel booting the
pagetables (both the boot pagetables and KASLR pagetables (if enabled) are
updated to include the encryption mask so that when the kernel is
decompressed into encrypted memory.

After the kernel is decompressed and continues booting the same logic is
used to check if SEV is active and set a flag indicating so.  This allows
us to distinguish between SME and SEV, each of which have unique
differences in how certain things are handled: e.g. DMA (always bounce
buffered with SEV) or EFI tables (always access decrypted with SME).

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/Makefile      |   2 +
 arch/x86/boot/compressed/head_64.S     |  16 +++++
 arch/x86/boot/compressed/mem_encrypt.S | 103 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h        |   2 +
 arch/x86/boot/compressed/pagetable.c   |   8 ++-
 arch/x86/include/asm/mem_encrypt.h     |   3 +
 arch/x86/include/asm/msr-index.h       |   3 +
 arch/x86/include/uapi/asm/kvm_para.h   |   1 -
 arch/x86/mm/mem_encrypt.c              |  42 +++++++++++---
 9 files changed, 169 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/boot/compressed/mem_encrypt.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 2c860ad..d2fe901 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -72,6 +72,8 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/head_$(BITS).o $(obj)/misc.o \
 	$(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
 	$(obj)/piggy.o $(obj)/cpuflags.o
 
+vmlinux-objs-$(CONFIG_X86_64) += $(obj)/mem_encrypt.o
+
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
 ifdef CONFIG_X86_64
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fbf4c32..6179d43 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -130,6 +130,19 @@ ENTRY(startup_32)
  /*
   * Build early 4G boot pagetable
   */
+	/*
+	 * If SEV is active then set the encryption mask in the page tables.
+	 * This will insure that when the kernel is copied and decompressed
+	 * it will be done so encrypted.
+	 */
+	call	get_sev_encryption_bit
+	xorl	%edx, %edx
+	testl	%eax, %eax
+	jz	1f
+	subl	$32, %eax	/* Encryption bit is always above bit 31 */
+	bts	%eax, %edx	/* Set encryption mask for page tables */
+1:
+
 	/* Initialize Page tables to 0 */
 	leal	pgtable(%ebx), %edi
 	xorl	%eax, %eax
@@ -140,12 +153,14 @@ ENTRY(startup_32)
 	leal	pgtable + 0(%ebx), %edi
 	leal	0x1007 (%edi), %eax
 	movl	%eax, 0(%edi)
+	addl	%edx, 4(%edi)
 
 	/* Build Level 3 */
 	leal	pgtable + 0x1000(%ebx), %edi
 	leal	0x1007(%edi), %eax
 	movl	$4, %ecx
 1:	movl	%eax, 0x00(%edi)
+	addl	%edx, 0x04(%edi)
 	addl	$0x00001000, %eax
 	addl	$8, %edi
 	decl	%ecx
@@ -156,6 +171,7 @@ ENTRY(startup_32)
 	movl	$0x00000183, %eax
 	movl	$2048, %ecx
 1:	movl	%eax, 0(%edi)
+	addl	%edx, 4(%edi)
 	addl	$0x00200000, %eax
 	addl	$8, %edi
 	decl	%ecx
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
new file mode 100644
index 0000000..696716e
--- /dev/null
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -0,0 +1,103 @@
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2017 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/processor-flags.h>
+#include <asm/msr.h>
+#include <asm/asm-offsets.h>
+
+	.text
+	.code32
+ENTRY(get_sev_encryption_bit)
+	xor	%eax, %eax
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	push	%ebx
+	push	%ecx
+	push	%edx
+
+	/* Check if running under a hypervisor */
+	movl	$1, %eax
+	cpuid
+	bt	$31, %ecx		/* Check the hypervisor bit */
+	jnc	.Lno_sev
+
+	movl	$0x80000000, %eax	/* CPUID to check the highest leaf */
+	cpuid
+	cmpl	$0x8000001f, %eax	/* See if 0x8000001f is available */
+	jb	.Lno_sev
+
+	/*
+	 * Check for the SEV feature:
+	 *   CPUID Fn8000_001F[EAX] - Bit 1
+	 *   CPUID Fn8000_001F[EBX] - Bits 5:0
+	 *     Pagetable bit position used to indicate encryption
+	 */
+	movl	$0x8000001f, %eax
+	cpuid
+	bt	$1, %eax		/* Check if SEV is available */
+	jnc	.Lno_sev
+
+	movl	$MSR_F17H_SEV, %ecx	/* Read the SEV MSR */
+	rdmsr
+	bt	$MSR_F17H_SEV_ENABLED_BIT, %eax	/* Check if SEV is active */
+	jnc	.Lno_sev
+
+	/*
+	 * Get memory encryption information:
+	 */
+	movl	%ebx, %eax
+	andl	$0x3f, %eax		/* Return the encryption bit location */
+	jmp	.Lsev_exit
+
+.Lno_sev:
+	xor	%eax, %eax
+
+.Lsev_exit:
+	pop	%edx
+	pop	%ecx
+	pop	%ebx
+
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
+
+	ret
+ENDPROC(get_sev_encryption_bit)
+
+	.code64
+ENTRY(get_sev_encryption_mask)
+	xor	%rax, %rax
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	push	%rbp
+	push	%rdx
+
+	movq	%rsp, %rbp		/* Save current stack pointer */
+
+	call	get_sev_encryption_bit	/* Get the encryption bit position */
+	testl	%eax, %eax
+	jz	.Lno_sev_mask
+
+	xor	%rdx, %rdx
+	bts	%rax, %rdx		/* Create the encryption mask */
+	mov	%rdx, %rax		/* ... and return it */
+
+.Lno_sev_mask:
+	movq	%rbp, %rsp		/* Restore original stack pointer */
+
+	pop	%rdx
+	pop	%rbp
+
+#endif
+
+	ret
+ENDPROC(get_sev_encryption_mask)
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 766a521..38c5f0e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -108,4 +108,6 @@ static inline void console_init(void)
 { }
 #endif
 
+unsigned long get_sev_encryption_mask(void);
+
 #endif
diff --git a/arch/x86/boot/compressed/pagetable.c b/arch/x86/boot/compressed/pagetable.c
index f1aa438..a577329 100644
--- a/arch/x86/boot/compressed/pagetable.c
+++ b/arch/x86/boot/compressed/pagetable.c
@@ -76,16 +76,18 @@ static unsigned long top_level_pgt;
  * Mapping information structure passed to kernel_ident_mapping_init().
  * Due to relocation, pointers must be assigned at run time not build time.
  */
-static struct x86_mapping_info mapping_info = {
-	.page_flag       = __PAGE_KERNEL_LARGE_EXEC,
-};
+static struct x86_mapping_info mapping_info;
 
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
+	unsigned long sev_me_mask = get_sev_encryption_mask();
+
 	/* Init mapping_info with run-time function/buffer pointers. */
 	mapping_info.alloc_pgt_page = alloc_pgt_page;
 	mapping_info.context = &pgt_data;
+	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sev_me_mask;
+	mapping_info.kernpg_flag = _KERNPG_TABLE | sev_me_mask;
 
 	/*
 	 * It should be impossible for this not to already be true,
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9274ec7..9cb6472 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -19,6 +19,9 @@
 
 #include <asm/bootparam.h>
 
+#define AMD_SME_FEATURE_BIT	BIT(0)
+#define AMD_SEV_FEATURE_BIT	BIT(1)
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern unsigned long sme_me_mask;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e399d68..530020f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -326,6 +326,9 @@
 
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
+#define MSR_F17H_SEV			0xc0010131
+#define MSR_F17H_SEV_ENABLED_BIT	0
+#define MSR_F17H_SEV_ENABLED		BIT_ULL(MSR_F17H_SEV_ENABLED_BIT)
 
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index a965e5b..c202ba3 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -109,5 +109,4 @@ struct kvm_vcpu_pv_apf_data {
 #define KVM_PV_EOI_ENABLED KVM_PV_EOI_MASK
 #define KVM_PV_EOI_DISABLED 0x0
 
-
 #endif /* _UAPI_ASM_X86_KVM_PARA_H */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 5e5d460..ed8780e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -288,7 +288,9 @@ void __init mem_encrypt_init(void)
 	if (sev_active())
 		dma_ops = &sme_dma_ops;
 
-	pr_info("AMD Secure Memory Encryption (SME) active\n");
+	pr_info("AMD %s active\n",
+		sev_active() ? "Secure Encrypted Virtualization (SEV)"
+			     : "Secure Memory Encryption (SME)");
 }
 
 void swiotlb_set_mem_attributes(void *vaddr, unsigned long size)
@@ -616,12 +618,23 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
+	unsigned long feature_mask;
 	bool active_by_default;
 	unsigned long me_mask;
 	char buffer[16];
 	u64 msr;
 
-	/* Check for the SME support leaf */
+	/*
+	 * Set the feature mask (SME or SEV) based on whether we are
+	 * running under a hypervisor.
+	 */
+	eax = 1;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	feature_mask = (ecx & BIT(31)) ? AMD_SEV_FEATURE_BIT
+				       : AMD_SME_FEATURE_BIT;
+
+	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
@@ -629,24 +642,39 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
 		return;
 
 	/*
-	 * Check for the SME feature:
+	 * Check for the SME/SEV feature:
 	 *   CPUID Fn8000_001F[EAX] - Bit 0
 	 *     Secure Memory Encryption support
+	 *   CPUID Fn8000_001F[EAX] - Bit 1
+	 *     Secure Encrypted Virtualization support
 	 *   CPUID Fn8000_001F[EBX] - Bits 5:0
 	 *     Pagetable bit position used to indicate encryption
 	 */
 	eax = 0x8000001f;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (!(eax & 1))
+	if (!(eax & feature_mask))
 		return;
 
 	me_mask = 1UL << (ebx & 0x3f);
 
-	/* Check if SME is enabled */
-	msr = __rdmsr(MSR_K8_SYSCFG);
-	if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
+	/* Check if memory encryption is enabled */
+	if (feature_mask == AMD_SME_FEATURE_BIT) {
+		/* For SME, check the SYSCFG MSR */
+		msr = __rdmsr(MSR_K8_SYSCFG);
+		if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
+			return;
+	} else {
+		/* For SEV, check the SEV MSR */
+		msr = __rdmsr(MSR_F17H_SEV);
+		if (!(msr & MSR_F17H_SEV_ENABLED))
+			return;
+
+		/* SEV state cannot be controlled by a command line option */
+		sme_me_mask = me_mask;
+		sev_enabled = 1;
 		return;
+	}
 
 	/*
 	 * Fixups have not been applied to phys_base yet and we're running
-- 
2.9.4

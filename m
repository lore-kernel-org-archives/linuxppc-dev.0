Return-Path: <bp@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGvZR70PLzDqm4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 20:27:43 +1000 (AEST)
Date: Tue, 25 Jul 2017 12:26:57 +0200
From: Borislav Petkov <bp@suse.de>
To: Brijesh Singh <brijesh.singh@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 David Howells <dhowells@redhat.com>,
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
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>
Subject: Re: [RFC Part1 PATCH v3 02/17] x86/CPU/AMD: Add the Secure Encrypted
 Virtualization CPU feature
Message-ID: <20170725102657.GD21822@nazgul.tnic>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170724190757.11278-3-brijesh.singh@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2017 at 02:07:42PM -0500, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Update the CPU features to include identifying and reporting on the
> Secure Encrypted Virtualization (SEV) feature.  SME is identified by
> CPUID 0x8000001f, but requires BIOS support to enable it (set bit 23 of
> MSR_K8_SYSCFG and set bit 0 of MSR_K7_HWCR).  Only show the SEV feature
> as available if reported by CPUID and enabled by BIOS.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/include/asm/msr-index.h   |  2 ++
>  arch/x86/kernel/cpu/amd.c          | 30 +++++++++++++++++++++++++-----
>  arch/x86/kernel/cpu/scattered.c    |  1 +
>  4 files changed, 29 insertions(+), 5 deletions(-)

...

> @@ -637,6 +642,21 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>  			clear_cpu_cap(c, X86_FEATURE_SME);
>  		}
>  	}
> +
> +	if (cpu_has(c, X86_FEATURE_SEV)) {
> +		if (IS_ENABLED(CONFIG_X86_32)) {
> +			clear_cpu_cap(c, X86_FEATURE_SEV);
> +		} else {
> +			u64 syscfg, hwcr;
> +
> +			/* Check if SEV is enabled */
> +			rdmsrl(MSR_K8_SYSCFG, syscfg);
> +			rdmsrl(MSR_K7_HWCR, hwcr);
> +			if (!(syscfg & MSR_K8_SYSCFG_MEM_ENCRYPT) ||
> +			    !(hwcr & MSR_K7_HWCR_SMMLOCK))
> +				clear_cpu_cap(c, X86_FEATURE_SEV);
> +		}
> +	}

Let's simplify this and read the MSRs only once. Diff ontop. Please
check if I'm missing a case:

---
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index c413f04bdd41..79af07731ab1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -546,6 +546,48 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 }
 
+static void early_detect_mem_enc(struct cpuinfo_x86 *c)
+{
+	u64 syscfg, hwcr;
+
+	/*
+	 * BIOS support is required for SME and SEV.
+	 *   For SME: If BIOS has enabled SME then adjust x86_phys_bits by
+	 *	      the SME physical address space reduction value.
+	 *	      If BIOS has not enabled SME then don't advertise the
+	 *	      SME feature (set in scattered.c).
+	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
+	 *            SEV feature (set in scattered.c).
+	 *
+	 *   In all cases, since support for SME and SEV requires long mode,
+	 *   don't advertise the feature under CONFIG_X86_32.
+	 */
+	if (cpu_has(c, X86_FEATURE_SME) ||
+	    cpu_has(c, X86_FEATURE_SEV)) {
+
+		if (IS_ENABLED(CONFIG_X86_32))
+			goto clear;
+
+		/* Check if SME is enabled */
+		rdmsrl(MSR_K8_SYSCFG, syscfg);
+		if (!(syscfg & MSR_K8_SYSCFG_MEM_ENCRYPT))
+			goto clear;
+
+		c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
+
+		/* Check if SEV is enabled */
+		rdmsrl(MSR_K7_HWCR, hwcr);
+		if (!(hwcr & MSR_K7_HWCR_SMMLOCK))
+			goto clear_sev;
+
+		return;
+clear:
+		clear_cpu_cap(c, X86_FEATURE_SME);
+clear_sev:
+		clear_cpu_cap(c, X86_FEATURE_SEV);
+	}
+}
+
 static void early_init_amd(struct cpuinfo_x86 *c)
 {
 	u32 dummy;
@@ -617,46 +659,8 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has_amd_erratum(c, amd_erratum_400))
 		set_cpu_bug(c, X86_BUG_AMD_E400);
 
-	/*
-	 * BIOS support is required for SME and SEV.
-	 *   For SME: If BIOS has enabled SME then adjust x86_phys_bits by
-	 *	      the SME physical address space reduction value.
-	 *	      If BIOS has not enabled SME then don't advertise the
-	 *	      SME feature (set in scattered.c).
-	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
-	 *            SEV feature (set in scattered.c).
-	 *
-	 *   In all cases, since support for SME and SEV requires long mode,
-	 *   don't advertise the feature under CONFIG_X86_32.
-	 */
-	if (cpu_has(c, X86_FEATURE_SME)) {
-		u64 msr;
-
-		/* Check if SME is enabled */
-		rdmsrl(MSR_K8_SYSCFG, msr);
-		if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT) {
-			c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
-			if (IS_ENABLED(CONFIG_X86_32))
-				clear_cpu_cap(c, X86_FEATURE_SME);
-		} else {
-			clear_cpu_cap(c, X86_FEATURE_SME);
-		}
-	}
+	early_detect_mem_enc(c);
 
-	if (cpu_has(c, X86_FEATURE_SEV)) {
-		if (IS_ENABLED(CONFIG_X86_32)) {
-			clear_cpu_cap(c, X86_FEATURE_SEV);
-		} else {
-			u64 syscfg, hwcr;
-
-			/* Check if SEV is enabled */
-			rdmsrl(MSR_K8_SYSCFG, syscfg);
-			rdmsrl(MSR_K7_HWCR, hwcr);
-			if (!(syscfg & MSR_K8_SYSCFG_MEM_ENCRYPT) ||
-			    !(hwcr & MSR_K7_HWCR_SMMLOCK))
-				clear_cpu_cap(c, X86_FEATURE_SEV);
-		}
-	}
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

Return-Path: <bp@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjwYb2xzFzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 07:31:47 +1000 (AEST)
Date: Thu, 31 Aug 2017 17:06:23 +0200
From: Borislav Petkov <bp@suse.de>
To: Brijesh Singh <brijesh.singh@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
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
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Subject: Re: [RFC Part1 PATCH v3 17/17] X86/KVM: Clear encryption attribute
 when SEV is active
Message-ID: <20170831150623.cljoy6rm72pn24wg@pd.tnic>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-18-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170724190757.11278-18-brijesh.singh@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2017 at 02:07:57PM -0500, Brijesh Singh wrote:
> The guest physical memory area holding the struct pvclock_wall_clock and
> struct pvclock_vcpu_time_info are shared with the hypervisor. Hypervisor
> periodically updates the contents of the memory. When SEV is active, we
> must clear the encryption attributes from the shared memory pages so that
> both hypervisor and guest can access the data.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/entry/vdso/vma.c  |  5 ++--
>  arch/x86/kernel/kvmclock.c | 64 +++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 726355c..ff50251 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -114,10 +114,11 @@ static int vvar_fault(const struct vm_special_mapping *sm,
>  		struct pvclock_vsyscall_time_info *pvti =
>  			pvclock_pvti_cpu0_va();
>  		if (pvti && vclock_was_used(VCLOCK_PVCLOCK)) {
> -			ret = vm_insert_pfn(
> +			ret = vm_insert_pfn_prot(
>  				vma,
>  				vmf->address,
> -				__pa(pvti) >> PAGE_SHIFT);
> +				__pa(pvti) >> PAGE_SHIFT,
> +				pgprot_decrypted(vma->vm_page_prot));
>  		}
>  	} else if (sym_offset == image->sym_hvclock_page) {
>  		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();

Yuck, that vvar_fault() function is one unreadable mess.

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index d889676..f3a8101 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
>  
> +#include <asm/mem_encrypt.h>
>  #include <asm/x86_init.h>
>  #include <asm/reboot.h>
>  #include <asm/kvmclock.h>
> @@ -45,7 +46,7 @@ early_param("no-kvmclock", parse_no_kvmclock);
>  
>  /* The hypervisor will put information about time periodically here */
>  static struct pvclock_vsyscall_time_info *hv_clock;
> -static struct pvclock_wall_clock wall_clock;
> +static struct pvclock_wall_clock *wall_clock;
>  
>  struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
>  {
> @@ -64,15 +65,18 @@ static void kvm_get_wallclock(struct timespec *now)
>  	int low, high;
>  	int cpu;
>  
> -	low = (int)__pa_symbol(&wall_clock);
> -	high = ((u64)__pa_symbol(&wall_clock) >> 32);
> +	if (!wall_clock)
> +		return;

Hmm, so if you return here, @now will remain unchanged so how is the
caller to know that ->get_wallclock() failed?

Maybe a WARN_ON_ONCE() at least...?

Dunno, what's the policy in kvm if the kvmclock init fails?

Paolo? Radim?

Because it does say:

        printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
                msr_kvm_system_time, msr_kvm_wall_clock);

too early. We can error out later and users will still think it is using
kvmclock ...

Hmmm.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

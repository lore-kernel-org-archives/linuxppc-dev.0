Return-Path: <Hollis_Blanchard@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0D0E4B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Aug 2010 03:16:54 +1000 (EST)
Message-ID: <4C5AF202.1000702@mentor.com>
Date: Thu, 05 Aug 2010 10:16:50 -0700
From: Hollis Blanchard <hollis_blanchard@mentor.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 17/27] KVM: PPC: KVM PV guest stubs
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
	<1280407688-9815-18-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-18-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2010 05:47 AM, Alexander Graf wrote:
> We will soon start and replace instructions from the text section with
> other, paravirtualized versions. To ease the readability of those patches
> I split out the generic looping and magic page mapping code out.
>
> This patch still only contains stubs. But at least it loops through the
> text section :).
>
> Signed-off-by: Alexander Graf<agraf@suse.de>
>
> ---
>
> v1 ->  v2:
>
>    - kvm guest patch framework: introduce patch_ins
>
> v2 ->  v3:
>
>    - add self-test in guest code
>    - remove superfluous new lines in generic guest code
> ---
>   arch/powerpc/kernel/kvm.c |   95 +++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 95 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index a5ece71..e93366f 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -33,6 +33,62 @@
>   #define KVM_MAGIC_PAGE		(-4096L)
>   #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
>
> +#define KVM_MASK_RT		0x03e00000
> +
> +static bool kvm_patching_worked = true;
> +
> +static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
> +{
> +	*inst = new_inst;
> +	flush_icache_range((ulong)inst, (ulong)inst + 4);
> +}
> +
> +static void kvm_map_magic_page(void *data)
> +{
> +	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
> +		       KVM_MAGIC_PAGE,  /* Physical Address */
> +		       KVM_MAGIC_PAGE); /* Effective Address */
> +}
> +
> +static void kvm_check_ins(u32 *inst)
> +{
> +	u32 _inst = *inst;
> +	u32 inst_no_rt = _inst&  ~KVM_MASK_RT;
> +	u32 inst_rt = _inst&  KVM_MASK_RT;
> +
> +	switch (inst_no_rt) {
> +	}
> +
> +	switch (_inst) {
> +	}
> +}
> +
> +static void kvm_use_magic_page(void)
> +{
> +	u32 *p;
> +	u32 *start, *end;
> +	u32 tmp;
> +
> +	/* Tell the host to map the magic page to -4096 on all CPUs */
> +	on_each_cpu(kvm_map_magic_page, NULL, 1);
> +
> +	/* Quick self-test to see if the mapping works */
> +	if (__get_user(tmp, (u32*)KVM_MAGIC_PAGE)) {
> +		kvm_patching_worked = false;
> +		return;
> +	}
> +
> +	/* Now loop through all code and find instructions */
> +	start = (void*)_stext;
> +	end = (void*)_etext;
> +
> +	for (p = start; p<  end; p++)
> +		kvm_check_ins(p);
> +
> +	printk(KERN_INFO "KVM: Live patching for a fast VM %s\n",
> +			 kvm_patching_worked ? "worked" : "failed");
> +}
>    
Rather than have the guest loop through every instruction in its text, 
why can't you use the existing cputable self-patching mechanism? The 
kernel already uses that in a number of places to patch itself at 
runtime in fast paths... see Documentation/powerpc/cpu_features.txt for 
some background.

Since we already know (at build time) the location of code that needs 
patching, we don't need to scan at all. (I also shudder to think of the 
number of page faults this scan will incur.)

Hollis Blanchard
Mentor Graphics, Embedded Systems Division

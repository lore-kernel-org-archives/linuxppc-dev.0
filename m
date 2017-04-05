Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyY5Y5V17zDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 14:39:13 +1000 (AEST)
Date: Wed, 5 Apr 2017 14:39:10 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S PR: Do not fail emulation with
 mtspr/mfspr for unknown SPRs
Message-ID: <20170405043910.GA26143@fergus.ozlabs.ibm.com>
References: <1491300303-16153-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491300303-16153-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 04, 2017 at 12:05:03PM +0200, Thomas Huth wrote:
> According to the PowerISA 2.07, mtspr and mfspr should not always
> generate an illegal instruction exception when being used with an
> undefined SPR, but rather treat the instruction as a NOP or inject a
> privilege exception in some cases, too - depending on the SPR number.
> Also turn the printk here into a ratelimited print statement, so that
> the guest can not flood the dmesg log of the host by issueing lots of
> illegal mtspr/mfspr instruction here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Inject illegal instruction program interrupt instead of emulation
>    assist interrupt (according to the last programming note in section
>    6.5.9 of Book III of the PowerISA v2.07)
> 
>  arch/powerpc/kvm/book3s_emulate.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index 8359752..bf4181e 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -503,10 +503,14 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
>  		break;
>  unprivileged:
>  	default:
> -		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
> -#ifndef DEBUG_SPR
> -		emulated = EMULATE_FAIL;
> -#endif
> +		pr_info_ratelimited("KVM: invalid SPR write: %d\n", sprn);
> +		if (sprn & 0x10) {
> +			if (kvmppc_get_msr(vcpu) & MSR_PR)
> +				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
> +		} else {
> +			if ((kvmppc_get_msr(vcpu) & MSR_PR) || sprn == 0)
> +				kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> +		}
>  		break;

In the cases where we generate an interrupt, we are now returning
EMULATE_DONE, which means that kvmppc_emulate_instruction() will
advance the PC by 4 after this function returns.  Since
kvmppc_core_queue_program() injects the interrupt straight away, this
means that the guest will resume execution at 0x704 rather than
0x700.

Paul.

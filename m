Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AE6D2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 08:59:21 +1000 (EST)
Message-ID: <1375484319.26902.4.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
 booke3s
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Date: Fri, 2 Aug 2013 17:58:39 -0500
In-Reply-To: <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-01 at 16:42 +0530, Bharat Bhushan wrote:
> KVM need to lookup linux pte for getting TLB attributes (WIMGE).
> This is similar to how book3s does.
> This will be used in follow-up patches.
> 
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v1->v2
>  - This is a new change in this version
> 
>  arch/powerpc/include/asm/kvm_booke.h |   73 ++++++++++++++++++++++++++++++++++
>  1 files changed, 73 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
> index d3c1eb3..903624d 100644
> --- a/arch/powerpc/include/asm/kvm_booke.h
> +++ b/arch/powerpc/include/asm/kvm_booke.h
> @@ -102,4 +102,77 @@ static inline ulong kvmppc_get_msr(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->arch.shared->msr;
>  }
> +
> +/*
> + * Lock and read a linux PTE.  If it's present and writable, atomically
> + * set dirty and referenced bits and return the PTE, otherwise return 0.
> + */
> +static inline pte_t kvmppc_read_update_linux_pte(pte_t *p, int writing)
> +{
> +	pte_t pte;
> +
> +#ifdef PTE_ATOMIC_UPDATES
> +	pte_t tmp;
> +        /* wait until _PAGE_BUSY is clear then set it atomically */

_PAGE_BUSY is 0 on book3e.

> +#ifdef CONFIG_PPC64
> +	__asm__ __volatile__ (
> +		"1:	ldarx	%0,0,%3\n"
> +		"	andi.	%1,%0,%4\n"
> +		"	bne-	1b\n"
> +		"	ori	%1,%0,%4\n"
> +		"	stdcx.	%1,0,%3\n"
> +		"	bne-	1b"
> +		: "=&r" (pte), "=&r" (tmp), "=m" (*p)
> +		: "r" (p), "i" (_PAGE_BUSY)
> +		: "cc");
> +#else
> +        __asm__ __volatile__ (
> +                "1:     lwarx   %0,0,%3\n"
> +                "       andi.   %1,%0,%4\n"
> +                "       bne-    1b\n"
> +                "       ori     %1,%0,%4\n"
> +                "       stwcx.  %1,0,%3\n"
> +                "       bne-    1b"
> +                : "=&r" (pte), "=&r" (tmp), "=m" (*p)
> +                : "r" (p), "i" (_PAGE_BUSY)
> +                : "cc");
> +#endif

What about 64-bit PTEs on 32-bit kernels?

In any case, this code does not belong in KVM.  It should be in the main
PPC mm code, even if KVM is the only user.

-Scott

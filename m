Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E8062C010F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 07:08:18 +1000 (EST)
Message-ID: <1379624878.16231.3.camel@aoeu.buserror.net>
Subject: Re: [PATCH 5/6 v5] kvm: booke: clear host tlb reference flag on
 guest tlb invalidation
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Date: Thu, 19 Sep 2013 16:07:58 -0500
In-Reply-To: <1379570566-3715-6-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379570566-3715-6-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-19 at 11:32 +0530, Bharat Bhushan wrote:
> On booke, "struct tlbe_ref" contains host tlb mapping information
> (pfn: for guest-pfn to pfn, flags: attribute associated with this mapping)
> for a guest tlb entry. So when a guest creates a TLB entry then
> "struct tlbe_ref" is set to point to valid "pfn" and set attributes in
> "flags" field of the above said structure. When a guest TLB entry is
> invalidated then flags field of corresponding "struct tlbe_ref" is
> updated to point that this is no more valid, also we selectively clear
> some other attribute bits, example: if E500_TLB_BITMAP was set then we clear
> E500_TLB_BITMAP, if E500_TLB_TLB0 is set then we clear this.
> 
> Ideally we should clear complete "flags" as this entry is invalid and does not
> have anything to re-used. The other part of the problem is that when we use
> the same entry again then also we do not clear (started doing or-ing etc).
> 
> So far it was working because the selectively clearing mentioned above
> actually clears "flags" what was set during TLB mapping. But the problem
> starts coming when we add more attributes to this then we need to selectively
> clear them and which is not needed.
> 
> This patch we do both
>         - Clear "flags" when invalidating;
>         - Clear "flags" when reusing same entry later
> 
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v3-> v5
>  - New patch (found this issue when doing vfio-pci development)
> 
>  arch/powerpc/kvm/e500_mmu_host.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 1c6a9d7..60f5a3c 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -217,7 +217,8 @@ void inval_gtlbe_on_host(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
>  		}
>  		mb();
>  		vcpu_e500->g2h_tlb1_map[esel] = 0;
> -		ref->flags &= ~(E500_TLB_BITMAP | E500_TLB_VALID);
> +		/* Clear flags as TLB is not backed by the host anymore */
> +		ref->flags = 0;
>  		local_irq_restore(flags);
>  	}

This breaks when you have both E500_TLB_BITMAP and E500_TLB_TLB0 set.

Instead, just convert the final E500_TLB_VALID clearing at the end into
ref->flags = 0, and convert the early return a few lines earlier into
conditional execution of the tlbil_one().

-Scott

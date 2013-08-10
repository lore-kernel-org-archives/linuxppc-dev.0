Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 98AC52C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 11:04:58 +1000 (EST)
Message-ID: <1376096685.15633.109.camel@snotra.buserror.net>
Subject: Re: [PATCH 6/6 v3] kvm: powerpc: use caching attributes as per
 linux pte
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Date: Fri, 9 Aug 2013 20:04:45 -0500
In-Reply-To: <1375788674-13140-7-git-send-email-Bharat.Bhushan@freescale.com>
References: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375788674-13140-7-git-send-email-Bharat.Bhushan@freescale.com>
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

On Tue, 2013-08-06 at 17:01 +0530, Bharat Bhushan wrote:
> @@ -449,7 +446,16 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  		gvaddr &= ~((tsize_pages << PAGE_SHIFT) - 1);
>  	}
>  
> -	kvmppc_e500_ref_setup(ref, gtlbe, pfn);
> +	pgdir = vcpu_e500->vcpu.arch.pgdir;
> +	ptep = lookup_linux_pte(pgdir, hva, &tsize_pages);
> +	if (pte_present(*ptep)) {
> +		wimg = (pte_val(*ptep) >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
> +	} else {
> +		printk(KERN_ERR "pte not present: gfn %lx, pfn %lx\n",
> +				(long)gfn, pfn);
> +		return -EINVAL;

Don't let the guest spam the host kernel console by repeatedly accessing
bad mappings (even if it requires host userspace to assist by pointing a
memslot at a bad hva).  This should at most be printk_ratelimited(), and
probably just pr_debug().  It should also have __func__ context.

Also, I don't see the return value getting checked (the immediate
callers check it and propogate the error, but kvmppc_mmu_map() doesn't).
We want to send a machine check to the guest if this happens (or
possibly exit to userspace since it indicates a bad memslot, not just a
guest bug).  We don't want to just silently retry over and over.

Otherwise, this series looks good to me.

-Scott

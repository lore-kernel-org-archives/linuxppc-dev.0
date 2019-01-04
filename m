Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD8EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:03:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED37218D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED37218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WgLw2c4bzDqNb
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 10:03:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WVdZ2rTRzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 03:30:41 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jan 2019 08:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; d="scan'208";a="124112789"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.154])
 by orsmga001.jf.intel.com with ESMTP; 04 Jan 2019 08:30:35 -0800
Date: Fri, 4 Jan 2019 08:30:35 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: lantianyu1986@gmail.com
Subject: Re: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
Message-ID: <20190104163035.GC11288@linux.intel.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Approved-At: Sat, 05 Jan 2019 10:00:30 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: , kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 04, 2019 at 04:54:00PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> This patch is to flush tlb via flush list function.

More explanation of why this is beneficial would be nice.  Without the
context of the overall series it's not immediately obvious what
kvm_flush_remote_tlbs_with_list() does without a bit of digging.

> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> index 833e8855bbc9..866ccdea762e 100644
> --- a/arch/x86/kvm/paging_tmpl.h
> +++ b/arch/x86/kvm/paging_tmpl.h
> @@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>  	bool host_writable;
>  	gpa_t first_pte_gpa;
>  	int set_spte_ret = 0;
> +	LIST_HEAD(flush_list);
>  
>  	/* direct kvm_mmu_page can not be unsync. */
>  	BUG_ON(sp->role.direct);
> @@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>  	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
>  
>  	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
> +		int tmp_spte_ret = 0;
>  		unsigned pte_access;
>  		pt_element_t gpte;
>  		gpa_t pte_gpa;
> @@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>  
>  		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
>  
> -		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
> +		tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
>  					 pte_access, PT_PAGE_TABLE_LEVEL,
>  					 gfn, spte_to_pfn(sp->spt[i]),
>  					 true, false, host_writable);
> +
> +		if (kvm_available_flush_tlb_with_range()
> +		    && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
> +			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
> +					& PT64_BASE_ADDR_MASK);
> +			list_add(&leaf_sp->flush_link, &flush_list);
> +		}
> +
> +		set_spte_ret |= tmp_spte_ret;
> +
>  	}
>  
>  	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
> -		kvm_flush_remote_tlbs(vcpu->kvm);
> +		kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);

This is a bit confusing and potentially fragile.  It's not obvious that
kvm_flush_remote_tlbs_with_list() is guaranteed to call
kvm_flush_remote_tlbs() when kvm_available_flush_tlb_with_range() is
false, and you're relying on the kvm_flush_remote_tlbs_with_list() call
chain to never optimize away the empty list case.  Rechecking
kvm_available_flush_tlb_with_range() isn't expensive.

>  
>  	return nr_present;
>  }
> -- 
> 2.14.4
> 

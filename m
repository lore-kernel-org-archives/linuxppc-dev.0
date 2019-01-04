Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C3C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6137218D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6137218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WgK32hfjzDqNL
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 10:01:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WTlQ6RRdzDqHf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 02:50:38 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jan 2019 07:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; d="scan'208";a="103935317"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.154])
 by orsmga007.jf.intel.com with ESMTP; 04 Jan 2019 07:50:36 -0800
Date: Fri, 4 Jan 2019 07:50:36 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: lantianyu1986@gmail.com
Subject: Re: [PATCH 7/11] KVM: Remove redundant check in the
 kvm_get_dirty_log_protect()
Message-ID: <20190104155036.GA11288@linux.intel.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
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

On Fri, Jan 04, 2019 at 04:54:01PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> The dirty bits have already been checked in the previous check of
> "dirty_bitmap" and mask must be non-zero value at this point.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  virt/kvm/kvm_main.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf7cc0554094..e75dbb15fd09 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1206,11 +1206,9 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
>  			mask = xchg(&dirty_bitmap[i], 0);
>  			dirty_bitmap_buffer[i] = mask;
>  
> -			if (mask) {
> -				offset = i * BITS_PER_LONG;
> -				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
> -									offset, mask);
> -			}
> +			offset = i * BITS_PER_LONG;
> +			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
> +								offset, mask);

Hmm, the check against mask was explicitly added by commit 58d2930f4ee3
("KVM: Eliminate extra function calls in kvm_get_dirty_log_protect()").
AFAIK KVM only *sets* bits in dirty_bitmap without holding slots_lock
and/or mmu_lock, so I agree that checking mask is redundant, but it'd be
nice to elaborate a bit more in the changelog.

At the very least this needs a Fixes tag for the aforementioned commit.


Tangentially related, does mmu_lock actually need to be held while we
walk dirty_bitmap in kvm_{clear,get}_dirty_log_protect()?  The bitmap
itself is protected by slots_lock (a lockdep assertion would be nice
too), e.g. can we grab the lock iff dirty_bitmap[i] != 0?

>  		}
>  		spin_unlock(&kvm->mmu_lock);
>  	}
> -- 
> 2.14.4
> 

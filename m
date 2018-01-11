Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHLy95rtpzF0XH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:01:53 +1100 (AEDT)
Date: Thu, 11 Jan 2018 20:56:14 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alexander Graf <agraf@suse.com>
Subject: Re: [RFC PATCH kernel] KVM: PPC: Book3S PR: Fix WIMG handling under
 pHyp
Message-ID: <20180111095614.GH24294@fergus.ozlabs.ibm.com>
References: <20171122034221.647-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171122034221.647-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 22, 2017 at 02:42:21PM +1100, Alexey Kardashevskiy wrote:
> 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits" added WIMG
> bits preserving but it missed 2 special cases:
> - a magic page in kvmppc_mmu_book3s_64_xlate() and
> - guest real mode in kvmppc_handle_pagefault().
> 
> For these ptes WIMG were 0 and pHyp failed on these causing a guest to
> stop in the very beginning at NIP=0x100 (due to bd9166ffe
> "KVM: PPC: Book3S PR: Exit KVM on failed mapping").
> 
> This initializes WIMG to non-zero value HPTE_R_M. The value is chosen
> as (0x192 & HPTE_R_WIMG); 0x192 is a magic value from
> kvmppc_mmu_map_page().
> 
> Fixes: 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, applied to my kvm-ppc-fixes branch, with an updated commit
message, fixes: tag, and cc:stable@vger.kernel.org.

Paul.

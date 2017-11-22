Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhm0S5ZqszDr4P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 02:02:47 +1100 (AEDT)
Subject: Re: [RFC PATCH kernel] KVM: PPC: Book3S PR: Fix WIMG handling under
 pHyp
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Ruediger Oertel <ro@suse.de>
References: <20171122034221.647-1-aik@ozlabs.ru>
From: Alexander Graf <agraf@suse.de>
Message-ID: <2e248967-7157-0283-dc41-8e4bde429e78@suse.de>
Date: Wed, 22 Nov 2017 16:02:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171122034221.647-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 22.11.17 04:42, Alexey Kardashevskiy wrote:
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
> ---
> 
> This indeed fixes PR KVM + VFIO under pHyp but selection of HPTE_R_M
> is arguable.

This does indeed fix the breakage we've seen:

Tested-by: Ruediger Oertel <ro@suse.de>


Alex

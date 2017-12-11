Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywKWw1jP0zDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 21:51:39 +1100 (AEDT)
Subject: Re: [RFC PATCH kernel] KVM: PPC: Book3S PR: Fix WIMG handling under
 pHyp
To: Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
References: <20171122034221.647-1-aik@ozlabs.ru>
 <20171124003330.2a980994@bahia.lan>
From: Alexander Graf <agraf@suse.de>
Message-ID: <d49d9dac-6230-8c60-51bc-cce7efb6ac56@suse.de>
Date: Mon, 11 Dec 2017 11:51:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171124003330.2a980994@bahia.lan>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24.11.17 00:33, Greg Kurz wrote:
> On Wed, 22 Nov 2017 14:42:21 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits" added WIMG
>> bits preserving but it missed 2 special cases:
>> - a magic page in kvmppc_mmu_book3s_64_xlate() and
>> - guest real mode in kvmppc_handle_pagefault().
>>
>> For these ptes WIMG were 0 and pHyp failed on these causing a guest to
>> stop in the very beginning at NIP=0x100 (due to bd9166ffe
>> "KVM: PPC: Book3S PR: Exit KVM on failed mapping").
>>
>> This initializes WIMG to non-zero value HPTE_R_M. The value is chosen
>> as (0x192 & HPTE_R_WIMG); 0x192 is a magic value from
>> kvmppc_mmu_map_page().
>>
>> Fixes: 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits"
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This indeed fixes PR KVM + VFIO under pHyp but selection of HPTE_R_M
>> is arguable.
>>
> 
> The initial page fault at 0x100 on machine startup causes H_ENTER to fail in
> pHyp with H_PARAMETER, as described in PAPR:
> 
>  The hypervisor checks that the WIMG bits within the PTE are appropriate for the
>  physical page number else H_Parameter return. (For System Memory pages WIMG=0010,
>  or, 1110 if the SAO option is enabled, and for IO pages WIMG=01**.)
> 
> I'm not aware we care for SAO so HPTE_R_M looks like the only sensible choice,
> or I'm missing something ?
> 
> Anyway, this patch allows to start a PR guest on PowerVM again.
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> and
> 
> Tested-by: Greg Kurz <groug@kaod.org>

So doesn't that mean we should pick it up, mark it CC stable and push it
upstream?


Alex

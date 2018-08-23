Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x2yy3XKpzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 21:59:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RESEND PATCH v2] powerpc/mce: Fix SLB rebolting during MCE
 recovery path.
In-Reply-To: <20180823170202.775e8bb0@roar.ozlabs.ibm.com>
References: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
 <20180823170202.775e8bb0@roar.ozlabs.ibm.com>
Date: Thu, 23 Aug 2018 21:59:53 +1000
Message-ID: <874lfll2di.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Thu, 23 Aug 2018 12:06:53 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> 
>> With the powerpc next commit e7e81847478 (powerpc/mce: Fix SLB rebolting
>> during MCE recovery path.), the SLB error recovery is broken. The new
>> change now does not add index value to RB[52-63] that selects the SLB
>> entry while rebolting, instead it assumes that the shadow save area
>> already have index embeded correctly in esid field. While all valid bolted
>> save areas do contain index value set correctly, there is a case where
>> 3rd (KSTACK_INDEX) entry for kernel stack does not embed index for NULL
>> esid entry. This patch fixes that.
>> 
>> Without this patch the SLB rebolt code overwrites the 1st entry of kernel
>> linear mapping and causes SLB recovery to fail.
>> 
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
> Changelog just needs a little more work, maybe this?
>
>
> The commit e7e81847478 ("powerpc/64s: move machine check SLB flushing
> to mm/slb.c") introduced a bug in reloading bolted SLB entries. Unused
> bolted entries are stored with .esid=0 in the slb_shadow area, and
> that value is now used directly as the RB input to slbmte, which means
> the RB[52:63] index field is set to 0, which causes SLB entry 0 to be
> cleared.
>
> Fix this by storing the index bits in the unused bolted entries, which
> directs the slbmte to the right place.
>
> The SLB shadow area is also used by the hypervisor, but PAPR is okay
> with that, from LoPAPR v1.1, 14.11.1.3 SLB Shadow Buffer:
>
>   Note: SLB is filled sequentially starting at index 0
>   from the shadow buffer ignoring the contents of
>   RB field bits 52-63
>
> Fixes: e7e81847478 ("powerpc/64s: move machine check SLB flushing to
> mm/slb.c")

Yep I'll take that, thanks.

cheers

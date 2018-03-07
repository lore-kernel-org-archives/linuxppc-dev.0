Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxB8y2LXCzF1VR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 22:23:29 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id 61-v6so1132821plf.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 03:23:29 -0800 (PST)
Date: Wed, 7 Mar 2018 21:23:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/14] numa aware allocation for pacas, stacks, pagetables
Message-ID: <20180307212315.7a773bad@roar.ozlabs.ibm.com>
In-Reply-To: <87muzkdusj.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <87muzkdusj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 07 Mar 2018 21:50:04 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > This series allows numa aware allocations for various early data
> > structures for radix. Hash still has a bolted SLB limitation that
> > prevents at least pacas and stacks from node-affine allocations.
> >
> > Fixed up a number of bugs, got pSeries working, added a couple more
> > cases where page tables can be allocated node-local.  
> 
> Few problems in here:
> 
> FAILURE kernel-build-linux » powerpc,gcc_ubuntu_be,pmac32
>   arch/powerpc/kernel/prom.c:748:2: error: implicit declaration of function 'allocate_paca_ptrs' [-Werror=implicit-function-declaration]
> 
> FAILURE kernel-build-linux » powerpc,gcc_ubuntu_le,powernv
>   arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has no member named 'lppaca_ptr'
>   arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has no member named 'lppaca_ptr'
> 
> Did I miss a follow-up or something?

No, I probably just don't do enough compile testing on ppc32. Not
sure about the powernv error, probably just missed testing a config.
Do you have more logs?

Thanks,
Nick

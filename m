Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx9QT0GvczF1T4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 21:50:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 00/14] numa aware allocation for pacas, stacks, pagetables
In-Reply-To: <20180213150824.27689-1-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
Date: Wed, 07 Mar 2018 21:50:04 +1100
Message-ID: <87muzkdusj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> This series allows numa aware allocations for various early data
> structures for radix. Hash still has a bolted SLB limitation that
> prevents at least pacas and stacks from node-affine allocations.
>
> Fixed up a number of bugs, got pSeries working, added a couple more
> cases where page tables can be allocated node-local.

Few problems in here:

FAILURE kernel-build-linux =C2=BB powerpc,gcc_ubuntu_be,pmac32
  arch/powerpc/kernel/prom.c:748:2: error: implicit declaration of function=
 'allocate_paca_ptrs' [-Werror=3Dimplicit-function-declaration]

FAILURE kernel-build-linux =C2=BB powerpc,gcc_ubuntu_le,powernv
  arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has no=
 member named 'lppaca_ptr'
  arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has no=
 member named 'lppaca_ptr'

Did I miss a follow-up or something?

cheers

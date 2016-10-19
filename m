Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szTRT29YlzDt1W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 21:57:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/7] powerpc/64s: tool to flag direct branches from
 unrelocated interrupt vectors
In-Reply-To: <20161019031600.17933-4-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-4-npiggin@gmail.com>
Date: Wed, 19 Oct 2016 21:57:21 +1100
Message-ID: <87zim04ne6.fsf@concordia.ellerman.id.au>
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

> Direct banches from code below __end_interrupts to code above
> __end_interrupts when built with CONFIG_RELOCATABLE are disallowed
> because they will break when the kernel is not located at 0.
>
> Sample output:
>
>     WARNING: Unrelocated relative branches
>     c000000000000118 bl-> 0xc000000000038fb8 <pnv_restore_hyp_resource>
>     c00000000000013c b-> 0xc0000000001068a4 <kvm_start_guest>
>     c000000000000148 b-> 0xc00000000003919c <pnv_wakeup_loss>
>     c00000000000014c b-> 0xc00000000003923c <pnv_wakeup_noloss>
>     c0000000000005a4 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
>     c000000000001af0 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
>     c000000000001b24 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
>     c000000000001b58 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Makefile.postlink           |  9 ++++-
>  arch/powerpc/tools/unrel_branch_check.sh | 56 ++++++++++++++++++++++++++++++++

arch/powerpc/scripts is meant for these kind of scripts (there's only
one there ATM, and yes we should move others in there).

cheers

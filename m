Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSk9v51j1zDvph
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 23:58:11 +1100 (AEDT)
In-Reply-To: <20161123130209.1667-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>
Subject: Re: [1/3] powerpc/64e: convert cmpi to cmpwi in head_64.S
Message-Id: <3tSk9v3tzcz9t1C@ozlabs.org>
Date: Tue, 29 Nov 2016 23:58:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-23 at 13:02:07 UTC, Nicholas Piggin wrote:
> >From 80f23935cadb ("powerpc: Convert cmp to cmpd in idle enter sequence"):
> 
>     PowerPC's "cmp" instruction has four operands. Normally people write
>     "cmpw" or "cmpd" for the second cmp operand 0 or 1. But, frequently
>     people forget, and write "cmp" with just three operands.
> 
>     With older binutils this is silently accepted as if this was "cmpw",
>     while often "cmpd" is wanted. With newer binutils GAS will complain
>     about this for 64-bit code. For 32-bit code it still silently assumes
>     "cmpw" is what is meant.
> 
>     In this instance the code comes directly from ISA v2.07, including the
>     cmp, but cmpd is correct. Backport to stable so that new toolchains can
>     build old kernels.
> 
> In this case, cmpwi is called for, so this is just a build fix for
> new toolchians.
> 
> Stable: v3.0
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f87f253bac3ce4a4eb2a60a1ae604d

cheers

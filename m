Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x65k119DZzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 12:33:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/asm: Mark cr0 as clobbered in mftb()
In-Reply-To: <20170710134326.GB13471@gate.crashing.org>
References: <20170706084643.22425-1-oohall@gmail.com>
 <8737a4v7dd.fsf@concordia.ellerman.id.au>
 <20170710134326.GB13471@gate.crashing.org>
Date: Tue, 11 Jul 2017 12:33:44 +1000
Message-ID: <87pod77ldj.fsf@concordia.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:

> Hi!
>
> On Mon, Jul 10, 2017 at 09:50:06PM +1000, Michael Ellerman wrote:
>> Oliver O'Halloran <oohall@gmail.com> writes:
>> 
>> > The workaround for the CELL timebase bug does not correctly mark cr0 as
>> > being clobbered. This can result in GCC making some poor^W completely
>> > broken optimisations.
>> 
>> Fruit 'n oats, how did we never notice that? Luck I guess. Or subtle
>> breakage that no one could pin down :E
>
> GCC does not use cr0 before it has used cr7, cr5, cr6, cr1 (unless some
> instruction _requires_ cr0, like record form ("dot") instructions, which
> until recently were disabled when targetting Cell), so it isn't too easy
> to hit the problem here.  Maybe Oliver used a very new GCC?  Or he was
> unlucky.

Aha. I think he actually hit the bug elsewhere and then noticed it here
also? And yeah I think it was a dot instruction that triggered it.

>> I'll tag it for stable.
>> 
>> Your change log is not entirely fair, it's not GCC's fault, we changed
>> register state without telling it, so it's on us :)  I'll reword it a
>> bit here.
>
> Yep, GCC works fine here, GIGO etc.  It isn't feasible to make GCC warn
> for most inline asm problems, either (we do not parse the mnemonics in
> the asm; this is a fundamental part of the design; you must express all
> constraints as, well, constraints).

Ack. It's a terrible terrible interface, but that's the price we pay for
wanting to insert arbitrary bits of asm inside an otherwise compiled
language :)

When I get the time I might go through our inline asm and convert all
the cmpwi x,z to cmpwi cr0,x,z, so at least the cr0 usage is a little
more obvious.

cheers

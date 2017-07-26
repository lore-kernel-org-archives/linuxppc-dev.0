Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHfz314XMzDqpM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 02:03:10 +1000 (AEST)
Date: Wed, 26 Jul 2017 11:02:56 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
Message-ID: <20170726160255.GO13471@gate.crashing.org>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-4-matthew.brown.dev@gmail.com>
 <20170725153033.GH13471@gate.crashing.org>
 <87tw1z5xcd.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87tw1z5xcd.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 26, 2017 at 08:03:30PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > A general question about these patches: some things are inside #ifdef
> > __powerpc64__, some are not.  It seems it is the wrong macro, and it
> > should be used (or not used) consistently?
> 
> Why is it the wrong macro? Because we tend to use CONFIG_PPC64 you mean?

Yeah.  But I see sstep.c already mixes those two at will (or if there
is a distinction, I'm not seeing it :-) )

> I thought the reason some are #ifdef'ed is that some are 64-bit only.
> ie. bpermd is 64-bit only ?

64-bit only, in what way?  It's not clear what the rules are.

It's not instructions that can only run in 64-bit mode.
It's not instructions that only give a usable result with 64-bit regs
implemented.
It's not instructions only implemented on 64-bit CPUs.
It's not even "all instructions that would not give a correct result
in the low 32 bits of GPRs if the high 32 bits are not implemented".


Segher

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHvTR6nfwzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:26:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
In-Reply-To: <20170726160255.GO13471@gate.crashing.org>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-4-matthew.brown.dev@gmail.com>
 <20170725153033.GH13471@gate.crashing.org>
 <87tw1z5xcd.fsf@concordia.ellerman.id.au>
 <20170726160255.GO13471@gate.crashing.org>
Date: Thu, 27 Jul 2017 11:26:51 +1000
Message-ID: <87iniefz50.fsf@concordia.ellerman.id.au>
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

> On Wed, Jul 26, 2017 at 08:03:30PM +1000, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> > A general question about these patches: some things are inside #ifdef
>> > __powerpc64__, some are not.  It seems it is the wrong macro, and it
>> > should be used (or not used) consistently?
>> 
>> Why is it the wrong macro? Because we tend to use CONFIG_PPC64 you mean?
>
> Yeah.  But I see sstep.c already mixes those two at will (or if there
> is a distinction, I'm not seeing it :-) )

Yeah OK. In practice they're equivalent, if CONFIG_PPC64=y then the
kernel is built 64-bit and therefore __powerpc64__ is defined.

But I agree it's a mess, we should use CONFIG_PPC64 exclusively unless
there's some reason not to (which I don't think there ever is).

>> I thought the reason some are #ifdef'ed is that some are 64-bit only.
>> ie. bpermd is 64-bit only ?
>
> 64-bit only, in what way?  It's not clear what the rules are.

Instructions that have "d" in the name? :P

> It's not instructions that can only run in 64-bit mode.
> It's not instructions that only give a usable result with 64-bit regs
> implemented.
> It's not instructions only implemented on 64-bit CPUs.

I think it's trying to be that ^

If you build a 32-bit kernel then instructions that are only defined on
64-bit CPUs should be treated as illegal, so the easiest way to achieve
that is to #ifdef off the code for those instructions.

cheers

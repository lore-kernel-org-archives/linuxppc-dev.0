Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPzqn3GW4zDvmj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 13:03:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
In-Reply-To: <20161124231716.GB30675@gate.crashing.org>
References: <20161123130840.1877-1-npiggin@gmail.com>
 <20161123143834.GB6099@gate.crashing.org>
 <CAOSf1CEJwdCCPVcksOBUSut_fPbr6WizacRrFRgMAJAeWoCqRw@mail.gmail.com>
 <20161124122713.GC14394@gate.crashing.org>
 <87d1hktt5z.fsf@concordia.ellerman.id.au>
 <20161124231716.GB30675@gate.crashing.org>
Date: Fri, 25 Nov 2016 13:02:58 +1100
Message-ID: <877f7stiy5.fsf@concordia.ellerman.id.au>
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

> On Fri, Nov 25, 2016 at 09:22:16AM +1100, Michael Ellerman wrote:
>> >> >> Question, are there any fundamental reasons we shouldn't use the ELFv2
>> >> >> ABI to build big endian kernels if the compiler supports it?
>> >> >
>> >> > No one uses ELFv2 for BE in production, and it isn't thoroughly tested
>> >> > at all, not even regularly tested.  "Not supported", as far as GCC is
>> >> > concerned (or any of the distros AFAIK).
>> >> 
>> >> Is this actually unsupported by gcc?
>> >
>> > It may or may not work.  We of course try to keep it working, or make
>> > it work if it doesn't now.  But it isn't regularly tested, and it isn't
>> > a target that is considered for the release criteria (see
>> > https://gcc.gnu.org/gcc-7/criteria.html -- powerpc64{,le}-linux, i.e.
>> > ABIv1 for BE, ABIv2 for LE).
>> 
>> It doesn't actually say that though. It just says
>> powerpc64-unknown-linux-gnu. So how is someone, say the musl folks,
>> supposed to know that BE ABIv2 is not supported?
>
> Because their target is powerpc64*-*-linux-musl instead?  It is not on
> the release criteria list, it is not something we make any claims about.
>
> How would you know -m32 -mlittle is not well tested at all?  It is in much
> the same boat: unusual combinations of options, and unusual configurations,
> are not well tested.  You have to build a separate C library just to get
> started with it, that should tell you there are some rough waters ahead!

Yeah OK, I guess that's the part that's confusing me.

Because we're hairy chested kernel programmers we don't actually build a
C library at all. So we don't get that hint that we're using an odd
combination, we just configure the toolchain, build it and off we go.

cheers

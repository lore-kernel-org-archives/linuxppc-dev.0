Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qt0-x234.google.com (mail-qt0-x234.google.com
 [IPv6:2607:f8b0:400d:c0d::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJVZx5SRSzDrLX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 10:48:41 +1000 (AEST)
Received: by mail-qt0-x234.google.com with SMTP id s6so81772685qtc.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 17:48:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87iniefz50.fsf@concordia.ellerman.id.au>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-4-matthew.brown.dev@gmail.com>
 <20170725153033.GH13471@gate.crashing.org>
 <87tw1z5xcd.fsf@concordia.ellerman.id.au>
 <20170726160255.GO13471@gate.crashing.org>
 <87iniefz50.fsf@concordia.ellerman.id.au>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Fri, 28 Jul 2017 10:48:38 +1000
Message-ID: <CAPoR37Z5oDfqLkYYKF6rPFzfJ5y0RArPFJjiiXshRPsnFCKbhQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 27, 2017 at 11:26 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
>
>> On Wed, Jul 26, 2017 at 08:03:30PM +1000, Michael Ellerman wrote:
>>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>>> > A general question about these patches: some things are inside #ifdef
>>> > __powerpc64__, some are not.  It seems it is the wrong macro, and it
>>> > should be used (or not used) consistently?
>>>
>>> Why is it the wrong macro? Because we tend to use CONFIG_PPC64 you mean?
>>
>> Yeah.  But I see sstep.c already mixes those two at will (or if there
>> is a distinction, I'm not seeing it :-) )
>
> Yeah OK. In practice they're equivalent, if CONFIG_PPC64=y then the
> kernel is built 64-bit and therefore __powerpc64__ is defined.
>
> But I agree it's a mess, we should use CONFIG_PPC64 exclusively unless
> there's some reason not to (which I don't think there ever is).
>
>>> I thought the reason some are #ifdef'ed is that some are 64-bit only.
>>> ie. bpermd is 64-bit only ?
>>
>> 64-bit only, in what way?  It's not clear what the rules are.
>
> Instructions that have "d" in the name? :P
>
>> It's not instructions that can only run in 64-bit mode.
>> It's not instructions that only give a usable result with 64-bit regs
>> implemented.
>> It's not instructions only implemented on 64-bit CPUs.
>
> I think it's trying to be that ^
>
> If you build a 32-bit kernel then instructions that are only defined on
> 64-bit CPUs should be treated as illegal, so the easiest way to achieve
> that is to #ifdef off the code for those instructions.
>

I'll fixup this up to use the xor implementation, and change the
series to use CONFIG_PPC64 for the ifdef.

Thanks,
Matt
> cheers

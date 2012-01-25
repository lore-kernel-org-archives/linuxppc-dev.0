Return-Path: <B10716@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41EA5B6F67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 01:32:32 +1100 (EST)
Message-ID: <4F201270.4020000@freescale.com>
Date: Wed, 25 Jan 2012 16:32:16 +0200
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
 <CALRxmdA9mh6x5YGK1oFHvgmV-RsnN6WkxhpZbcRJv1S8Y0RH1w@mail.gmail.com>
 <1327100755.2923.6.camel@pasglop> <4F1DB344.9030709@freescale.com>
 <1327351831.19850.9.camel@pasglop>
In-Reply-To: <1327351831.19850.9.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/2012 10:50 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-01-23 at 13:21 -0600, Scott Wood wrote:
>
>>> BTW, for non-booke, when is DEC checked when interrupts are hard-enabled
>>> as part of exception return?  Likewise with the PS3 HV thing.  I only
>>> see the iseries check in the exception path.
>
> Exception return restores them to their previous state, so shouldn't be
> a problem unless your exception takes long enough to overflow the DEC in
> which case you have other problems. The PS/3 case might be broken.
>
>> Perhaps the issues with a higher priority interrupt intervening can be
>> addressed by messing around with current task priority at the MPIC (with
>> an hcall introduced for the hv case, since currently task priority is
>> not exposed to the guest).  I haven't had time to revisit this, and
>> don't expect to soon.  If someone else wants to try, fine.  In the
>> meantime, lazy EE is causing problems.
>
> Or by storing pending interrupts in an array.
>
>> I'd still like to know the answer to that last question.  It's difficult
>> to determine how to correctly implement this stuff for our hardware if
>> it looks like there are holes in the scheme for hardware that this is
>> supposed to already work with.
>>
>>> Traditionally EE's have always been "level sensitive" on PowerPC,
>>
>> You mean besides the places you already have to work around, such as
>> doorbells
>
> Which you introduced as well... this is especially ironic since BookE
> had the decrementer done right in the first place :-)
>
>> and book3s decrementers
>
> Book3s decrementer is level sensitive based on the sign bit of the
> decrementer (a bit odd but heh....) at least on 64-bit processors.
>
>> and other hypervisors...
>
> I wouldn't take the PS3 HV and legacy iseries HV as good design
> examples :-) The later was working around limited HW functionality at
> the time as well.
>
>> and you force
>> all functions that enable interrupts to create a stack frame to deal
>> with this.
>
> Right, but overall this is still more efficient performance wise on most
> processors than whacking the MSR.
>
> However the main thing is that this significantly improves the quality
> of the samples obtained from performance interrupts which can now act as
> pseudo-NMI up to a certain point.
>
> It also helps with Alex PR KVM but that's just a detail really.
>
>>> the way you changed that is arguably an utterly broken HW design
>>
>> Just because you don't like it, and it doesn't play well with your hack,
>> doesn't make it "utterly broken".
>
> Deal with it. The "hack" has been there for long enough and works well.
> I don't want compile-time conditional to change that behaviour.
>
>>> and I am not too keen on changing our core interrupt handling to deal with it via
>>> ifdef's if we can find a less invasive solution.
>>
>> Wheras having to significantly change the way interrupts work because
>> the register size doubled is so totally reasonable...
>
> We were very tempted at some point to do lazy EE for 32-bit as well,
> eventually decided we didn't care enough :-)
>
>> What is the compelling reason for forcing lazy EE on us?  Why is it tied
>> to 64-bit?
>
> Because that's where we historically implemented it and because iSeries
> more/less required to begin with. And I don't want to have a split
> scheme, especially not a compile time one.

I'm thinking that we could get rid of the compile time option by using 
the "feature fixup" mechanism.

---
Best Regards, Laurentiu

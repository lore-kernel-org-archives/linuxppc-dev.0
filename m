Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CB3EC1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 07:41:55 +1100 (EST)
Received: from mail29-va3 (localhost [127.0.0.1])	by mail29-va3-R.bigfish.com
 (Postfix) with ESMTP id B178A2A0243	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2011 20:41:20 +0000 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.243])	by
 mail29-va3.bigfish.com (Postfix) with ESMTP id 70BAE80043	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 20:39:45 +0000 (UTC)
Message-ID: <4EB9939E.8070800@freescale.com>
Date: Tue, 8 Nov 2011 14:39:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 5/7] fsl_pmc: update device bindings
References: <1320410207-14537-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4456F.9020005@freescale.com>
 <3F607A5180246847A760FD34122A1E052BC964@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <3F607A5180246847A760FD34122A1E052BC964@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="windows-1252"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2011 04:56 AM, Li Yang-R58472 wrote:
>>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>> b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>>> index 07256b7..d84b4f8 100644
>>> --- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>>> @@ -9,22 +9,27 @@ Properties:
>>>
>>>    "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
>>>    compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
>>> -  whose PMC is compatible, and implies deep-sleep capability.
>>> +  whose PMC is compatible, and implies deep-sleep capability and
>>> +  wake on user defined packet(wakeup on ARP).
>>
>> Why does the PMC care?  This is an ethernet controller feature, the PMC
>> is just keeping the wakeup-relevant parts of the ethernet controller
>> alive (whatever they happen to be).
>>
>> Do we have any chips that have ethernet controller support for wake on
>> user-defined packet, but a sleep mode that doesn't let it be used?
> 
> I think it is more a PMC feature cause Ethernet controller on many
> SoCs have the filer feature, but only very limited SoCs can support
> using it as a wake-up source.  The differences should be mostly in
> the PM controller block.

Have you tried waking from sleep with it on those other SoCs?

> Also the wake on user-defined packet feature was never mentioned in the Ethernet controller part of UM.

AFAICT all this "feature" is, is programming the Ethernet controller to
filter out some packets that we don't want to wake us up, and then
refraining from entering magic packet mode.  What PMC registers are
programmed any differently for this?

It's in the PM part of the manual because that's where they generally
describe issues related to PM.  They describe magic packet there too.

The set of devices which are still active during sleep is a different
issue from the conditions on which a device will request a wake.

I also don't trust our PM documentation very much.  It's ambiguous just
what gets shut down in ordinary sleep mode.  E.g. the mpc8544 manual
talks about "external interrupts", but in one place it looks like it
means external to the SoC:

> In sleep mode, all clocks internal to the e500 core are turned off, including the timer facilities clock. All
> I/O interfaces in the device logic are also shut down. Only the clocks to the MPC8544E PIC are still
> running so that an external interrupt can wake up the device.

But the note immediately below that seems to imply they're talking about
external to the core:

> Only external interrupts can wake the MPC8544E from sleep mode. Internal
> interrupt sources like the core interval timer or watchdog timer depend on
> an active clock for their operation and these are disabled in sleep mode.



>> Normally that shouldn't matter, but we already an unused binding for
>> this. :-)
>>
>> Please provide rationale for doing it this way.  Ideally it should
>> probably use whatever http://devicetree.org/ClockBindings ends up being.
> 
> I have looked into that binding.  The binding was primarily defined for the Linux clock API which is not same as what we are doing here(set wakeup source).
> If in the future the clock API also covers wakeup related features, we can change to use it.

While Linux APIs can serve as an inspiration, they're not the basis of
device tree bindings.  The device tree is not Linux-specific, and should
not change just because Linux changes, but rather should describe the
hardware.  We want to get this right the first time.

What we are describing here is how a device's clock is connected to the PMC.

-Scott

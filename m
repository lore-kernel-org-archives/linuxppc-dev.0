Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3AADDDFA2
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 19:14:50 +1000 (EST)
In-Reply-To: <66B07304-BE33-4A9E-8C9C-BEC0BCEC79F8@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<1182907015126-git-send-email-galak@kernel.crashing.org>
	<11829070192461-git-send-email-galak@kernel.crashing.org>
	<C84F154C-EBC9-471F-A1E1-635A385E684A@freescale.com>
	<8fa84ed4810eb9aca18739bf709e71d9@kernel.crashing.org>
	<41E15EC0-D16E-4A9F-BCA8-1E126F6D95A7@kernel.crashing.org>
	<0639caa4f420578b671c9e2f9713ba39@kernel.crashing.org>
	<EEF07F54-B6C2-4F27-A3F5-0824DD4826A0@kernel.crashing.org>
	<17094a76430d6dd0df7aa07560b4e204@kernel.crashing.org>
	<66B07304-BE33-4A9E-8C9C-BEC0BCEC79F8@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d60e81d52af08a3ba88da214a1822cf3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 09/15] [POWERPC] 86xx: Add uli1575 pci-bridge sector to
	MPC8641HPCN dts file.
Date: Thu, 28 Jun 2007 11:14:36 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>>>>> -		ranges = <0 f8000000 00100000>;
>>>>>>>> -		reg = <f8000000 00100000>;	// CCSRBAR 1M
>>>>>>>> +		ranges = <00001000 f8001000 000ff000
>>>>>>>> +		reg = <f8000000 00001000>;	// CCSRBAR
>>
>>>> There is "BAR" in the name, so it is a movable range?  Where
>>>> is the base address set?
>>>
>>> in a MMIO register in the space itself.
>>
>> Oh, *great* design.</sarcasm>
>
> its not that bad ;)

Well there's no way to configure it if the current
configuration is screwed, or you just don't know
what the current configuration is.  Anyway, that's
all beside the point here.

>>>> What is the relationship between (in the example) the address
>>>> ranges x'f800_0000+1000 and x'f800_1000+ff000?
>>>
>>> uugh, not sure what that's all about.
>>
>> Reading back I see that the CCSR region is 1MB, and only the
>> first 4kB are for this PHB.  What is the rest of this range
>> used for -- devices on this PCI bus, other SoC devices, ...?
>
> No, the first 4kB are SOC/platform level config registers (high level 
> window setup, CCSR location, etc).
>
> The PHB registers are somewhere in the middle (0x8000, I think).  All 
> the children devices (enet, PHBs, etc) live in the 1M block.

So:

-- CCSR doesn't sit on PCI at all
-- It is a SoC register space
-- And it is only needed for configuration, not for normal
    operation? ( <-- I so much hope this one is true!)

> I think my original idea was the reg property on the SOC node was for 
> the first 4k block that held the SOC config registers.  I think what 
> Wade did is correct since the reg property on the SOC node isnt going 
> to get translated through the ranges property and that they should be 
> mutually exclusive.

Yeah but I'm wondering about the other devices on CCSR now...


Segher

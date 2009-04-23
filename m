Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5F7ADDED5
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 14:06:47 +1000 (EST)
Date: Thu, 23 Apr 2009 14:06:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
Message-ID: <20090423040642.GG19376@yookeroo.seuss>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<80CA86D4-3DA5-4C28-AE7A-C03CE5758774@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80CA86D4-3DA5-4C28-AE7A-C03CE5758774@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 10:36:36PM -0500, Kumar Gala wrote:
>
> On Apr 22, 2009, at 9:26 PM, David Gibson wrote:
>
>> On Wed, Apr 22, 2009 at 04:55:42PM -0500, Kumar Gala wrote:
>>>
>>> On Apr 22, 2009, at 4:38 PM, Scott Wood wrote:
>>>
>>>> Kumar Gala wrote:
>>>>> I disagree.  If you update your kernel you should update your  
>>>>> device
>>>>> tree (thus we have .dts in the kernel tree and not somewhere else).
>>>>
>>>> No.  The device tree is a means to pass information from the  
>>>> firmware
>>>> to the kernel.  It is part of the firmware.  That the repository of
>>>> trees is in the Linux kernel for any boards which are not  
>>>> including the
>>>> tree inside a bootwrapper is a historical accident.
>>>
>>> I think its a point of view argument.  I don't agree its part of the
>>> firmware, at least not part of the firmware we use (u-boot).
>>
>> It's not so much point of view as situation.  Putting the device tree
>> in the firmware and putting the device tree in the kernel are both
>> valid choices, with their own distinct advantages and drawbacks.  With
>> OF it's clearly in the firmware, with cuboot it's clearly in the
>> kernel.  With modern u-boot, it's a bit fuzzier.  But if the dts is
>> flashed into the device in the same way as the bootloader, then it's
>> fair to avoid having to change it, in the same way we usually provide
>> workarounds to work with old firmware versions.
>
> I think this all sounds great in theory but in reality the vast majority 
> (I'd say over 80-90%) we are talking about embedded reference boards.  
> They are subject to change as we evolve support over time.  Our firmware 
> isn't well defined and stable like a x86 PC system or true OF platform.  
> I will also say we have made mistakes as learned from them and one we 
> keep repeating is NOT ensuring at a minimum that all parts of the SOC 
> memory map are actually described in the device tree to start with.

Well, yes, I guess I agree.  How immutable you consider the device
tree blob to be is a judgement call based on the specific details of
platform/board in question.  If it is indeed a reference platform, in
the early stages of development where it's reasonably easy to change
the dtb, then it's probably best to change the dtb in sync with the
kernel to reduce long-term cruft build-up.  But once the board is
sufficiently widely deployed, you want to stop doing that and include
backwards compatibility workarounds in the kernel to cope with the
widely deployed broken trees.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

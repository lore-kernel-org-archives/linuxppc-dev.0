Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 376E9DE1E8
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 13:39:03 +1000 (EST)
Message-Id: <80CA86D4-3DA5-4C28-AE7A-C03CE5758774@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20090423022610.GA19376@yookeroo.seuss>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: removing get_immrbase()??
Date: Wed, 22 Apr 2009 22:36:36 -0500
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
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


On Apr 22, 2009, at 9:26 PM, David Gibson wrote:

> On Wed, Apr 22, 2009 at 04:55:42PM -0500, Kumar Gala wrote:
>>
>> On Apr 22, 2009, at 4:38 PM, Scott Wood wrote:
>>
>>> Kumar Gala wrote:
>>>> I disagree.  If you update your kernel you should update your  
>>>> device
>>>> tree (thus we have .dts in the kernel tree and not somewhere else).
>>>
>>> No.  The device tree is a means to pass information from the  
>>> firmware
>>> to the kernel.  It is part of the firmware.  That the repository of
>>> trees is in the Linux kernel for any boards which are not  
>>> including the
>>> tree inside a bootwrapper is a historical accident.
>>
>> I think its a point of view argument.  I don't agree its part of the
>> firmware, at least not part of the firmware we use (u-boot).
>
> It's not so much point of view as situation.  Putting the device tree
> in the firmware and putting the device tree in the kernel are both
> valid choices, with their own distinct advantages and drawbacks.  With
> OF it's clearly in the firmware, with cuboot it's clearly in the
> kernel.  With modern u-boot, it's a bit fuzzier.  But if the dts is
> flashed into the device in the same way as the bootloader, then it's
> fair to avoid having to change it, in the same way we usually provide
> workarounds to work with old firmware versions.

I think this all sounds great in theory but in reality the vast  
majority (I'd say over 80-90%) we are talking about embedded reference  
boards.  They are subject to change as we evolve support over time.   
Our firmware isn't well defined and stable like a x86 PC system or  
true OF platform.  I will also say we have made mistakes as learned  
from them and one we keep repeating is NOT ensuring at a minimum that  
all parts of the SOC memory map are actually described in the device  
tree to start with.

If I look at the MPC8572 SoC from FSL I will see that the following  
items aren't described today:

* Local access windows
* ECM
* GPIO - we have a binding and its possible the board doesn't use them
* PME
* TLU
* perf mon
* watchpoint debug

We also don't describe the following interrupt sources:
* ECM
* perf mon
* GPIO
* PME
* TLU
* IEEE 1588

Until we meet the most basic level of properly describing 95% of the  
HW I don't see the value you guys prescribe to FW compatibility.   
Additionally I believe for embedded developers its perfectly  
reasonable to expect them (if they are using u-boot) to possibly have  
to update their .dts/dtb if they want to update their kernel.

- k

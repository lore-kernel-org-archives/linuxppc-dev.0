Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 413DADDF90
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 07:21:20 +1000 (EST)
In-Reply-To: <EEF07F54-B6C2-4F27-A3F5-0824DD4826A0@kernel.crashing.org>
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
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <17094a76430d6dd0df7aa07560b4e204@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 09/15] [POWERPC] 86xx: Add uli1575 pci-bridge sector to
	MPC8641HPCN dts file.
Date: Wed, 27 Jun 2007 23:21:10 +0200
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

>>>>>> -		ranges = <0 f8000000 00100000>;
>>>>>> -		reg = <f8000000 00100000>;	// CCSRBAR 1M
>>>>>> +		ranges = <00001000 f8001000 000ff000
>>>>>> +		reg = <f8000000 00001000>;	// CCSRBAR

>> There is "BAR" in the name, so it is a movable range?  Where
>> is the base address set?
>
> in a MMIO register in the space itself.

Oh, *great* design.</sarcasm>

>> What is the relationship between (in the example) the address
>> ranges x'f800_0000+1000 and x'f800_1000+ff000?
>
> uugh, not sure what that's all about.

Reading back I see that the CCSR region is 1MB, and only the
first 4kB are for this PHB.  What is the rest of this range
used for -- devices on this PCI bus, other SoC devices, ...?


Segher

Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A96B9DE05D
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 12:26:16 +1000 (EST)
Date: Thu, 23 Apr 2009 12:26:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
Message-ID: <20090423022610.GA19376@yookeroo.seuss>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
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

On Wed, Apr 22, 2009 at 04:55:42PM -0500, Kumar Gala wrote:
>
> On Apr 22, 2009, at 4:38 PM, Scott Wood wrote:
>
>> Kumar Gala wrote:
>>> I disagree.  If you update your kernel you should update your device 
>>> tree (thus we have .dts in the kernel tree and not somewhere else).
>>
>> No.  The device tree is a means to pass information from the firmware 
>> to the kernel.  It is part of the firmware.  That the repository of 
>> trees is in the Linux kernel for any boards which are not including the 
>> tree inside a bootwrapper is a historical accident.
>
> I think its a point of view argument.  I don't agree its part of the  
> firmware, at least not part of the firmware we use (u-boot).

It's not so much point of view as situation.  Putting the device tree
in the firmware and putting the device tree in the kernel are both
valid choices, with their own distinct advantages and drawbacks.  With
OF it's clearly in the firmware, with cuboot it's clearly in the
kernel.  With modern u-boot, it's a bit fuzzier.  But if the dts is
flashed into the device in the same way as the bootloader, then it's
fair to avoid having to change it, in the same way we usually provide
workarounds to work with old firmware versions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

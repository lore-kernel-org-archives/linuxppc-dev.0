Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0868ADDF74
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 08:33:59 +1000 (EST)
Message-ID: <49EF9B50.7010904@freescale.com>
Date: Wed, 22 Apr 2009 17:33:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
In-Reply-To: <5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Apr 22, 2009, at 4:38 PM, Scott Wood wrote:
>> Kumar Gala wrote:
>>> I disagree.  If you update your kernel you should update your device 
>>> tree (thus we have .dts in the kernel tree and not somewhere else).
>>
>> No.  The device tree is a means to pass information from the firmware 
>> to the kernel.  It is part of the firmware.  That the repository of 
>> trees is in the Linux kernel for any boards which are not including 
>> the tree inside a bootwrapper is a historical accident.
> 
> I think its a point of view argument.

I don't.  It is the responsibility of u-boot to produce a complete 
device tree; what bits are in the dts and what bits are programatically 
generated is an internal implementation detail.  We are currently 
hosting some parts of that implementation detail in the Linux tree, but 
it is still a u-boot implementation detail.  U-boot is perfectly within 
its rights to generate the entire tree from scratch if it wanted to.

Just a few hours ago you were telling me that you didn't want to put
accurate information in the device tree because you wanted u-boot to 
generate it instead. :-)

The reason we have standards such as ePAPR in the first place is so that 
we are dealing with well-defined interfaces that can be used even when 
the firmware is not U-Boot at all (but merely something that is 
standards-compliant) and/or the kernel is not Linux at all (but merely 
something that is standards-compliant).  The downside to that is that 
revising standards is a bit more of a pain than revising code.  We can 
do it if it's worthwhile, but we should try to avoid doing it gratuitously.

> I don't agree its part of the 
> firmware, at least not part of the firmware we use (u-boot).

We have had many instances of certain versions of device trees being 
incompatible with certain versions of u-boot.

All I'm asking is that we treat a mandatory dts upgrade as seriously as 
a mandatory firmware upgrade.

>> Updating the dtb with the kernel just shifts the risk of 
>> incompatibility to interactions between the firmware and the dtb.  The 
>> same backwards compatibility considerations when making kernel changes 
>> that depend on firmware changes should be made when making kernel 
>> changes that depend on dts changes.
> 
> As I told Timur, I'm speaking of addition of new nodes and code that 
> parses and expect those nodes to be there.

And what do we gain from this change in interface with the firmware on 
hardware that is not exactly under active development?  What problem are 
you trying to solve?  Why do we need to get rid of get_immrbase() (as 
opposed to being less reliant on it going forward, and tolerating its 
failure on platforms that may be virtualized and thus not have the 
complete IMMR/CCSR)?

Will any of these new nodes need anything to be filled in by u-boot?

-Scott

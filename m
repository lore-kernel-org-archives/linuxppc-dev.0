Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8760CDE14D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 03:03:19 +1000 (EST)
Message-ID: <49F09F4A.8090506@freescale.com>
Date: Thu, 23 Apr 2009 12:03:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: removing get_immrbase()??
References: <ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
	<20090423160048.GC19717@ld0162-tx32.am.freescale.net>
	<20090423165430.GA8355@oksana.dev.rtsoft.ru>
In-Reply-To: <20090423165430.GA8355@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Anton Vorontsov wrote:
> On Thu, Apr 23, 2009 at 11:00:48AM -0500, Scott Wood wrote:
>> Even if the given change may not break the firmware, it could force an
>> update in which a prior change breaks the firmware.
> 
> I'm not sure I'm following here. Could you give an example?

1. U-boot X1 is used with kernel Y1 and device tree Z1.  All is well.
2. U-boot X2 needs device tree Z2.  Device tree Z2 goes in kernel Y2. 
It will break when used with u-boot X1, so users of u-boot X1 do not 
upgrade their device trees.  All is well.
3. Kernel Y3 makes a change to the device tree (now Z3) that it needs. 
This change does not have u-boot compatibility issues by itself, so the 
kernel developer feels confident saying "go ahead and upgrade your tree, 
it should be fine".  Users of U-boot X1 pull in the latest device tree, 
which includes the changes made in device tree Z2.  Breakage.

-Scott

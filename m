Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3B35DDF5C
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 23:33:29 +1000 (EST)
In-Reply-To: <200704250949.17795.arnd@arndb.de>
References: <20070417210745.GA3567@aepfle.de>
	<200704250001.18162.arnd@arndb.de>
	<0e76c9675bd1bcf4b7ed6bf83da8c3d7@kernel.crashing.org>
	<200704250949.17795.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <3f8a4cde6b06ee98203d62dc33c1630f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Wed, 25 Apr 2007 15:33:05 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> SLOF/JS21 (at least some versions of it) have an "ipmi"
>> node on the "isa" bus. =A0And the kernel ipmi driver actually
>> works on it, too (no idea about the currently proposed
>> scanning though -- but the principle is correct at least).
>
> It won'd be found by the of_platform_driver part of ipmi,
> since devices on the ISA bus do not get added to the linux
> device tree.

Drat.  Why not?

> If the ipmi node on the ISA bus is located at the standardized
> legacy I/O port range, it should get found by the later probing,
> if check_legacy_ioport allows it.

"Standardised" hahaha.  No, it is at some other
address.

> We might still want to have the driver use a proper of_device,
> which would require the maple platform code to add this device
> during probing.

That sounds like the only option then.  Does
this have to be done per platform though?  It
sounds perfectly safe to do it in more generic
code.


Segher

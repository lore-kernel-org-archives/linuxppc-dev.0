Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27124B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 03:32:09 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FB68DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 03:32:07 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n67HVlSN005923
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 10:31:58 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n67HVk28003935
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 12:31:46 -0500 (CDT)
Date: Tue, 7 Jul 2009 12:31:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: MTD OF parser problem
Message-ID: <20090707173146.GA25939@b07421-ec1.am.freescale.net>
References: <200907071545.30121.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200907071545.30121.roman.fietze@telemotive.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 07, 2009 at 03:45:29PM +0200, Roman Fietze wrote:
> Hallo,
> 
> I tried to define my MTD partitions in a device tree as
> documented. The function of_flash_probe() inside teh file physmap_of.c
> never compiled the code below
> 
> #ifdef CONFIG_MTD_OF_PARTS
> 
> because when the MTD subsystem is compiled as a module I can only find
> CONFIG_MTD_OF_PARTS_MODULE beeing defined somewhere below my build
> directory.
> 
> If I change the above define to
> 
> #if defined(CONFIG_MTD_OF_PARTS) || defined(CONFIG_MTD_OF_PARTS_MODULE)
> 
> everything is fine and MTD partition work as expected.
> 
> My fault? Other solution?

That would break if MTD_PHYSMAP_OF (or any other user) is built-in but
MTD_OF_PARTS is a module.

Perhaps there's some way we could hook OF partitions into the normal
partition probing, so we don't have to refer to it by symbol?  The main
obstacle would be communicating the device node.

Or we could just disallow MTD_OF_PARTS from being modularized -- like
MTD_PARTITIONS.

-Scott

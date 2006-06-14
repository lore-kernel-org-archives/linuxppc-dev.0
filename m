Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 95C3F67B78
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 01:59:25 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5EGGL99009103
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 09:16:21 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5EFxNmZ014620
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 10:59:23 -0500 (CDT)
Subject: Re: [PATCH 5/10 v2] Add 8641 CPU and i8259 Setup
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <E1FojUI-0004N5-E7@jdl.com>
References: <1149803956.23938.284.camel@cashmere.sps.mot.com>
	<1149826989.12687.50.camel@localhost.localdomain>
	<E1FojUI-0004N5-E7@jdl.com>
Content-Type: text/plain
Message-Id: <1150300488.23938.467.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 14 Jun 2006 10:54:51 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-09 at 11:05, Jon Loeliger wrote:

> > > +	bl	clear_bats
> > >  	bl	load_up_mmu
> > 
> > Why do you need to call clear_bats here ? load_up_mmu should load BATs.
> > If it doesn't handle the high BATs, then fix it :) 

Ben,

This line item has finally come around on the guitar!
And I have a question for you... 

How come this additional clear_bats call isn't seen
as a generic fix?  It is possible that the bootloader
has left some crufty (high) BATs hanging around.

Or are you suggesting just adding something like:

    li r10, 0
    mtspr SPRN_DBATxU,r10
    mtspr SPRN_DBATxL,r10

for x in (4 .. 7) to the tail end of load_up_mmu as
the general fix?

Thanks,
jdl

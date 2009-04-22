Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25E4DDE08B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 05:44:42 +1000 (EST)
Message-ID: <49EF7394.30606@freescale.com>
Date: Wed, 22 Apr 2009 14:44:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
In-Reply-To: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I'm not sure if we can actually get away with completely removing 
> get_immrbase() but I figured I'd give everyone something to flame me 
> about.  The current users are:

I think we want to keep it for an eventual re-introduction of a large 
TLB entry to cover IMMR (but no longer at a fixed virtual address, of 
course).

> CPM/QE related users.
> 
> arch/powerpc/include/asm/cpm1.h:#define IMAP_ADDR        (get_immrbase())
> 
>     only used drivers/net/fs_enet/fs_enet-main.c which seems evil.

That driver *is* evil. :-)

It looks like the only remaining user of fs_enet_immap (which is what 
IMAP_ADDR is used to initialize) is in mac-fec.c, under CONFIG_DUET -- 
which hasn't been touched since 2005 and appears to have died with arch/ppc.

I'm fine with removing it -- it probably no longer compiles anyway.

> arch/powerpc/sysdev/cpm1.c:    mpc8xx_immr = ioremap(get_immrbase(), 
> 0x4000);
>     not sure? ideas?

This is used for accessing a variety of registers, not all of which are 
currently expressed in the device tree.

> arch/powerpc/include/asm/cpm2.h:#define CPM_MAP_ADDR (get_immrbase() + 
> 0x80000)
> arch/powerpc/sysdev/cpm2.c:    cpm2_immr = ioremap(get_immrbase(), 
> CPM_MAP_SIZE);
>     these two are related and seem like we could look for "fsl,cpm2"

And do what with it that wouldn't be a reimplementation of get_immrbase()?

> arch/powerpc/platforms/83xx/suspend.c:    rcw_regs = 
> ioremap(get_immrbase() + IMMR_RCW_OFFSET,
> arch/powerpc/platforms/83xx/suspend.c:    immrbase = get_immrbase();

The suspend code touches a variety of SOC registers in various blocks -- 
likely including some which are not described by any device node at present.

-Scott

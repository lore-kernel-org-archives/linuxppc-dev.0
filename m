Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EC28B7D43
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 07:33:55 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4JLXqB2018465
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 14:33:52 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o4JLi4up001016
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 16:44:04 -0500 (CDT)
Message-ID: <4BF4593E.8030101@freescale.com>
Date: Wed, 19 May 2010 16:33:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop>
In-Reply-To: <1274304013.1931.6.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>> So to accommodate future boards where more padding is needed, we make the
>> option for the -p parameter configurable.
> 
> Can't u-boot just allocate more space ?

Yes and no.  U-Boot has functions to increase the size of an fdt, but these
functions can't be sure that the fdt will grow beyond its allocated space.
So if U-Boot calls fdt_setprop() or fdt_add_subnode(), and there isn't
enough space in the fdt, those functions will return with an error.

The problem with growing the fdt is that the function which does this
(fdt_open_into) cannot guarantee that the fdt will grow too large and
overwrite the end of whatever allocated memory it's in.

I had a long argument with Wolfgang on this (see "libfdt: make
fdt_increase_size() available to everyone"), and he says he'll reject any
patch that can't guarantee that fdt_open_into() won't grow too large.  He'll
also reject any patch that uses a macro constant to reserve this space, even
if I use that constant to ensure that fdt_open_into() won't do anything bad.

So in other words, U-Boot could allocate more space, but Wolfgang won't let it.

-- 
Timur Tabi
Linux kernel developer at Freescale

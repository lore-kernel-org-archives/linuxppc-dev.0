Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ADA44B6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 06:09:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o68K967N024536 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 8 Jul 2010 13:09:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o68KL0P0025093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 8 Jul 2010 15:21:00 -0500 (CDT)
Date: Thu, 8 Jul 2010 15:09:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
Message-ID: <20100708150904.79feffdd@schlenkerla.am.freescale.net>
In-Reply-To: <DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
References: <1278614421.1801.0@antares>
	<DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Albrecht =?ISO-8859-1?B?RHJl3w==?= <albrecht.dress@arcor.de>,
	Steve Deiters <SteveDeiters@basler.com>, linuxppc-dev@lists.ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 8 Jul 2010 21:30:33 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > Actually, this is something which might need closer attention -
> > and maybe some support in the device tree indicating which read or  
> > write width a device can accept?
> 
> There already is "device-width"; the drivers never should use any
> other access width unless they *know* that will work.

Wouldn't you want to use "bank-width" instead?  "device-width" might
not even work if, say, you've got two 8-bit chips interleaved, feeding
into a bus controller in 16-bit mode that only accepts 16-bit accesses.

It would be nice to have a device tree property that can specify that
all access widths supported by the CPU will work, though.

-Scott

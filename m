Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CC7AB7D20
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 08:44:20 +1000 (EST)
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4BF4593E.8030101@freescale.com>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop>  <4BF4593E.8030101@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 May 2010 08:44:10 +1000
Message-ID: <1274309050.1931.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-05-19 at 16:33 -0500, Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> 
> >> So to accommodate future boards where more padding is needed, we make the
> >> option for the -p parameter configurable.
> > 
> > Can't u-boot just allocate more space ?
> 
> Yes and no.  U-Boot has functions to increase the size of an fdt, but these
> functions can't be sure that the fdt will grow beyond its allocated space.
> So if U-Boot calls fdt_setprop() or fdt_add_subnode(), and there isn't
> enough space in the fdt, those functions will return with an error.

 .../...

It's still not kernel business to have to deal with u-boot memory
allocation constraints. The padding in the kernel built is intended to
make space for DT changes done by the zImage wrapper.

Maybe we could add to libfdt a way to provide a realloc() callback to it
when it hits the max size, and uboot can then move things around (or
fail).

Ben.

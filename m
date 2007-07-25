Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA8C9DDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 20:08:12 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6PA872a022855
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 03:08:07 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6PA85SD003894
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 05:08:06 -0500 (CDT)
Subject: Re: modpost warning question
From: chengong <g.chen@freescale.com>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20070725072712.GB24093@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0707250210520.14366@blarg.am.freescale.net>
	<20070725072712.GB24093@uranus.ravnborg.org>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 18:08:03 +0800
Message-Id: <1185358083.4996.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-25 at 09:27 +0200, Sam Ravnborg wrote:
> On Wed, Jul 25, 2007 at 02:14:12AM -0500, Kumar Gala wrote:
> > I'm seeing the following warning:
> > 
> > WARNING: vmlinux.o(.init.text+0x1acdc): Section mismatch: reference to
> > .exit.text:gfar_mdio_exit (between 'gfar_init' and 'gfar_mdio_init')
> > 
> > I don't understand why its not ok to access .exit.text from .init.text
> 
> Several architectures discards .exit.text in the final linker
> script (arch/$(ARCH)/kernel/vmlinux.lds.S
> 
> So any references to .exit.text will when a module is build-in result
> in a linker error because ld will flag it as an error when we reference
> a symbol in a discarded section.
But why? Just make kernel size smaller?
> 
> For the popular architectures (i386,x86_64) we discard .exit.text at
> runtime so here we do not see the error from ld (sadly).
>From which version? On my machine I have seen the same problem when
building i386 target with the version 2.6.21.
> 
> 	Sam
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

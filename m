Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CD8C8DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 05:28:19 +1000 (EST)
Date: Wed, 19 Sep 2007 14:30:24 -0500
From: Olof Johansson <olof@lixom.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: Sequoia kernel crash workaround.
Message-ID: <20070919193024.GA28163@lixom.net>
References: <46F16CC9.3010003@ru.mvista.com> <200709192119.48259.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709192119.48259.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Josh Boyer <jwboyer@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 09:19:47PM +0200, Stefan Roese wrote:
> Hi Valentine,
> 
> On Wednesday 19 September 2007, Valentine Barshak wrote:
> > Disabling write pipelining really helps.
> > Josh, David, what is the right place to put this workaround to?
> >
> > Is it OK to do mtdcr(PLB4A0_ACR, mfdcr(PLB4A0_ACR) & ~PLB4_WRP); in
> > arch/powerpc/boot/cuboot-sequoia.c:sequoia_fixups()?
> > or
> > should this be done in
> > arch/powerpc/platforms/44x/sequoia.c:sequoia_setup_arch()
> > with dcr_map, dcr_read/write stuff?
> 
> I vote for putting it into sequoia.c, since it's very likely to happen that 
> Sequoia will at one point be booted without the bootwrapper. Or perhaps it 
> should go into some common code checking the PVR and disabling it when this 
> 440EPx/GRx is detected, since all those boards are affected.

This is what we have setup_cpu functions in the cpu table for. Please
put it there instead of in board code.


-Olof

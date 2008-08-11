Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A190DE58A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 02:43:41 +1000 (EST)
Date: Mon, 11 Aug 2008 17:26:21 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20080811172621.147b6277@lxorguk.ukuu.org.uk>
In-Reply-To: <20080811163648.GI26082@trinity.fluff.org>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<20080811163648.GI26082@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Aug 2008 17:36:48 +0100
Ben Dooks <ben-linux@fluff.org> wrote:

> 
> On Mon, Aug 11, 2008 at 07:19:13PM +0400, Anton Vorontsov wrote:
> > When no irq specified, pata_of_platform fills irq_res with -1,
> > which is wrong to do for two reasons:
> > 
> > 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> 
> interesting, IRQ 0 is actually valid on some ARM systems.

Not as far as Linux is concerned. It's expected that any IRQ that happens
to be "physical IRQ 0" whatever that means is remapped by the arch code
unless not visible outside the arch.

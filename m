Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BC2CDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 21:24:16 +1100 (EST)
Date: Tue, 7 Oct 2008 10:37:23 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20081007103723.0224671e@lxorguk.ukuu.org.uk>
In-Reply-To: <48EABBD3.1010401@kernel.org>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Li Yang <leoli@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > This was discussed years ago.
> > 
> > http://lkml.org/lkml/2005/11/22/159
> > http://lkml.org/lkml/2005/11/22/227
> > 
> 
> Would this break any existing platforms?  If so, can those be fixed
> together or does it become a much bigger problem that way?

Zero means no IRQ. Any platform with bits of code left over exposing IRQ
0 is already not supported by lots of driver code including libata.

As IRQs are unsigned using -1 is asking for trouble

Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 043C5DDEB8
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 04:02:05 +1000 (EST)
Date: Wed, 25 Jul 2007 13:01:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver for
	CF	interface
Message-ID: <20070725180145.GA29689@ld0162-tx32.am.freescale.net>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46A78E3F.1030904@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 25, 2007 at 09:54:07PM +0400, Sergei Shtylyov wrote:
>     Also, what mmio-ide in the compat properly means in the context of 
> ide_platform which is able to handle both port and memory mapped IDE.

I/O-space is only valid in the context of PCI, ISA, or similar buses, and
the bus-specific reg format indicates whether it's mmio-space or
io-space.

> I think we must get rid with this crap, and since this IDE register
> mapping is pretty much board specific, call it something like
> "mpc8349emitx-ide" instead.

What is board specific about a set of standard IDE registers at a given
address?  Do we need to make board-specific glue code for all of the
various ns16550-compatibles out there as well?

-Scott

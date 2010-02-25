Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B1E9B7CF4
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 07:49:58 +1100 (EST)
Subject: Re: PCI on 834x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <4B86886B.5000304@mlbassoc.com>
References: <4B854A93.7030405@mlbassoc.com>	<4B85746F.3020200@freescale.com>
	<4B857AA8.9000208@mlbassoc.com>	<4B857EA1.6030605@freescale.com>
	<4B858243.8010908@mlbassoc.com>	<4B858B6C.4020809@freescale.com>
	<20100224205159.GA6555@oksana.dev.rtsoft.ru>
	<4B85A4C2.6090007@mlbassoc.com>
	<A0F7894F-8B88-4646-8B81-830F67E39489@kernel.crashing.org>
	<4B85B182.2030508@mlbassoc.com>  <4B86886B.5000304@mlbassoc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Feb 2010 07:49:42 +1100
Message-ID: <1267130982.23523.1728.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-02-25 at 07:25 -0700, Gary Thomas wrote:
> I may have been too hasty pronouncing this fixed.  Indeed, the
> SATA interface now works, but my video card (Fujitsu Coral-P)
> does not work when it's mapped at the bottom of the PCI space :-(
> 
> With the bridge mapped, the video ends up at a non-zero address
> (0xC8000000..0xCFFFFFFF).  If it gets mapped to 0xC0000000, it
> fails to respond to MMIO accesses.
> 
> Any ideas how I might get around this?  Is there a way to force
> the PCI allocator to start somewhere other than [relative] zero?

I'm not familiar with the way the FSL bridge works, but it would
be possible to invert MMIO and DMA on your PCI bus. IE. Have MMIO go
from 0....2G and DMA from 2G..4G for example. Provided the FSL bridge
can offset the DMA back down to 0 (memory). Can it ?

Cheers,
Ben.

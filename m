Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 2A302DE11C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 04:43:07 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Tue, 13 Jan 2009 18:42:53 +0100
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901131733.04341.arnd@arndb.de>
	<20090113164007.GA7434@ovro.caltech.edu>
In-Reply-To: <20090113164007.GA7434@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901131842.54688.arnd@arndb.de>
Cc: netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	shemminger@vyatta.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 13 January 2009, Ira Snyder wrote:
> So do you program one channel of the DMA engine from the host side and
> another channel from the guest side?

Yes.

> I tried to avoid having the host program the DMA controller at all.
> Using the DMAEngine API on the guest did better than I could achieve by
> programming the registers manually. I didn't use chaining or any of the
> fancier features in my tests, though.

Our driver unfortunately does not use the DMA API, but it clearly
should. What this means in your case is that you would need to port
the freescale DMA engine driver to the host side, to operate on the
PCI device. Not sure about how specifically this would work on fsl
hardware, but it seems generally doable.

	Arnd <><

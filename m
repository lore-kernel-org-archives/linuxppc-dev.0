Return-Path: <scottwood@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A26321007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2011 06:57:35 +1100 (EST)
Date: Tue, 25 Jan 2011 13:57:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: FSL DMA engine transfer to PCI memory
Message-ID: <20110125135706.45f351a2@udp111988uds.am.freescale.net>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC29@saturn3.aculab.com>
References: <20110125162946.GA13438@ovro.caltech.edu>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC29@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 25 Jan 2011 16:34:49 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

>  
> > > >>>> custom board based on P2020 running linux-2.6.35. The PCI
> > > >>>> device is Altera FPGA, connected directly to SoC PCI-E
> controller.
> 
>  
> > This sounds like your FPGA doesn't handle burst mode accesses 
> > correctly.
> > A logic analyzer will help you prove it.
> 
> He is doing PCIe, not PCI.
> A PCIe transfers is an HDLC packet pair, one containing the
> request, the other the response.
> In order to get any significant throughput the hdlc packet(s)
> have to contain all the data (eg 128 bytes).
> On the ppc we used that means you have to use the dma
> controller inside the PCIe interface block.

What was the ppc you used?

On 85xx/QorIQ-family chips such as P2020, there is no DMA controller
inside the PCIe controller itself (or are you talking about bus
mastering by the PCIe device[1]?  "interface" is a bit ambiguous),
though it was considered part of the PCI controller on 82xx.

The DMA engine and PCIe are both on OCeaN, so the traffic does not need
to pass through the e500 Coherency Module.  My understanding -- for
what it's worth, coming from a software person :-) -- is that you should
be able to get large transfer chunks using the DMA engine.

I suggest getting things working, and then seeing whether the
performance is acceptable.

> The generic dma controller can't even generate 64bit
> cycles into the ppc's PCIe engine.

Could you elaborate?

-Scott

[1] To the original poster, is there any reason you're not doing bus
mastering from the PCIe device, assuming you control the content of
the FPGA?

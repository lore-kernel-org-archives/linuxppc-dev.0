Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id ABE42B70EE
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2011 03:37:01 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 00480-10 for <linuxppc-dev@ozlabs.org>;
	Tue, 25 Jan 2011 16:36:58 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: FSL DMA engine transfer to PCI memory
Date: Tue, 25 Jan 2011 16:34:49 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC29@saturn3.aculab.com>
In-Reply-To: <20110125162946.GA13438@ovro.caltech.edu>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>,
	"Felix Radensky" <felix@embedded-sol.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > >>>> custom board based on P2020 running linux-2.6.35. The PCI
> > >>>> device is Altera FPGA, connected directly to SoC PCI-E
controller.

=20
> This sounds like your FPGA doesn't handle burst mode accesses=20
> correctly.
> A logic analyzer will help you prove it.

He is doing PCIe, not PCI.
A PCIe transfers is an HDLC packet pair, one containing the
request, the other the response.
In order to get any significant throughput the hdlc packet(s)
have to contain all the data (eg 128 bytes).
On the ppc we used that means you have to use the dma
controller inside the PCIe interface block.
The generic dma controller can't even generate 64bit
cycles into the ppc's PCIe engine.

	David

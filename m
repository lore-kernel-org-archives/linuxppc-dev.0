Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD006DDE1E
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 07:34:20 +1100 (EST)
Subject: Re: [PATCH 12/24] powerpc: 4xx PLB to PCI Express support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200712021332.29074.sr@denx.de>
References: <20071130061155.41D71DDF5F@ozlabs.org>
	<200712021332.29074.sr@denx.de>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 07:33:41 +1100
Message-Id: <1196627621.13230.156.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-12-02 at 13:32 +0100, Stefan Roese wrote:
> As already mentioned I'm experiencing some problems with this current
> version. 
> At least what's available in Josh's 2.6.25-candidates branch. The
> kernel 
> crashes in the first ppc4xx_pciex_read_config() call upon (after I
> fixed the 
> small problem mentioned further down below):
> 
>         BUG_ON(hose != port->hose);
>
> So before digging into this deeper, I wanted to check if you don't
> have a 
> slightly "better" version which passed your tests with the sky2 PCIe
> card.

Yup, looks I forgot a quilt ref or something. I'll check. I'll also give
port 1 and 2 a go (after fixing the DT).

I also want to change the config space code to use some fixmap type
direct mapping/unmapping to remove bus number limitations as soon as
Kumar has implemented the fixmap stuff, since he seems to be working on
it now.

Ben.

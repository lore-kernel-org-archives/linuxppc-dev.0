Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de",
	Issuer "HE CA - G02" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 29712DDE47
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 21:59:24 +1000 (EST)
Date: Wed, 25 Jul 2007 13:59:20 +0200
From: Adrian Reber <adrian@lisas.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.23-rc1 breaks on JS20 w/SLOF
Message-ID: <20070725115920.GA1149@lisas.de>
References: <20070723144745.GA31329@lisas.de>
	<1185228378.5439.144.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1185228378.5439.144.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 24, 2007 at 08:06:18AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-07-23 at 16:47 +0200, Adrian Reber wrote:
> > On a JS20 with SLOF (pretending to be Maple) 2.6.23-rc1 breaks with
> > following oops. 2.6.22 is working. Let me know if I can help debug this.
> 
> That would be my fault... looks like it tries to access IO ports before
> the IO space is mapped by the PCI code, and without a legacy ISA range.
> The later is now the only case where IO ports are available before the
> main PCI setup.
> 
> I can add some tweak to the maple code to map the ISA stuff even when
> the "isa" node is missing...

This also happens on JS21 (with SLOF) in a pretty similar way.

		Adrian

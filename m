Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31E38679FB
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 07:43:45 +1000 (EST)
Subject: Re: ppc -> powerpc porting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0607102135330.10561@poirot.grange>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>
	<20060710214158.1d8dcf2c@vitb.ru.mvista.com>
	<Pine.LNX.4.60.0607102135330.10561@poirot.grange>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 07:43:37 +1000
Message-Id: <1152567817.1576.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-07-10 at 21:43 +0200, Guennadi Liakhovetski wrote:
> On Mon, 10 Jul 2006, Vitaly Bordug wrote:
> 
> > On Mon, 10 Jul 2006 12:14:24 -0500
> > "Rune Torgersen" <runet@innovsys.com> wrote:
> > 
> > > To make my life a little easier: Does anybody have a list of stuff to
> > > watch out for/need to do when porting a board from ppc to powerpc?
> > > The board uses a Freescale 8265 and runs under 2.6.17, using platfrom
> > > device support for accessing fs_enet driver.
> 
> Look at Documentation/powerpc/booting-without-of.txt - 

You guys be careful, if you use OpenPIC/MPIC, that there is an error in
that documentation for the interrupt specifier definition. I'll send an
updated documentation soon with some more details about the OF interrupt
tree, but in the meantime, the proper sense encoding for MPIC is:

 0 = rising edge
 1 = negative level
 2 = positive level
 3 = falling edge

Cheers,
Ben.

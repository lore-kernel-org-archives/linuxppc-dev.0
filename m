Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 828EF679EB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 10:09:34 +1000 (EST)
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20060420234640.GA20059@iram.es>
References: <28892.1145559466@www088.gmx.net>
	<20060420203848.GA23192@gate.ebshome.net>
	<1145567174.4517.1.camel@localhost.localdomain>
	<20060420211321.GB25755@gate.ebshome.net>
	<1145572770.4517.8.camel@localhost.localdomain>
	<20060420234640.GA20059@iram.es>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 10:09:14 +1000
Message-Id: <1145578154.4517.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> In this case the problem is double mapping with inconsistent attributes
> (through BAT and page tables I assume). 

Yes.
 
> > On POWER4, 970 and later, the chip guys confirmed that the problem is
> > real though. Not only bcs of prefetch but also speculative execution
> > which can cause the chip to do a load that will never actually be
> > executed. Imagine for example a loop walking an array, the chip might
> > speculatively load elements beyond the array by speculatively executing
> > beyond the branch that ends the loop.
> 
> Even if the page has the guarded bit set?

The BAT mapping doesn't have G set.

Ben.

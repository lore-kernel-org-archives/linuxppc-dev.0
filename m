Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7A0667E8D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 12:46:54 +1100 (EST)
Subject: Re: Help with an MMIO register read function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200611110010.28788.arnd@arndb.de>
References: <1163199434.30540.13.camel@dyn9047021226.beaverton.ibm.com>
	<200611110010.28788.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 12:46:46 +1100
Message-Id: <1163209606.4982.201.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-11 at 00:10 +0100, Arnd Bergmann wrote:
> On Friday 10 November 2006 23:57, Carl Love wrote:
> > I expect the SBI values to be 0x2000000  not 0x200000000.  The L2 debug
> > value should be 0x6 not 0x600000000000000.  It seems like the bits are
> > there but shifted from where I would expect them to be.  Anyone have any
> > thoughts as to what is wrong?
> 
> Hmm, maybe you confused the bit order in the specification? IBM
> counts the MSB as bit 0, while everyone else counts the LSB as
> bit 0.

I think in this case the problem is that he's using readq() which
byteswaps.

Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97578DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 23:05:22 +1100 (EST)
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070105102618.GA9970@aepfle.de>
References: <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
	<1165293679.29784.39.camel@localhost.localdomain>
	<20061205081557.GA8483@aepfle.de>
	<1165349941.5469.1.camel@localhost.localdomain>
	<20070104174947.GA3636@aepfle.de>
	<1167946240.5273.11.camel@localhost.localdomain>
	<20070105102618.GA9970@aepfle.de>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 23:05:06 +1100
Message-Id: <1167998706.22458.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, greg@kroah.com, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-05 at 11:26 +0100, Olaf Hering wrote:
> On Fri, Jan 05, Benjamin Herrenschmidt wrote:
> 
> > Nah, but also set resource->end = 0 too and or-in IORESOURCE_UNSET for
> > flags not (=) (or just set it to 0, I have no problem with completely
> > clearing the resource, that will keep it out of the way)
> 
> I get this output with the change below:
> 
> Using INTC for W82c105 IDE controller.
> W82c105: bn 0 dfn 19
> 00: f 0000000000000101 s 000000000000f000 e 000000000000f007
> 01: f 0000000000000101 s 000000000000f010 e 000000000000f013
> 02: f 0000000000000101 s 000000000000f020 e 000000000000f027
> 03: f 0000000000000101 s 000000000000f030 e 000000000000f033
> 04: f 0000000000000101 s 000000000000f040 e 000000000000f04f
> 05: f 0000000000000101 s 0000000000000000 e 000000000000000f
> 05: disable IO resource on W82c105 IDE controller
> 06: f 0000000000000000 s 0000000000000000 e 0000000000000000
> 07: f 0000000000000000 s 0000000000000000 e 0000000000000000
> 08: f 0000000000000000 s 0000000000000000 e 0000000000000000
> 09: f 0000000000000000 s 0000000000000000 e 0000000000000000
> 10: f 0000000000000000 s 0000000000000000 e 0000000000000000
> 11: f 0000000000000000 s 0000000000000000 e 0000000000000000
> 
> If thats ok, I will submit a patch without the printk.

If it works, I'm fine with it.

Ben.

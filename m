Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E43D167F09
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 10:10:19 +1100 (EST)
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <tkrat.fa66c98c1012e645@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de> <20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
	<tkrat.fa66c98c1012e645@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 10:10:08 +1100
Message-Id: <1163200208.4982.193.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Gioele Barabucci <dev@gioelebarabucci.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-11 at 00:07 +0100, Stefan Richter wrote:
> I wrote:
> > On  7 Nov, Benjamin Herrenschmidt wrote:
> >> On Tue, 2006-11-07 at 08:08 +0100, Olaf Hering wrote:
> > [...]
> >>> and it is the rmmod, not the insmod, that hangs the pismo.
> >>> Adding some mdelay to the remove function doesnt help either.
> >> 
> >> Tried not calling the pmac feature stuff at all in the rmmod ?
> > 
> > Olaf?
> > 
> >> I reckon there might be a problem with the cable power control on some
> >> old models like... the pismo :-)
> > 
> > Is there a way to detect affected machines or at least to blacklist
> > known broken machines?
> 
> Actually, shouldn't ohci1394_pci_remove enlcose the platform code into
> 
> 	if (machine_is(powermac)) {
> 		...
> 	}
> 
> like ohci1394_pci_suspend and ohci1394_pci_resume do?

Yes.

Ben.

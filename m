Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 12965DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 01:27:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: porting pci driverfrom arch=ppc on kernel 2.6.16 to arch=powerpc
	on	2.6.24...
Date: Thu, 8 May 2008 08:28:27 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D602131E28@uss-am-xch-01.am.trimblecorp.net>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: scottwood@freescale.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks for the help Scott. Simply getting my irq from the pci device
structure in my probe callback following successful PCI driver
registration was the trick. I now have my Fujitsu CoralP driver running
under the 2.6.24 kernel on the Lite5200b (although I have a HW problem
on my product board that confused my efforts). Regardless, I'm now
confident I'm doing this correctly, thanks to you help.

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: Tuesday, May 06, 2008 2:42 PM
To: Mike Timmons
Cc: linuxppc-embedded@ozlabs.org; Mark Gibson
Subject: Re: porting pci driverfrom arch=3Dppc on kernel 2.6.16 to
arch=3Dpowerpc on 2.6.24...

Mike Timmons wrote:
> If I'm not supposed to read the interrupt using config_read, should I
> also not be writing to the host register on the coral P to clear the
> interrupt?
>=20
> Should I instead be using some PCI helper functions?=20

No, clearing interrupts is device-specific.

Have you verified that the device does not think it's generating an=20
interrupt during the interrupt storm?  Do other PCI cards work?

-Scott

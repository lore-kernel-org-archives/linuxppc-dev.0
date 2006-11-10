Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AE93467EFE
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 10:07:21 +1100 (EST)
Date: Sat, 11 Nov 2006 00:07:02 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle]
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
Message-ID: <tkrat.fa66c98c1012e645@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de> <20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
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

I wrote:
> On  7 Nov, Benjamin Herrenschmidt wrote:
>> On Tue, 2006-11-07 at 08:08 +0100, Olaf Hering wrote:
> [...]
>>> and it is the rmmod, not the insmod, that hangs the pismo.
>>> Adding some mdelay to the remove function doesnt help either.
>> 
>> Tried not calling the pmac feature stuff at all in the rmmod ?
> 
> Olaf?
> 
>> I reckon there might be a problem with the cable power control on some
>> old models like... the pismo :-)
> 
> Is there a way to detect affected machines or at least to blacklist
> known broken machines?

Actually, shouldn't ohci1394_pci_remove enlcose the platform code into

	if (machine_is(powermac)) {
		...
	}

like ohci1394_pci_suspend and ohci1394_pci_resume do?
-- 
Stefan Richter
-=====-=-==- =-== -=-==
http://arcgraph.de/sr/

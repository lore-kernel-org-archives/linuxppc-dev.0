Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3DA0ADDF2B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 May 2008 05:27:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: porting pci driverfrom arch=ppc on kernel 2.6.16 to arch=powerpc
	on	2.6.24...
Date: Tue, 6 May 2008 12:27:21 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6020D6B01@uss-am-xch-01.am.trimblecorp.net>
References: <161B3BAD77161449A144FF054231C3D6020D6A5D@uss-am-xch-01.am.trimblecorp.net>
	<48209F79.70506@freescale.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Scott,
Thanks for the quick answer. I did try this. I successfully get the
interrupt (virq=3D16) but it then fires continuously, immedetely =
following
the request_irq call.

My old ppc driver calls request_irq with flags SA_SHIRQ | SA_INTERRUPT
(0x20000000 | 0x04000000 ). I can't find equivalencies in the new
powerpc 2.6.24 kernel.

The only flag I'm passing to request_irq under the new 2.6.24 is
IRQF_SHARED.

I'm wondering if some interrupt type setting is mucked up, hence the
continuous interrupts. I only expect to receive this interrupt in
response to an error on my coralP, so I shouldn't see the interrupt at
all immediately following the interrupt request.

Any ideas? Thanks again,

Mike


-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: Tuesday, May 06, 2008 1:12 PM
To: Mike Timmons
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: porting pci driverfrom arch=3Dppc on kernel 2.6.16 to
arch=3Dpowerpc on 2.6.24...

Mike Timmons wrote:
> pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &irqnum).

Don't do this; use pci_dev->irq instead.

If that value doesn't work, check your interrupt-map in the pci node of=20
the device tree.

-Scott

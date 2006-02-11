Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0924867AA0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 06:02:36 +1100 (EST)
Message-ID: <43EE3433.9000006@ovro.caltech.edu>
Date: Sat, 11 Feb 2006 11:00:03 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de>
	<200602101859.24830.sr@denx.de> <43ECD753.5000105@ovro.caltech.edu>
	<200602110906.05547.sr@denx.de>
In-Reply-To: <200602110906.05547.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Do you really need this I2O unit? You could easily create some message 
> ringbuffers, one in the 440EP's SDRAM for the host-to-440 messages and one in 
> the host-cpu SDRAM for the 440-to-host messages. This way, all messages will 
> be transferred using pci writes.

Actually, its not the I2O unit I want, really just the doorbell
registers in the messaging unit. The MPC834x's seem to have
dropped the I2O units in that the 8272-family appears to
have, but they have the messaging unit registers.

I plan to create something like the ring-buffers scheme you
mention. And of course, you don't need an I2O unit to
implement it. However, you do need to be able to interrupt
the 440 from the host - which was the original issue.
But, there is a work-around :)

BTW, even with this scheme you really want to use DMA on
the adapter board for transfers in either direction, i.e.,
use the peripheral for both DMA read and write.

Unless of course you want to turn your 1GHz x86 host processor
into a 1MHz CPU. Check out the following performance tests
that I did between the current boards and an x86 host:

http://www.ovro.caltech.edu/~dwh/correlator/pdf/pci_performance.pdf

The boards use a PLX-9054 bridge and can DMA between themselves
at 118MB/s. However, the DMA through bridges, and DMA to/from host
bandwidth is less due to burst capabilites (or lack thereof) of
the bridges. CPU reads/writes by the host were dismal; look
at p19-26.

Of course, if I had used a PowerPC host I'm sure I would
have been fine!

Dave

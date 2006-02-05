Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 22B7B689F9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Feb 2006 10:45:19 +1100 (EST)
Received: from ovro.ovro.caltech.edu
	(IDENT:U2FsdGVkX181irXo8nzIo+mn08pGNdTPCvWh6z3wL9g@ovro.ovro.caltech.edu
	[192.100.16.2])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with SMTP id k15NjDKw005240
	for <linuxppc-embedded@ozlabs.org>; Sun, 5 Feb 2006 15:45:15 -0800
Message-ID: <43E68E85.3080100@ovro.caltech.edu>
Date: Sun, 05 Feb 2006 15:47:17 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP PLB4 vs PLB3 DMA to PCI issue
References: <20060205103958.284003535FD@atlas.denx.de>
In-Reply-To: <20060205103958.284003535FD@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <43E58202.8020000@ovro.caltech.edu> you wrote:
> 
>>MRM/MRL commands. I'll do that next. I just figured I'd
>>post these results now, so that others reading this
>>list might comment (Stefan from Denx comes to mind :))
> 
> 
> He's on vacation; he will be back on Monday, but certainly needs some
> time to catch up. Please stay tuned.

No rush, I just wanted to get the question on the list.

I took a look at the 440EP user manual, and I haven't been
able to explain the PLB4 DMA controller observations.

Here's what I've got so far;

p595: PLB-to-PCI transaction handling
    Shows the two situations where the PCI bridge will
    generate memory-read-line (MRL) and memory-read-multiple (MRM)

p646: has comments on PCI Memory to SDRAM DMA Transfer
    and SDRAM to PCI memory DMA transfer. The figures
    for those comments are further on.

    The figures for the PCI read transactions on p663 and p691
    show the PCI command MRL (Eh) being generated on the PCI
    bus, and PCI data bursts occurring in lengths of 32-bytes.

These figures confirm what was observed with the PLB3 DMA
controller. Since the figures show the reads and the writes
on the PLB bus, and do not comment on the PLB bridge,
I can only assume that the figures assume the DMA controller
in use is the PLB3 DMA controller.

As to the PLB4 DMA controller observation of reads to PCI
causing the PCI read command to toggle between MRL and MRM,
I've no idea ... from p595 the transactions are considered
a burst read (MRM), then a burst read of 8-words (MRL),
then repeating. Since each read results in a PCI read burst of
length 32-bytes, there's clearly nothing different between
them on the PCI bus. But perhaps the transaction looks
different on the 440EP internal buses.

The test transfers were to a page-aligned block of SDRAM,
so I don't think the transactions are generating any alignment
issues.

(I hope you had a nice vacation Stefan!)

Cheers
Dave

Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5207A67B58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 05:14:05 +1100 (EST)
Message-ID: <43ECD753.5000105@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 10:11:31 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de>
	<200602100847.54363.sr@denx.de> <43ECC7CE.1010409@ovro.caltech.edu>
	<200602101859.24830.sr@denx.de>
In-Reply-To: <200602101859.24830.sr@denx.de>
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



>>There's actually an additional issue with the 440EP
>>for my application. I'll be using it in a 5V PCI
>>environment (due to the reuse of the existing host
>>CPUs).
> 
> Autsch! Those must be pretty old CPU's! Is this standard desktop PCI or 
> CompactPCI or PMC?

They're not too old ... but at $2k a piece, you don't want
to just throw them away.

The CPUs are Force Computers 735AR2 devices. They contain
a Force Sentinel PCI-to-PCI bridge. The bridges can operate
at 3.3V or 5V, but they decided to hardwire them for 5V
operation to implement hot-swap.

The other newer CPUs are Trenton CPLEs.
http://www.trentontechnology.com/products/singleboards/5932.php4

The system uses cPCI crates. In some cases 21152 bridges are
used to make larger backplanes, in other cases SBS bridges
containing 21152's are used to link crates.

>>Since the 440EP is not 5V tolerant, I figured 
>>I would add clamps or buffers to the board design.
> 
> I would be careful here, since you easily can violate the pci
> specs. Do you  have other pci devices on this pci bus?

Yeah, I'd make sure that I had others check my work. However,
the 21555 would take care of it, and the only PCI bus
on the board would be the one between the 440EP and the
bridge.

> Just use newer host CPU's! ;-)

Ah, the words of a true engineer :)

Of course the project manager wouldn't appreciate me doing that.

However, its not totally out of the question ... $50 per 21555
and 20 per crate, thats $1000, about half the price of
a CPU. But of course, without the I20 unit on the 440EP,
I might need the 21555 anyway.

Cheers
Dave

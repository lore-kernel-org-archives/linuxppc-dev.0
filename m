Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D7D87DDFA4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 05:47:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx ML310 Linux 2.6 PCI bridge
Date: Mon, 10 Dec 2007 10:47:43 -0800
In-Reply-To: <169c03cb0712100833m36842bf7j95aab235f67b5250@mail.gmail.com>
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
	<fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
	<169c03cb0712090932y52cb2744p245cdeb0cccc2ff2@mail.gmail.com>
	<fa686aa40712091223x3efb1143kfd81277890fb74ae@mail.gmail.com>
	<20071210054659.D373C16006E@mail51-dub.bigfish.com>
	<169c03cb0712100833m36842bf7j95aab235f67b5250@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Message-Id: <20071210184748.368EA1390066@mail71-blu.bigfish.com>
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

=20
> That's where things get complicated...  In our lab, we get expensive
> hardware such as the BEE2 via CMC Microsystems (a Canadian granting
> agency).  However, getting funds locally to buy other equipment is a
> relatively long and administratively complex process...

Yeah, I understand how such things go... :)

> I find it strange that Xilinx would not invest in supporting Linux 2.6
> for an important feature such as a PCI bridge (not specifically for
> the ML-310, but in general) when this can bring many interesting
> benefits to an embedded platform.  Is this something that is "in
> progress" at Xilinx?  You seem to imply that most of the difficulty in
> getting the PCI core working is in meeting the timing requirements
> (not with the SW drivers), so I might be missing driver files when I
> generate the BSP code for Linux 2.6.

The PCI core needs a separate driver for generating the right
constraints.  In EDK 9.2 there is some linux 2.6 support for this, but
the code won't work with any of the new kernels.  I've pulled the
changes into my internal git tree, but for reasons that I haven't been
able to ascertain, there are hardcoded xparameter-based interrupt
defines in the super I/O bridge controller.

In any event, I'll send you the patches directly and you can try getting
it to work, although you'll likely need to carefully write the
xparameters by hand.  If you can get away without networking, I'd do
that, though.  :)

Steve=20

From: "Jason Wohlgemuth" <jsw-embedded@mindspring.com>
To: "Dan Malek" <dan@netx4.com>, "Steve Rossi" <srossi@ccrl.mot.com>
Cc: "Embedded Linux PPC List" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Question on QSPAN Driver
Date: Mon, 20 Mar 2000 21:07:52 -0500
Message-ID: <NCBBKJKKGDLPHKDPAFFMMEIPCDAA.jsw-embedded@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <38D6842A.E01E5204@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan and Steve,

The way we got the qspan up and running was to check a GPIO pin to see
whether or not the Qspan was present, inside pci_init or pcibios_init (I did
this a while ago), and if it was present we intialized the qspan and scanned
the bus then, this prevented the majority of the problems of running the
pci_scanner code from the bootrom since the linux exception vectors are
there.  I am glad to hear that people are using the Qspan II, since we
intend to shift to that chip soon, so any issues that you all run into I
would love to hear about or assist you.

Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan
Malek
Sent: Monday, March 20, 2000 3:04 PM
To: Steve Rossi
Cc: Dan Malek; Embedded Linux PPC List
Subject: Re: Question on QSPAN Driver



Steve Rossi wrote:

> Ok, now this is making a whole lot more sense to me, so where would
> be an appropriate place to call qspan_init and pci_scanner from?

I do it after the serial initialization so you can print the messages.
I am changing some of this code right now so it will either call an
initialization function prior to decompress_kernel or as part of
decompress_kernel.  I don't know why I put so much stuff in the
assember code.....It is changing now.


> ......I can't find where (or if) it happens for
> the mbx board.

You don't have to do the qspan_init for the MBX board.  PPC-Bug already
does this.  It also attempts some mapping, but it doesn't get it right.


I just realized there is a big piece of code missing that will prevent
this from working properly.  Configuration register access to devices
that don't exist will result in a machine check exception.  There isn't
anything in this boot code at the moment that will trap this exception
and properly return to the qspan_pci functions........I guess I dropped
the PCI functions here so I wouldn't lose them, and didn't finish the
development.  Another thing for the list.....


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

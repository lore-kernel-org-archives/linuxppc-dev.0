Message-ID: <38D6842A.E01E5204@embeddededge.com>
Date: Mon, 20 Mar 2000 15:03:54 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Dan Malek <dan@netx4.com>,
        Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question on QSPAN Driver
References: <38D64A54.D5A8E8BA@ccrl.mot.com> <38D66069.AA538C28@embeddededge.com> <38D67FA3.D00A5110@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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

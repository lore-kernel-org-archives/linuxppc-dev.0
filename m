Message-ID: <38399F76.919D1FB4@netx4.com>
Date: Mon, 22 Nov 1999 14:54:30 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: sorin@nitechinc.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MBX board
References: <99111909331400.01435@splash.nitechinc.com> <38397383.8F8677A1@jlc.net> <99112211371500.00831@splash.nitechinc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorin Balea wrote:

> So from what i understand, the IDE on MBX board is done by the W83C553F
> chip which i suppose it's not present on other boards, am i right?


Well, that part just appears as a standard PC-style IDE controller,
and the standard Linux port will support that.  It's everything
between the 8xx and that part, the QSpan PCI Bridge, the 8259
interrupt controller, and the integrated features inside the 8xx
that are the challenge.  If you look at the MBX as "just" a i486
PC board, and ignore all of the internal 8xx features, these things
work just fine.  The trouble is, on one hand you want to leverage
all of the internal 8xx features, and on the other you want this
external.....well....crap.  The 8xx MBX just doesn't represent
the kind of board people use for building products (those I have
helped develop).  The added cost of the PCI and PC-style I/O
aren't necessary for embedded designs suitable for the 8xx.
This is further complicated by Linux assuming an exclusive
PC-style environment (8259 interrupt controller, PCI, ISA, 165xx
serial, PCI Ethernet, etc.), and currently prevents some internal
8xx devices to co-exist with external PC stuff.

> If nobody minds, i'd like to give it a shot at making it work,

Just pick a "stock" 2.2.x and it is likely to work.  Just choose
the proper configuration options.  Just don't configure everything,
or you get a big mess.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

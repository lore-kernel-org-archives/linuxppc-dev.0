Message-ID: <38BF5A9B.3C7BB222@netx4.com>
Date: Fri, 03 Mar 2000 01:24:27 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
CC: embedded linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: struct bd_info
References: <20000303143138.28215.qmail@web208.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sebastien Articlaux wrote:

> Someone could explain to me what to put on the
> structure board info?


I created that when I did the original 8xx port of Linux/PPC.
It served as a model to provide some information to an
embedded kernel.  Normally, Linux/PPC gets lots of information
from the OF data structures, and in the embedded systems
we don't have such capability.

> ie , I just want to know, for instance, if ,for the
> size of DRAM memory I must put the real size
> of DRAM in hex,

Hex, decimal, octal, it doesn't really matter :-).
It has to be the size of DRAM (or the size you offer
Linux to use).  It is used during the Linux memory
initialization.


> .... or if it's a offset in relation with
> the chipset select or something else...

It was modelled after the data structure EPPC-Bug provides
to a program when it is started.  The board information
structure are not all identical, although I would like them
that way.  It includes information about memory location and
sizes, processor/bus speed, console baud rate, Ethernet address,
and so on.  If you have a system with discontiguous memory
spaces, you will have to modify the structure to accomodate this.
I would recommend making arrays for the start and size information.

For systems where I wrote the boot rom, it creates the board
information structure and passes it to the Linux image.  Most
other boards create a board information structure in
arch/ppc/mbxboot/embed_config.c and pass that to the Linux kernel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

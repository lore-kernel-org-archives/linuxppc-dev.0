Message-ID: <39664E6E.56CA6D7@embeddededge.com>
Date: Fri, 07 Jul 2000 17:41:02 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ron Bianco <ronb@junction.net>
CC: LinuxPPClist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems in building a kernel for a minimal 8240 board
References: <000301bfe84f$56c9a820$4d012ac7@warp-speed>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ron Bianco wrote:

> I've been trying to figure out what files I need to change to reflect the differences
> between the Sandpoint and our board, and produce a clean build with my radically
> simplified config.

You don't have a "radically simplified" configuration from the Sandpoint.
The only thing you don't have are the ISA I/O devices in the SouthBridge
and Super I/O chips.  The only thing I ever used in that set was the serial
I/O port, and that never worked well.

> I know the file:  arch/ppc/kernel/Makefile is causing me some grief,

The Makefile is OK, it is just the configuration that is amiss.

> A major question I have in both cases is:   why is pmac stuff in there?

To resolve some common functions among all of the platforms.

> Also linked into the kernel are 5 files to do with pci,  why?   For one thing, I thought
> prep and chrp were mutually exclusive hardware configurations.

They are, but this is configured at run-time.  The 8240 is basically
a PowerPC 603 core with a MPC106 PCI Bridge.  I don't remember which
memory map I used, probably Prep, but it doesn't quite match either one.
It doesn't really matter as the I/O mapping functions are fairly generic.
I just used the bits and pieces that were appropriate.


> ...   Also, there is no i8259
> on the sandpoint board!?!

Yes, there is.  It is inside the SouthBridge (Winbond 83c553).  It handles
all of the external interrupt arbitration.

> ....   And why the gemini stuff?

To get the Grackle (MPC106) PCI configuration/control functions.  I just
used what Cort wrote for the Gemini, no sense duplicating code.

> This causes problems when the config is changed/simplified.

There isn't very much you are going to change from the Sandpoint port,
as it was really just a 8240 Port.  I used the Ethernet card on the
PCI bus, but you are doing the same.

You will have to include your Ethernet driver and other PCI device
drivers.  You will have to possibly modify the OpenPIC configuration to
match your hardware (I don't know how you are managing external interrupts).
The code as I left it assumed a standard serial port at a well known
address for the boot/kernel console.  You will probably have to change
that to match your system.

> ..........   There is a lot of interdependencies of
> function calls amongst these files.   I've started to explore some of the source files,
> but am so far bewildered on what to specify for a minimal obj file list that will link OK.

Yes.  The Sandpoint or Gemini are about as minimal as you can get.  There
doesn't appear to be much software specific to Sandpoint because it
utilizes all of the standard functions in other files for the standard
interfaces (processor, PCI, OpenPIC, etc.).

Take the existing Sandpoint files, modify to suit your needs, configure
your Ethernet driver, and you are done.  Don't try to remove all of the
other files because they are required to support the hardware.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <39FEA72D.F0433269@vas-gmbh.de>
Date: Tue, 31 Oct 2000 12:04:13 +0100
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: Peter Uttley <P.Uttley-97@student.lboro.ac.uk>
Subject: Re: Using BDM4GDB on a custom board.
References: <005e01c042b3$cf071160$74dee783@lboro.ac.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Peter,

> I'm currently trying to get BDM4GDB running on a custom board with a MPC850
> and being quite new to all this would just like a quick pointer into which
> parts of mpcbdm I need to configure.

For general information for embedded linux on ppc look under
http://members.nbci.com/greyhams/linux/PowerPC-Embedded-HOWTO.html
(thanks Graham, excellent work!)

For mpcbdm look under http://www.vas-gmbh.de/software/mpcbdm/ right now. This
stuff will sooner or later be moved to bdm4gdb at sourceforge (thanks to
Raphael). There should be a README and script to build the cross gdb. There
should also be an init script for the cross gdb, called mpc.init. Only a few
things need to be setup for debugging. Look under the 'init' macro.

I assume you've built the adapter yourself? Be careful with powering the
adapter: I think the mpc850 limits voltage to 3.6V for input on BDM, so use
jumper settings 2-3, powering the adapter from target board.

Right now support for internal registers is designed for mpc860. mpc850 uses
different internal mappings for some registers, so you have to adapt the
mpcbdm.h file for you needs, otherwise you'll get wrong information. This
shouldn't be too hard, thought it take's some time to input (so I'd like to get
those mapping when you have finished it ;-). But most important registers should
work out of the box. So configuring for mpcbdm shouldn't be to hard.

I'm working on a new version of software allowing loadable register mappings.
This will be announced and updated on bdm4gdb. I've also have designed a new
adapter, avoiding some problems (e.g. the VFSL0..1 vs FRZ, and introduce some
new problems arg). If there is interest I could produce this adapter for you for
around $50. I'm also going to publish the schematics. This new adapter includes
a port for the JTAG/COP for the mpc8260, though I have no idea for the software
right now due to Motorola' NDA for the COP protocol.

If you have still problems, feel free to contact me.

hth
 Frank

--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

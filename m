Reply-To: <jdomogala@acmepacket.com>
From: "Jeff Domogala" <jdomogala@acmepacket.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Handling of cascaded interrupt controllers
Date: Wed, 25 Aug 2004 16:08:58 -0400
Message-ID: <NFBBJCNFKLFMBACPKDKCOEIFEFAA.jdomogala@acmepacket.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20040825143025.GJ23113@mind.be>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a Marvell GT-64260A based custom board.  The interrupt line out of
the GT is cascaded into a CPLD, which also has 15 other interrupt sources.
The way I handled this situation in VxWorks was to define interrupt vectors
for the CPLD interrupts, minus the one cascaded interrupt from the GT (so 15
interrupt vectors), then use 64 more interrupt vectors for the GT
interrupts.  The cascaded interrupt would then call the GT's normal
interrupt handler to determine the interrupt source.

Is there a way to define two interrupt controller devices in this fashion in
Linux, where a single interrupt from one controller (the CPLD) can somehow
manage multiple interrupts for the other controller (the GT), with all
interrupt sources having unique vectors?  This appears to be identical to a
cascaded pair of 8259 controllers.  Or, do I do something similar to my
VxWorks implementation and create one interrupt controller device with
unique interrupt vectors for all sources except the cascaded CPLD interrupt
for the GT?

Regards,

Jeff


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Fri, 1 Dec 2000 22:36:22 -0500
From: Dan Hopper <eusdbho@rtp.ericsson.se>
To: linuxppc-embedded@lists.linuxppc.org
Subject: trouble with FEC on MPC860T - FEC_INTERRUPT not going off?
Message-ID: <20001201223622.A28837@slug.rtp.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've ported ppcboot to a custom MPC860T-based board which uses the
FEC, and am now working on the kernel.  At the moment, I'm using the
2.4-2000-11-11 kernel from ftp.denx.de as a baseline, since it
seemed to be a good starting point.

I've created my own header file in include/asm-ppc/, with board info
struct, IMMR, and defined FEC_INTERRUPT to be SIU_LEVEL1.  I've
corrected drivers/net/setup.c to call fec_enet_init.  The kernel
boots, and gets down to this point, where the FEC is detected, but
the PHY is not, and so eth0 can't be opened:

eth0: FEC ENET Version 0.2, 08:00:3e:03:01:04
IP-Config: Failed to open eth0
IP-Config: No network devices available.

I've poked around, and it appears that the MII command queued at the
end of fec_enet_init() is never processed.  It appears that this
processing should be done from fec_enet_mii(), which is called from
the FEC interrupt routine, fec_enet_interrupt().  To prove the
point, I placed a printk() at the beginning of fec_enet_interrupt().
It never appeared on the console, so I conclude that FEC interrupts
aren't happening.

I'm aware that the MII can also have an interrupt assigned, though
the current code makes it appear to be optional (only the FADS board
seems to run request_8xxirq() on it).  The PHY IRQ line (it's an
Level One LXT972LC) isn't hooked up to the 860, though it could be.
Thinking this might be the problem, I put a scope on the LXT972's
MDINT* pin, and rebooted the kernel.  No interrupts at all.  So,
unless I'm missing an interaction, hooking that up would be unlikely
to change the current problem.

I imagine I'm missing something obvious, but I can't figure out what
it would be right now.  Has anyone got any suggestions, or perhaps
has run into this type of problem before?

Thanks!
Dan Hopper

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

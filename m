From: "Ron Bianco" <ronb@junction.net>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: MontaVista->sandpoint_setup.c:  changing IRQs
Date: Thu, 27 Jul 2000 13:24:15 -0700
Message-ID: <000401bff808$a2501f90$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The sandpoint code sets up the EPIC to cascade to the 8259.

I've changed it to try to use the openpic for all irqs.  And changed the sandpoint_map[]
in sandpoint_pci.c to agree with my hardware.
And all other sandpoint specific irq stuff, including #if 0'ing  out all code related to
the 8259 in the sandpoint files.

FYI, I've tried to create 2 replacement files for sandpoint_setup.c and sandpoint_pci.c
with different names but changing the Makefile where the related object files are
referenced is not sufficient to have the new files included in the build.  I don't
understand all the components that control a build well enough yet to make successful
changes to the process.  I wish there was some detailed explaination somewhere.

I'm still uncertain that I've done all the right things.

In sandpoint_init_IRQ():

- I'm uncertain about:   irq_desc[i].ctl = &open_pic   where i is less than 16.    Should
I include 0 to 15 for this?

- Since there is no setup for the 8259 now in 'my' modified code, is there someplace
amongst all the openpic init stuff where I need to explicitly provide EPIC register setup
for all interrupts to direct mode?

Thanks, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

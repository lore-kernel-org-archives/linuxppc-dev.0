From: "Chris Hallinan" <clh@net1plus.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC850 SIMASK Settings
Date: Sat, 21 Oct 2000 10:17:38 -0400
Message-ID: <NEBBKJPFOLJNBMFNKBIIEENICDAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having trouble disabling an external interrupt (IRQ7).
I have the IRQ configured for edge detect ( SIEL[ED7] = 1 )
According to the MPC850 User's Manual, to enable this
interrupt to be presented to the core, I should set
SIMASK[IRM7] = 1, and to disable interrupts to the core, I
should clear SIMASK[IRM7] = 0.

Here is the code I'm using to enable it, which seems to
work.

immap->im_siu_conf.sc_siel |= 0x00020000;  // set for edge
detect
immap->im_siu_conf.sc_simask |= 0x00020000;	// unmask

Here is the code I've used to try to disable the interrupt,
which does not work:

immap->im_siu_conf.sc_siel &= ~0x00020000; // return to
level int
immap->im_siu_conf.sc_simask &= ~0x00020000;  // mask
immap->im_siu_conf_sc_sipend |= 0x00020000;  // clear if
pending (??)

If I write a 0x00000000 into the SIMASK, I am able to
disable the interrupt.  This, of course, is not acceptable
because it disables other internal and/or external interrupt
sources that may already have been configured.

Surely I'm overlooking something simple?  Can anyone shed
some light on this?

-Chris Hallinan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

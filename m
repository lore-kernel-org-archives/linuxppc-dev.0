Message-Id: <200012281413.eBSEDIR04767@ginger.cmf.nrl.navy.mil>
To: jingai@floatingpenguins.com
cc: Benjamin Herrenschmidt <bh40@calva.net>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of PCI-PCI bridge on UMAX S900 
In-reply-to: Your message of "Wed, 27 Dec 2000 23:05:03 EST."
             <200012280405.WAA05948@lists.linuxppc.org>
Date: Thu, 28 Dec 2000 09:13:19 -0500
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


just a short followup to the message i sent to debian-powerpc, i applied the
following diff and was able to move my usb board to the other side of the
umax/s900 bridge w/o any ill effect:

--- prom.c.000  Thu Dec 28 08:43:12 2000
+++ prom.c      Thu Dec 28 09:06:16 2000
@@ -1563,8 +1563,8 @@
        }

        ip = (int *) get_property(np, "AAPL,interrupts", &l);
-       if (ip == 0)
-               ip = (int *) get_property(np, "interrupts", &l);
+       if (ip == 0 && np->parent != NULL)
+               ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
        if (ip != 0) {
                np->intrs = (struct interrupt_info *) mem_start;
                np->n_intrs = l / sizeof(int);

lspci, now shows:

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE (prog-if 00 [VGA])
        Subsystem: Unknown device b530:0408
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 25
        Memory at 84000000 (32-bit, prefetchable) [size=64M]
        I/O ports at 1000 [size=256]
        Memory at 80804000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 80820000 [disabled] [size=128K]
        Capabilities: <available only to root>

01:01.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc.: Unknown device c861
        Flags: bus master, medium devsel, latency 32, IRQ 25
        Memory at 80800000 (32-bit, non-prefetchable) [size=4K]

on a related, note, shouldnt the 'right' code be:

	ip = (int *) get_property(np, "interrupts", &l);
	if (ip > 0)
	{
		/* find and assign interrupt -- see above */
	}

pci boards should only get an interrupt if they have the interrupt property
(which seems to be the number of interrupts, not the interrupt number)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

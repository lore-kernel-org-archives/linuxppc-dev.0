Date: Mon, 27 Mar 2000 10:57:26 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.05.10003251432500.11322-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10003271050560.31313-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The code I posted for the LongTrail does assign missing/conflicting resources.
> Please adapt it for PowerMac.

Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
one solves my PCI address conflict for the Mach64 by reallocating the MMIO
aperture, and allows XFree86 4.0 to run on my Lombard.

	Michael

--- arch/ppc/kernel/pci.c.org	Sun Mar 26 14:08:53 2000
+++ arch/ppc/kernel/pci.c	Sun Mar 26 14:09:16 2000
@@ -231,7 +231,7 @@
 				if (!pr || request_resource(pr, r) < 0) {
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, dev->slot_name);
 					/* We'll assign a new address later */
-					r->start -= r->end;
+					r->end -= r->start;
 					r->start = 0;
 				}
 			}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sat, 20 Dec 2003 14:09:07 +0100
From: Harald Welte <laforge@gnumonks.org>
To: prism54-devel@prism54.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 2.6] fix pci_update_resource() / IORESOURCE_UNSET on PPC
Message-ID: <20031220130907.GA15552@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

The prism54 (http://prism54.org) driver for my cardbus adapter works
with 2.4.x, but not 2.6.x on a Titanium G4 Powerbook IV.

On 2.6.x the error message was
PCI:0001:02:00.0 Resource 0 [00000000-00001fff] is unassigned

After investigating differences in the PCI code of 2.4.x and 2.6.x, i
noticed that 2.4.x/arc/ppc/kernel/pci.c:pcibios_update_resource()
contained a couple of lines that unset the IORESOURCE_UNSET bitflag.

In 2.6.x, this is handled by the generic PCI core in
drivers/pci/setup-res.c:pci_update_resource() code.  However, the code
is missing the 'res->flags &= ~IORESOURCE_UNSET' part.

The below fix re-adds that section from 2.4.x.

I'm not sure wether this belongs into the arch-independent PCI api.
Anyway, on PPC it seems to be needed for certain cardbus devices.

Any comments welcome.

diff -Nru linuxppc25bh-031214-plain/drivers/pci/setup-res.c linuxppc25bh-031214-orinoco_monitor/drivers/pci/setup-res.c
--- linuxppc25bh-031214-plain/drivers/pci/setup-res.c	2003-12-05 02:37:16.000000000 +0100
+++ linuxppc25bh-031214-orinoco_monitor/drivers/pci/setup-res.c	2003-12-15 12:08:11.000000000 +0100
@@ -84,6 +84,10 @@
 			       pci_name(dev), resno, new, check);
 		}
 	}
+	res->flags &= ~IORESOURCE_UNSET;
+	printk(KERN_INFO "PCI: moved device %s resource %d (%lx) to %x\n",
+		dev->slot_name, resno, res->flags,
+		new & ~PCI_REGION_FLAG_MASK);
 }

 int __init

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

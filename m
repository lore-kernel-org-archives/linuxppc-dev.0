Date: Thu, 26 Jul 2001 10:18:19 +0200
From: Sven Dickert <Sven.Dickert@planb.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: CAROLINA_IRQ_EDGE_MASK_HI, Segment Register 8 instead of BATs on 601
Message-ID: <20010726101819.A15010@remote.org>
References: <20010724105114.A17706@remote.org> <20010725144239.A11885@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010725144239.A11885@austin.ibm.com>; from hollis@austin.ibm.com on Wed, Jul 25, 2001 at 02:42:39PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
> >   At the moment I'm working on sound support. I changed
> > -#define CAROLINA_IRQ_EDGE_MASK_HI   0xA4  /* IRQ's 8-15 [10,13,15] */
> > +#define CAROLINA_IRQ_EDGE_MASK_HI   0xA0  /* IRQ's 8-15 [10,13,15] */
> > in arch/ppc/kernel/prep_pci.c
> > I found this 'patch' at http://penguinppc.org/dev/prep/tp850.diff
>
> Neither the 40P nor the Thinkpad 850 are Carolina systems, so those constants
> should remain how they are and new ones for other systems introduced. That
> will mean slight changes to the IBM section of prep_route_pci_interrupts(),
> but nothing major.

  O.k. it's better done this way:
-------------------------------------------------- 8< ------------------------
diff -rwu linux-2.4.7/arch/ppc/kernel/prep_pci.c linux-2.4.7.40p/arch/ppc/kernel/prep_pci.c
--- linux-2.4.7/arch/ppc/kernel/prep_pci.c  Wed Jul  4 18:11:52 2001
+++ linux-2.4.7.40p/arch/ppc/kernel/prep_pci.c  Thu Jul 26 10:01:51 2001
@@ -564,6 +565,10 @@
  */
 #define CAROLINA_IRQ_EDGE_MASK_LO   0x00  /* IRQ's 0-7  */
 #define CAROLINA_IRQ_EDGE_MASK_HI   0xA4  /* IRQ's 8-15 [10,13,15] */
+#define IBM6015_IRQ_EDGE_MASK_LO   0x00  /* IRQ's 0-7  */
+#define IBM6015_IRQ_EDGE_MASK_HI   0xA0  /* IRQ's 8-15 [13,15] */
+#define NOBIS_IRQ_EDGE_MASK_LO     0x00  /* IRQ's 0-7  */
+#define NOBIS_IRQ_EDGE_MASK_HI     0xA0  /* IRQ's 8-15 [13,15] */

 /*
  * 8259 edge/level control definitions
@@ -839,6 +845,7 @@
  } else if ( _prep_type == _PREP_IBM )
  {
    unsigned char pl_id;
+   unsigned char irq_edge_mask_lo,irq_edge_mask_hi;
    /*
     * my carolina is 0xf0
     * 6015 has 0xfc
@@ -851,27 +858,33 @@
      Motherboard_map_name = "IBM 850/860 Portable\n";
      Motherboard_map = Nobis_pci_IRQ_map;
      Motherboard_routes = Nobis_pci_IRQ_routes;
+     irq_edge_mask_lo=NOBIS_IRQ_EDGE_MASK_LO;
+     irq_edge_mask_hi=NOBIS_IRQ_EDGE_MASK_HI;
      break;
    case 0xfc:
-     Motherboard_map_name = "IBM 6015";
+     Motherboard_map_name = "IBM 6015/7020 (Sandalfoot/Sandalbow)";
      Motherboard_map = ibm6015_pci_IRQ_map;
      Motherboard_routes = ibm6015_pci_IRQ_routes;
+     irq_edge_mask_lo=IBM6015_IRQ_EDGE_MASK_LO;
+     irq_edge_mask_hi=IBM6015_IRQ_EDGE_MASK_HI;
      break;
    default:
      Motherboard_map_name = "IBM 8xx (Carolina)";
      Motherboard_map = ibm8xx_pci_IRQ_map;
      Motherboard_routes = ibm8xx_pci_IRQ_routes;
+     irq_edge_mask_lo=CAROLINA_IRQ_EDGE_MASK_LO;
+     irq_edge_mask_hi=CAROLINA_IRQ_EDGE_MASK_HI;
      break;
    }

    /*printk("Changing IRQ mode\n");*/
    pl_id=inb(0x04d0);
    /*printk("Low mask is %#0x\n", pl_id);*/
-   outb(pl_id|CAROLINA_IRQ_EDGE_MASK_LO, 0x04d0);
+   outb(pl_id|irq_edge_mask_lo, 0x04d0);

    pl_id=inb(0x04d1);
    /*printk("Hi mask is  %#0x\n", pl_id);*/
-   outb(pl_id|CAROLINA_IRQ_EDGE_MASK_HI, 0x04d1);
+   outb(pl_id|irq_edge_mask_hi, 0x04d1);
    pl_id=inb(0x04d1);
    /*printk("Hi mask now %#0x\n", pl_id);*/
  }
-------------------------------------------------- 8< ------------------------

> In your patch you're using a segment register because 601 BAT's are only 8MB
> (and we need more for IO space). Someone suggested using ioremap in the driver
> (the one causing the page fault), but I suspect the whole reason those BAT
> regions are there is to support legacy IO and not have to get everything to
> ioremap?

  I think so, too. It's not just one driver that makes problems. Kernel
shows bad memory access even at "PCI: Probing PCI hardware"

>          Is there an equivalent to ioremap that allows the virtual address to
> be specified (want to map 0x80000000 physical to 0x80000000 virtual [NOT
> n+io_base] for IO ports)?

  When I get to know about this, I would no longer use SR8 :)

Bye,	Sven

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

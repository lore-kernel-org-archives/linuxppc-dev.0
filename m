Date: Sat, 7 Jul 2001 01:15:40 -0500
From: Colin Gibbs <colin@rmconsulting.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: pcmcia broken in recent benh kernel
Message-ID: <20010707011540.B9329@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5gxpn/Q6ypwruk0T"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With a recent benh kernel I get this message on card insertion:
  cs: unable to map card memory!

This seems to be caused by changes to the pci code. In the old kernel
(2.4.4-pre3) I have this in /proc/iomem:

80081000-80081fff : usb-ohci
80082000-80082fff : usb-ohci
a0000000-a0003fff : aty128fb MMIO
a4000000-a7ffffff : aty128fb FB

With the new kernel (2.4.6-pre8) I get this:

80000000-9fffffff : /pci@f2000000
  80000000-8007ffff : Apple Computer Inc. KeyLargo Mac I/O
  80080000-80080fff : Texas Instruments PCI1211
  80081000-80081fff : Apple Computer Inc. KeyLargo USB (#2)
    80081000-80081fff : usb-ohci
  80082000-80082fff : Apple Computer Inc. KeyLargo USB
    80082000-80082fff : usb-ohci
  80400000-807fffff : PCI CardBus #02
a0000000-afffffff : /pci@f0000000
  a0000000-a0003fff : ATI Technologies Inc Mobility M3 AGP 2x
    a0000000-a0003fff : aty128fb MMIO
  a4000000-a7ffffff : ATI Technologies Inc Mobility M3 AGP 2x
    a4000000-a7ffffff : aty128fb FB
f1000000-f1ffffff : /pci@f0000000
f3000000-f3ffffff : /pci@f2000000
  f3000000-f33fffff : PCI CardBus #02
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : Apple Computer Inc. UniNorth FireWire
  f5200000-f53fffff : Apple Computer Inc. UniNorth GMAC

The attached patch fixes things for me. It uses the check_region/
check_mem_region in the pcmcia code which descents the resource
tree instead of check_resource which does not.

Colin

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rsrc_mgr.c.patch"

--- linux-2.4-benh/drivers/pcmcia/rsrc_mgr.c	Tue Apr  3 05:48:39 2001
+++ linux-build/drivers/pcmcia/rsrc_mgr.c	Fri Jul  6 00:01:46 2001
@@ -104,8 +104,8 @@

 ======================================================================*/

-#define check_io_resource(b,n)	check_resource(&ioport_resource, (b), (n))
-#define check_mem_resource(b,n)	check_resource(&iomem_resource, (b), (n))
+#define check_io_resource(b,n)	check_region((b), (n))
+#define check_mem_resource(b,n)	check_mem_region((b), (n))

 /*======================================================================


--5gxpn/Q6ypwruk0T--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

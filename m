Date: Tue, 14 May 2002 00:40:17 -0400
From: Bill Fink <billfink@mindspring.com>
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Firewire Disk Broken in 2.4.19-pre8-ben0 kernel (was working fine with 2.4.18-ben0)
Message-Id: <20020514004017.2a66ccf2.billfink@mindspring.com>
In-Reply-To: <20020513160900.GK494@blimpo.internal.net>
References: <20020513105519.7cb1daf8.billfink@mindspring.com>
	<20020513151319.GI494@blimpo.internal.net>
	<20020513120748.654bcbc0.billfink@mindspring.com>
	<20020513160900.GK494@blimpo.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 May 2002, Ben Collins wrote:

> On Mon, May 13, 2002 at 12:07:48PM -0400, Bill Fink wrote:
> > On Mon, 13 May 2002, Ben Collins wrote:
> >
> > > > ohci1394: $Revision: 1.101 $ Ben Collins <bcollins@debian.org>
> > >
> > > Try the SVN code base (check the website for how to download).
> >
> > Hi Ben,
> >
> > As I indicated in my earlier message, I already tried the latest
> > ieee1394-473 tarball (dated May 13).  I gave the output from the
> > ieee1394-444 tarball (dated April 4), since that was the earliest
> > point I knew it to be broken.  For completeness, here is the dmesg
> > output from the ieee1394-473 tarball:
> >
> > ohci1394: $Rev: 460 $ Ben Collins <bcollins@debian.org>
> > ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-80080800]  Max Packet=[2048]
> > ieee1394: received packet during reset; ignoring
> > ohci1394_0: Unexpected tcode 0xf(0x6001c1ff) in AR ctx=0, length=-1: dma prg stopped
> > ieee1394: ConfigROM quadlet transaction error for node 00:1023
> > ieee1394: Host added: Node[01:1023]  GUID[00000000feeb324a]  [Linux OHCI-1394]
> >
> > I know it is reporting "$Rev: 460" but it is in fact from the ieee1394-473
> > tarball.
>
> 460 was the last revision that ohci1394.c changed, so that's normal.
> BenH may know more about the problem here.

Hi Ben (either or both :-),

OK, I've narrowed it down a bit.  I'm enclosing a diff between a working
ieee1394 CVS checkout from "26 Feb 2002 12:00" and a broken CVS checkout
from "27 Feb 2002 12:00".  I'm wondering if it could be a data alignment
issue but since I'm not at all familiar with this code, I'll let the experts
check out the diff to see if anything pops out at anyone, especially if
there's anything that might be problematic for PPC.

						-Thanks

						-Bill



--------------------------------------------------------------------------------
Common subdirectories: ieee1394-022602/CVS and ieee1394-022702/CVS
diff -u ieee1394-022602/hosts.c ieee1394-022702/hosts.c
--- ieee1394-022602/hosts.c	Sat Feb  9 00:41:40 2002
+++ ieee1394-022702/hosts.c	Tue Feb 26 15:06:39 2002
@@ -43,6 +43,16 @@
         devctl:           dummy_devctl
 };

+/**
+ * hpsb_ref_host - increase reference count for host controller.
+ * @host: the host controller
+ *
+ * Increase the reference count for the specified host controller.
+ * When holding a reference to a host, the memory allocated for the
+ * host struct will not be freed and the host is guaranteed to be in a
+ * consistent state.  The driver may be unloaded or the controller may
+ * be removed (PCMCIA), but the host struct will remain valid.
+ */

 int hpsb_ref_host(struct hpsb_host *host)
 {
@@ -64,6 +74,15 @@
         return retval;
 }

+/**
+ * hpsb_unref_host - decrease reference count for host controller.
+ * @host: the host controller
+ *
+ * Decrease the reference count for the specified host controller.
+ * When the reference count reaches zero, the memory allocated for the
+ * &hpsb_host will be freed.
+ */
+
 void hpsb_unref_host(struct hpsb_host *host)
 {
         unsigned long flags;
@@ -78,26 +97,39 @@
         spin_unlock_irqrestore(&hosts_lock, flags);
 }

+/**
+ * hpsb_alloc_host - allocate a new host controller.
+ * @drv: the driver that will manage the host controller
+ * @extra: number of extra bytes to allocate for the driver
+ *
+ * Allocate a &hpsb_host and initialize the general subsystem specific
+ * fields.  If the driver needs to store per host data, as drivers
+ * usually do, the amount of memory required can be specified by the
+ * @extra parameter.  Once allocated, the driver should initialize the
+ * driver specific parts, enable the controller and make it available
+ * to the general subsystem using hpsb_add_host().
+ *
+ * The &hpsb_host is allocated with an single initial reference
+ * belonging to the driver.  Once the driver is done with the struct,
+ * for example, when the driver is unloaded, it should release this
+ * reference using hpsb_unref_host().
+ *
+ * Return Value: a pointer to the &hpsb_host if succesful, %NULL if
+ * no memory was available.
+ */
+
 struct hpsb_host *hpsb_alloc_host(struct hpsb_host_driver *drv, size_t extra)
 {
         struct hpsb_host *h;

-        h = kmalloc(sizeof(struct hpsb_host), SLAB_KERNEL);
+        h = kmalloc(sizeof(struct hpsb_host) + extra, SLAB_KERNEL);
         if (!h) return NULL;
         memset(h, 0, sizeof(struct hpsb_host));

-	/* Drivers usually use this to allocate their private data */
-	if (extra) {
-		h->hostdata = kmalloc(extra, SLAB_KERNEL);
-		if (!h->hostdata) {
-			kfree(h);
-			return NULL;
-		}
-		memset(h->hostdata, 0, extra);
-	}
-
+	h->hostdata = h + 1;
         h->driver = drv;
         h->ops = drv->ops;
+	h->refcount = 1;

         INIT_LIST_HEAD(&h->pending_packets);
         spin_lock_init(&h->pending_pkt_lock);
@@ -141,9 +173,7 @@
         spin_lock_irqsave(&hosts_lock, flags);
         list_del(&host->driver_list);
         list_del(&host->host_list);
-
         drv->number_of_hosts--;
-        if (!host->refcount) kfree(host);
         spin_unlock_irqrestore(&hosts_lock, flags);
 }

diff -u ieee1394-022602/ohci1394.c ieee1394-022702/ohci1394.c
--- ieee1394-022602/ohci1394.c	Sun Feb 10 00:13:15 2002
+++ ieee1394-022702/ohci1394.c	Tue Feb 26 15:06:39 2002
@@ -161,7 +161,7 @@
 printk(level "%s_%d: " fmt "\n" , OHCI1394_DRIVER_NAME, card , ## args)

 static char version[] __devinitdata =
-	"$Revision: 1.98 $ Ben Collins <bcollins@debian.org>";
+	"$Revision: 1.99 $ Ben Collins <bcollins@debian.org>";

 /* Module Parameters */
 MODULE_PARM(attempt_root,"i");
@@ -2281,7 +2281,7 @@
 #endif /* CONFIG_ALL_PPC */

 	pci_set_drvdata(ohci->dev, NULL);
-	kfree(ohci);
+	hpsb_unref_host(ohci->host);
 }

 #define PCI_CLASS_FIREWIRE_OHCI     ((PCI_CLASS_SERIAL_FIREWIRE << 8) | 0x10)
diff -u ieee1394-022602/pcilynx.c ieee1394-022702/pcilynx.c
--- ieee1394-022602/pcilynx.c	Sat Feb  9 00:41:40 2002
+++ ieee1394-022702/pcilynx.c	Tue Feb 26 15:06:39 2002
@@ -1212,7 +1212,7 @@
         }

 	tasklet_kill(&lynx->iso_rcv.tq);
-	kfree(lynx);
+	hpsb_unref_host(lynx->host);
 }


diff -u ieee1394-022602/video1394.c ieee1394-022702/video1394.c
--- ieee1394-022602/video1394.c	Mon Feb 25 20:06:57 2002
+++ ieee1394-022702/video1394.c	Tue Feb 26 22:46:14 2002
@@ -74,8 +74,7 @@
 #define vmalloc_32(x) vmalloc(x)
 #endif

-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,3) && LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)) || \
-	LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,3))
 #define remap_page_range_1394(vma, start, addr, size, prot) \
 	remap_page_range(start, addr, size, prot)
 #else

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

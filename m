Message-ID: <3A902FD9.699F4537@talknet.de>
Date: Sun, 18 Feb 2001 21:26:01 +0100
From: Alois Fertl <alois_fertl@talknet.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ncr810 problem on powerstack
References: <Pine.LNX.4.05.10101190851170.27117-100000@callisto.of.borg>
Content-Type: multipart/mixed;
 boundary="------------94E1A3227C44AFB384FCA5F2"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------94E1A3227C44AFB384FCA5F2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Geert Uytterhoeven wrote:
>
> On Fri, 19 Jan 2001, Troy Benjegerdes wrote:
> > On Tue, Jan 16, 2001 at 09:44:07PM +0100, Alois Fertl wrote:
> > > I tried the recent 2.4.1-pre1 kernel on a powerstack but the ncr810 based
> > > SCSI code does not work. The driver complains about CACHE INCORRECTLY CONFIGURED.
> > >
> > > Anybody knows what this comes from. Attached if the full boot log of the system.
> >
> > Arrrgh, the same thing happens on my powerstack.
> > I'd track this down, but
> >
> > a) I don't have time
> > b) the machine is my mail server and runs the linuxppc_2_2 tree happily.
>
> I saw a similar thing on my LongTrail (with '875 card) after I added a call to
> pci_assign_unassigned_resources() to arch/ppc/kernel/pci.c (like PReP) did, and
> before I fixed the test for ppc_md.pcibios_enable_device_hook.
>
> Perhaps PReP doesn't like ppc_md.pcibios_enable_device_hook instead of
> pci_assign_unassigned_resources?
>

The recent code in prep_pci.c no longer tweaks pci memory resources to fit
into a 256 MByte BAT range. For some reason this is now limited I/O resources.
I don't know why this change was introduced. The attached diff keeps the handling
for I/O and introduces a similar fix for memory. I don't know if this is the
way to do it. The ncr810 controller starts working again.

Regards,
  Alois
--------------94E1A3227C44AFB384FCA5F2
Content-Type: text/plain; charset=us-ascii;
 name="prep_pci.diff"
Content-Disposition: inline;
 filename="prep_pci.diff"
Content-Transfer-Encoding: 7bit

--- arch/ppc/kernel/prep_pci.c.dist	Sat Feb 17 17:42:00 2001
+++ arch/ppc/kernel/prep_pci.c	Sun Feb 18 20:47:48 2001
@@ -1084,23 +1084,37 @@
 		for ( i = 0 ; i <= 5 ; i++ )
 		{
 			/*
-			 * Relocate PCI I/O resources if necessary so the
+			 * Relocate PCI memory and I/O resources if necessary so the
 			 * standard 256MB BAT covers them.
 			 */
-			if ( (pci_resource_flags(dev, i) & IORESOURCE_IO) &&
-				(dev->resource[i].start > 0x10000000) )
+			if ( dev->resource[i].start > 0x10000000 )
 		        {
-		                printk("Relocating PCI address %lx -> %lx\n",
-		                       dev->resource[i].start,
-		                       (dev->resource[i].start & 0x00FFFFFF)
-		                       | 0x01000000);
-		                dev->resource[i].start =
-		                  (dev->resource[i].start & 0x00FFFFFF) | 0x01000000;
-		                pci_write_config_dword(dev,
-		                        PCI_BASE_ADDRESS_0+(i*0x4),
-		                       dev->resource[i].start );
-				dev->resource[i].end =
-					(dev->resource[i].end & 0x00FFFFFF) | 0x01000000;
+			        if ( pci_resource_flags(dev, i) & IORESOURCE_IO )
+			        {
+		                        printk("Relocating PCI I/O address %lx -> %lx\n",
+		                               dev->resource[i].start,
+		                               (dev->resource[i].start & 0x00FFFFFF)
+		                               | 0x01000000);
+		                        dev->resource[i].start =
+		                          (dev->resource[i].start & 0x00FFFFFF) | 0x01000000;
+		                        pci_write_config_dword(dev,
+		                                PCI_BASE_ADDRESS_0+(i*0x4),
+		                               dev->resource[i].start );
+			        	dev->resource[i].end =
+		        			(dev->resource[i].end & 0x00FFFFFF) | 0x01000000;
+				} else
+				{
+		                        printk("Relocating PCI memory address %lx -> %lx\n",
+		                               dev->resource[i].start,
+		                               dev->resource[i].start & 0x0FFFFFFF);
+		                        dev->resource[i].start =
+		                          dev->resource[i].start & 0x0FFFFFFF;
+		                        pci_write_config_dword(dev,
+		                                PCI_BASE_ADDRESS_0+(i*0x4),
+		                               dev->resource[i].start );
+			        	dev->resource[i].end =
+		        			dev->resource[i].end & 0x0FFFFFFF;
+				}
 		        }
 		}
 #if 0

--------------94E1A3227C44AFB384FCA5F2--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

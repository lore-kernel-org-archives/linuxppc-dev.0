Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2D51CDDE0C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 21:26:11 +1100 (EST)
Date: Fri, 5 Jan 2007 11:26:18 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
Message-ID: <20070105102618.GA9970@aepfle.de>
References: <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
	<1165293679.29784.39.camel@localhost.localdomain>
	<20061205081557.GA8483@aepfle.de>
	<1165349941.5469.1.camel@localhost.localdomain>
	<20070104174947.GA3636@aepfle.de>
	<1167946240.5273.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1167946240.5273.11.camel@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, greg@kroah.com, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 05, Benjamin Herrenschmidt wrote:

> Nah, but also set resource->end = 0 too and or-in IORESOURCE_UNSET for
> flags not (=) (or just set it to 0, I have no problem with completely
> clearing the resource, that will keep it out of the way)

I get this output with the change below:

Using INTC for W82c105 IDE controller.
W82c105: bn 0 dfn 19
00: f 0000000000000101 s 000000000000f000 e 000000000000f007
01: f 0000000000000101 s 000000000000f010 e 000000000000f013
02: f 0000000000000101 s 000000000000f020 e 000000000000f027
03: f 0000000000000101 s 000000000000f030 e 000000000000f033
04: f 0000000000000101 s 000000000000f040 e 000000000000f04f
05: f 0000000000000101 s 0000000000000000 e 000000000000000f
05: disable IO resource on W82c105 IDE controller
06: f 0000000000000000 s 0000000000000000 e 0000000000000000
07: f 0000000000000000 s 0000000000000000 e 0000000000000000
08: f 0000000000000000 s 0000000000000000 e 0000000000000000
09: f 0000000000000000 s 0000000000000000 e 0000000000000000
10: f 0000000000000000 s 0000000000000000 e 0000000000000000
11: f 0000000000000000 s 0000000000000000 e 0000000000000000

If thats ok, I will submit a patch without the printk.

@@ -130,11 +130,18 @@ static void fixup_winbond_82c105(struct 
        /* Enable LEGIRQ to use INTC instead of ISA interrupts */
        pci_write_config_dword(dev, 0x40, reg | (1<<11));
 
+       printk("W82c105: bn %x dfn %x\n", dev->bus->number, dev->devfn);
        for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i) {
+               printk("%02d: f %016lx s %016lx e %016lx\n", i, dev->resource[i].flags, dev->resource[i].start, dev->resource[i].end);
                /* zap the 2nd function of the winbond chip */
                if (dev->resource[i].flags & IORESOURCE_IO
                    && dev->bus->number == 0 && dev->devfn == 0x81)
                        dev->resource[i].flags &= ~IORESOURCE_IO;
+               if (dev->resource[i].start == 0 && dev->resource[i].end) {
+                       printk("%02d: disable IO resource on W82c105 IDE controller\n", i);
+                       dev->resource[i].flags = 0;
+                       dev->resource[i].end = 0;
+               }
        }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,

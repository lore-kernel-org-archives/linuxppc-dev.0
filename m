Date: Sun, 7 Dec 2003 00:21:53 -0600
To: Jeff Garzik <jgarzik@pobox.com>
Cc: tulip-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100 PCI Adapter
Message-ID: <20031207062153.GB6302@permusion.kilzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
From: ddkilzer@kilzer.net (David D. Kilzer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm looking for some feedback on a kernel patch, and how best to fix the
Tulip driver to report a correct mac address with the Asante Fast 10/100
PCI ethernet card that's installed in my PowerMac 7200/75.

The issue is that the byte-order of the mac address is swapped by
default:

  Original:  00:00:B5:94:71:86  [INCORRECT]
   Patched:  00:00:94:B5:86:71  [CORRECT]

There is code in linux-2.2.20/drivers/net/tulip.c (and in tulip_core.c
in the 2.4.x and 2.6.x kernels) that swaps the byte order of the mac
address by looking at the current, byte-swapped mac address in-place:

>	/* Lite-On boards have the address byte-swapped. */
>	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
>		&&  dev->dev_addr[1] == 0x00)
>		for (i = 0; i < 6; i+=2) {
>			char tmp = dev->dev_addr[i];
>			dev->dev_addr[i] = dev->dev_addr[i+1];
>			dev->dev_addr[i+1] = tmp;
>		}

My questions:

Is it sufficient to simply check the first two bytes of the mac address
to determine this?  (This is what the attached patch does.  I added a
check for the first byte being 0x00 for the Asante card.)

Should the first three bytes of the mac address be used intead?  (Note
that I can only identify 00:A0:CC as one of the Lite-On mac addresses
that would be matched by the code segment above.  I don't see a 00:C0:**
entry for Lite-On in the IEEE database.)

Should PCI IDs be used in place of mac address values?

Thanks!  Below is more information that may be helpful.


Resources:

- IEEE OUI and Company_Id Assignments web site:
  http://standards.ieee.org/regauth/oui/index.shtml

- Output to /var/log/syslog when the kernel module is loaded:

Dec  6 23:49:02 stan kernel: tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
Dec  6 23:49:02 stan kernel: eth1: Lite-On 82c168 PNIC rev 32 at 0x400, 00:00:94:B5:86:71, IRQ 24.
Dec  6 23:49:02 stan kernel: eth1:  MII transceiver #1 config 3100 status 782d advertising 01e1.

- Output to /var/log/syslog when the interface is brought up:

Dec  6 23:49:05 stan kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 01e1.

- Output from lspci -vvn:

00:0e.0 Class 0200: 11ad:0002 (rev 20)
	Subsystem: 128a:f001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 0400
	Region 1: Memory at 80800000 (32-bit, non-prefetchable) [disabled]
	Expansion ROM at 80840000 [disabled]

- Output from 'cat /proc/pci':

  Bus  0, device  14, function  0:
    Ethernet controller: LiteOn LNE100TX (rev 32).
      Medium devsel.  Fast back-to-back capable.  IRQ 24.  Master Capable.  Latency=32.
      I/O at 0x400 [0x401].
      Non-prefetchable 32 bit memory at 0x80800000 [0x80800000].

- I've added information to the pciids SourceForge project about the
  card:  http://pciids.sourceforge.net/iii/?i=11ad0002

Dave

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.2.20-tulip-fix-asante-mac-addr.diff"

diff -u6 kernel-source-2.2.20/drivers/net/tulip.c.orig kernel-source-2.2.20/drivers/net/tulip.c
--- kernel-source-2.2.20/drivers/net/tulip.c.orig	Fri Jul  4 17:58:17 2003
+++ kernel-source-2.2.20/drivers/net/tulip.c	Sat Dec  6 23:41:30 2003
@@ -783,15 +783,15 @@
 		}
 		for (i = 0; i < 6; i ++) {
 			dev->dev_addr[i] = ee_data[i + sa_offset];
 			sum += ee_data[i + sa_offset];
 		}
 	}
-	/* Lite-On boards have the address byte-swapped. */
-	if ((dev->dev_addr[0] == 0xA0  ||  dev->dev_addr[0] == 0xC0)
-		&&  dev->dev_addr[1] == 0x00)
+	/* Lite-On boards have the mac address byte-swapped. */
+	if ((dev->dev_addr[0] == 0x00 || dev->dev_addr[0] == 0xA0 ||
+		dev->dev_addr[0] == 0xC0) &&  dev->dev_addr[1] == 0x00)
 		for (i = 0; i < 6; i+=2) {
 			char tmp = dev->dev_addr[i];
 			dev->dev_addr[i] = dev->dev_addr[i+1];
 			dev->dev_addr[i+1] = tmp;
 		}
 	/* On the Zynx 315 Etherarray and other multiport boards only the

--0OAP2g/MAC+5xKAE--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

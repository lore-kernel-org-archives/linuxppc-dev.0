Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1335DE03E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 22:45:57 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m3MCjpGK152456
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 12:45:51 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3MCjoA61482908
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 13:45:50 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3MCjomY000322
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 12:45:50 GMT
Message-ID: <480DDE2B.4000808@linux.vnet.ibm.com>
Date: Tue, 22 Apr 2008 14:46:35 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>	<1208566122.6958.425.camel@pasglop>	<480BA937.7050603@linux.vnet.ibm.com>	<1208727408.7009.0.camel@pasglop>	<480C80B6.30904@linux.vnet.ibm.com>	<480C87BD.8090207@ru.mvista.com>	<480C9FE2.4030601@linux.vnet.ibm.com>
	<480CAFD2.2050108@ru.mvista.com> <480CBEE0.9000104@ru.mvista.com>
In-Reply-To: <480CBEE0.9000104@ru.mvista.com>
Content-Type: multipart/mixed; boundary="------------040709000306040206010903"
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040709000306040206010903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Sergei Shtylyov wrote:
> Hello, I wrote:
> 
>>    Ah, that's what happens -- BAR0 in functions 0/1 takes up the whole 
>> 265 MiB of the PCI memory space (128+128), so no place is left for 
>> other memory BARs.
> 
>    What's interesting, the Sequoia/Rainier board user manual says that 
> PCI memory is 0x80000000 thru 0xbfffffff (i.e. 1 GiB), while the Linux 
> code seem to always have assumed only 0x[1]800000000 thru 0x[1]8fffffff...
> 
> WBR, Sergei

Thanks to all your help I saw that the detected spaces on boot are wrong because of the dts file.

PCI host bridge /plb/pci@1ec000000 (primary) ranges:
 MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000    => 256M
  IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000    => 1M

The Documentation of the 440EPx core lists these spaces:
PCI 1 Memory     1 8000 0000     1 BFFF FFFF     1GB
I/O              1 E800 0000     1 E800 FFFF     64KB
I/O              1 E880 0000     1 EBFF FFFF     56MB

I modified the dts file and now it shows this on boot which is what the user manual lists as mem/io space:

PCI host bridge /plb/pci@1ec000000 (primary) ranges:
 MEM 0x0000000180000000..0x00000001bfffffff -> 0x0000000080000000
  IO 0x00000001e8000000..0x00000001e800ffff -> 0x0000000000000000
  IO 0x00000001e8800000..0x00000001ebffffff -> 0x0000000000000000
 \--> Skipped (too many) !
4xx PCI DMA offset set to 0x00000000

The detected sizes look good compared to the processor documentation.
But I never modified a dts file before and I only found a ranges documentation speaking of three elemnts in the ranges element.
So feel free to correct the dts if I wrote something bad without knowing it (e.g. that skipped message).

The issue that let me start debugging this was the initialization of the radeonfb driver and with that patch it works:
radeonfb_pci_register BEGIN
radeonfb (0000:00:0a.0): Cannot match card to OF node !
aper_base: 80000000 MC_FB_LOC to: 87ff8000, MC_AGP_LOC to: ffff9000
radeonfb (0000:00:0a.0): Found 131072k of DDR 64 bits wide videoram
radeonfb (0000:00:0a.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=240.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... found TMDS panel
radeonfb: I2C (port 3) ... found CRT display
i2c-adapter i2c-3: unable to read EDID block.
i2c-adapter i2c-3: unable to read EDID block.
i2c-adapter i2c-3: unable to read EDID block.
radeonfb: I2C (port 4) ... not found
radeon_probe_OF_head
radeonfb: I2C (port 2) ... found TMDS panel
radeon_probe_OF_head
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
Parsing EDID data for panel info
Setting up default mode based on panel info
radeonfb (0000:00:0a.0): ATI Radeon Y`
radeonfb_pci_register END

And btw. now we really need the change of the radeonfb.h to use the correct resource_size_t type, otherwise it fails with:

radeonfb_pci_register BEGIN
Machine check in kernel mode.
Data Read PLB Error
Oops: Machine check, sig: 7 [#1]
Sequoia
Modules linked in:
NIP: c029cf00 LR: c029cee8 CTR: 00000000
REGS: c038bf50 TRAP: 0214   Not tainted  (2.6.25-rc9)
MSR: 00029000 <EE,ME>  CR: 84000028  XER: 0000005f
TASK = cf81ec00[1] 'swapper' THREAD: cf82e000
GPR00: 01000000 cf82fe00 cf81ec00 d1018000 d101b000 00000000 90023000 0000071b
GPR08: 00000000 00000000 9002371b 00000000 9002ffff 00000000 0ffa6800 0ffbf000
GPR16: 100c0000 00000000 100c0000 c02e0000 cf810458 cf8a0608 cf8a0000 00000001
GPR24: c0350000 cf810400 c037102c cf813de0 c03713f4 c0371800 00000000 cf8a02ec
NIP [c029cf00] 0xc029cf00
LR [c029cee8] 0xc029cee8
Call Trace:
[cf82fe00] [c029cee8] 0xc029cee8 (unreliable)
[cf82fe40] [c012f554] pci_device_probe+0x80/0xa0
[cf82fe60] [c019014c] driver_probe_device+0xb8/0x1cc
[cf82fe80] [c0190438] __driver_attach+0xcc/0xf8
[cf82fea0] [c018ecd4] bus_for_each_dev+0x58/0x94
[cf82fed0] [c018fe7c] driver_attach+0x24/0x34
[cf82fee0] [c018fc6c] bus_add_driver+0xb0/0x248
[cf82ff00] [c0190920] driver_register+0x48/0x130
[cf82ff20] [c012f158] __pci_register_driver+0x48/0x94
[cf82ff40] [c034bca4] radeonfb_init+0xc4/0x21c
[cf82ff70] [c0337840] kernel_init+0x98/0x284
[cf82fff0] [c000cc4c] kernel_thread+0x44/0x60
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX

I attached the patch I used to get it working now for further discussion e.g. because I don't really know dts syntax ;-)
I hope both changes find their way into the kernel once you are all agreeing with the new dts content.

I still have issues with my X11, but thats another story.

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization

--------------040709000306040206010903
Content-Type: text/plain;
 name="fix-sequoia-pci-memory-dts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-sequoia-pci-memory-dts"

Subject: [PATCH][dts][radeonfb]: fix pci mem in dts and radeonfb resource variables

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This patch is fixing the sequoia.dts device tree file to the values defined
in the 440Epx data sheet from amcc.
That fixes an issue where my graphic card could not initialize because the pci
resource space was not big enough.
The related mail thread about the backgrounds of this has the subject "pci
issue - wrong detection of pci ressources"
After these values were fixed another modification that came up in the mail
thread was needed to prevent an error. This change fixes the type of the
resource vaiables in the radeon frame buffer driver (We might want to split
that into two patches).

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 arch/powerpc/boot/dts/sequoia.dts |    9 +++++++--
 drivers/video/aty/radeonfb.h      |    4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -344,9 +344,14 @@
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
+			 * From the 440EPx user manual:
+			 * PCI 1 Memory     1 8000 0000     1 BFFF FFFF     1GB
+			 * I/O              1 E800 0000     1 E800 FFFF     64KB
+			 * I/O              1 E880 0000     1 EBFF FFFF     56MB
 			 */
-			ranges = <02000000 0 80000000 1 80000000 0 10000000
-				01000000 0 00000000 1 e8000000 0 00100000>;
+			ranges = <02000000 0 80000000 1 80000000 0 40000000
+				01000000 0 00000000 1 e8000000 0 00010000
+				01000000 0 00000000 1 e8800000 0 03800000>;
 
 			/* Inbound 2GB range starting at 0 */
 			dma-ranges = <42000000 0 0 0 0 0 80000000>;
diff --git a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h
+++ b/drivers/video/aty/radeonfb.h
@@ -287,8 +287,8 @@ struct radeonfb_info {
 
 	char			name[DEVICE_NAME_SIZE];
 
-	unsigned long		mmio_base_phys;
-	unsigned long		fb_base_phys;
+	resource_size_t		mmio_base_phys;
+	resource_size_t		fb_base_phys;
 
 	void __iomem		*mmio_base;
 	void __iomem		*fb_base;

--------------040709000306040206010903--

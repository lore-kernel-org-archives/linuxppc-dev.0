Return-Path: <ravi.rao@rflelect.com>
Received: from noteshub1.teal.com (mail.teal.com [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id D3159DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Dec 2007 06:32:29 +1100 (EST)
To: linuxlink-help@timesys.com,
	linuxppc-embedded@ozlabs.org
Subject: Getting this error when mounting the jffs2 partition created using
	mkImage..
MIME-Version: 1.0
Message-ID: <OF51AFEA66.838FE3D0-ON852573B5.0067739C-852573B5.00689046@RFLELECT.COM>
From: ravi.rao@rflelect.com
Date: Tue, 18 Dec 2007 14:02:02 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 00689040852573B5_="
Cc: Miki.Groftisza@rflelect.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00689040852573B5_=
Content-Type: text/plain; charset="US-ASCII"

Hi All,
      I have u-boot based bootloader on our custom board based on 
ppc405EP. 
Various partitions are..
Amd/Fujitsu Extended Query Table at 0x0040
RoadRunner: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 5 MTD partitions on "RoadRunner":
0x03fc0000-0x04000000 : "U-Boot based RR Boot loader"
0x03fa0000-0x03fc0000 : "U-Boot Env Storage"
0x03f80000-0x03fa0000 : "U-Boot Redundant Env Storage"
0x027c0000-0x03f80000 : "Kernel Image"
0x00000000-0x027c0000 : "JFFS2 Linux FS"

I have used the following command to create the jffs2 file system image.
$BLDTOOLS/mkfs.jffs2 -b -e 0x10000 -d $JFFS2 -p 0x27c0000 -o rr-app_64.img
${MKIMAGE} -T filesystem -n 'RR App Image for AMD' -d rr-app_64.img 
uRR-app_64

I did tftp the uRR-app_64 at the uboot prompt and copy the image to flash 
at address 0xfc000000 using the command..
=> tftp 1000000 rr1/uRR-app_64
Trying ppc_4xx_eth0
PHY AN speed read failed, assuming 10BASE-T
PHY AN duplex read failed, assuming half duplex
ENET Speed is 10 Mbps - HALF duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 10.2.1.1; our IP address is 10.2.254.125
Filename 'rr1/uRR-app_64'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########################
done
Bytes transferred = 9109568 (8b0040 hex)
=> cp.b 1000000 fc000000 8b0040

addr=>FC000000 ...flash_id=>000000AA ... start=>FC000000 ...end=>FDFFFFFF 
...Copy to Flash...
addr=>FC000000 ...flash_id=>000000AA ... start=>FC000000 ...end=>FDFFFFFF 
...
addr=>FC8B003F ...flash_id=>000000AA ... start=>FC000000 ...end=>FDFFFFFF 
...
addr=>FC000000 ... end=>FC8B003F ...info_first=>03FFDF00 ... 
info_last=>03FFDF00 ...

Writing from src 0x1000000 to addr 0xfc000000 of length 9109568 and count 
= 9109568
done

Board boot's up fine but I get the following error at the end of boot..

IP-Config: Complete:
      device=eth0, addr=10.2.254.125, mask=255.255.0.0, gw=10.2.0.1,
     host=unknown, domain=, nis-domain=(none),
     bootserver=10.2.1.1, rootserver=10.2.1.1, rootpath=
Freeing unused kernel memory: 112k init
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000: 
0x2705 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004: 
0xdf63 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000008: 
0x4768 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c: 
0x008b instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000018: 
0xe581 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c: 
0x0507 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020: 
0x5252 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000024: 
0x7070 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000028: 
0x6d61 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000002c: 
0x2066 instead
Further such events for this erase block will not be printed
CLEANMARKER node found at 0x00000040, not first node in block (0x00000000)
Node at 0x0000fbe0 with length 0x0000045a would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010000: 
0x0103 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010004: 
0xffa0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010008: 
0xa361 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0001000c: 
0x15a0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010010: 
0xfd66 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010014: 
0xcfd1 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010018: 
0x1040 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0001001c: 
0x52ab instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010020: 
0x002c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00010024: 
0xe510 instead
Further such events for this erase block will not be printed
Empty flash at 0x0001003c ends at 0x00010040
CLEANMARKER node found at 0x00010040, not first node in block (0x00010000)
Node at 0x0001fc38 with length 0x00000403 would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020000: 
0x0c22 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020004: 
0x1924 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020008: 
0x32c8 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002000c: 
0xc8a0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020010: 
0x91c1 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020014: 
0x46ba instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020018: 
0xbf76 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002001c: 
0x1313 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020020: 
0x3c50 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020024: 
0x1040 instead
Further such events for this erase block will not be printed
Empty flash at 0x0002003c ends at 0x00020040
CLEANMARKER node found at 0x00020040, not first node in block (0x00020000)
Node at 0x0002f8e0 with length 0x0000075b would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030000: 
0x4cff instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030004: 
0x0e27 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030008: 
0x1b50 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0003000c: 
0xc760 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030010: 
0x4f80 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030014: 
0xdaaf instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030018: 
0x9b43 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0003001c: 
0x6103 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030020: 
0xb076 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00030024: 
0x00a1 instead
Further such events for this erase block will not be printed
Empty flash at 0x0003003c ends at 0x00030040
CLEANMARKER node found at 0x00030040, not first node in block (0x00030000)
Node at 0x0003f954 with length 0x000006e8 would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040000: 
0x2b40 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040004: 
0x6d4f instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040008: 
0x6db6 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0004000c: 
0xb0be instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040010: 
0xe8c8 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040014: 
0x712e instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040018: 
0xd01d instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0004001c: 
0xf2bb instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040020: 
0x0350 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00040024: 
0x0a83 instead
Further such events for this erase block will not be printed
Empty flash at 0x0004003c ends at 0x00040040
CLEANMARKER node found at 0x00040040, not first node in block (0x00040000)
Node at 0x0004f7f0 with length 0x0000084a would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050000: 
0xfda7 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050004: 
0xd769 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050008: 
0xf4db instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0005000c: 
0x06fa instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050010: 
0xe86f instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050014: 
0x0132 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050018: 
0xd8be instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0005001c: 
0x0710 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050020: 
0x7980 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00050024: 
0x63a8 instead
Further such events for this erase block will not be printed
Empty flash at 0x0005003c ends at 0x00050040
CLEANMARKER node found at 0x00050040, not first node in block (0x00050000)
Node at 0x0005f8ac with length 0x0000078f would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060000: 
0x501a instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060004: 
0x00b6 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060008: 
0x4e02 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0006000c: 
0x9ccc instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060010: 
0x4d0c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060014: 
0x0c3f instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060018: 
0xd81b instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0006001c: 
0xea19 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060020: 
0x3258 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00060024: 
0xfb51 instead
Further such events for this erase block will not be printed
Empty flash at 0x0006003c ends at 0x00060040
CLEANMARKER node found at 0x00060040, not first node in block (0x00060000)
Node at 0x0006f8c0 with length 0x0000077c would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070000: 
0x7dc1 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070004: 
0x9b76 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070008: 
0x0750 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0007000c: 
0x5a5f instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070010: 
0x90cd instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070014: 
0x7803 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070018: 
0xacfe instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0007001c: 
0x2fc0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070020: 
0x6a6f instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00070024: 
0xba07 instead
Further such events for this erase block will not be printed
Empty flash at 0x0007003c ends at 0x00070040
CLEANMARKER node found at 0x00070040, not first node in block (0x00070000)
Node at 0x0007ff34 with length 0x00000107 would run over the end of the 
erase block
Perhaps the file system was created with the wrong erase size?

Any help to resolve this issue is greatly appreciated..
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
 
CONFIDENTIALITY NOTE
This e-mail, including any attachments, may contain confidential and/or 
legally privileged information.  The Information is intended only for the 
use of the individual or entity named on this e-mail .  If you are not the 
intended recipient, you are hereby notified that any disclosure, copying, 
distribution, or the taking of any action in reliance on the contents of 
this transmitted Information is strictly prohibited.  Further, if you are 
not the intended recipient, please notify us by return e-mail and delete 
the Information promptly.
 
 
 
--=_alternative 00689040852573B5_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi All,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; I have u-boot based
bootloader on our custom board based on ppc405EP. </font>
<br><font size=2 face="sans-serif">Various partitions are..</font>
<br><font size=2 face="Courier New">Amd/Fujitsu Extended Query Table at
0x0040</font>
<br><font size=2 face="Courier New">RoadRunner: CFI does not contain boot
bank location. Assuming top.</font>
<br><font size=2 face="Courier New">number of CFI chips: 2</font>
<br><font size=2 face="Courier New">cfi_cmdset_0002: Disabling erase-suspend-program
due to code brokenness.</font>
<br><font size=2 face="Courier New">Creating 5 MTD partitions on &quot;RoadRunner&quot;:</font>
<br><font size=2 face="Courier New">0x03fc0000-0x04000000 : &quot;U-Boot
based RR Boot loader&quot;</font>
<br><font size=2 face="Courier New">0x03fa0000-0x03fc0000 : &quot;U-Boot
Env Storage&quot;</font>
<br><font size=2 face="Courier New">0x03f80000-0x03fa0000 : &quot;U-Boot
Redundant Env Storage&quot;</font>
<br><font size=2 face="Courier New">0x027c0000-0x03f80000 : &quot;Kernel
Image&quot;</font>
<br><font size=2 face="Courier New">0x00000000-0x027c0000 : &quot;JFFS2
Linux FS&quot;</font>
<br>
<br><font size=2 face="sans-serif">I have used the following command to
create the jffs2 file system image.</font>
<br><font size=2 face="sans-serif">$BLDTOOLS/mkfs.jffs2 -b -e 0x10000 -d
$JFFS2 -p 0x27c0000 -o rr-app_64.img</font>
<br><font size=2 face="sans-serif">${MKIMAGE} -T filesystem -n 'RR App
Image for AMD' -d rr-app_64.img uRR-app_64</font>
<br>
<br><font size=2 face="sans-serif">I did tftp the uRR-app_64 at the uboot
prompt and copy the image to flash at address 0xfc000000 using the command..</font>
<br><font size=2 face="Courier New">=&gt; tftp 1000000 rr1/uRR-app_64</font>
<br><font size=2 face="Courier New">Trying ppc_4xx_eth0</font>
<br><font size=2 face="Courier New">PHY AN speed read failed, assuming
10BASE-T</font>
<br><font size=2 face="Courier New">PHY AN duplex read failed, assuming
half duplex</font>
<br><font size=2 face="Courier New">ENET Speed is 10 Mbps - HALF duplex
connection (EMAC0)</font>
<br><font size=2 face="Courier New">Using ppc_4xx_eth0 device</font>
<br><font size=2 face="Courier New">TFTP from server 10.2.1.1; our IP address
is 10.2.254.125</font>
<br><font size=2 face="Courier New">Filename 'rr1/uRR-app_64'.</font>
<br><font size=2 face="Courier New">Load address: 0x1000000</font>
<br><font size=2 face="Courier New">Loading: #################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#################################################################</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#########################</font>
<br><font size=2 face="Courier New">done</font>
<br><font size=2 face="Courier New">Bytes transferred = 9109568 (8b0040
hex)</font>
<br><font size=2 face="Courier New">=&gt; cp.b 1000000 fc000000 8b0040</font>
<br>
<br><font size=2 face="Courier New">addr=&gt;FC000000 ...flash_id=&gt;000000AA
... start=&gt;FC000000 ...end=&gt;FDFFFFFF ...Copy to Flash...</font>
<br><font size=2 face="Courier New">addr=&gt;FC000000 ...flash_id=&gt;000000AA
... start=&gt;FC000000 ...end=&gt;FDFFFFFF ...</font>
<br><font size=2 face="Courier New">addr=&gt;FC8B003F ...flash_id=&gt;000000AA
... start=&gt;FC000000 ...end=&gt;FDFFFFFF ...</font>
<br><font size=2 face="Courier New">addr=&gt;FC000000 ... end=&gt;FC8B003F
...info_first=&gt;03FFDF00 ... info_last=&gt;03FFDF00 ...</font>
<br>
<br><font size=2 face="Courier New">Writing from src 0x1000000 to addr
0xfc000000 of length 9109568 and count = 9109568</font>
<br><font size=2 face="Courier New">done</font>
<br>
<br><font size=2 face="sans-serif">Board boot's up fine but I get the following
error at the end of boot..</font>
<br>
<br><font size=2><tt>IP-Config: Complete:</tt></font>
<br><font size=2><tt>&nbsp; &nbsp; &nbsp; device=eth0, addr=10.2.254.125,
mask=255.255.0.0, gw=10.2.0.1,</tt></font>
<br><font size=2><tt>&nbsp; &nbsp; &nbsp;host=unknown, domain=, nis-domain=(none),</tt></font>
<br><font size=2><tt>&nbsp; &nbsp; &nbsp;bootserver=10.2.1.1, rootserver=10.2.1.1,
rootpath=</tt></font>
<br><font size=2><tt>Freeing unused kernel memory: 112k init</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00000000: 0x2705 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00000004: 0xdf63 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00000008: 0x4768 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0000000c: 0x008b instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00000018: 0xe581 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0000001c: 0x0507 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00000020: 0x5252 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00000024: 0x7070 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00000028: 0x6d61 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0000002c: 0x2066 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00000040, not first node
in block (0x00000000)</tt></font>
<br><font size=2><tt>Node at 0x0000fbe0 with length 0x0000045a would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010000: 0x0103 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010004: 0xffa0 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010008: 0xa361 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0001000c: 0x15a0 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010010: 0xfd66 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010014: 0xcfd1 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010018: 0x1040 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0001001c: 0x52ab instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010020: 0x002c instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00010024: 0xe510 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>Empty flash at 0x0001003c ends at 0x00010040</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00010040, not first node
in block (0x00010000)</tt></font>
<br><font size=2><tt>Node at 0x0001fc38 with length 0x00000403 would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020000: 0x0c22 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020004: 0x1924 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020008: 0x32c8 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0002000c: 0xc8a0 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020010: 0x91c1 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020014: 0x46ba instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020018: 0xbf76 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0002001c: 0x1313 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020020: 0x3c50 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00020024: 0x1040 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>Empty flash at 0x0002003c ends at 0x00020040</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00020040, not first node
in block (0x00020000)</tt></font>
<br><font size=2><tt>Node at 0x0002f8e0 with length 0x0000075b would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030000: 0x4cff instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030004: 0x0e27 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030008: 0x1b50 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0003000c: 0xc760 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030010: 0x4f80 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030014: 0xdaaf instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030018: 0x9b43 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0003001c: 0x6103 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030020: 0xb076 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00030024: 0x00a1 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>Empty flash at 0x0003003c ends at 0x00030040</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00030040, not first node
in block (0x00030000)</tt></font>
<br><font size=2><tt>Node at 0x0003f954 with length 0x000006e8 would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040000: 0x2b40 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040004: 0x6d4f instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040008: 0x6db6 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0004000c: 0xb0be instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040010: 0xe8c8 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040014: 0x712e instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040018: 0xd01d instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0004001c: 0xf2bb instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040020: 0x0350 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00040024: 0x0a83 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>Empty flash at 0x0004003c ends at 0x00040040</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00040040, not first node
in block (0x00040000)</tt></font>
<br><font size=2><tt>Node at 0x0004f7f0 with length 0x0000084a would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050000: 0xfda7 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050004: 0xd769 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050008: 0xf4db instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0005000c: 0x06fa instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050010: 0xe86f instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050014: 0x0132 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050018: 0xd8be instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0005001c: 0x0710 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050020: 0x7980 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00050024: 0x63a8 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>Empty flash at 0x0005003c ends at 0x00050040</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00050040, not first node
in block (0x00050000)</tt></font>
<br><font size=2><tt>Node at 0x0005f8ac with length 0x0000078f would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060000: 0x501a instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060004: 0x00b6 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060008: 0x4e02 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0006000c: 0x9ccc instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060010: 0x4d0c instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060014: 0x0c3f instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060018: 0xd81b instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0006001c: 0xea19 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060020: 0x3258 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00060024: 0xfb51 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>Empty flash at 0x0006003c ends at 0x00060040</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00060040, not first node
in block (0x00060000)</tt></font>
<br><font size=2><tt>Node at 0x0006f8c0 with length 0x0000077c would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070000: 0x7dc1 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070004: 0x9b76 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070008: 0x0750 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0007000c: 0x5a5f instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070010: 0x90cd instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070014: 0x7803 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070018: 0xacfe instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x0007001c: 0x2fc0 instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070020: 0x6a6f instead</tt></font>
<br><font size=2><tt>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
found at 0x00070024: 0xba07 instead</tt></font>
<br><font size=2><tt>Further such events for this erase block will not
be printed</tt></font>
<br><font size=2><tt>Empty flash at 0x0007003c ends at 0x00070040</tt></font>
<br><font size=2><tt>CLEANMARKER node found at 0x00070040, not first node
in block (0x00070000)</tt></font>
<br><font size=2><tt>Node at 0x0007ff34 with length 0x00000107 would run
over the end of the erase block</tt></font>
<br><font size=2><tt>Perhaps the file system was created with the wrong
erase size?</tt></font>
<br>
<br><font size=2 face="sans-serif">Any help to resolve this issue is greatly
appreciated..<br>
</font><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<div align=center>
<br><font size=2 color=blue face="Tms Rmn"><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1 face="Tms Rmn">This e-mail, including any attachments,
may contain confidential and/or legally privileged information.&nbsp; The
Information is intended only for the use of the individual or entity named
on this e-mail</font><font size=1 face="Tms Rmn"> </font><font size=1 face="Tms Rmn">.&nbsp;
If you are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or the taking of any action in reliance
on the contents of this transmitted Information is strictly prohibited.&nbsp;
Further, if you are not the intended recipient, please notify us by return
e-mail and delete the Information promptly.</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=3>&nbsp;</font>
--=_alternative 00689040852573B5_=--

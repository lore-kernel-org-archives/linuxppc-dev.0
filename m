Date: Thu, 27 Mar 2003 18:36:42 +0100
From: Boris Bezlaj <boris@gajba.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: mikpe@csd.uu.se
Subject: booting COFF image on OldWorld mac
Message-ID: <20030327173642.GA501@gajba.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

I had similar/same problem booting OldWorld mac and the patch from Olaf fixed it.

The box is: PowerComputing PowerTower Pro
cpu		: 604e
clock		: 195MHz
revision	: 2.2 (pvr 0009 0202)
bogomips	: 448.92
machine		: Power Macintosh
motherboard	: AAPL,9500 MacRISC
detected as	: 16 (PowerMac 9500/9600)
pmac flags	: 00000000
L2 cache	: 1024K unified
memory		: 128MB
pmac-generation	: OldWorld

Situation before patch with 2.4.21-pre5:

0> boot fd:vmlinux.coff
tsize=5880 dsize=139780 bsize=21500 entry=500000
SECTIONS:
.text 00500000 00500000 00005880 000000D4
.data 00505880 00505880 00139780 00005954
.bss  0063F000 0063F000 0002150C 00000000
loading .text, done..
loading .dataCLAIM failed
ok
0>

After applying Olaf's patch it boots fine:
--- arch/ppc/boot/OLD_ld.script	2003-03-27 17:51:15.000000000 +0100
+++ arch/ppc/boot/ld.script	2003-03-27 17:52:10.000000000 +0100
@@ -39,7 +39,7 @@
   PROVIDE (etext = .);

   /* Read-write section, merged into data segment: */
-  . = ALIGN(8);
+  . = ALIGN(0x1000);
   .data    :
   {
     *(.data)

NVRAM parameters (OF 1.0.5):

little-endian?  false
real-mode?      false
auto-boot?      true
diag-switch?    false
fcode-debug?    false
oem-banner?     false
oem-logo?       false
use-nvramrc?    true
real-base       0x7f00000
real-size       0x100000
virt-base       0xffffffff
virt-size       0x100000
load-base       0x4000
pci-probe-list  0xffffffff
screen-#columns 0x64
screen-#rows    0x28
selftest-#megs  0x0
boot-device     scsi-int/sd@0:0
boot-file
diag-device     fd:diags
diag-file
input-device    kbd
output-device   /bandit@F4000000/IMS,tt128mb8
oem-banner
oem-logo
nvramrc         : slowboot begin
                ." Waiting for boot device.." cr d# 1000 ms
                boot-device ['] $boot catch drop
                key? until ;

boot-command    slowboot
--

With best regards,

		Boris B.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Amit.Lubovsky@infineon.com
Message-ID: <AD2F581BD7340A4C908AF1AFB066EA3B0E4831@ntah901e.savan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: u-boot on mbx860
Date: Tue, 30 Sep 2003 11:02:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have compiled u-boot for mbx860, created uImage (using the sources from
denx site) but have
a problem when I try to run the uImge on the board, follows what I get:

create u-boot image
-------------------
[devel@amit_lap linuxppc_2_4_devel]$ make uImage
. scripts/mkversion > .tmpversion
dnsdomainname: Unknown host
ppc_8xx-gcc -D__KERNEL__ -I/home/devel/mbx860/linuxppc_2_4_devel/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer
-I/home/devel/mbx860/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float
-pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-DUTS_MACHINE='"ppc"' -DKBUILD_BASENAME=version -c -o init/version.o
init/version.c
...

make[1]: Entering directory
`/home/devel/mbx860/linuxppc_2_4_devel/arch/ppc/boot'
make -C images vmlinux.gz
make[2]: Entering directory
`/home/devel/mbx860/linuxppc_2_4_devel/arch/ppc/boot/images'
ppc_8xx-objcopy --strip-all -S -O binary
/home/devel/mbx860/linuxppc_2_4_devel/vmlinux vmlinux
gzip -vf9 vmlinux
vmlinux:                 57.0% -- replaced with vmlinux.gz
make[2]: Leaving directory
`/home/devel/mbx860/linuxppc_2_4_devel/arch/ppc/boot/images'
./utils/mkimage.wrapper -A ppc -O linux -T kernel -C gzip -a 00000000 -e
00000000 \
-n 'Linux-2.4.20' \
-d images/vmlinux.gz images/vmlinux.PPCBoot
Image Name:   Linux-2.4.20
Created:      Tue Sep 30 11:50:22 2003
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    842305 Bytes = 822.56 kB = 0.80 MB
Load Address: 0x00000000
Entry Point:  0x00000000
ln -sf vmlinux.PPCBoot images/pImage
ln -sf vmlinux.PPCBoot images/uImage
make[1]: Leaving directory
`/home/devel/mbx860/linuxppc_2_4_devel/arch/ppc/boot'



load the uImage to the mbx board
--------------------------------

=>



U-Boot 0.4.8 (Sep 18 2003 - 17:29:19)



CPU:   XPC86xxxZPnnC1 at 50 MHz: 4 kB I-Cache 4 kB D-Cache

Board: MBX860-006C860EN(01-W3527F31C)

         *** Warning: Low Battery Status - On-Board Battery ***

DRAM:  16 MB

FLASH:  8 MB

In:    serial

Out:   serial

Err:   serial

Net:   SCC ETHERNET

PCMCIA:   No Card found

=> tftp 0x20000 uImage

TFTP from server 192.168.15.18; our IP address is 192.168.15.34

Filename 'uImage'.

Load address: 0x20000

Loading: #################################################################

         #################################################################

         ###################################

done

Bytes transferred = 842369 (cda81 hex)

=> bootm 0x20000

## Booting image at 00020000 ...

   Image Name:   Linux-2.4.20

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    842305 Bytes = 822.6 kB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... Error: inflate() returned -3

GUNZIP ERROR - must RESET board to recover



U-Boot 0.4.8 (Sep 18 2003 - 17:29:19)

CPU:   XPC86xxxZPnnC1 at 50 MHz: 4 kB I-Cache 4 kB D-Cache

Board: MBX860-006C860EN(01-W3527F31C)

         *** Warning: Low Battery Status - On-Board Battery ***

DRAM:  16 MB

FLASH:  8 MB

In:    serial

Out:   serial

Err:   serial

Net:   SCC ETHERNET

PCMCIA:   No Card found

=>

Any idea what is wrong ?

Thanks,
Amit.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

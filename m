Message-Id: <sd412d3c.087@amxgwia.amx.com>
Date: Fri, 26 Jul 2002 11:06:10 -0500
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <johny122@hotmail.com>
Subject: Re: Uncompressing kernel image problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You are trying to uncompress a kernel that is 667kB compressed in only
16kB of space (0 - 0x4000)

Try bootm 0x400000 instead.

>>> "john ashfield" <johny122@hotmail.com> 07/26/02 10:32AM >>>

Hi,

I have the problem of uncompressing Kernel Image. I used /tools/mkimage
in
ppcboot-1.1.6 to create vmlinux.ppcboot from vmlinux.gz. Then I
convert
vmlinux.ppcboot to vmlinux.srec using "objcopy -I binary -O srec
vmlinux.ppcboot vmlinux.srec" and finally load vmlinux.srec to memory
at
0x4000 using "loads 0x4000". I tried to boot the image and received
the
following message:

=> bootm 0x4000
## Booting image at 00004000 ...
   Image Name:   linuxppc_2_4_galileo
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    683041 Bytes = 667 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... Error: inflate() returned -3
GUNZIP ERROR - must RESET board to recover

Does anyone know what happened?

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

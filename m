Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7F71EB711B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 03:54:14 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so1473921rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 10:54:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>
	<97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
	<1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Mon, 29 Jun 2009 12:53:51 -0500
Message-ID: <97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
To: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	Scott Wood <scottwood@freescale.com>
Content-Type: multipart/mixed; boundary=000e0cd117c8b4dcfc046d8060d1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd117c8b4dcfc046d8060d1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi guys, I've been working off your suggestions and here's my update
on where I'm at now.

For reference, attached are my current
"linux-2.6-denx/arch/powerpc/boot/dts/ep88xc.dts" and
"u-boot-2009.03/include/configs/EP88x.h".

> I might be able to help out. Scott's right. According to U-Boots
> include/configs/EP88x.h,
> CONFIG_SYS_IMMR is 0xf0000000, but the Linux the ep88xc.dts is
> referring to an IMMR set
> to 0xfa200000. Replace every instance of 0xfa20 with 0xf000, and it may w=
ork.
I did notice the IMMR discrepancy and as Frank suggested adjusted the
0xfa20xxxx values to 0xf000xxxx in my DTS, though I'm wondering if it
would be better to have just set my CONFIG_SYS_IMMR to 0xfa200000? Not
sure if that would break more than it would fix. Anyways, I have not
noticed any difference in output after changing this in the DTS, but
I'll leave it this way as it seems more correct.

>>> Also, make sure u-boot is properly updating the memory size in the devi=
ce
>>> tree. =A0Can you dump the post-fixup device tree in u-boot?
>> Not sure, but I'll try to find out if that's possible. It'd certainly
>> answer a lot of questions...
While I have not yet figured out how to dump the post-fixup tree... I
can see that U-Boot doesn't seem to be doing proper fixup because
after manually setting all the DTS fields that U-Boot was supposed to
fill in (clock frequency, RAM start/end, etc.), the kernel seems to be
going through a fairly normal boot sequence. Without me manually
setting those fields, they remain initialized to 0. The only issue is
that no output goes to the console.

Here is my current output.
>From U-Boot:

U-Boot 2009.03-svn8591 (Jun 29 2009 - 11:25:23)

CPU:   MPC885ZPnn at 100 MHz [40.0...133.0 MHz]
       8 kB I-Cache 8 kB D-Cache FEC present
Board: EP88xC 1.1  CPLD revision 2
DRAM:  64 MB
FLASH: 32 MB
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET, FEC2 ETHERNET
Hit any key to stop autoboot:  0
=3D> tftp ep88x_uimage2
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_uimage2'.
Load address: 0x400000
Loading: #################################################################
         ########
done
Bytes transferred =3D 1057419 (10228b hex)
=3D> tftp 750000 ep88x_dtb2
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_dtb2'.
Load address: 0x750000
Loading: #
done
Bytes transferred =3D 7725 (1e2d hex)
=3D> bootm 400000 - 750000
## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-2.6.30-rc2-01402-gd4e2f68-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1057355 Bytes =3D  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 00750000
   Booting using the fdt blob at 0x750000
   Uncompressing Kernel Image ... OK


>From Kernel via postmortem analysis - sorry it's a little messy, my
debugger ICDPPCZ is not that great at producing memory dumps so I had
to do some cleanup/conversion to make the results at least somewhat
legible:

<6>Using Embedded Planet EP88xC machine description?
<5>Linux version 2.6.30-rc2-??1402-gd4e2f68-dirty
(devone@localhost.localdomain) (gcc version 4.2.2) #1 Mon J??n 29
11:35:28 CDT 2009?
<7>Top of RAM: 0x4000000' Total RAM: 0x4000000?
<7>Memory??hole size: 0MB?
<4>Zone PFN ranges:?
<4>  DMA      0x00000000 -> 0x00004000?
<4>  ??ormal   0x00004000 -> 0x00004000?
<4>Movable zone start PFN for each node?
<4>ear??y_node_map[1] active PFN ranges?
<4>    0: 0x00000000 -> 0x00004000?
<7>On node 0??totalpages: 16384?
<7>free_area_init_node: node 0' pgdat c021bf7c' node_mem_map ??023f000?
<7>  DMA zone: 128 pages used for memmap?
<7>  DMA zone: 0 pages reserve???
<7>  DMA zone: 16256 pages' LIFO batch:3?
<6>MMU: Allocated 72 bytes of context??maps for 16 contexts?
<4>Built 1 zonelists in Zone order' mobility grouping on. ??Total pages: 16=
256?
<5>Kernel command line: console=3DttyS0'9600n8 loglevel=3D7?
<6>N??_IRQS:512?
<7>irq: irq 5 on host /soc@f0000000/interrupt-controller@0 mapped to
??irtual irq 16?
<7>irq: irq 0 on host /soc@f0000000/cpm@9c0/interrupt-controller@??30
mapped to virtual irq 17?
<4>PID hash table entries: 256 (order: 8' 1024 byte??)?
<4>Decrementer Frequency =3D 0x7bfa48?
<7>irq: irq 15 on host /soc@f0000000/inte??rupt-controller@0 mapped to
virtual irq 18?
<7>time_init: decrementer frequency ?? 8.125000 MHz?
<7>time_init: processor frequency   =3D 130.000000 MHz?
<6>clocksour??e: timebase mult[1ec4ec4f] shift[22] registered?
<7>clockevent: decrementer mult??214] shift[16] cpu[0]?
<6>Dentry cache hash table entries: 8192 (order: 3' 32768??bytes)?
<6>Inode-cache hash table entries: 4096 (order: 2' 16384 bytes)?
<6>Memor??: 62532k/65536k available (2064k kernel code' 2940k
reserved' 100k data' 99k bs??' 96k init)?
<6>SLUB: Genslabs=3D12' HWalign=3D16' Order=3D0-3' MinObjects=3D0' CPUs=3D1=
' ??odes=3D1?
<6>Calibrating delay loop... 16.12 BogoMIPS (lpj=3D80640)?
<4>Mount-cache h??sh table entries: 512?
<6>net_namespace: 296 bytes?
<6>NET: Registered protocol f??mily 16?
<4>bio: create slab <bio-0> at 0?
<7>Switched to high resolution mode on??CPU 0?
<6>NET: Registered protocol family 2?
<6>IP route cache hash table entries?? 1024 (order: 0' 4096 bytes)?
<6>TCP established hash table entries: 2048 (order?? 2' 16384 bytes)?
<6>TCP bind hash table entries: 2048 (order: 1' 8192 bytes)?
<6??TCP: Hash tables configured (established 2048 bind 2048)?
<6>TCP reno registered??
<6>NET: Registered protocol family 1?
<6>msgmni has been set to 122?
<6>io schedu??er noop registered?
<6>io scheduler deadline registered (default)?
<6>Generic RTC??Driver v1.07?
<7>irq: irq 4 on host /soc@f0000000/cpm@9c0/interrupt-controller@9??0
mapped to virtual irq 19?
<6>f0000a80.serial: ttyCPM0 at MMIO 0xc500ea80 (irq ?? 19) is a CPM UART?
<7>irq: irq 29 on host /soc@f0000000/cpm@9c0/interrupt-contr??ller@930
mapped to virtual irq 29?
<6>f0000a20.serial: ttyCPM1 at MMIO 0xc501aa2?? (irq =3D 29) is a CPM UART?
<7>irq: irq 3 on host /soc@f0000000/interrupt-control??er@0 mapped to
virtual irq 20?
<6>eth0: fs_enet: 00:00:00:00:00:00?
<7>irq: irq 7??on host /soc@f0000000/interrupt-controller@0 mapped to
virtual irq 21?
<6>eth1: ??s_enet: 00:00:00:00:00:00?
<6>FEC MII Bus: probed?
<6>fe000000.flash: Found 2 x16??devices at 0x0 in 32-bit bank?
<4> Amd/Fujitsu Extended Query Table at 0x0040?
<4??fe000000.flash: CFI does not contain boot bank location. Assuming top.?
<5>numbe?? of CFI chips: 1?
<5>cfi_cmdset_0002: Disabling erase-suspend-program due to cod?? brokenness=
.?
<6>TCP cubic registered?
<6>NET: Registered protocol family 17?
<6>R??C: Registered udp transport module.?
<6>RPC: Registered tcp transport module.?
<3??Root-NFS: No NFS server available' giving up.?
<3>VFS: Unable to mount root fs v??a NFS' trying floppy.?
<4>VFS: Cannot open root device "<NULL>" or unknown-block??2'0)?
<4>Please append a correct "root=3D" boot option; here are the available
par??itions:?
<4>1f00           32768 mtdblock0 driver: of-flash?
<0>Kernel panic - no?? syncing: VFS: Unable to mount root fs on
unknown-block(2'0)?
<4>Call Trace:?
<4>??c381fed0] [c00069e0] show_stack+0x44/0x16c (unreliable)?
<4>[c381ff10] [c001bc6c?? panic+0x8c/0x168?
<4>[c381ff60] [c01ecb80] mount_block_root+0x12c/0x244?
<4>[c38??ffb0] [c01ecdf4] prepare_namespace+0x4c/0x1c4?
<4>[c381ffd0] [c01ec1b0] kernel_i??it+0xd0/0xfc?
<4>[c381fff0] [c000da60] kernel_thread+0x4c/0x68?
<0>Rebooting in 1??0 seconds..?????????????????????????????????

At this point, my primary goal is to get console output working before
I do anything else. I've tried different "console=3Dx" boot arguments
and I've added the "chosen" section to my DTS, but still no output.
Anyone have suggestions about this? Is something else messed up in my
DTS?

Thanks,
Mikhail Zaturenskiy

--000e0cd117c8b4dcfc046d8060d1
Content-Type: application/octet-stream; name="ep88xc.dts"
Content-Disposition: attachment; filename="ep88xc.dts"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwjh3s4j0

LyoKICogRVA4OHhDIERldmljZSBUcmVlIFNvdXJjZQogKgogKiBDb3B5cmlnaHQgMjAwNiBNb250
YVZpc3RhIFNvZnR3YXJlLCBJbmMuCiAqIENvcHlyaWdodCAyMDA3LDIwMDggRnJlZXNjYWxlIFNl
bWljb25kdWN0b3IsIEluYy4KICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlICBpdCBhbmQvb3IgbW9kaWZ5IGl0CiAqIHVuZGVyICB0aGUgdGVy
bXMgb2YgIHRoZSBHTlUgR2VuZXJhbCAgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRo
ZQogKiBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247ICBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSAg
TGljZW5zZSwgb3IgKGF0IHlvdXIKICogb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICovCgov
ZHRzLXYxLzsKCi8gewoJbW9kZWwgPSAiRVA4OHhDIjsKCWNvbXBhdGlibGUgPSAiZnNsLGVwODh4
YyI7CgkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCSNzaXplLWNlbGxzID0gPDE+OwoKCWNwdXMgewoJ
CSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCSNzaXplLWNlbGxzID0gPDA+OwoKCQlQb3dlclBDLDg4
NUAwIHsKCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKCQkJcmVnID0gPDB4MD47CgkJCWQtY2FjaGUt
bGluZS1zaXplID0gPDE2PjsKCQkJaS1jYWNoZS1saW5lLXNpemUgPSA8MTY+OwoJCQlkLWNhY2hl
LXNpemUgPSA8ODE5Mj47CgkJCWktY2FjaGUtc2l6ZSA9IDw4MTkyPjsKCQkJdGltZWJhc2UtZnJl
cXVlbmN5ID0gPDgwMDAwMDA+OyAvLyBNWiAtIHdhcyAwCgkJCWJ1cy1mcmVxdWVuY3kgPSA8NTAw
MDAwMDA+OyAvLyBNWiAtIHdhcyAwCgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwxMzAwMDAwMDA+OyAv
LyBNWiAtIHdhcyAwLAoJCQlpbnRlcnJ1cHRzID0gPDE1IDI+OwkvLyBkZWNyZW1lbnRlciBpbnRl
cnJ1cHQKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmUElDPjsKCQl9OwoJfTsKCgltZW1vcnkgewoJ
CWRldmljZV90eXBlID0gIm1lbW9yeSI7CgkJcmVnID0gPDB4MCAweDA0MDAwMDAwPjsgLy8gTVog
LSB3YXMgPDB4MCAweDA+Cgl9OwoKCWxvY2FsYnVzQGYwMDAwMTAwIHsgLy8gTVogLSB3YXMgZmEy
MHh4eHgKCQljb21wYXRpYmxlID0gImZzbCxtcGM4ODUtbG9jYWxidXMiLCAiZnNsLHBxMS1sb2Nh
bGJ1cyI7CgkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47CgkJI3NpemUtY2VsbHMgPSA8MT47CgkJcmVn
ID0gPDB4ZjAwMDAxMDAgMHg0MD47IC8vIE1aIC0gd2FzIGZhMjB4eHh4CgoJCXJhbmdlcyA9IDwK
CQkJMHgwIDB4MCAweGZjMDAwMDAwIDB4NDAwMDAwMAoJCQkweDMgMHgwIDB4ZmEwMDAwMDAgMHgx
MDAwMDAwCgkJPjsKCgkJZmxhc2hAMCwyMDAwMDAwIHsKCQkJY29tcGF0aWJsZSA9ICJjZmktZmxh
c2giOwoJCQlyZWcgPSA8MHgwIDB4MjAwMDAwMCAweDIwMDAwMDA+OwoJCQliYW5rLXdpZHRoID0g
PDQ+OwoJCQlkZXZpY2Utd2lkdGggPSA8Mj47CgkJfTsKCgkJYm9hcmQtY29udHJvbEAzLDQwMDAw
MCB7CgkJCXJlZyA9IDwweDMgMHg0MDAwMDAgMHgxMD47CgkJCWNvbXBhdGlibGUgPSAiZnNsLGVw
ODh4Yy1iY3NyIjsKCQl9OwoJfTsKCglzb2NAZjAwMDAwMDAgeyAvLyBNWiAtIHdhcyBmYTIweHh4
eAoJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzg4NSIsICJmc2wscHExLXNvYyI7CgkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47CgkJI3NpemUtY2VsbHMgPSA8MT47CgkJZGV2aWNlX3R5cGUgPSAic29jIjsK
CQlyYW5nZXMgPSA8MHgwIDB4ZjAwMDAwMDAgMHg0MDAwPjsgLy8gTVogLSB3YXMgZmEyMHh4eHgK
CQlidXMtZnJlcXVlbmN5ID0gPDA+OwoKCQkvLyBUZW1wb3JhcnkgLS0gd2lsbCBnbyBhd2F5IG9u
Y2Uga2VybmVsIHVzZXMgcmFuZ2VzIGZvciBnZXRfaW1tcmJhc2UoKS4KCQlyZWcgPSA8MHhmMDAw
MDAwMCAweDQwMDA+OyAvLyBNWiAtIHdhcyBmYTIweHh4eAoKCQltZGlvQGUwMCB7CgkJCWNvbXBh
dGlibGUgPSAiZnNsLG1wYzg4NS1mZWMtbWRpbyIsICJmc2wscHExLWZlYy1tZGlvIjsKCQkJcmVn
ID0gPDB4ZTAwIDB4MTg4PjsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCSNzaXplLWNlbGxz
ID0gPDA+OwoKCQkJUEhZMDogZXRoZXJuZXQtcGh5QDAgewoJCQkJcmVnID0gPDB4MD47CgkJCQlk
ZXZpY2VfdHlwZSA9ICJldGhlcm5ldC1waHkiOwoJCQl9OwoKCQkJUEhZMTogZXRoZXJuZXQtcGh5
QDEgewoJCQkJcmVnID0gPDB4MT47CgkJCQlkZXZpY2VfdHlwZSA9ICJldGhlcm5ldC1waHkiOwoJ
CQl9OwoJCX07CgoJCWV0aGVybmV0QGUwMCB7CgkJCWRldmljZV90eXBlID0gIm5ldHdvcmsiOwoJ
CQljb21wYXRpYmxlID0gImZzbCxtcGM4ODUtZmVjLWVuZXQiLAoJCQkgICAgICAgICAgICAgImZz
bCxwcTEtZmVjLWVuZXQiOwoJCQlyZWcgPSA8MHhlMDAgMHgxODg+OwoJCQlsb2NhbC1tYWMtYWRk
cmVzcyA9IFsgMDAgMDAgMDAgMDAgMDAgMDAgXTsKCQkJaW50ZXJydXB0cyA9IDwzIDE+OwoJCQlp
bnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQlwaHktaGFuZGxlID0gPCZQSFkwPjsKCQkJbGlu
dXgsbmV0d29yay1pbmRleCA9IDwwPjsKCQl9OwoKCQlldGhlcm5ldEAxZTAwIHsKCQkJZGV2aWNl
X3R5cGUgPSAibmV0d29yayI7CgkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzg4NS1mZWMtZW5ldCIs
CgkJCSAgICAgICAgICAgICAiZnNsLHBxMS1mZWMtZW5ldCI7CgkJCXJlZyA9IDwweDFlMDAgMHgx
ODg+OwoJCQlsb2NhbC1tYWMtYWRkcmVzcyA9IFsgMDAgMDAgMDAgMDAgMDAgMDAgXTsKCQkJaW50
ZXJydXB0cyA9IDw3IDE+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQlwaHktaGFu
ZGxlID0gPCZQSFkxPjsKCQkJbGludXgsbmV0d29yay1pbmRleCA9IDwxPjsKCQl9OwoKCQlQSUM6
IGludGVycnVwdC1jb250cm9sbGVyQDAgewoJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsKCQkJI2lu
dGVycnVwdC1jZWxscyA9IDwyPjsKCQkJcmVnID0gPDB4MCAweDI0PjsKCQkJY29tcGF0aWJsZSA9
ICJmc2wsbXBjODg1LXBpYyIsICJmc2wscHExLXBpYyI7CgkJfTsKCgkJcGNtY2lhQDgwIHsKCQkJ
I2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47CgkJCSNzaXpl
LWNlbGxzID0gPDI+OwoJCQljb21wYXRpYmxlID0gImZzbCxwcS1wY21jaWEiOwoJCQlkZXZpY2Vf
dHlwZSA9ICJwY21jaWEiOwoJCQlyZWcgPSA8MHg4MCAweDgwPjsKCQkJaW50ZXJydXB0LXBhcmVu
dCA9IDwmUElDPjsKCQkJaW50ZXJydXB0cyA9IDwxMyAxPjsKCQl9OwoKCQljcG1AOWMwIHsKCQkJ
I2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCSNzaXplLWNlbGxzID0gPDE+OwoJCQljb21wYXRpYmxl
ID0gImZzbCxtcGM4ODUtY3BtIiwgImZzbCxjcG0xIjsKCQkJY29tbWFuZC1wcm9jID0gPDB4OWMw
PjsKCQkJaW50ZXJydXB0cyA9IDwwPjsJLy8gY3BtIGVycm9yIGludGVycnVwdAoJCQlpbnRlcnJ1
cHQtcGFyZW50ID0gPCZDUE1fUElDPjsKCQkJcmVnID0gPDB4OWMwIDB4NDA+OwoJCQlyYW5nZXM7
CgoJCQltdXJhbUAyMDAwIHsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkJI3NpemUtY2Vs
bHMgPSA8MT47CgkJCQlyYW5nZXMgPSA8MHgwIDB4MjAwMCAweDIwMDA+OwoKCQkJCWRhdGFAMCB7
CgkJCQkJY29tcGF0aWJsZSA9ICJmc2wsY3BtLW11cmFtLWRhdGEiOwoJCQkJCXJlZyA9IDwweDAg
MHgxYzAwPjsKCQkJCX07CgkJCX07CgoJCQlicmdAOWYwIHsKCQkJCWNvbXBhdGlibGUgPSAiZnNs
LG1wYzg4NS1icmciLAoJCQkJICAgICAgICAgICAgICJmc2wsY3BtMS1icmciLAoJCQkJICAgICAg
ICAgICAgICJmc2wsY3BtLWJyZyI7CgkJCQlyZWcgPSA8MHg5ZjAgMHgxMD47CgkJCX07CgoJCQlD
UE1fUElDOiBpbnRlcnJ1cHQtY29udHJvbGxlckA5MzAgewoJCQkJaW50ZXJydXB0LWNvbnRyb2xs
ZXI7CgkJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+OwoJCQkJaW50ZXJydXB0cyA9IDw1IDIgMCAy
PjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJQz47CgkJCQlyZWcgPSA8MHg5MzAgMHgyMD47
CgkJCQljb21wYXRpYmxlID0gImZzbCxtcGM4ODUtY3BtLXBpYyIsCgkJCQkgICAgICAgICAgICAg
ImZzbCxjcG0xLXBpYyI7CgkJCX07CgoJCQkvLyBNT04tMQoJCQlzZXJpYWxAYTgwIHsKCQkJCWRl
dmljZV90eXBlID0gInNlcmlhbCI7CgkJCQljb21wYXRpYmxlID0gImZzbCxtcGM4ODUtc21jLXVh
cnQiLAoJCQkJICAgICAgICAgICAgICJmc2wsY3BtMS1zbWMtdWFydCI7CgkJCQlyZWcgPSA8MHhh
ODAgMHgxMCAweDNlODAgMHg0MD47CgkJCQlpbnRlcnJ1cHRzID0gPDQ+OwoJCQkJaW50ZXJydXB0
LXBhcmVudCA9IDwmQ1BNX1BJQz47CgkJCQlmc2wsY3BtLWJyZyA9IDwxPjsKCQkJCWZzbCxjcG0t
Y29tbWFuZCA9IDwweDkwPjsKCQkJCWxpbnV4LHBsYW5ldGNvcmUtbGFiZWwgPSAiU01DMSI7CgkJ
CX07CgoJCQkvLyBTRVItMQoJCQlzZXJpYWxAYTIwIHsKCQkJCWRldmljZV90eXBlID0gInNlcmlh
bCI7CgkJCQljb21wYXRpYmxlID0gImZzbCxtcGM4ODUtc2NjLXVhcnQiLAoJCQkJICAgICAgICAg
ICAgICJmc2wsY3BtMS1zY2MtdWFydCI7CgkJCQlyZWcgPSA8MHhhMjAgMHgyMCAweDNkMDAgMHg4
MD47CgkJCQlpbnRlcnJ1cHRzID0gPDI5PjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JkNQTV9Q
SUM+OwoJCQkJZnNsLGNwbS1icmcgPSA8Mj47CgkJCQlmc2wsY3BtLWNvbW1hbmQgPSA8MHg0MD47
CgkJCQlsaW51eCxwbGFuZXRjb3JlLWxhYmVsID0gIlNDQzIiOwoJCQl9OwoKCQkJdXNiQGEwMCB7
CgkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJCSNzaXplLWNlbGxzID0gPDA+OwoJCQkJY29t
cGF0aWJsZSA9ICJmc2wsbXBjODg1LXVzYiIsCgkJCQkgICAgICAgICAgICAgImZzbCxjcG0xLXVz
YiI7CgkJCQlyZWcgPSA8MHhhMDAgMHgxOCAweDFjMDAgMHg4MD47CgkJCQlpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZDUE1fUElDPjsKCQkJCWludGVycnVwdHMgPSA8MzA+OwoJCQkJZnNsLGNwbS1jb21t
YW5kID0gPDAwMDA+OwoJCQl9OwoJCX07Cgl9OwoKCWNob3NlbiB7CgkJbGludXgsc3Rkb3V0LXBh
dGggPSAiL3NvY0BmMDAwMDAwMC9jcG1AOWMwL3NlcmlhbEBhODAiOyAvLyBNWiAtIGFkZGVkIHRo
aXMgJ2Nob3Nlbicgc2VjdGlvbgoJfTsKCn07Cg==
--000e0cd117c8b4dcfc046d8060d1
Content-Type: application/octet-stream; name="EP88x.h"
Content-Disposition: attachment; filename="EP88x.h"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwjh3wje1

LyoKICogQ29weXJpZ2h0IChDKSAyMDA1IEFyYWJlbGxhIFNvZnR3YXJlIEx0ZC4KICogWXVsaSBC
YXJjb2hlbiA8eXVsaUBhcmFiZWxsYXN3LmNvbT4KICoKICogU3VwcG9ydCBmb3IgRW1iZWRkZWQg
UGxhbmV0IEVQODh4IGJvYXJkcy4KICogVGVzdGVkIG9uIEVQODh4QyB3aXRoIE1QQzg4NSBDUFUs
IDY0TUIgU0RSQU0gYW5kIDE2TUIgZmxhc2guCiAqCiAqIFNlZSBmaWxlIENSRURJVFMgZm9yIGxp
c3Qgb2YgcGVvcGxlIHdobyBjb250cmlidXRlZCB0byB0aGlzCiAqIHByb2plY3QuCiAqCiAqIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3IKICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMKICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247
IGVpdGhlciB2ZXJzaW9uIDIgb2YKICogdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikg
YW55IGxhdGVyIHZlcnNpb24uCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0
aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAogKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgogKiBNRVJDSEFOVEFCSUxJ
VFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuCSBTZWUgdGhlCiAqIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCiAqCiAqIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCiAq
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3
YXJlCiAqIEZvdW5kYXRpb24sIEluYy4sIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0
b24sCiAqIE1BIDAyMTExLTEzMDcgVVNBCiAqLwojaWZuZGVmIF9fQ09ORklHX0gKI2RlZmluZSBf
X0NPTkZJR19ICgovLyNkZWZpbmUgREVCVUcgLy8gTVoKCiNkZWZpbmUgQ09ORklHX09GX0xJQkZE
VCAJLy8gTVogLSBhZGRlZCB0byBzdXBwb3J0IEZEVCwgc3VnZ2VzdGVkIGJ5IERldGxldgoKI2Rl
ZmluZSBDT05GSUdfTVBDODg1CgojZGVmaW5lIENPTkZJR19FUDg4WAkJCQkvKiBFbWJlZGRlZCBQ
bGFuZXQgRVA4OHggYm9hcmQJKi8KCiNkZWZpbmUgQ09ORklHX0JPQVJEX0VBUkxZX0lOSVRfRgkJ
LyogQ2FsbCBib2FyZF9lYXJseV9pbml0X2YJKi8KCi8qIEFsbG93IHNlcmlhbCBudW1iZXIgKHNl
cmlhbCMpIGFuZCBNQUMgYWRkcmVzcyAoZXRoYWRkcikgdG8gYmUgb3ZlcndyaXR0ZW4gKi8KI2Rl
ZmluZSBDT05GSUdfRU5WX09WRVJXUklURQoKI2RlZmluZQlDT05GSUdfOHh4X0NPTlNfU01DMQkx
CQkvKiBDb25zb2xlIGlzIG9uIFNNQzEJCSovCiNkZWZpbmUgQ09ORklHX0JBVURSQVRFCQk5NjAw
CgojZGVmaW5lCUNPTkZJR19FVEhFUl9PTl9GRUMxCQkJLyogRW5hYmxlIEV0aGVybmV0IG9uIEZF
QzEJKi8KI2RlZmluZQlDT05GSUdfRVRIRVJfT05fRkVDMgkJCS8qIEVuYWJsZSBFdGhlcm5ldCBv
biBGRUMyCSovCiNpZiBkZWZpbmVkKENPTkZJR19FVEhFUl9PTl9GRUMxKSB8fCBkZWZpbmVkKENP
TkZJR19FVEhFUl9PTl9GRUMyKQojZGVmaW5lIENPTkZJR19TWVNfRElTQ09WRVJfUEhZCiNkZWZp
bmUgQ09ORklHX01JSV9JTklUCQkxCiNkZWZpbmUgRkVDX0VORVQKI2VuZGlmIC8qIENPTkZJR19G
RUNfRU5FVCAqLwoKI2RlZmluZSBDT05GSUdfOHh4X09TQ0xLCQkxMDAwMDAwMCAvKiAxMCBNSHog
b3NjaWxsYXRvciBvbiBFWFRDTEsgKi8KI2RlZmluZSBDT05GSUdfOHh4X0NQVUNMS19ERUZBVUxU
CTEwMDAwMDAwMAojZGVmaW5lIENPTkZJR19TWVNfOHh4X0NQVUNMS19NSU4JNDAwMDAwMDAKI2Rl
ZmluZSBDT05GSUdfU1lTXzh4eF9DUFVDTEtfTUFYCTEzMzAwMDAwMAoKLyoKICogQk9PVFAgb3B0
aW9ucwogKi8KI2RlZmluZSBDT05GSUdfQk9PVFBfQk9PVEZJTEVTSVpFCiNkZWZpbmUgQ09ORklH
X0JPT1RQX0JPT1RQQVRICiNkZWZpbmUgQ09ORklHX0JPT1RQX0dBVEVXQVkKI2RlZmluZSBDT05G
SUdfQk9PVFBfSE9TVE5BTUUKCgovKgogKiBDb21tYW5kIGxpbmUgY29uZmlndXJhdGlvbi4KICov
CiNpbmNsdWRlIDxjb25maWdfY21kX2RlZmF1bHQuaD4KCiNkZWZpbmUgQ09ORklHX0NNRF9ESENQ
CiNkZWZpbmUgQ09ORklHX0NNRF9JTU1BUAojZGVmaW5lIENPTkZJR19DTURfTUlJCiNkZWZpbmUg
Q09ORklHX0NNRF9QSU5HCgoKLy8jZGVmaW5lIENPTkZJR19CT09UREVMQVkJNQkJLyogQXV0b2Jv
b3QgYWZ0ZXIgNSBzZWNvbmRzCSovCiNkZWZpbmUgQ09ORklHX0JPT1RERUxBWQkxNQkJLyogTVog
LSBBdXRvYm9vdCBhZnRlciAxNSBzZWNvbmRzCSovCi8vI2RlZmluZSBDT05GSUdfQk9PVENPTU1B
TkQJImJvb3RtIGZlMDYwMDAwIgkvKiBBdXRvYm9vdCBjb21tYW5kCSovCiNkZWZpbmUgQ09ORklH
X0JPT1RDT01NQU5ECSJib290bSBmYzA4MDAwMCIJLyogTVogLSBBdXRvYm9vdCBjb21tYW5kCSov
Ci8vI2RlZmluZSBDT05GSUdfQk9PVEFSR1MJCSJyb290PS9kZXYvbXRkYmxvY2sxIHJ3IG10ZHBh
cnRzPXBoeXM6Mk0oUk9NKXJvLC0ocm9vdCkiCiNkZWZpbmUgQ09ORklHX0JPT1RBUkdTCQkiY29u
c29sZT10dHlTMCw5NjAwbjggbG9nbGV2ZWw9NyIJLy8gTVoKCiNkZWZpbmUgQ09ORklHX0JaSVAy
CQkvKiBJbmNsdWRlIHN1cHBvcnQgZm9yIGJ6aXAyIGNvbXByZXNzZWQgaW1hZ2VzICAqLwojdW5k
ZWYJQ09ORklHX1dBVENIRE9HCQkvKiBEaXNhYmxlIHBsYXRmb3JtIHNwZWNpZmljIHdhdGNoZG9n
CQkqLwoKLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogKiBNaXNjZWxsYW5lb3VzIGNvbmZpZ3VyYWJsZSBvcHRp
b25zCiAqLwojZGVmaW5lIENPTkZJR19TWVNfUFJPTVBUCQkiPT4gIgkJLyogTW9uaXRvciBDb21t
YW5kIFByb21wdAkqLwojZGVmaW5lIENPTkZJR19TWVNfSFVTSF9QQVJTRVIKI2RlZmluZSBDT05G
SUdfU1lTX1BST01QVF9IVVNIX1BTMgkiPiAiCiNkZWZpbmUgQ09ORklHX1NZU19MT05HSEVMUAkJ
CQkvKiAjdW5kZWYgdG8gc2F2ZSBtZW1vcnkJKi8KI2RlZmluZSBDT05GSUdfU1lTX0NCU0laRQkJ
MjU2CQkvKiBDb25zb2xlIEkvTyBCdWZmZXIgU2l6ZQkqLwojZGVmaW5lIENPTkZJR19TWVNfUEJT
SVpFIChDT05GSUdfU1lTX0NCU0laRSArIHNpemVvZihDT05GSUdfU1lTX1BST01QVCkgKyAxNikg
IC8qIFByaW50IEJ1ZmZlciBTaXplICovCiNkZWZpbmUgQ09ORklHX1NZU19NQVhBUkdTCQkxNgkJ
LyogTWF4IG51bWJlciBvZiBjb21tYW5kIGFyZ3MJKi8KI2RlZmluZSBDT05GSUdfU1lTX0JBUkdT
SVpFCQlDT05GSUdfU1lTX0NCU0laRQkvKiBCb290IEFyZ3VtZW50IEJ1ZmZlciBTaXplCSovCgoj
ZGVmaW5lIENPTkZJR19TWVNfTE9BRF9BRERSCQkweDQwMDAwMAkvKiBEZWZhdWx0IGxvYWQgYWRk
cmVzcwkJKi8KCiNkZWZpbmUgQ09ORklHX1NZU19IWgkJCTEwMDAJCS8qIERlY3JlbWVudGVyIGZy
ZXE6IDEgbXMgdGlja3MJKi8KCiNkZWZpbmUgQ09ORklHX1NZU19CQVVEUkFURV9UQUJMRQl7IDk2
MDAsIDE5MjAwLCAzODQwMCwgNTc2MDAsIDExNTIwMCB9CgovKi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAqIFJB
TSBjb25maWd1cmF0aW9uIChub3RlIHRoYXQgQ09ORklHX1NZU19TRFJBTV9CQVNFIG11c3QgYmUg
emVybykKICovCiNkZWZpbmUgQ09ORklHX1NZU19TRFJBTV9CQVNFCQkweDAwMDAwMDAwCi8vI2Rl
ZmluZSBDT05GSUdfU1lTX1NEUkFNX01BWF9TSVpFCTB4MDgwMDAwMDAJLyogVXAgdG8gMTI4IE1i
eXRlCQkqLwojZGVmaW5lIENPTkZJR19TWVNfU0RSQU1fTUFYX1NJWkUJMHgwNDAwMDAwMAkvKiBN
WiAtIFVwIHRvIDY0IE1ieXRlCQkqLwoKI2RlZmluZSBDT05GSUdfU1lTX01BTVIJCTB4MDA4MDUw
MDAKCi8qCiAqIDQwOTYJVXAgdG8gNDA5NiBTRFJBTSByb3dzCiAqIDEwMDAJZmFjdG9yIHMgLT4g
bXMKICogMzIJUFRQIChwcmUtZGl2aWRlciBmcm9tIE1QVFBSKQogKiA0CU51bWJlciBvZiByZWZy
ZXNoIGN5Y2xlcyBwZXIgcGVyaW9kCiAqIDY0CVJlZnJlc2ggY3ljbGUgaW4gbXMgcGVyIG51bWJl
ciBvZiByb3dzCiAqLwojZGVmaW5lIENPTkZJR19TWVNfUFRBX1BFUl9DTEsJCSgoNDA5NiAqIDMy
ICogMTAwMCkgLyAoNCAqIDY0KSkKCiNkZWZpbmUgQ09ORklHX1NZU19NRU1URVNUX1NUQVJUCTB4
MDAxMDAwMDAJLyogbWVtdGVzdCB3b3JrcyBvbgkJKi8KI2RlZmluZSBDT05GSUdfU1lTX01FTVRF
U1RfRU5ECQkweDAwNTAwMDAwCS8qIDEgLi4uIDUgTUIgaW4gU0RSQU0JCSovCgojZGVmaW5lIENP
TkZJR19TWVNfUkVTRVRfQUREUkVTUwkweDA5OTAwMDAwCgovKi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAqIEZv
ciBib290aW5nIExpbnV4LCB0aGUgYm9hcmQgaW5mbyBhbmQgY29tbWFuZCBsaW5lIGRhdGEKICog
aGF2ZSB0byBiZSBpbiB0aGUgZmlyc3QgOCBNQiBvZiBtZW1vcnksIHNpbmNlIHRoaXMgaXMKICog
dGhlIG1heGltdW0gbWFwcGVkIGJ5IHRoZSBMaW51eCBrZXJuZWwgZHVyaW5nIGluaXRpYWxpemF0
aW9uLgogKi8KI2RlZmluZSBDT05GSUdfU1lTX0JPT1RNQVBTWgkJKDggPDwgMjApCS8qIEluaXRp
YWwgTWVtb3J5IG1hcCBmb3IgTGludXggKi8KCiNkZWZpbmUgQ09ORklHX1NZU19NT05JVE9SX0JB
U0UJVEVYVF9CQVNFCiNkZWZpbmUgQ09ORklHX1NZU19NT05JVE9SX0xFTgkJKDI1NiA8PCAxMCkJ
LyogUmVzZXJ2ZSAyNTYgS0IgZm9yIE1vbml0b3IgICAqLwojdW5kZWYgQ09ORklHX0JaSVAyCS8v
IE1aCiNpZmRlZiBDT05GSUdfQlpJUDIKI2RlZmluZSBDT05GSUdfU1lTX01BTExPQ19MRU4JCSg0
MDk2IDw8IDEwKQkvKiBSZXNlcnZlIH40IE1CIGZvciBtYWxsb2MoKSAgICovCiNlbHNlCiNkZWZp
bmUgQ09ORklHX1NZU19NQUxMT0NfTEVOCQkoMTI4IDw8IDEwKQkvKiBSZXNlcnZlIDEyOCBLQiBm
b3IgbWFsbG9jKCkgICovCiNlbmRpZiAvKiBDT05GSUdfQlpJUDIgKi8KCi8qLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KICogRmxhc2ggb3JnYW5pc2F0aW9uCiAqLwojZGVmaW5lIENPTkZJR19TWVNfRkxBU0hfQkFT
RQkJMHhGQzAwMDAwMAojZGVmaW5lIENPTkZJR19TWVNfRkxBU0hfQ0ZJCQkJCS8qIFRoZSBmbGFz
aCBpcyBDRkkgY29tcGF0aWJsZSAgKi8KI2RlZmluZSBDT05GSUdfRkxBU0hfQ0ZJX0RSSVZFUgkJ
CS8qIFVzZSBjb21tb24gQ0ZJIGRyaXZlciAgICAgICAgKi8KI2RlZmluZSBDT05GSUdfU1lTX01B
WF9GTEFTSF9CQU5LUwkxCQkvKiBNYXggbnVtYmVyIG9mIGZsYXNoIGJhbmtzCSovCi8vI2RlZmlu
ZSBDT05GSUdfU1lTX01BWF9GTEFTSF9TRUNUCTUxMgkJLyogTWF4IG51bSBvZiBzZWN0cyBvbiBv
bmUgY2hpcCAqLwojZGVmaW5lIENPTkZJR19TWVNfTUFYX0ZMQVNIX1NFQ1QJMTI4CQkvKiBNWiAt
IE1heCBudW0gb2Ygc2VjdHMgb24gb25lIGNoaXAgKi8KCi8qIEVudmlyb25tZW50IGlzIGluIGZs
YXNoICovCiNkZWZpbmUgQ09ORklHX0VOVl9JU19JTl9GTEFTSAovLyNkZWZpbmUgQ09ORklHX0VO
Vl9TRUNUX1NJWkUJMHgyMDAwMAkJLyogV2UgdXNlIG9uZSBjb21wbGV0ZSBzZWN0b3IJKi8KI2Rl
ZmluZSBDT05GSUdfRU5WX1NFQ1RfU0laRQkweDQwMDAwCQkvKiBNWiAtIFdlIHVzZSBvbmUgY29t
cGxldGUgc2VjdG9yCSovIAojZGVmaW5lIENPTkZJR19FTlZfQUREUgkJKENPTkZJR19TWVNfTU9O
SVRPUl9CQVNFICsgQ09ORklHX1NZU19NT05JVE9SX0xFTikKCiNkZWZpbmUgQ09ORklHX1NZU19P
UjBfUFJFTElNCQkweEZDMDAwMTYwCiNkZWZpbmUgQ09ORklHX1NZU19CUjBfUFJFTElNCQkoQ09O
RklHX1NZU19GTEFTSF9CQVNFIHwgQlJfUFNfMzIgfCBCUl9NU19HUENNIHwgQlJfVikKCiNkZWZp
bmUJQ09ORklHX1NZU19ESVJFQ1RfRkxBU0hfVEZUUAoKLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogKiBCQ1NS
CiAqLwojZGVmaW5lIENPTkZJR19TWVNfT1IzX1BSRUxJTQkJMHhGRjAwMDVCMAojZGVmaW5lIENP
TkZJR19TWVNfQlIzX1BSRUxJTQkJKDB4RkEwMDAwMDAgfEJSX1BTXzE2IHwgQlJfTVNfR1BDTSB8
IEJSX1YpCgojZGVmaW5lIENPTkZJR19TWVNfQkNTUgkJMHhGQTQwMDAwMAoKLyotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQogKiBJbnRlcm5hbCBNZW1vcnkgTWFwIFJlZ2lzdGVyCiAqLwojZGVmaW5lIENPTkZJR19T
WVNfSU1NUgkJMHhGMDAwMDAwMAoKLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogKiBEZWZpbml0aW9ucyBmb3Ig
aW5pdGlhbCBzdGFjayBwb2ludGVyIGFuZCBkYXRhIGFyZWEgKGluIERQUkFNKQogKi8KI2RlZmlu
ZSBDT05GSUdfU1lTX0lOSVRfUkFNX0FERFIJQ09ORklHX1NZU19JTU1SCiNkZWZpbmUgQ09ORklH
X1NZU19JTklUX1JBTV9FTkQJMHgyRjAwCQkvKiBFbmQgb2YgdXNlZCBhcmVhIGluIERQUkFNCSov
CiNkZWZpbmUgQ09ORklHX1NZU19HQkxfREFUQV9TSVpFCTEyOCAgLyogU2l6ZSBpbiBieXRlcyBy
ZXNlcnZlZCBmb3IgaW5pdGlhbCBkYXRhICovCiNkZWZpbmUgQ09ORklHX1NZU19HQkxfREFUQV9P
RkZTRVQJKENPTkZJR19TWVNfSU5JVF9SQU1fRU5EIC0gQ09ORklHX1NZU19HQkxfREFUQV9TSVpF
KQojZGVmaW5lIENPTkZJR19TWVNfSU5JVF9TUF9PRkZTRVQJQ09ORklHX1NZU19HQkxfREFUQV9P
RkZTRVQKCi8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICogQ29uZmlndXJhdGlvbiByZWdpc3RlcnMKICovCiNp
ZmRlZiBDT05GSUdfV0FUQ0hET0cKI2RlZmluZSBDT05GSUdfU1lTX1NZUENSCQkoU1lQQ1JfU1dU
QyB8IFNZUENSX0JNVCB8IFNZUENSX0JNRSAgfCBcCgkJCQkgU1lQQ1JfU1dGICB8IFNZUENSX1NX
RSB8IFNZUENSX1NXUkkgfCBcCgkJCQkgU1lQQ1JfU1dQKQojZWxzZQojZGVmaW5lIENPTkZJR19T
WVNfU1lQQ1IJCShTWVBDUl9TV1RDIHwgU1lQQ1JfQk1UIHwgU1lQQ1JfQk1FICB8IFwKCQkJCSBT
WVBDUl9TV0YgIHwgU1lQQ1JfU1dQKQojZW5kaWYgLyogQ09ORklHX1dBVENIRE9HICovCgojZGVm
aW5lIENPTkZJR19TWVNfU0lVTUNSCQkoU0lVTUNSX01MUkMwMSB8IFNJVU1DUl9EQkdDMTEpCgov
KiBUQlNDUiAtIFRpbWUgQmFzZSBTdGF0dXMgYW5kIENvbnRyb2wgUmVnaXN0ZXIgKi8KI2RlZmlu
ZSBDT05GSUdfU1lTX1RCU0NSCQkoVEJTQ1JfVEJGIHwgVEJTQ1JfVEJFKQoKLyogUElTQ1IgLSBQ
ZXJpb2RpYyBJbnRlcnJ1cHQgU3RhdHVzIGFuZCBDb250cm9sICovCiNkZWZpbmUgQ09ORklHX1NZ
U19QSVNDUgkJUElTQ1JfUFMKCi8qIFNDQ1IgLSBTeXN0ZW0gQ2xvY2sgYW5kIHJlc2V0IENvbnRy
b2wgUmVnaXN0ZXIgKi8KI2RlZmluZSBTQ0NSX01BU0sJCVNDQ1JfRUJERjExCiNkZWZpbmUgQ09O
RklHX1NZU19TQ0NSCQlTQ0NSX1JUU0VMCgojZGVmaW5lIENPTkZJR19TWVNfREVSCQkJMAoKLyot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogKiBDYWNoZSBDb25maWd1cmF0aW9uCiAqLwojZGVmaW5lIENPTkZJR19T
WVNfQ0FDSEVMSU5FX1NJWkUJMTYJLyogRm9yIGFsbCBNUEM4eHggY2hpcHMJCQkqLwoKLyotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogKiBJbnRlcm5hbCBEZWZpbml0aW9ucwogKgogKiBCb290IEZsYWdzCiAqLwoj
ZGVmaW5lIEJPT1RGTEFHX0NPTEQJCTB4MDEJLyogTm9ybWFsIFBvd2VyLU9uOiBCb290IGZyb20g
Zmxhc2gJKi8KI2RlZmluZSBCT09URkxBR19XQVJNCQkweDAyCS8qIFNvZnR3YXJlIHJlYm9vdAkJ
CSovCgojZW5kaWYgLyogX19DT05GSUdfSCAqLwo=
--000e0cd117c8b4dcfc046d8060d1--

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EA776EC.3090805@tataelxsi.co.in>
Date: Thu, 24 Apr 2003 11:02:28 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: initrd problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am unable to boot up my linux with my ramdisk image.
Board: MPC8260 ADS
Kernel: 2.4.1
PPC Boot: 2.0.0

When I boot up the kernel without ramdisk, the same kernel image is
booting up fine.
But when I use a ramdisk

## Booting image at 00100000 ...
   Image Name:   Embedix for MPC8260ADS
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    531861 Bytes = 519.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00200000 ...
   Image Name:   Simple ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (uncompressed)
   Data Size:    4194304 Bytes =  4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00b5e000, end 00f5e000 ... OK

I dont get any console output after this. I am not sure that it hangs,
because I see the ethernet link led's getting reset (same behaviour in
normal bootup) and the SCC controller leds getting enabled. (same
behaviour in normal boot up).

The command line passing into the kernel is:
" root=/dev/ram0 init=/linuxrc rw "
I believe PPC boot will pass the ramdisk start and end address along
with the above command line.
I have verified this also by checking the log_buff after I had reset the
board.

00145664: 3c343e72 343a2030 30623565 3030300a    <4>r4: 00b5e000.
00145674: 3c343e54 6f74616c 206d656d 6f727920    <4>Total memory
00145684: 3d203136 4d423b20 7573696e 67203634    = 16MB; using 64
00145694: 6b422066 6f722068 61736820 7461626c    kB for hash tabl
001456a4: 65202861 74206330 31383030 3030290a    e (at c0180000).
001456b4: 3c343e4c 696e7578 20766572 73696f6e    <4>Linux version
001456c4: 20322e34 2e312028 726f6f74 40656d62     2.4.1 (root@emb
001456d4: 65646978 29202867 63632076 65727369    edix) (gcc versi
001456e4: 6f6e2032 2e39352e 33203230 30313033    on 2.95.3 200103
001456f4: 31352028 72656c65 61736529 29202338    15 (release)) #8
00145704: 30205765 64204170 72203233 2031353a    0 Wed Apr 23 15:
00145714: 35393a32 37205554 43203230 30330a3c    59:27 UTC 2003.<
00145724: 343e4f6e 206e6f64 65203020 746f7461    4>On node 0 tota
00145734: 6c706167 65733a20 34303936 0a3c343e    lpages: 4096.<4>
00145744: 7a6f6e65 2830293a 20343039 36207061    zone(0): 4096 pa
00145754: 6765732e 0a3c343e 7a6f6e65 2831293a    ges..<4>zone(1):
00145764: 20302070 61676573 2e0a3c34 3e7a6f6e     0 pages..<4>zon
00145774: 65283229 3a203020 70616765 732e0a3c    e(2): 0 pages..<
00145784: 343e4b65 726e656c 20636f6d 6d616e64    4>Kernel command
00145794: 206c696e 653a202f 6465762f 00000000     line: /dev/....
001457a4: 00000000 00000000 00000000 00000000    ................
001457b4: 00000000 00000000 00000000 00000000    ................
001457c4: 00000000 00000000 00000000 00000000    ................
001457d4: 00000000 00000000 00000000 00000000    ................

The r4 register which points to the ramdisk start is also correct. So
PPC boot is passing the ramdisk parameter properly.
I unable to get any more output from the log_buff.

Also when I tried using a compressed image of the ramdisk, PPC boot
failed to uncompress it.
Can I provide a compressed image of the ramdisk to PPCBoot.?

Is there anything wrong that I am doing in setting up the ramdisk
environment ?

Any pointers or suggestions would be very useful.
Thank you.
Regards,
Sriram N


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

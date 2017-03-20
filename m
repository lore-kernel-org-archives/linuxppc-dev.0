Return-Path: <giu.lippolis@gmail.com>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn89x6YV1zDqbg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 08:25:25 +1100 (AEDT)
Received: by mail-wm0-x230.google.com with SMTP id n11so74882371wma.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 14:25:25 -0700 (PDT)
Received: from Schopenhauer (p5499496B.dip0.t-ipconnect.de. [84.153.73.107])
 by smtp.gmail.com with ESMTPSA id b17sm14931183wma.33.2017.03.20.14.25.21
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Mar 2017 14:25:21 -0700 (PDT)
From: "Giuseppe Lippolis" <giu.lippolis@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Problem with cuImage on 83x
Date: Mon, 20 Mar 2017 22:25:17 +0100
Message-ID: <000001d2a1c0$7938bd00$6baa3700$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear All,
I'm trying, using buildroot, to generate an image for my iomega 150d
(mpc8347 based).
I'm prepared the device tree and configured the platform with:
CONFIG_PPC_83xx=y
CONFIG_MPC834x_MDS=y
CONFIG_MPC834x_ITX=y

The image I'm generating is cuImage.

I generated the image and the system crash after the wrapper call the
kernel.

## Booting image at 01000000 ...
   Image Name:   Linux-4.10.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2988301 Bytes =  2.8 MB
   Load Address: 00600000
   Entry Point:  006001f4
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x20000000> (512MB)
ethernet0: local-mac-address <- 00:d0:b8:01:d1:9f
ethernet1: local-mac-address <- 4b:ff:ff:60:72:6f 
CPU clock-frequency <- 0x179a7b00 (396MHz) 
CPU timebase-frequency <- 0x3ef1480 (66MHz) 
CPU bus-frequency <- 0xfbc5200 (264MHz)

zImage starting: loaded at 0x00600000 (sp: 0x1ffb2cf8) Decompression error:
'Not a gzip file'
No valid compressed data found, assume uncompressed data Allocating 0x5f9250
bytes for kernel...
0x5bd520 bytes of uncompressed data copied

Linux/PowerPC load: root=/dev/mtdblock1 ro rootfstype=cramfs devfs=mount
console=ttySc 
Finalizing device tree... flat tree at 0xbdb960


After some investigation I realize that the system crash very early on the
early_init call:

c000004c:       48 55 f8 71     bl      c055f8bc <early_init>

This call is linked in the .init.text section.
According to the readelf readout:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk
Inf Al
  [15] .init.text        PROGBITS        c055a000 56a000 025ae0 00  AX  0
0  4

And again according to the objdump/readelf readout:

c055a000 <__init_begin>:
c055a000:       ff ef b1 b0     .long 0xffefb1b0

c055a004 <dt_find_string>:
c055a004:       94 21 ff e0     stwu    r1,-32(r1)
c055a008:       7c 08 02 a6     mflr    r0
c055a00c:       42 9f 00 05     bcl     20,4*cr7+so,c055a010
<dt_find_string+0xc>

[...]

c055f8bc <early_init>:
c055f8bc:       94 21 ff f0     stwu    r1,-16(r1)
c055f8c0:       7c 08 02 a6     mflr    r0
c055f8c4:       bf c1 00 08     stmw    r30,8(r1)

Hex dump of section '.init.text':
  0xc055a000 ffefb1b0 9421ffe0 7c0802a6 429f0005 .....!..|...B...
  0xc055a010 bf61000c 7fc802a6 7c7b1b78 90010024 .a......|{.x...$


But If I execute a post-mortem dump on the target memory I get:

0055a000: afafd773 c13b262f 7be3b7ba ff3e75ef    ...s.;&/{....>u.
0055a010: 3e636df5 1d444cb1 9eeafdc9 bdb5eff4    >cm..DL.........

[..]

0055f8b0: ba7a7df9 9ca516fd 16faf9cd 11664eb4    .z}..........fN.
0055f8c0: 08addfb6 db7eae53 29ad963e db5a2fef    .....~.S)..>.Z/.


So It seems that the wrapper is making a mistake during the kernel copy.

I will proceed with the analysis, but before to proceed I would like to ask
if my analysis is correct or I'm wrong somewhere.

Thanks,
Bye.

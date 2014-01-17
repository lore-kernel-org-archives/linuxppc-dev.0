Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3862A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 05:24:44 +1100 (EST)
Received: from christians-pro.lan
 (ppp-93-104-71-144.dynamic.mnet-online.de [93.104.71.144])
 by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
 with (TLSv1:DHE-RSA-AES256-SHA encrypted) ESMTPSA id k037e9q0HIBTqPe
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 17 Jan 2014 19:11:29 +0100 (CET)
Message-ID: <52D97250.5070302@xenosoft.de>
Date: Fri, 17 Jan 2014 19:11:28 +0100
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: PASEMI: Nemo support
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

First, let me introduce myself. My name is Christian Zigotzky. I'm 39 
years old and I live in Germany. My hobbies are traveling and computing. 
I'm a member of the A-EON Core Linux Support Team.

A-EON Technology, in co-operation with Varisys, Hyperion Entertainment 
and AmigaKit created the AmigaONE X1000, a new high-end, prestige 
platform that will once more allow the Amiga Operating System to shine.  
The Nemo motherboard is at the heart of A-EON Technology’s AmigaONE 
X1000 system, the most powerful Next-Generation computer, custom 
designed to specifically run the latest version of the Amiga Operating 
system (AmigaOS 4.1). Built around the unique PA Semi PA6T 1682M, a 
64-bit dual core PowerPC CPU, the Nemo motherboard also supports a lot 
of Linux PowerPC distributions including the a specially configured Live 
Ubuntu Remix 12.04 LTS DVD.

Information about the Nemo board:

CPU: PA Semi Dual-core PA6T-1682M, nominal 2.0GHz (1.8GHz standard) 
PowerISA™ v2.04+
4x DDR2 RAM slots
10x USB 2.0
1x Gigabit Ethernet
2x PCIe x16 slots (1x16 or 2x8)
2x PCIe x1 slots
1x Xorro slot
2x PCI legacy slots
2x RS232
4x SATA 2 connectors
1x IDE connector
JTAG connector
1x Compact Flash
1x "Xena" 500MHz XMOS XS1-L2 124

http://en.wikipedia.org/wiki/AmigaOne_X1000
http://www.a-eon.com/?page=nemo
http://www.supertuxkart-amiga.de/amiga/x1000.html

The Nemo motherboard is currently available. You can buy it from a lot 
of Amiga dealers. It is also possible to get a developer board for free 
of charge.

Current state of the Linux support:

RadeonHD 4000, 5000, 6000 series support: WORKS
HDAudio 7.1 Driver: WORKS
PA Semi Network Driver: WORKS
3D acceleration: WORKS (Mesa 8.0.X - 9.1.X)

Linux distributions: Debian 6 and 7, Ubuntu 10.04.4 LTS and 12.04.3 LTS, 
openSUSE 11.1 and 12.3, Fedora 17, Gentoo, CRUX PPC, Red Ribbon RC6, 
Live Debian USB image, Live MintPPC USB image, and MintPPC 11. Released 
soon: Live Ubuntu Remix DVD. In development: Ubuntu 13.10 and 14.04, 
Debian Sid, and SliTaz.

Linux kernel: 2.6.38, 2.6.39, 3.5.7, 3.8.7, 3.9.0, 3.9.8.1 (openSUSE 
kernel), 3.10.0, 3.10.3 (Ubuntu kernel), 3.10.13, 3.10.15 (Live Ubuntu 
Remix DVD kernel), 3.11.0, 3.12.0, and 3.12.5. In development: 3.13.0.

Mesa 9.2.X and higher: DOESN'T WORK
RadeonHD 7000 series support: WORKS WITHOUT 3D ACCELERATION

We have created a patch to support the A-EON Nemo board. It based on the 
great work of Olof Johansson. Nemo uses the AMD/ATI SB600 South Bridge 
to provide various integrated I/O functions including
SATA/PATA ports, USB and audio. The SB600’s HD Audio controller is 
connected to an IDT 92HD700 codec. This patch makes the kernel 
compatible with the SB600 chipset and the HD Audio chip on the Nemo 
board. It also solved any problems with Radeon HD graphics cards. I'd 
like to integrate this patch to the kernel sources. Olof and Alan told 
me that I have to split up the big patch into separate patches.

OK, here is the first part.

diff -rupN linux-3.13/arch/powerpc/platforms/pasemi/Kconfig 
linux-3.13-nemo/arch/powerpc/platforms/pasemi/Kconfig
--- linux-3.13/arch/powerpc/platforms/pasemi/Kconfig    2013-12-06 
18:34:04.000000000 +0100
+++ linux-3.13-nemo/arch/powerpc/platforms/pasemi/Kconfig 2013-12-14 
10:31:19.896353725 +0100
@@ -14,6 +14,13 @@ config PPC_PASEMI
  menu "PA Semi PWRficient options"
      depends on PPC_PASEMI

+config PPC_PASEMI_SB600
+       bool "Nemo SB600 South Bridge Support"
+       depends on PPC_PASEMI
+       select PPC_I8259
+       help
+       Workarounds for the SB600 South Bridge.
+
  config PPC_PASEMI_IOMMU
      bool "PA Semi IOMMU support"
      depends on PPC_PASEMI

Is it possible to integrate the support of the Nemo board to the 
official kernel sources? Thanks a lot to this list for the help to solve 
the boot problems with the kernel 3.13. Sorry, my English isn't very 
well. I hope you understand my email. But I'll learn more English. I 
promise it gets better.

Rgds,
Christian

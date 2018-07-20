Return-Path: <noring@nocrew.org>
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X4Hf3XnNzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 18:46:37 +1000 (AEST)
Date: Fri, 20 Jul 2018 10:46:17 +0200
From: Fredrik Noring <noring@nocrew.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geoff Levand <geoff@infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Improvements for the PS3
Message-ID: <20180720084617.GF8962@localhost.localdomain>
References: <20180714164906.GQ23412@localhost.localdomain>
 <7d6362d7-da99-e57f-40ed-81c7a03ea1a4@infradead.org>
 <CAMuHMdX3xiRYYdhQftHRDYFqob7xMHm-xxvh3NyoC1TowH4x8g@mail.gmail.com>
 <20180719201415.GE8962@localhost.localdomain>
 <CAMuHMdXcbzDi07_AXUzwnzw39DYeoHpORk2aSn9W+jmBKeShOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMuHMdXcbzDi07_AXUzwnzw39DYeoHpORk2aSn9W+jmBKeShOg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geert,

> > That would not work with kernel freezes unfortunately. Debugging those with
> > nondeterministicly invisible kernel prints would be painful, I believe.
> 
> Unfortunately AFAIK the PS3 doesn't have any other "synchronous" output we
> can use for debugging (like flashing the power LED).

Well, one can use lv1_panic to bisect the PowerPC boot process. It either
freezes, in which case the call to lv1_panic isn't reached, or it reboots.
This method yields 1 bit of information for every reflash and reboot, with
a procedure taking about 5 minutes per turn, so 12 bits/hour sustained. ;)

The prime advantage is that lv1_panic works everywhere, including the
earliest boot stages.

I've since learned about the PS3GELIC_UDBG option to broadcast UDP via the
Ethernet port, but I don't know how well it works or its limitations.

One useful option for debugging is to setup a very early graphical console,
more or less from head.S, before any kernel functions are invoked. I have a
simple proof of concept implemented for the PS2 here:

https://github.com/frno7/linux/blob/ps2-v4.17-n3/arch/mips/boot/compressed/dbg.c

This could be done for the PS3 as well. The OtherOS demo

http://mc.pp.se/ps3/oodemo.xhtml

by Marcus Comstedt in 2007 contains the essentials with MMU and hypervisor
initialisation for graphics. I discovered that a small patch is required to
make his demo work with modern GCC:

--- a/source/script.lds
+++ b/source/script.lds
@@ -50,6 +50,7 @@ SECTIONS
  .opd : {
       *(.opd)
       }
+ . = ALIGN(256);
  .got : {
       __toc_start = .;
       *(.got)

Fredrik

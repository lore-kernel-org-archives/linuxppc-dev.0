Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com
 [IPv6:2a00:1450:4010:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EDDF1A0429
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 19:42:23 +1100 (AEDT)
Received: by mail-la0-f45.google.com with SMTP id gq15so3627143lab.32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 00:42:18 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1419237118-9712-1-git-send-email-geert@linux-m68k.org>
References: <1419237118-9712-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 22 Dec 2014 09:42:18 +0100
Message-ID: <CAMuHMdU0ym7PLkEcdmDnxvDVBn879QWkOm=-zUXFaQMh2FHfrQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.19-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Miao Steven <realmz6@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, Cris <linux-cris-kernel@axis.com>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 22, 2014 at 9:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v3.19-rc1[1] compared to v3.18[2].
>
> Summarized:
>   - build errors: +24/-16

  + /home/kisskb/slave/src/arch/powerpc/xmon/xmon.c: error: unused
variable 'badaddr' [-Werror=unused-variable]:  => 1185:13
  + /home/kisskb/slave/src/arch/powerpc/xmon/xmon.c: error: unused
variable 'mode' [-Werror=unused-variable]:  => 1183:6

powerpc-randconfig

  + /home/kisskb/slave/src/arch/sh/boards/mach-se/7343/irq.c: error:
too few arguments to function 'ioread16':  => 44:2
  + /home/kisskb/slave/src/arch/sh/boards/mach-se/7343/irq.c: error:
too few arguments to function 'iowrite16':  => 123:2

sh4/se7343_defconfig

  + /home/kisskb/slave/src/arch/sh/boards/mach-se/7722/irq.c: error:
too few arguments to function 'ioread16':  => 43:2
  + /home/kisskb/slave/src/arch/sh/boards/mach-se/7722/irq.c: error:
too few arguments to function 'iowrite16':  => 116:2

sh4/se7722_defconfig

  + /home/kisskb/slave/src/drivers/usb/musb/blackfin.c: error:
'bfin_writel' undeclared here (not in a function):  => 476:13

bfin/BF527-EZKIT-V2_defconfig

  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_BABBLE_CTL' undeclared here (not in a function):  => 67:17
  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_CONFIGDATA' undeclared here (not in a function):  => 62:18
  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_EPINFO' undeclared here (not in a function):  => 74:14
  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_RAMINFO' undeclared here (not in a function):  => 75:15
  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_RXFIFOADD' undeclared here (not in a function):  => 71:17
  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_RXFIFOSZ' undeclared here (not in a function):  => 69:16
  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_TXFIFOADD' undeclared here (not in a function):  => 70:17
  + /home/kisskb/slave/src/drivers/usb/musb/musb_debugfs.c: error:
'MUSB_TXFIFOSZ' undeclared here (not in a function):  => 68:16

bfin/BF527-EZKIT_defconfig
bfin/BF527-EZKIT-V2_defconfig
bfin/BF548-EZKIT_defconfig
bfin/CM-BF548_defconfig
bfin/CM-BF527_defconfig

  + /home/kisskb/slave/src/include/linux/irq.h: error: conflicting
types for 'ioread16':  => 856:19
  + /home/kisskb/slave/src/include/linux/irq.h: error: conflicting
types for 'iowrite16':  => 847:20

sh4/se7343_defconfig
sh4/se7722_defconfig

  + error: "csum_partial_copy_nocheck" [net/ipv6/ipv6.ko] undefined!:  => N/A

cris/cris-allmodconfig

  + error: No rule to make target include/config/auto.conf:  => N/A

arm/arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8241/ (262 out of 262 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/8168/ (262 out of 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

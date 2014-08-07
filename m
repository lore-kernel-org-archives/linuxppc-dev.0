Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x22e.google.com (mail-lb0-x22e.google.com
 [IPv6:2a00:1450:4010:c04::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A7AF1A0A2B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 07:36:16 +1000 (EST)
Received: by mail-lb0-f174.google.com with SMTP id c11so3222735lbj.33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Aug 2014 14:36:10 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
Date: Thu, 7 Aug 2014 23:36:10 +0200
Message-ID: <CAMuHMdVZmJR=Cu1Wvpyx+KqgdKRRtnAO94k4imXChUwfC_GPTw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] defconfigs: add MTD_SPI_NOR (new subsystem
 dependency for M25P80)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Lunn <andrew@lunn.ch>, Stephen Warren <swarren@wwwdotorg.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 MTD Maling List <linux-mtd@lists.infradead.org>, Marek Vasut <marex@denx.de>,
 Russell King <linux@arm.linux.org.uk>,
 Linux-sh list <linux-sh@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Roland Stigge <stigge@antcom.de>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, Steven Miao <realmz6@gmail.com>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, Simon Horman <horms@verge.net.au>,
 linux-tegra@vger.kernel.org, Andrew Victor <linux@maxim.org.za>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Huang Shijie <b32955@freescale.com>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>,
 Sascha Hauer <kernel@pengutronix.de>, Olof Johansson <olof@lixom.net>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Brian,

On Thu, May 1, 2014 at 8:26 AM, Brian Norris
<computersforpeace@gmail.com> wrote:
> v1 --> v2: split ARM defconfig changes into their sub-architectures. No change
>            in the overall diff.
>
> Hi all,
>
> We are introducing a new SPI-NOR subsystem/framework for MTD, to support
> various types of SPI-NOR flash controllers which require (or benefit from)
> intimate knowledge of the flash interface, rather than just the relatively dumb
> SPI interface. This framework borrows much of the m25p80 driver for its
> abstraction and moves this code into a spi-nor module.
>
> This means CONFIG_M25P80 now has a dependency on CONFIG_MTD_SPI_NOR, which
> should be added to the defconfigs. I expect that each (sub)architecture
> maintainer can merge these patches to their own tree.
>
> Note that without the new CONFIG_MTD_SPI_NOR symbol in your defconfig, Kconfig
> will automatically drop M25P80 for you.
>
> Please keep general comments to the cover letter, so all parties can see.
>
> This series is based on 3.15-rc1.
>
> The SPI-NOR development code (in -next, queued for 3.16) is here:
>
>   git://git.infradead.org/l2-mtd.git +spinor
>
> This defconfig series is available in the same repo at:
>
>   git://git.infradead.org/l2-mtd.git +defconfigs
>
> Thanks,
> Brian
>
> Brian Norris (12):
>   ARM: imx/mxs defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: keystone: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: tegra: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: lpc32xx: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: at91: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: shmobile: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: marvell: add MTD_SPI_NOR (new dependency for M25P80)
>   blackfin: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   mips: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   powerpc: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   sh: defconfig: add MTD_SPI_NOR (new dependency for M25P80)
>
>  arch/arm/configs/bockw_defconfig               | 2 +-
>  arch/arm/configs/dove_defconfig                | 2 +-
>  arch/arm/configs/imx_v6_v7_defconfig           | 1 +
>  arch/arm/configs/keystone_defconfig            | 1 +
>  arch/arm/configs/kirkwood_defconfig            | 1 +
>  arch/arm/configs/koelsch_defconfig             | 1 +
>  arch/arm/configs/lager_defconfig               | 1 +
>  arch/arm/configs/lpc32xx_defconfig             | 2 +-
>  arch/arm/configs/multi_v5_defconfig            | 1 +
>  arch/arm/configs/multi_v7_defconfig            | 1 +
>  arch/arm/configs/mvebu_v5_defconfig            | 1 +
>  arch/arm/configs/mvebu_v7_defconfig            | 1 +
>  arch/arm/configs/mxs_defconfig                 | 1 +
>  arch/arm/configs/sama5_defconfig               | 2 +-
>  arch/arm/configs/shmobile_defconfig            | 1 +
>  arch/arm/configs/tegra_defconfig               | 1 +
>  arch/blackfin/configs/BF526-EZBRD_defconfig    | 2 +-
>  arch/blackfin/configs/BF527-EZKIT-V2_defconfig | 2 +-
>  arch/blackfin/configs/BF527-EZKIT_defconfig    | 2 +-
>  arch/blackfin/configs/BF548-EZKIT_defconfig    | 2 +-
>  arch/blackfin/configs/BF609-EZKIT_defconfig    | 2 +-
>  arch/blackfin/configs/BlackStamp_defconfig     | 3 +--
>  arch/blackfin/configs/H8606_defconfig          | 3 +--
>  arch/mips/configs/ath79_defconfig              | 3 +--
>  arch/mips/configs/db1xxx_defconfig             | 1 +
>  arch/mips/configs/rt305x_defconfig             | 2 +-
>  arch/powerpc/configs/corenet32_smp_defconfig   | 2 +-
>  arch/powerpc/configs/corenet64_smp_defconfig   | 2 +-
>  arch/powerpc/configs/mpc85xx_defconfig         | 2 +-
>  arch/powerpc/configs/mpc85xx_smp_defconfig     | 2 +-
>  arch/sh/configs/sh7757lcr_defconfig            | 2 +-
>  31 files changed, 31 insertions(+), 21 deletions(-)

FWIW, this change still hasn't propagated to the following defconfigs:

arch/arm/configs/axm55xx_defconfig
arch/arm/configs/bockw_defconfig
arch/arm/configs/koelsch_defconfig
arch/arm/configs/lager_defconfig
arch/arm/configs/lpc32xx_defconfig
arch/arm/configs/multi_v5_defconfig
arch/arm/configs/multi_v7_defconfig
arch/arm/configs/qcom_defconfig
arch/arm/configs/sama5_defconfig
arch/arm/configs/shmobile_defconfig
arch/powerpc/configs/85xx/kmp204x_defconfig
arch/powerpc/configs/corenet32_smp_defconfig
arch/powerpc/configs/corenet64_smp_defconfig
arch/powerpc/configs/mpc85xx_defconfig
arch/powerpc/configs/mpc85xx_smp_defconfig
arch/sh/configs/sh7757lcr_defconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

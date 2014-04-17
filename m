Return-Path: <marex@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5EE69140099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 21:30:26 +1000 (EST)
From: Marek Vasut <marex@denx.de>
To: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Date: Thu, 17 Apr 2014 13:07:44 +0200
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201404171307.44214.marex@denx.de>
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-sh@vger.kernel.org,
 Steven Miao <realmz6@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Sascha Hauer <kernel@pengutronix.de>, Olof Johansson <olof@lixom.net>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Shawn Guo <shawn.guo@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, April 17, 2014 at 09:21:44 AM, Brian Norris wrote:
> Hi all,
> 
> We are introducing a new SPI-NOR library/framework for MTD, to support
> various types of SPI-NOR flash controllers which require (or benefit from)
> intimate knowledge of the flash interface, rather than just the relatively
> dumb SPI interface. This library borrows much of the m25p80 driver for its
> abstraction and moves this code into a spi-nor module.
> 
> This means CONFIG_M25P80 now has a dependency on CONFIG_MTD_SPI_NOR, which
> should be added to the defconfigs. I'm not sure what is the best process
> for doing this. Should each $ARCH maintainer just take their respective
> patch, even if the MTD_SPI_NOR Kconfig symbol is not defined for them yet?
> Or should maintainers plan on merging the relevant SPI-NOR code into their
> trees during the development cycle? Or some third option?

Shouldn't the M25P80 driver just "select" the SPI NOR framework? Then you won't 
need the adjustment to defconfigs at all I think.

Best regards,
Marek Vasut

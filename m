Return-Path: <marex@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EFBC1400D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 11:25:29 +1000 (EST)
From: Marek Vasut <marex@denx.de>
To: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Date: Mon, 21 Apr 2014 16:52:39 +0200
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <20140417105302.GA32603@ulmo> <20140418063054.GK5512@norris-Latitude-E6410>
In-Reply-To: <20140418063054.GK5512@norris-Latitude-E6410>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201404211652.39704.marex@denx.de>
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

On Friday, April 18, 2014 at 08:30:54 AM, Brian Norris wrote:
> Hi,
> 
> On Thu, Apr 17, 2014 at 12:53:03PM +0200, Thierry Reding wrote:
> > On Thu, Apr 17, 2014 at 12:21:44AM -0700, Brian Norris wrote:
> > > We are introducing a new SPI-NOR library/framework for MTD, to support
> > > various types of SPI-NOR flash controllers which require (or benefit
> > > from) intimate knowledge of the flash interface, rather than just the
> > > relatively dumb SPI interface. This library borrows much of the m25p80
> > > driver for its abstraction and moves this code into a spi-nor module.
> > 
> > If this is a common library, then the more common approach to solve this
> > would be to have each driver that uses it to select MTD_SPI_NOR rather
> > than depend on it. That way you can drop this whole series to update the
> > default configurations.
> 
> But does MTD_SPI_NOR (and drivers/mtd/spi-nor/) qualify as a "library"
> or as a "subsystem"? I thought the latter were typically expected to be
> user-selectable options, not automatically-"select"ed.

I agree the "subsystem" is user-selectable while the "library" is to be 
'select'ed .

> I would say that, except for its age, MTD_SPI_NOR is very similar in to
> MTD_NAND (driver/mtd/nand/), which I'd consider a kind of subsystem, and
> which users must select before they are asked about drivers which fall
> under its category.
> 
> Perhaps my usage of the word "library" in the description was a mistake,
> as I don't exactly consider it like a library in the sense of many other
> "select"ed libraries.

It did look like a library to me at first, but it's rather a subsystem that 
contains a small library in it. Thus, I retract my previous comment about using 
'select' and add :

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut

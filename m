Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x233.google.com (mail-la0-x233.google.com
 [IPv6:2a00:1450:4010:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 056B1140094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 00:16:16 +1000 (EST)
Received: by mail-la0-f51.google.com with SMTP id gf5so848163lab.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 07:16:11 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v13 0/5] MPC512x DMA slave s/g support, OF DMA lookup
Date: Thu, 15 May 2014 18:15:30 +0400
Message-Id: <1400163335-29853-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/7/14 Gerhard Sittig <gsi@denx.de>:
> this series
> - introduces slave s/g support (that's support for DMA transfers which
>    involve peripherals in contrast to mem-to-mem transfers)
> - adds device tree based lookup support for DMA channels
> - combines floating patches and related feedback which already covered
>    several aspects of what the suggested LPB driver needs, to demonstrate
>    how integration might be done

...

Changes in v12:
 A new patch (part 2/7) is added to this series.
 Part 6/7:
 - change the description of 'compatible' property according part 2/7;
 - improve the document according Gerhard's feedback;

Parts 1/7, 2/7 and 4/7 have been applied by Vinod Koul and
are excluded from v13.

Changes in v13:
 A new patch (part 1/5) is added to this series.
 Part 2/5:
 - fix style issue;
 - improve comments;

> known issues:
> - it's yet to get confirmed whether MPC8308 can use slave support or
>    whether the DMA controller's driver shall actively reject it, the
>    information that's available so far suggests that peripheral transfers
>    to IP bus attached I/O is useful and shall not get blocked right away


Alexander Popov (5):
  dmaengine: fix comment typo
  dma: mpc512x: add support for peripheral transfers
  dma: of: add common xlate function for matching by channel id
  dma: mpc512x: add device tree binding document
  dma: mpc512x: register for device tree channel lookup

 .../devicetree/bindings/dma/mpc512x-dma.txt        |  40 ++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |   1 +
 drivers/dma/mpc512x_dma.c                          | 257 ++++++++++++++++++++-
 drivers/dma/of-dma.c                               |  35 +++
 include/linux/dmaengine.h                          |   2 +-
 include/linux/of_dma.h                             |   4 +
 6 files changed, 332 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

-- 
1.8.4.2

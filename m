Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com
 [IPv6:2a00:1450:400c:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D1C0F14009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 21:59:36 +1100 (EST)
Received: by mail-we0-f169.google.com with SMTP id w62so1662915wes.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Apr 2014 03:59:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
Date: Thu, 3 Apr 2014 14:59:31 +0400
Message-ID: <CAF0T0X5hAp8R3Pg5b+JaCH0r2JedjaFXCFqwb=CAXuXjvUyEhQ@mail.gmail.com>
Subject: Re: [PATCH RFC v10 0/6] MPC512x DMA slave s/g support, OF DMA lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

2014-03-20 18:47 GMT+04:00 Alexander Popov <a13xp0p0v88@gmail.com>:
> Changes in v10:
>  Part 2/6:
>  - don't use direction field of dma_slave_config in mpc_dma_device_control()
>     but store settings in mpc_dma_chan for both DMA_DEV_TO_MEM and
>     DMA_MEM_TO_DEV cases; then retrieve the needed values in
>     mpc_dma_prep_slave_sg();
>  - fix style issue and put 2014 instead of 2013;
>  Part 3/6:
>  - fix mpc_dma_probe() error path and mpc_dma_remove(): manually free IRQs and
>     dispose IRQ mappings before devm_* takes care of other resources;
>  Part 6/6:
>  - change according the new part 3/6;
>  - fix style issue;

Excuse me, could I have a feedback?
Thanks!

> Alexander Popov (5):
>   dma: mpc512x: reorder mpc8308 specific instructions
>   dma: mpc512x: add support for peripheral transfers
>   dma: mpc512x: fix freeing resources in mpc_dma_probe() and
>     mpc_dma_remove()
>   dma: of: Add common xlate function for matching by channel id
>   dma: mpc512x: register for device tree channel lookup
>
> Gerhard Sittig (1):
>   dma: mpc512x: add device tree binding document
>
>  .../devicetree/bindings/dma/mpc512x-dma.txt        |  55 ++++
>  arch/powerpc/boot/dts/mpc5121.dtsi                 |   1 +
>  drivers/dma/mpc512x_dma.c                          | 345 ++++++++++++++++++---
>  drivers/dma/of-dma.c                               |  35 +++
>  include/linux/of_dma.h                             |   4 +
>  5 files changed, 402 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>
> --
> 1.8.4.2

Best regards,
Alexander

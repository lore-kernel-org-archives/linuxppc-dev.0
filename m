Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0HHd1YbXzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 22:22:53 +1000 (AEST)
Received: by mail-oi0-x232.google.com with SMTP id x19so62542115oix.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 05:22:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Date: Wed, 4 May 2016 15:22:51 +0300
Message-ID: <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 26, 2016 at 12:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The last approach in the commit 8b3444852a2b ("sata_dwc_460ex: move to ge=
neric
> DMA driver") to switch to generic DMA engine API wasn't tested on bare me=
tal.
> Besides that we expecting new board support coming with the same SATA IP =
but
> with different DMA.
>
> This series is targetting the following things:
> - a few bug fixes to the original driver
> - a part to fix the DMA engine usage and in particularly dw_dmac driver
> - move driver to use generic PHY and "dmas" property which leads to updat=
e in DTS
>
> The driver has been tested myself on Sam460ex and WD MyBookLive (apollo3g=
)
> boards. In any case I ask Christian, M=C3=A5ns, and Julian to independent=
ly test and
> provide Tested-by tag or an error report.
>
> Series depends on previously published but not yet fully applied series [=
1].
>
> The patches are also available via public branch [2].
>
> [1] http://www.spinics.net/lists/dmaengine/msg09250.html
> [2] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fsata
>

Tejun, since Vinod applied all necessary patches into his tree, the
series now has just a dependency to whatever branch / tag he marks for
it.
Do we have a chance to see the SATA series be applied in your tree?

> Since v1:
> - simplify patch 8 (David Laight)
> - add Tested-by and Acked-by tags
>
> Andy Shevchenko (11):
>   ata: sata_dwc_460ex: set dma_boundary to 0x1fff
>   ata: sata_dwc_460ex: burst size must be in items not bytes
>   ata: sata_dwc_460ex: DMA is always a flow controller
>   ata: sata_dwc_460ex: select only core part of DMA driver
>   ata: sata_dwc_460ex: don't call ata_sff_qc_issue() on DMA commands
>   ata: sata_dwc_460ex: correct HOSTDEV{P}_FROM_*() macros
>   ata: sata_dwc_460ex: supply physical address of FIFO to DMA
>   ata: sata_dwc_460ex: switch to new dmaengine_terminate_* API
>   ata: sata_dwc_460ex: use devm_ioremap
>   ata: sata_dwc_460ex: make debug messages neat
>   powerpc/4xx: Device tree update for the 460ex DWC SATA
>
> Christian Lamparter (1):
>   ata: sata_dwc_460ex: fix crash on offline links without an attached
>     drive
>
> Mans Rullgard (11):
>   ata: sata_dwc_460ex: remove incorrect locking
>   ata: sata_dwc_460ex: skip dma setup for non-dma commands
>   ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
>   ata: sata_dwc_460ex: add phy support
>   ata: sata_dwc_460ex: get rid of global data
>   ata: sata_dwc_460ex: remove empty libata callback
>   ata: sata_dwc_460ex: get rid of some pointless casts
>   ata: sata_dwc_460ex: get rid of incorrect cast
>   ata: sata_dwc_460ex: add __iomem to register base pointer
>   ata: sata_dwc_460ex: use readl/writel_relaxed()
>   ata: sata_dwc_460ex: tidy up sata_dwc_clear_dmacr()
>
>  arch/powerpc/boot/dts/canyonlands.dts |  15 +-
>  drivers/ata/Kconfig                   |  12 +-
>  drivers/ata/sata_dwc_460ex.c          | 552 +++++++++++++++++-----------=
------
>  3 files changed, 305 insertions(+), 274 deletions(-)
>
> --
> 2.8.0.rc3
>



--=20
With Best Regards,
Andy Shevchenko

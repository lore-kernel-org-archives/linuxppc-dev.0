Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKqJh4ngszDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 11:24:36 +1000 (AEST)
Message-ID: <1464830660.22191.6.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>,
 Mark Rutland <mark.rutland@arm.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Qiang Zhao
 <qiang.zhao@nxp.com>, Russell King <linux@arm.linux.org.uk>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>,  Joerg Roedel <joro@8bytes.org>, Claudiu
 Manoil <claudiu.manoil@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kumar Gala <galak@codeaurora.org>,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 01 Jun 2016 20:24:20 -0500
In-Reply-To: <5513501.AmZs7h1vI2@wuerfel>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <HE1PR04MB0889852B7809A1CCFF8922ACF8410@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <CAPDyKFqx2JMLzXoDxGCKFYMFV47+SegnkuWFXKvsQHK7L5w-1g@mail.gmail.com>
 <5513501.AmZs7h1vI2@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 4/4] Revert "powerpc/fsl: Move fsl_guts.h out of
 arch/powerpc"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-30 at 15:18 +0200, Arnd Bergmann wrote:
> All users of this driver are PowerPC specific and the header file
> has no business in the global include/linux/ hierarchy, so move
> it back before anyone starts using it on ARM.
> 
> This reverts commit 948486544713492f00ac8a9572909101ea892cb0.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This part of the series is not required for the eSDHC quirk,
> but it restores the asm/fsl_guts.h header so it doesn't accidentally
> get abused for this in the future. I found two drivers outside of
> arch/powerpc that already accessed the registers directly, but the
> functions look fairly contained, and can be easily hidden in an
> #ifdef CONFIG_PPC

NACK

Besides adding ifdef pollution for no good reason, this register block is used
on some ARM chips as well.  Why is it a problem if "anyone starts using it on
ARM"?

BTW, of all the mailing lists you included on this CC, you seem to have left
off the PPC list (I've added it).

-Scott

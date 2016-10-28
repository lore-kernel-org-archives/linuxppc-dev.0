Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t50yT5CvgzDvR0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 21:54:57 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, Scott Wood <oss@buserror.net>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org,
 Qiang Zhao <qiang.zhao@nxp.com>, Russell King <linux@arm.linux.org.uk>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>, Joerg Roedel <joro@8bytes.org>,
 Jochen Friedrich <jochen@scram.de>,
 Claudiu Manoil <claudiu.manoil@freescale.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Leo Li <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v15, 0/7] Fix eSDHC host version register bug
Date: Fri, 28 Oct 2016 12:53:56 +0200
Message-ID: <3386858.dvuMhvkN3m@wuerfel>
In-Reply-To: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, October 28, 2016 2:50:11 PM CEST Yangbo Lu wrote:
> This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
> eSDHC controller. To match the SoC version and revision, 10 previous version
> patchsets had tried many methods but all of them were rejected by reviewers.
> Such as
>         - dts compatible method
>         - syscon method
>         - ifdef PPC method
>         - GUTS driver getting SVR method
> Anrd suggested a soc_device_match method in v10, and this is the only available
> method left now. This v11 patchset introduces the soc_device_match interface in
> soc driver.
> 
> The first five patches of Yangbo are to add the GUTS driver. This is used to
> register a soc device which contain soc version and revision information.
> The other two patches introduce the soc_device_match method in soc driver
> and apply it on esdhc driver to fix this bug.
> 

Looks good overall. With patch 3 dropped (or an explanation why it's still
needed), everything

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd

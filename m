Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t50yP2X77zDvZ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 21:54:52 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, Scott Wood <oss@buserror.net>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org,
 Qiang Zhao <qiang.zhao@nxp.com>, Russell King <linux@arm.linux.org.uk>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Li <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Kumar Gala <galak@codeaurora.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [v15, 6/7] base: soc: introduce soc_device_match() interface
Date: Fri, 28 Oct 2016 12:47:54 +0200
Message-ID: <2572890.e6aV4hmMEL@wuerfel>
In-Reply-To: <1477637418-38938-7-git-send-email-yangbo.lu@nxp.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <1477637418-38938-7-git-send-email-yangbo.lu@nxp.com>
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

On Friday, October 28, 2016 2:50:17 PM CEST Yangbo Lu wrote:
> +
> +static int soc_device_match_one(struct device *dev, void *arg)
> +{
> +       struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> +       const struct soc_device_attribute *match = arg;
> +
> +       if (match->machine &&
> +           !glob_match(match->machine, soc_dev->attr->machine))
> +               return 0;
> +
> +       if (match->family &&
> +           !glob_match(match->family, soc_dev->attr->family))
> +               return 0;
> +
> 

Geert found a bug in my code, and submitted a fix at
https://patchwork.kernel.org/patch/9361395/

I think you should include that one in your series.

	Arnd

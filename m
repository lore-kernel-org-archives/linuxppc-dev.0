Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by ozlabs.org (Postfix) with ESMTP id 3EA8F2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 13:03:30 +1000 (EST)
Date: Tue, 18 Sep 2012 23:03:24 -0400
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 5/7] ASoC: fsl: convert pcm030-audio-fabric to a
 platform-driver
Message-ID: <20120919030324.GO8832@opensource.wolfsonmicro.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2012 at 05:43:14PM -0400, Eric Millbrandt wrote:

> +static int __devexit pcm030_fabric_remove(struct platform_device *op)
> +{
> +	struct platform_device *pdev = platform_get_drvdata(op);
> +
> +	platform_device_unregister(pdev);
> +
> +	return 0;
> +}

This seems really confused...  why is a platform device registering
another platform device?  Do you mean to convert to
snd_soc_register_card()?

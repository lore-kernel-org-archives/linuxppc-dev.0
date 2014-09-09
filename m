Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73B851A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 04:38:21 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id ey11so7613179pad.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 11:38:19 -0700 (PDT)
Date: Tue, 9 Sep 2014 11:38:05 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140909183804.GA6944@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz, broonie@kernel.org,
 mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:
> @@ -1321,7 +1333,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
> +	if (ssi_private->soc->imx)
> +		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
> +			"ipg", iomem, &fsl_ssi_regconfig);
> +	else
> +		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,

As Markus mentioned, the key point here is to be compatible with those
non-clock-name platforms.

I think it would be safer to keep the current code while adding an extra
clk_disable_unprepare() at the end of probe() as a common routine. And
meantime, make sure to have the call for imx only because it seems that
the other platforms do not depend on the clock. //a bit guessing here :)

Then we can get a patch like:
open() {
+	clk_prepare_enable();
	....
}

close() {
	....
+	clk_disable_unprepare()
}

probe() {
	clk_get();
	clk_prepare_enable();
	....
	if (xxx)
-		goto err_xx;
+		return ret;
	....
+	clk_disable_unprepare();
	return 0;
-err_xx:
-	clk_disable_unprepare()
}

remove() {
	....
-	clk_disable_unprepare()
}

As long as you make the subject clear as 'Don't enable core/ipg clock
when SSI's idle', I'm sure you can make them within a single patch.

And an alternative way for open() and close() is to put those code into
pm_runtime_resume/suspend() instead (since we might have some internal
code need to be added by using pm_runtime as well), which would make
the further code neater IMO.

Thank you
Nicolin

Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 8FF4F140083
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 03:01:11 +1100 (EST)
Message-ID: <5331A6BA.9030507@tabi.org>
Date: Tue, 25 Mar 2014 10:54:34 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [PATCH] video/fsl: Fix the sleep function for FSL DIU module
References: <1395734180-45012-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1395734180-45012-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: scottwood@freescale.com, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2014 02:56 AM, Dongsheng Wang wrote:
> From: Jason Jin <Jason.Jin@freescale.com>
>
> For deep sleep, the diu module will power off, when wake up
> from the deep sleep, the registers need to be reinitialized.
>
> Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index e8758b9..7ec780c 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1628,9 +1628,18 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
>   static int fsl_diu_resume(struct platform_device *ofdev)
>   {
>   	struct fsl_diu_data *data;
> +	struct mfb_info *mfbi;

You don't need this, if ...

> +	int i;
>
>   	data = dev_get_drvdata(&ofdev->dev);
> -	enable_lcdc(data->fsl_diu_info);
> +	fsl_diu_enable_interrupts(data);
> +	update_lcdc(data->fsl_diu_info);
> +
> +	for (i = 0; i < NUM_AOIS; i++) {
> +		mfbi = &data->mfb[i];
> +		if (mfbi->count)

... you do this:

		if (data->mfb[i].count)

Also, 'i' should be an 'unsigned int'.

> +			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
> +	}
>
>   	return 0;
>   }
>

Other than that, this seems okay.

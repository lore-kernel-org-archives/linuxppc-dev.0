Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id E752A140081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 05:50:18 +1100 (EST)
Message-ID: <53332168.5050805@tabi.org>
Date: Wed, 26 Mar 2014 13:50:16 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Jason Jin <Jason.Jin@freescale.com>
Subject: Re: [PATCH 2/2] video/fsl: Fix the sleep function for FSL DIU module
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
In-Reply-To: <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: b07421@freescale.com, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, r58472@freescale.com,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2014 12:41 PM, Jason Jin wrote:
> +	if (!diu_ops.set_pixel_clock) {
> +		data->saved_pixel_clock = 0;
> +		if (of_address_to_resource(ofdev->dev.of_node, 1, &res))
> +			pr_err(KERN_ERR "No pixel clock set func and no pixel node!\n");
> +		else {
> +			data->pixelclk_ptr =
> +				devm_ioremap(&ofdev->dev, res.start, resource_size(&res));
> +			if (!data->pixelclk_ptr) {
> +				pr_err(KERN_ERR "fslfb: could not map pixelclk register!\n");
> +				ret = -ENOMEM;
> +			} else
> +				data->saved_pixel_clock = in_be32(data->pixelclk_ptr);
> +		}
> +	}

This seems very hackish.  What node does ofdev point to?  I wonder if 
this code should be in the platform file instead.

Also, use dev_info() instead of pr_err, and never use exclamation marks 
in driver messages.

Return-Path: <groeck7@gmail.com>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F7cf2hcdzDrcN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:24:50 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id f1-v6so1250739plt.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 09:24:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 18 Sep 2018 09:24:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Radu Rendec <radu.rendec@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] watchdog: mpc8xxx: provide boot status
Message-ID: <20180918162446.GE28152@roeck-us.net>
References: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
 <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2018 at 06:22:50AM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver supports the following platforms:
> - mpc8xx
> - mpc83xx
> - mpc86xx
> 
> Those three platforms have a 32 bits register which provides the
> reason of the last boot, including whether it was caused by the
> watchdog.
> 
> mpc8xx: Register RSR, bit SWRS (bit 3)
> mpc83xx: Register RSR, bit SWRS (bit 28)
> mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)
> 
> This patch maps the register as defined in the device tree and updates
> wdt.bootstatus based on the value of the watchdog related bit. Then
> the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.
> 
> Hereunder is an example of devicetree for mpc8xx,
> the Reset Status Register being at offset 0x288:
> 
> 		WDT: watchdog@0 {
> 			compatible = "fsl,mpc823-wdt";
> 			reg = <0x0 0x10 0x288 0x4>;
> 		};
> 
> On the mpc83xx, RSR is at offset 0x910
> On the mpc86xx, RSTRSCR is at offset 0xe0094
> 
> Suggested-by: Radu Rendec <radu.rendec@gmail.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

I am ok with the patch, though I would really appreciate change logs
in the future. Consider this an informal Reviewed-by:.
Waiting for DT review before final approval.

Guenter

>  drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 1dcf5f10cdd9..069072e6747d 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
>  struct mpc8xxx_wdt_type {
>  	int prescaler;
>  	bool hw_enabled;
> +	u32 rsr_mask;
>  };
>  
>  struct mpc8xxx_wdt_ddata {
> @@ -159,6 +160,24 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  		return -ENODEV;
>  	}
>  
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		bool status;
> +		u32 __iomem *rsr = ioremap(res->start, resource_size(res));
> +
> +		if (!rsr)
> +			return -ENOMEM;
> +
> +		status = in_be32(rsr) & wdt_type->rsr_mask;
> +		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
> +		 /* clear reset status bits related to watchdog timer */
> +		out_be32(rsr, wdt_type->rsr_mask);
> +		iounmap(rsr);
> +
> +		dev_info(dev, "Last boot was %scaused by watchdog\n",
> +			 status ? "" : "not ");
> +	}
> +
>  	spin_lock_init(&ddata->lock);
>  
>  	ddata->wdd.info = &mpc8xxx_wdt_info,
> @@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.compatible = "mpc83xx_wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
> +			.rsr_mask = BIT(3), /* RSR Bit SWRS */
>  		},
>  	},
>  	{
> @@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
>  		},
>  	},
>  	{
> @@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x800,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(28), /* RSR Bit SWRS */
>  		},
>  	},
>  	{},
> -- 
> 2.13.3
> 

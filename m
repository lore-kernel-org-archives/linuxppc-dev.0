Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DCCB1A0C98
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 05:38:26 +1100 (AEDT)
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <5693B4C1.4060400@maciej.szmigiero.name>
 <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
 <569AD8A7.7080803@maciej.szmigiero.name> <569ADC0D.2000807@tabi.org>
 <569AE7D1.6050607@maciej.szmigiero.name> <569B23A8.3010006@tabi.org>
 <569BA225.8070509@maciej.szmigiero.name>
 <569BA786.4020305@maciej.szmigiero.name>
From: Timur Tabi <timur@tabi.org>
Message-ID: <569BDFB3.1080401@tabi.org>
Date: Sun, 17 Jan 2016 12:38:43 -0600
MIME-Version: 1.0
In-Reply-To: <569BA786.4020305@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maciej S. Szmigiero wrote:
> On 17.01.2016 15:16, Maciej S. Szmigiero wrote:
>> On 17.01.2016 06:16, Timur Tabi wrote:
>>> Maciej S. Szmigiero wrote:
>>>> This is because (at least according to the datasheet) imx21-class SSI
>>>> registers end at CCSR_SSI_SRMSK (no SACC{ST,EN,DIS} regs), so
>>>> reading them for cache initialization may not be safe.
>>>>
>>>> Also, a "MXC 91221 only" comment before these regs in FSL tree
>>>> (drivers/mxc/ssi/registers.h) seems to confirm that these registers
>>>> aren't present at least on some SSI (or SoC) models.
>>>
>>> Can't we just mark them as precious or something, so that we don't have to have two structures?
>>
>> Looks like it can be done with just one static regmap config struct
>> used then as template - I will post updated patch.
>
> Updated patch:
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 40dfd8a36484..105de76dd2fc 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -112,20 +112,6 @@ struct fsl_ssi_rxtx_reg_val {
>   	struct fsl_ssi_reg_val tx;
>   };
>
> -static const struct reg_default fsl_ssi_reg_defaults[] = {
> -	{CCSR_SSI_SCR,     0x00000000},
> -	{CCSR_SSI_SIER,    0x00003003},
> -	{CCSR_SSI_STCR,    0x00000200},
> -	{CCSR_SSI_SRCR,    0x00000200},
> -	{CCSR_SSI_STCCR,   0x00040000},
> -	{CCSR_SSI_SRCCR,   0x00040000},
> -	{CCSR_SSI_SACNT,   0x00000000},
> -	{CCSR_SSI_STMSK,   0x00000000},
> -	{CCSR_SSI_SRMSK,   0x00000000},
> -	{CCSR_SSI_SACCEN,  0x00000000},
> -	{CCSR_SSI_SACCDIS, 0x00000000},
> -};
> -
>   static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
>   {
>   	switch (reg) {
> @@ -190,8 +176,7 @@ static const struct regmap_config fsl_ssi_regconfig = {
>   	.val_bits = 32,
>   	.reg_stride = 4,
>   	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> -	.reg_defaults = fsl_ssi_reg_defaults,
> -	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
> +	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / 4 + 1,

Replace "4" with "sizeof(uint32_t).

>   	.readable_reg = fsl_ssi_readable_reg,
>   	.volatile_reg = fsl_ssi_volatile_reg,
>   	.precious_reg = fsl_ssi_precious_reg,
> @@ -201,6 +186,7 @@ static const struct regmap_config fsl_ssi_regconfig = {
>
>   struct fsl_ssi_soc_data {
>   	bool imx;
> +	bool imx21regs;

Please add a comment explaining why this is needed.

>   	bool offline_config;
>   	u32 sisr_write_mask;
>   };
> @@ -295,6 +281,7 @@ struct fsl_ssi_private {
>
>   static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
>   	.imx = false,
> +	.imx21regs = false,

This is unnecessary.  The default is already 0 (false).

>   	.offline_config = true,
>   	.sisr_write_mask = CCSR_SSI_SISR_RFRC | CCSR_SSI_SISR_TFRC |
>   			CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
> @@ -303,12 +290,14 @@ static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
>
>   static struct fsl_ssi_soc_data fsl_ssi_imx21 = {
>   	.imx = true,
> +	.imx21regs = true,
>   	.offline_config = true,
>   	.sisr_write_mask = 0,
>   };
>
>   static struct fsl_ssi_soc_data fsl_ssi_imx35 = {
>   	.imx = true,
> +	.imx21regs = false,

Same here.

>   	.offline_config = true,
>   	.sisr_write_mask = CCSR_SSI_SISR_RFRC | CCSR_SSI_SISR_TFRC |
>   			CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
> @@ -317,6 +306,7 @@ static struct fsl_ssi_soc_data fsl_ssi_imx35 = {
>
>   static struct fsl_ssi_soc_data fsl_ssi_imx51 = {
>   	.imx = true,
> +	.imx21regs = false,
>   	.offline_config = false,
>   	.sisr_write_mask = CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
>   		CCSR_SSI_SISR_TUE0 | CCSR_SSI_SISR_TUE1,
> @@ -586,8 +576,11 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
>   	 */
>   	regmap_write(regs, CCSR_SSI_SACNT,
>   			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
> -	regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
> -	regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
> +
> +	if (!ssi_private->soc->imx21regs) {
> +		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
> +		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
> +	}

This needs a comment.

>
>   	/*
>   	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
> @@ -1397,6 +1390,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>   	struct resource *res;
>   	void __iomem *iomem;
>   	char name[64];
> +	struct regmap_config regconfig = fsl_ssi_regconfig;
>
>   	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
>   	if (!of_id || !of_id->data)
> @@ -1444,15 +1438,22 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>   		return PTR_ERR(iomem);
>   	ssi_private->ssi_phys = res->start;
>
> +	if (ssi_private->soc->imx21regs) {
> +		/* According to datasheet imx21-class SSI have less regs */

First of all, it would be "fewer regs", but even better would be to say 
that certain regs don't exist.

However, I wonder if this patch is necessary at all.  If the regs don't 
exist on an i.MX 21, does it really matter if we write to them?

> +		regconfig.max_register = CCSR_SSI_SRMSK;
> +		regconfig.num_reg_defaults_raw = CCSR_SSI_SRMSK / 4 + 1;
> +	}
> +
>   	ret = of_property_match_string(np, "clock-names", "ipg");
>   	if (ret < 0) {
>   		ssi_private->has_ipg_clk_name = false;
>   		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
> -			&fsl_ssi_regconfig);
> +							  &regconfig);
>   	} else {
>   		ssi_private->has_ipg_clk_name = true;
>   		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
> -			"ipg", iomem, &fsl_ssi_regconfig);
> +							      "ipg", iomem,
> +							      &regconfig);

What's wrong with the original indentation?  It looks nicer than what 
you're doing here.

>   	}
>   	if (IS_ERR(ssi_private->regs)) {
>   		dev_err(&pdev->dev, "Failed to init register map\n");
>
>
> Also needs regmap fix from
> http://www.spinics.net/lists/kernel/msg2161934.html
>
> Maciej Szmigiero
>

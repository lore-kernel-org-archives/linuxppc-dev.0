Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygpWT64RgzDqm5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 12:52:52 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id x7so8703162pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 17:52:52 -0800 (PST)
Date: Mon, 20 Nov 2017 17:52:48 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: fsl_ssi: serialize AC'97 register
 access operations
Message-ID: <20171121015247.GE14136@Asurada-Nvidia>
References: <9010cdad-4b05-d456-bf73-24cc48e38d69@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9010cdad-4b05-d456-bf73-24cc48e38d69@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 20, 2017 at 11:16:07PM +0100, Maciej S. Szmigiero wrote:
> AC'97 register access operations (both read and write) on SSI use a one,
> shared set of SSI registers for AC'97 register address and data.
> This means that only one such access is possible at a time and so all these
> operations need to be serialized.
> 
> Since an AC'97 register access operation in this driver takes 100us+ let's
> use a mutex for this.
> 
> Use this opportunity to also change a default value returned from AC'97
> register read function from -1 to 0, since that's what AC'97 specs require
> to be returned when unknown / undefined registers are read.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

>  static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
> @@ -1287,16 +1295,18 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>  {
>  	struct regmap *regs = fsl_ac97_data->regs;
>  
> -	unsigned short val = -1;
> +	unsigned short val = 0;
>  	u32 reg_val;
>  	unsigned int lreg;
>  	int ret;
>  
> +	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
> +
>  	ret = clk_prepare_enable(fsl_ac97_data->clk);
>  	if (ret) {
>  		pr_err("ac97 read clk_prepare_enable failed: %d\n",
>  			ret);
> -		return -1;
> +		goto ret_unlock;

It will return val (== 0) in this case. Will this be correctly
handled by callers? I find sound/ac97/bus.c checks if ret < 0
for ops->read().

So it might be better to add "val = ret;" before goto? Or use
val instead of ret directly?

>  	}
>  
>  	lreg = (reg & 0x7f) <<  12;
> @@ -1311,6 +1321,8 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>  
>  	clk_disable_unprepare(fsl_ac97_data->clk);
>  
> +ret_unlock:
> +	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
>  	return val;
>  }

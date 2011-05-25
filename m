Return-Path: <dedekind1@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17A44B6F95
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 17:24:53 +1000 (EST)
Received: by ewy6 with SMTP id 6so2450519ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 00:24:48 -0700 (PDT)
Subject: Re: [PATCH][upstream] NAND Machine support for Integrated Flash
	Controller
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Dipen Dudhat <Dipen.Dudhat@freescale.com>
In-Reply-To: <1306296011-11348-1-git-send-email-Dipen.Dudhat@freescale.com>
References: <1306296011-11348-1-git-send-email-Dipen.Dudhat@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 May 2011 10:20:22 +0300
Message-ID: <1306308022.2785.129.camel@localhost>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linux-mtd@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, 2011-05-25 at 09:30 +0530, Dipen Dudhat wrote:
> +	ret = nand_scan_tail(&priv->mtd);
> +	if (ret)
> +		goto err;
> +
> +#ifdef CONFIG_MTD_PARTITIONS

We've just removed this macro, it should be merged upstream soon, but it
is in the mtd tree so far.

> +	/* First look for RedBoot table or partitions on the command
> +	 * line, these take precedence over device tree information */
> +	ret = parse_mtd_partitions(&priv->mtd, part_probe_types, &parts, 0);
> +	if (ret < 0)
> +		goto err;

> +
> +#ifdef CONFIG_MTD_OF_PARTS
> +	if (ret == 0) {
> +		ret = of_mtd_parse_partitions(priv->dev, node, &parts);
> +		if (ret < 0)
> +			goto err;
> +	}
> +#endif

You should invent something to make sure you do not need #ifdef
CONFIG_MTD_OF_PARTS.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)

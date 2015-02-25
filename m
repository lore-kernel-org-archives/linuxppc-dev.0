Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0107.outbound.protection.outlook.com [157.56.110.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B6A01A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 12:17:33 +1100 (AEDT)
Message-ID: <1424827041.4698.44.camel@freescale.com>
Subject: Re: [PATCH 6/8] clk: ppc-corenet: Replace kzalloc() with kmalloc()
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 24 Feb 2015 19:17:21 -0600
In-Reply-To: <1421748570-14282-7-git-send-email-Emilian.Medve@Freescale.com>
References: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
 <1421748570-14282-7-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mturquette@linaro.org, haokexin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 yuantian.tang@Freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-20 at 04:09 -0600, Emil Medve wrote:
> Where the memset() is not necessary
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  drivers/clk/clk-ppc-corenet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
> index d84a7f0..91816b1 100644
> --- a/drivers/clk/clk-ppc-corenet.c
> +++ b/drivers/clk/clk-ppc-corenet.c
> @@ -185,7 +185,7 @@ static void __init core_pll_init(struct device_node *np)
>  	if (!subclks)
>  		goto err_map;
>  
> -	onecell_data = kzalloc(sizeof(*onecell_data), GFP_KERNEL);
> +	onecell_data = kmalloc(sizeof(*onecell_data), GFP_KERNEL);
>  	if (!onecell_data)
>  		goto err_clks;
>  

I think it's better to use kzalloc always, outside of
performance-sensitive allocations.  E.g. what if a new field is added to
the struct later?

-Scott

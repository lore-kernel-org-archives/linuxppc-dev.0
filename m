Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0108.outbound.protection.outlook.com [207.46.100.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5B061A0264
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 14:52:15 +1100 (AEDT)
Message-ID: <1417751519.334.9.camel@freescale.com>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 4 Dec 2014 21:51:59 -0600
In-Reply-To: <1417596833-31456-2-git-send-email-haokexin@gmail.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-03 at 16:53 +0800, Kevin Hao wrote:
> This reverts commit da788acb28386aa896224e784954bb73c99ff26c.
> 
> That commit tried to fix the section mismatch warning by moving the
> ppc_corenet_clk_driver struct to init section. This is definitely wrong
> because the kernel would free the memories occupied by this struct
> after boot while this driver is still registered in the driver core.
> The kernel would panic when accessing this driver struct.
> 
> Cc: stable@vger.kernel.org # 3.17
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> Acked-by: Michael Turquette <mturquette@linaro.org>
> ---
> v3: Cc stable and add ack.
> 
> v2: A new patch in v2.
> 
>  drivers/clk/clk-ppc-corenet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
> index b6e6c85507a5..0a47d6f49cd6 100644
> --- a/drivers/clk/clk-ppc-corenet.c
> +++ b/drivers/clk/clk-ppc-corenet.c
> @@ -291,7 +291,7 @@ static const struct of_device_id ppc_clk_ids[] __initconst = {
>  	{}
>  };
>  
> -static struct platform_driver ppc_corenet_clk_driver __initdata = {
> +static struct platform_driver ppc_corenet_clk_driver = {
>  	.driver = {
>  		.name = "ppc_corenet_clock",
>  		.of_match_table = ppc_clk_ids,

This patch is going to conflict with commit a4ae8f3b0f7ac6ab3 "clk: drop
owner assignment from platform_drivers" in linux-next -- or rather,
you've based this on that patch, but it's not in mpe's next branch, so I
get a merge conflict and there'd be another merge conflict later on to
get back to the newer base.

I really think this should go via the clock tree.  That's where the
breakage was introduced in the first place...

-Scott

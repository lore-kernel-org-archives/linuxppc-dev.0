Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id CDEDDDE34E
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 03:18:39 +1100 (EST)
Message-ID: <48ECDD5B.1070507@mvista.com>
Date: Wed, 08 Oct 2008 09:18:35 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] edac: mpc85xx: Add support for new compatible types,
	mpc8536	and mpc8560
References: <Pine.LNX.4.64.0810080721120.4673@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0810080721120.4673@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Dave Jiang <djiang@mvista.com>

Kumar Gala wrote:
> All other compatibles that are uniquely identifying the processor use
> a prefix of the form fsl,mpc85...'.  We add support for it so we
> can deprecate the older 'fsl,85...' that was inproperly used here.
> 
> Additionally added mpc8536 & mpc8560 to the compatible lists.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> This patch is based on Nate's 8572 patch.
> 
>  drivers/edac/mpc85xx_edac.c |   74 ++++++++++++++++++------------------------
>  1 files changed, 32 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 63bdc47..184799a 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -630,27 +630,22 @@ static int mpc85xx_l2_err_remove(struct of_device *op)
>  }
> 
>  static struct of_device_id mpc85xx_l2_err_of_match[] = {
> -	{
> -	 .compatible = "fsl,8540-l2-cache-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8541-l2-cache-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8544-l2-cache-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8548-l2-cache-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8555-l2-cache-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8568-l2-cache-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,mpc8572-l2-cache-controller",
> -	 },
> +/* deprecate the fsl,85.. forms in the future, 2.6.30? */
> +	{ .compatible = "fsl,8540-l2-cache-controller", },
> +	{ .compatible = "fsl,8541-l2-cache-controller", },
> +	{ .compatible = "fsl,8544-l2-cache-controller", },
> +	{ .compatible = "fsl,8548-l2-cache-controller", },
> +	{ .compatible = "fsl,8555-l2-cache-controller", },
> +	{ .compatible = "fsl,8568-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8536-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8540-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8541-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8544-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8548-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8555-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8560-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8568-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8572-l2-cache-controller", },
>  	{},
>  };
> 
> @@ -967,27 +962,22 @@ static int mpc85xx_mc_err_remove(struct of_device *op)
>  }
> 
>  static struct of_device_id mpc85xx_mc_err_of_match[] = {
> -	{
> -	 .compatible = "fsl,8540-memory-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8541-memory-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8544-memory-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8548-memory-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8555-memory-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,8568-memory-controller",
> -	 },
> -	{
> -	 .compatible = "fsl,mpc8572-memory-controller",
> -	 },
> +/* deprecate the fsl,85.. forms in the future, 2.6.30? */
> +	{ .compatible = "fsl,8540-memory-controller", },
> +	{ .compatible = "fsl,8541-memory-controller", },
> +	{ .compatible = "fsl,8544-memory-controller", },
> +	{ .compatible = "fsl,8548-memory-controller", },
> +	{ .compatible = "fsl,8555-memory-controller", },
> +	{ .compatible = "fsl,8568-memory-controller", },
> +	{ .compatible = "fsl,mpc8536-memory-controller", },
> +	{ .compatible = "fsl,mpc8540-memory-controller", },
> +	{ .compatible = "fsl,mpc8541-memory-controller", },
> +	{ .compatible = "fsl,mpc8544-memory-controller", },
> +	{ .compatible = "fsl,mpc8548-memory-controller", },
> +	{ .compatible = "fsl,mpc8555-memory-controller", },
> +	{ .compatible = "fsl,mpc8560-memory-controller", },
> +	{ .compatible = "fsl,mpc8568-memory-controller", },
> +	{ .compatible = "fsl,mpc8572-memory-controller", },
>  	{},
>  };
> 


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------

Return-Path: <robherring2@gmail.com>
Message-ID: <509F217D.8020901@gmail.com>
Date: Sat, 10 Nov 2012 21:54:37 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] of/fdt: Don't copy garbage after "/" in root node path
References: <1350865950.2476.145.camel@pasglop>
In-Reply-To: <1350865950.2476.145.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/21/2012 07:32 PM, Benjamin Herrenschmidt wrote:
> The root node path must be internally converted to "/", or various
> pieces of code looking for it that way will fail. The code to do
> that however had a bug where we might incorrectly append pieces
> of the original path from the fdt to the "/".
> 
> We should probably add a proper dedicated accessor for the root node
> but in the meantime this patch should fix it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied. Thanks.

Rob

> ---
>  drivers/of/fdt.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 91a375f..c2b08dc 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -186,6 +186,7 @@ static unsigned long unflatten_dt_node(struct boot_param_header *blob,
>  			 */
>  			fpsize = 1;
>  			allocl = 2;
> +			l = 0;
>  		} else {
>  			/* account for '/' and path size minus terminal 0
>  			 * already in 'l'
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 

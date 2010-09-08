Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 8 Sep 2010 13:46:58 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 7/7] arch/powerpc/platforms/cell: Add of_node_put to
	avoid memory leak
Message-ID: <20100908194658.GA7065@angua.secretlab.ca>
References: <1283075566-27441-1-git-send-email-julia@diku.dk>
	<1283075566-27441-8-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283075566-27441-8-git-send-email-julia@diku.dk>
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 29, 2010 at 11:52:46AM +0200, Julia Lawall wrote:
> Add calls to of_node_put in the error handling code following calls to
> of_find_node_by_path and of_find_node_by_phandle.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r exists@
> local idexpression x;
> expression E,E1;
> statement S;
> @@
> 
> *x = 
> (of_find_node_by_path
> |of_find_node_by_name
> |of_find_node_by_phandle
> |of_get_parent
> |of_get_next_parent
> |of_get_next_child
> |of_find_compatible_node
> |of_match_node
> )(...);
> ...
> if (x == NULL) S
> <... when != x = E
> *if (...) {
>   ... when != of_node_put(x)
>       when != if (...) { ... of_node_put(x); ... }
> (
>   return <+...x...+>;
> |
> *  return ...;
> )
> }
> ...>
> of_node_put(x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> 
> ---
>  arch/powerpc/platforms/cell/ras.c        |    4 +++-
>  arch/powerpc/platforms/cell/spider-pic.c |    4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
> index 1d3c4ef..5ec1e47 100644
> --- a/arch/powerpc/platforms/cell/ras.c
> +++ b/arch/powerpc/platforms/cell/ras.c
> @@ -173,8 +173,10 @@ static int __init cbe_ptcal_enable(void)
>  		return -ENODEV;
>  
>  	size = of_get_property(np, "ibm,cbe-ptcal-size", NULL);
> -	if (!size)
> +	if (!size) {
> +		of_node_put(np);
>  		return -ENODEV;
> +	}
>  
>  	pr_debug("%s: enabling PTCAL, size = 0x%x\n", __func__, *size);
>  	order = get_order(*size);
> diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
> index 5876e88..3f2e557 100644
> --- a/arch/powerpc/platforms/cell/spider-pic.c
> +++ b/arch/powerpc/platforms/cell/spider-pic.c
> @@ -258,8 +258,10 @@ static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
>  		return NO_IRQ;
>  	imap += intsize + 1;
>  	tmp = of_get_property(iic, "#interrupt-cells", NULL);
> -	if (tmp == NULL)
> +	if (tmp == NULL) {
> +		of_node_put(iic);
>  		return NO_IRQ;
> +	}
>  	intsize = *tmp;
>  	/* Assume unit is last entry of interrupt specifier */
>  	unit = imap[intsize - 1];
> 

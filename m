Return-Path: <michael@ellerman.id.au>
Message-ID: <1347931959.7046.1.camel@concordia>
Subject: Re: [RESEND PATCH v3 2/5] dt/powerpc/powernv: Use
 of_get_child_by_name to get a named child.
From: Michael Ellerman <michael@ellerman.id.au>
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Tue, 18 Sep 2012 11:32:39 +1000
In-Reply-To: <1347883109-16714-1-git-send-email-srinivas.kandagatla@st.com>
References: <1347883109-16714-1-git-send-email-srinivas.kandagatla@st.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kgene.kim@samsung.com, devicetree-discuss@lists.ozlabs.org,
 broonie@opensource.wolfsonmicro.com, robherring2@gmail.com,
 ben-linux@fluff.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-17 at 12:58 +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> As follow-up to "dt: introduce of_get_child_by_name to get child node by
> name." patch, This patch removes some of the code duplication in the
> driver by replacing it with of_get_child_by_name instead.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index aaa0dba..fc7ae70 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -294,9 +294,9 @@ static int __init opal_init(void)
>  		consoles = of_node_get(opal_node);
>  
>  	/* Register serial ports */
> -	for_each_child_of_node(consoles, np) {
> -		if (strcmp(np->name, "serial"))
> -			continue;
> +	np = of_get_child_by_name(consoles, "serial");
> +	if (np) {
> +		of_node_put(np);
>  		of_platform_device_create(np, NULL, NULL);

You mustn't drop the reference until after you've finished with np, as
you have written it the node could be freed before you call
of_platform_device_create().

cheers

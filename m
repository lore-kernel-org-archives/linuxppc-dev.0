Return-Path: <robherring2@gmail.com>
Message-ID: <50532BEC.70201@gmail.com>
Date: Fri, 14 Sep 2012 08:06:52 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 2/7] dt/powerpc: Use of_get_child_by_name to get a
 named child.
References: <1347610724-20152-1-git-send-email-srinivas.kandagatla@st.com>
In-Reply-To: <1347610724-20152-1-git-send-email-srinivas.kandagatla@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: bergner@us.ibm.com, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2012 03:18 AM, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> As follow-up to "dt: introduce of_get_child_by_name to get child node by
> name." patch, This patch removes some of the code duplication in the
> driver by replacing it with of_get_child_by_name instead.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  arch/powerpc/kernel/prom.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index f191bf0..80e5b6c 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -735,7 +735,6 @@ void __init early_init_devtree(void *params)
>   */
>  struct device_node *of_find_next_cache_node(struct device_node *np)
>  {
> -	struct device_node *child;
>  	const phandle *handle;
>  
>  	handle = of_get_property(np, "l2-cache", NULL);
> @@ -749,9 +748,7 @@ struct device_node *of_find_next_cache_node(struct device_node *np)
>  	 * beneath CPU nodes.
>  	 */
>  	if (!strcmp(np->type, "cpu"))
> -		for_each_child_of_node(np, child)
> -			if (!strcmp(child->type, "cache"))

name and type are not the same thing.

Rob

> -				return child;
> +		return of_get_child_by_name(np, "cache");
>  
>  	return NULL;
>  }
> 

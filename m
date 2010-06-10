Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] of/irq: merge of_irq_find_parent()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100604212145.10552.95452.stgit@angua>
References: <20100604212134.10552.70717.stgit@angua>
	<20100604212145.10552.95452.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:38:07 +1000
Message-ID: <1276151887.1962.53.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-06-04 at 15:21 -0600, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze.  Also create a new
> arch hook, of_irq_find_parent_by_phandle() to handle arch-specific
> quirks.

First, you changeset comment should be much more verbose as to
what that arch specific quirk is about etc... it took me time to figure
it out again :-)

I dislike the naming you use. Your "of_irq_find_parent_by_phandle"
doesn't ring "right" to me.

I'm tempted to say we should put the quirks in the common code, your
attempt at "abstracting" them just makes the code much harder to follow.

Also, if we stick to your approach the "default" variant should either
be an inline protected by an ifndef or a weak function.

Cheers,
Ben.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Michal Simek <monstr@monstr.eu>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>
> CC: microblaze-uclinux@itee.uq.edu.au
> CC: linuxppc-dev@lists.ozlabs.org
> CC: devicetree-discuss@lists.ozlabs.org
> ---
>  arch/microblaze/kernel/prom_parse.c |   22 +++-------------------
>  arch/powerpc/kernel/prom_parse.c    |   30 +++++-------------------------
>  drivers/of/irq.c                    |   28 ++++++++++++++++++++++++++++
>  include/linux/of_irq.h              |    2 ++
>  4 files changed, 38 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel/prom_parse.c
> index af1b2a7..946f14d 100644
> --- a/arch/microblaze/kernel/prom_parse.c
> +++ b/arch/microblaze/kernel/prom_parse.c
> @@ -648,25 +648,9 @@ void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
>   * Interrupt remapper
>   */
>  
> -static struct device_node *of_irq_find_parent(struct device_node *child)
> +struct device_node *of_irq_find_parent_by_phandle(phandle p)
>  {
> -	struct device_node *p;
> -	const phandle *parp;
> -
> -	if (!of_node_get(child))
> -		return NULL;
> -
> -	do {
> -		parp = of_get_property(child, "interrupt-parent", NULL);
> -		if (parp == NULL)
> -			p = of_get_parent(child);
> -		else
> -			p = of_find_node_by_phandle(*parp);
> -		of_node_put(child);
> -		child = p;
> -	} while (p && of_get_property(p, "#interrupt-cells", NULL) == NULL);
> -
> -	return p;
> +	return of_find_node_by_phandle(p);
>  }
>  
>  int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
> @@ -783,7 +767,7 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
>  			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
>  
>  			/* Get the interrupt parent */
> -			newpar = of_find_node_by_phandle((phandle)*imap);
> +			newpar = of_irq_find_parent_by_phandle((phandle)*imap);
>  			imap++;
>  			--imaplen;
>  
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 8362620..39e977d 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -685,29 +685,12 @@ void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
>  static unsigned int of_irq_workarounds;
>  static struct device_node *of_irq_dflt_pic;
>  
> -static struct device_node *of_irq_find_parent(struct device_node *child)
> +struct device_node *of_irq_find_parent_by_phandle(phandle p)
>  {
> -	struct device_node *p;
> -	const phandle *parp;
> -
> -	if (!of_node_get(child))
> -		return NULL;
> -
> -	do {
> -		parp = of_get_property(child, "interrupt-parent", NULL);
> -		if (parp == NULL)
> -			p = of_get_parent(child);
> -		else {
> -			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
> -				p = of_node_get(of_irq_dflt_pic);
> -			else
> -				p = of_find_node_by_phandle(*parp);
> -		}
> -		of_node_put(child);
> -		child = p;
> -	} while (p && of_get_property(p, "#interrupt-cells", NULL) == NULL);
> +	if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
> +		return of_node_get(of_irq_dflt_pic);
>  
> -	return p;
> +	return of_find_node_by_phandle(p);
>  }
>  
>  /* This doesn't need to be called if you don't have any special workaround
> @@ -859,10 +842,7 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
>  			DBG(" -> match=%d (imaplen=%d)\n", match, imaplen);
>  
>  			/* Get the interrupt parent */
> -			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
> -				newpar = of_node_get(of_irq_dflt_pic);
> -			else
> -				newpar = of_find_node_by_phandle((phandle)*imap);
> +			newpar = of_irq_find_parent_by_phandle((phandle)*imap);
>  			imap++;
>  			--imaplen;
>  
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 56ad1aa..ad569ca 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -24,6 +24,34 @@
>  #include <linux/of_irq.h>
>  #include <linux/string.h>
>  
> +/**
> + * of_irq_find_parent - Given a device node, find its interrupt parent node
> + * @child: pointer to device node
> + *
> + * Returns a pointer to the interrupt parent node, or NULL if the interrupt
> + * parent could not be determined.
> + */
> +struct device_node *of_irq_find_parent(struct device_node *child)
> +{
> +	struct device_node *p;
> +	const phandle *parp;
> +
> +	if (!of_node_get(child))
> +		return NULL;
> +
> +	do {
> +		parp = of_get_property(child, "interrupt-parent", NULL);
> +		if (parp == NULL)
> +			p = of_get_parent(child);
> +		else
> +			p = of_irq_find_parent_by_phandle(*parp);
> +		of_node_put(child);
> +		child = p;
> +	} while (p && of_get_property(p, "#interrupt-cells", NULL) == NULL);
> +
> +	return p;
> +}
> +
>  unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
>  {
>  	struct of_irq oirq;
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 0e37c05..f98b27b 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -30,6 +30,8 @@ struct of_irq {
>  	u32 specifier[OF_MAX_IRQ_SPEC]; /* Specifier copy */
>  };
>  
> +extern struct device_node *of_irq_find_parent_by_phandle(phandle p);
> +extern struct device_node *of_irq_find_parent(struct device_node *child);
>  extern int of_irq_map_one(struct device_node *device, int index,
>  			  struct of_irq *out_irq);
>  extern unsigned int irq_create_of_mapping(struct device_node *controller,

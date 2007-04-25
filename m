Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFE34DDF32
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 10:00:49 +1000 (EST)
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070424223930.1dab0e28.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424223930.1dab0e28.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 10:00:35 +1000
Message-Id: <1177459235.14873.155.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 22:39 +1000, Stephen Rothwell wrote:
> The only change here is that a readlock is taken while the property list
> is being traversed on Sparc where it was not taken previously.
> 
> Also, Sparc uses strcasecmp to compare property names while PowerPC
> uses strcmp.

Ok, so that's the opposite as the previous one... property names are
supposed to be case sensitive though, no ? Dave, how do you think we
should converge here ? I don't think we would take much risk on ppc by
using strncasecmp but it shouldn't be necessary...

Ben.

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/prom.c |   24 +-----------------------
>  arch/sparc/kernel/prom.c   |   22 +---------------------
>  arch/sparc64/kernel/prom.c |   22 +---------------------
>  drivers/openfw/base.c      |   26 ++++++++++++++++++++++++++
>  include/asm-powerpc/prom.h |    1 +
>  include/asm-sparc/prom.h   |    1 +
>  include/asm-sparc64/prom.h |    1 +
>  7 files changed, 32 insertions(+), 65 deletions(-)
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 723df55..939d5e4 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -79,10 +79,7 @@ struct boot_param_header *initial_boot_params;
>  
>  static struct device_node *allnodes = NULL;
>  
> -/* use when traversing tree through the allnext, child, sibling,
> - * or parent members of struct device_node.
> - */
> -static DEFINE_RWLOCK(devtree_lock);
> +extern rwlock_t devtree_lock;	/* temporary while merging */
>  
>  /* export that to outside world */
>  struct device_node *of_chosen;
> @@ -1454,25 +1451,6 @@ static int __init prom_reconfig_setup(void)
>  __initcall(prom_reconfig_setup);
>  #endif
>  
> -struct property *of_find_property(const struct device_node *np,
> -				  const char *name,
> -				  int *lenp)
> -{
> -	struct property *pp;
> -
> -	read_lock(&devtree_lock);
> -	for (pp = np->properties; pp != 0; pp = pp->next)
> -		if (strcmp(pp->name, name) == 0) {
> -			if (lenp != 0)
> -				*lenp = pp->length;
> -			break;
> -		}
> -	read_unlock(&devtree_lock);
> -
> -	return pp;
> -}
> -EXPORT_SYMBOL(of_find_property);
> -
>  /*
>   * Add a property to a node
>   */
> diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
> index f2ce0d4..0f5aab4 100644
> --- a/arch/sparc/kernel/prom.c
> +++ b/arch/sparc/kernel/prom.c
> @@ -27,10 +27,7 @@
>  
>  static struct device_node *allnodes;
>  
> -/* use when traversing tree through the allnext, child, sibling,
> - * or parent members of struct device_node.
> - */
> -static DEFINE_RWLOCK(devtree_lock);
> +extern rwlock_t devtree_lock;	/* temporary while merging */
>  
>  struct device_node *of_get_parent(const struct device_node *node)
>  {
> @@ -130,23 +127,6 @@ struct device_node *of_find_compatible_node(struct device_node *from,
>  }
>  EXPORT_SYMBOL(of_find_compatible_node);
>  
> -struct property *of_find_property(const struct device_node *np,
> -				  const char *name,
> -				  int *lenp)
> -{
> -	struct property *pp;
> -
> -	for (pp = np->properties; pp != 0; pp = pp->next) {
> -		if (strcasecmp(pp->name, name) == 0) {
> -			if (lenp != 0)
> -				*lenp = pp->length;
> -			break;
> -		}
> -	}
> -	return pp;
> -}
> -EXPORT_SYMBOL(of_find_property);
> -
>  int of_getintprop_default(struct device_node *np, const char *name, int def)
>  {
>  	struct property *prop;
> diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
> index d6dd972..c759660 100644
> --- a/arch/sparc64/kernel/prom.c
> +++ b/arch/sparc64/kernel/prom.c
> @@ -31,10 +31,7 @@
>  
>  static struct device_node *allnodes;
>  
> -/* use when traversing tree through the allnext, child, sibling,
> - * or parent members of struct device_node.
> - */
> -static DEFINE_RWLOCK(devtree_lock);
> +extern rwlock_t devtree_lock;	/* temporary while merging */
>  
>  struct device_node *of_get_parent(const struct device_node *node)
>  {
> @@ -134,23 +131,6 @@ struct device_node *of_find_compatible_node(struct device_node *from,
>  }
>  EXPORT_SYMBOL(of_find_compatible_node);
>  
> -struct property *of_find_property(const struct device_node *np,
> -				  const char *name,
> -				  int *lenp)
> -{
> -	struct property *pp;
> -
> -	for (pp = np->properties; pp != 0; pp = pp->next) {
> -		if (strcasecmp(pp->name, name) == 0) {
> -			if (lenp != 0)
> -				*lenp = pp->length;
> -			break;
> -		}
> -	}
> -	return pp;
> -}
> -EXPORT_SYMBOL(of_find_property);
> -
>  int of_getintprop_default(struct device_node *np, const char *name, int def)
>  {
>  	struct property *prop;
> diff --git a/drivers/openfw/base.c b/drivers/openfw/base.c
> index 0751313..2597d29 100644
> --- a/drivers/openfw/base.c
> +++ b/drivers/openfw/base.c
> @@ -18,6 +18,12 @@
>   */
>  #include <linux/module.h>
>  #include <linux/openfw.h>
> +#include <linux/spinlock.h>
> +
> +/* use when traversing tree through the allnext, child, sibling,
> + * or parent members of struct device_node.
> + */
> +DEFINE_RWLOCK(devtree_lock);
>  
>  int of_n_addr_cells(struct device_node *np)
>  {
> @@ -51,6 +57,26 @@ int of_n_size_cells(struct device_node *np)
>  }
>  EXPORT_SYMBOL(of_n_size_cells);
>  
> +struct property *of_find_property(const struct device_node *np,
> +				  const char *name,
> +				  int *lenp)
> +{
> +	struct property *pp;
> +
> +	read_lock(&devtree_lock);
> +	for (pp = np->properties; pp != 0; pp = pp->next) {
> +		if (of_prop_cmp(pp->name, name) == 0) {
> +			if (lenp != 0)
> +				*lenp = pp->length;
> +			break;
> +		}
> +	}
> +	read_unlock(&devtree_lock);
> +
> +	return pp;
> +}
> +EXPORT_SYMBOL(of_find_property);
> +
>  /*
>   * Find a property with a given name for a given node
>   * and return the value.
> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
> index 1f3e8cd..a0679be 100644
> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -25,6 +25,7 @@
>  #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
>  
>  #define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
> +#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
>  
>  /* Definitions used by the flattened device tree */
>  #define OF_DT_HEADER		0xd00dfeed	/* marker */
> diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
> index cc049fd..d3dc05b 100644
> --- a/include/asm-sparc/prom.h
> +++ b/include/asm-sparc/prom.h
> @@ -24,6 +24,7 @@
>  #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
>  
>  #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
> +#define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
>  
>  typedef u32 phandle;
>  typedef u32 ihandle;
> diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
> index 843f9e8..a1b64e7 100644
> --- a/include/asm-sparc64/prom.h
> +++ b/include/asm-sparc64/prom.h
> @@ -24,6 +24,7 @@
>  #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
>  
>  #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
> +#define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
>  
>  typedef u32 phandle;
>  typedef u32 ihandle;

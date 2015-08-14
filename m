Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 240C41A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 21:52:00 +1000 (AEST)
In-Reply-To: <1439292189-78925-5-git-send-email-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Segher Boessenkool <segher@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [v2,5/5] powerpc/pseries: re-use code from of_helpers module
Message-Id: <20150814115200.0F4E1140293@ozlabs.org>
Date: Fri, 14 Aug 2015 21:51:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-08 at 11:23:09 UTC, Andy Shevchenko wrote:
> The derive_parent() has similar semantics to what we have in newly introduced
> of_helpers module. The replacement reduces code base and propagates the actual
> error code to the caller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/platforms/pseries/dlpar.c | 31 +++++--------------------------
>  1 file changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 47d9cebe..b7f243c 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -18,6 +18,8 @@
>  #include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +
> +#include "of_helpers.h"
>  #include "offline_states.h"
>  #include "pseries.h"
>  
> @@ -244,36 +246,13 @@ cc_error:
>  	return first_dn;
>  }
>  
> -static struct device_node *derive_parent(const char *path)
> -{
> -	struct device_node *parent;
> -	char *last_slash;
> -
> -	last_slash = strrchr(path, '/');
> -	if (last_slash == path) {
> -		parent = of_find_node_by_path("/");
> -	} else {
> -		char *parent_path;
> -		int parent_path_len = last_slash - path + 1;
> -		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
> -		if (!parent_path)
> -			return NULL;
> -
> -		strlcpy(parent_path, path, parent_path_len);
> -		parent = of_find_node_by_path(parent_path);
> -		kfree(parent_path);
> -	}
> -
> -	return parent;
> -}
> -
>  int dlpar_attach_node(struct device_node *dn)
>  {
>  	int rc;
>  
> -	dn->parent = derive_parent(dn->full_name);
> -	if (!dn->parent)
> -		return -ENOMEM;
> +	dn->parent = pseries_of_derive_parent(dn->full_name);
> +	if (IS_ERR(dn->parent))
> +		return PTR_ERR(dn_parent);
                                 ^
				 ?

There are cross compilers on kernel.org, or on Ubuntu you can just:

$ apt-get install gcc-powerpc-linux-gnu
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-gcc

cheers

Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 13D3C1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 02:20:18 +1000 (AEST)
Message-ID: <1443629978.8361.316.camel@linux.intel.com>
Subject: Re: [v2,5/5] powerpc/pseries: re-use code from of_helpers module
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Segher
 Boessenkool <segher@kernel.crashing.org>
Date: Wed, 30 Sep 2015 19:19:38 +0300
In-Reply-To: <20150814115200.0F4E1140293@ozlabs.org>
References: <20150814115200.0F4E1140293@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-08-14 at 21:51 +1000, Michael Ellerman wrote:
> On Tue, 2015-11-08 at 11:23:09 UTC, Andy Shevchenko wrote:
> > The derive_parent() has similar semantics to what we have in newly 
> > introduced
> > of_helpers module. The replacement reduces code base and propagates 
> > the actual
> > error code to the caller.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/powerpc/platforms/pseries/dlpar.c | 31 +++++-----------------
> > ---------
> >  1 file changed, 5 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/dlpar.c 
> > b/arch/powerpc/platforms/pseries/dlpar.c
> > index 47d9cebe..b7f243c 100644
> > --- a/arch/powerpc/platforms/pseries/dlpar.c
> > +++ b/arch/powerpc/platforms/pseries/dlpar.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/cpu.h>
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> > +
> > +#include "of_helpers.h"
> >  #include "offline_states.h"
> >  #include "pseries.h"
> >  
> > @@ -244,36 +246,13 @@ cc_error:
> >  	return first_dn;
> >  }
> >  
> > -static struct device_node *derive_parent(const char *path)
> > -{
> > -	struct device_node *parent;
> > -	char *last_slash;
> > -
> > -	last_slash = strrchr(path, '/');
> > -	if (last_slash == path) {
> > -		parent = of_find_node_by_path("/");
> > -	} else {
> > -		char *parent_path;
> > -		int parent_path_len = last_slash - path + 1;
> > -		parent_path = kmalloc(parent_path_len, 
> > GFP_KERNEL);
> > -		if (!parent_path)
> > -			return NULL;
> > -
> > -		strlcpy(parent_path, path, parent_path_len);
> > -		parent = of_find_node_by_path(parent_path);
> > -		kfree(parent_path);
> > -	}
> > -
> > -	return parent;
> > -}
> > -
> >  int dlpar_attach_node(struct device_node *dn)
> >  {
> >  	int rc;
> >  
> > -	dn->parent = derive_parent(dn->full_name);
> > -	if (!dn->parent)
> > -		return -ENOMEM;
> > +	dn->parent = pseries_of_derive_parent(dn->full_name);
> > +	if (IS_ERR(dn->parent))
> > +		return PTR_ERR(dn_parent);
>                                  ^
> 				 ?
> 
> There are cross compilers on kernel.org, or on Ubuntu you can just:
> 
> $ apt-get install gcc-powerpc-linux-gnu
> $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-gcc

Thanks! I tried today and the above the only problem with the series.
Would you like me to resend whole series?

> 
> cheers

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

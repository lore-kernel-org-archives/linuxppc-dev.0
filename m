Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXwRd34dyzDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 10:54:53 +1100 (AEDT)
Message-ID: <1488326091.15238.1.camel@russell.cc>
Subject: Re: [RFC 2/3] powerpc/eeh: Introduce function
 eeh_pe_reset_freeze_counter
From: Russell Currey <ruscur@russell.cc>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,  frederic.barrat@fr.ibm.com
Cc: Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie
 <ianmunsi@au1.ibm.com>,  Christophe Lombard
 <christophe_lombard@fr.ibm.com>, Philippe Bergheaud
 <philippe.bergheaud@fr.ibm.com>, Gregory Kurz <KURZGREG@fr.ibm.com>, Gavin
 Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 01 Mar 2017 10:54:51 +1100
In-Reply-To: <20170228070222.21126-3-vaibhav@linux.vnet.ibm.com>
References: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
 <20170228070222.21126-3-vaibhav@linux.vnet.ibm.com>
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

On Tue, 2017-02-28 at 12:32 +0530, Vaibhav Jain wrote:
> This patch introduces function eeh_pe_reset_freeze_counter which can
> be used to reset the PE's freeze count variable outside eeh code. This
> is useful for devices that can acquire a different personality after
> a PERST event (e.g FPGA Adapters). Presently an existing freeze
> count for an adapter with personality N will be taken into account
> when the adapter acquired personality N+1.
> 
> By calling eeh_pe_reset_freeze_counter drivers can reset the freeze
> counter for an adapter once it has acquired a new personality and
> ideally wont be plagued by the failures similar to the one before.

Same comment as before about adding () to the end of function names

> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 68806be..19ac6d0 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -266,6 +266,13 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
>  int eeh_add_to_parent_pe(struct eeh_dev *edev);
>  int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
>  int eeh_pe_update_freeze_counter(struct eeh_pe *pe);
> +
> +/* Reset the PE freeze counter */

I would like to see a comment here noting that doing this is in general a bad
idea, and this shouldn't be called for regular PCI devices.

> +static inline void eeh_pe_reset_freeze_counter(struct eeh_pe *pe)
> +{
> +	pe->freeze_count = 0;
> +}
> +
>  void *eeh_pe_traverse(struct eeh_pe *root,
>  		eeh_traverse_func fn, void *flag);
>  void *eeh_pe_dev_traverse(struct eeh_pe *root,
> @@ -339,6 +346,8 @@ static inline int eeh_check_failure(const volatile void
> __iomem *token)
>  	return 0;
>  }
>  
> +static inline void eeh_pe_reset_freeze_counter(struct eeh_pe *pe) { }
> +
>  #define eeh_dev_check_failure(x) (0)
>  
>  static inline void eeh_addr_cache_build(void) { }

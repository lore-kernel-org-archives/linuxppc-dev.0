Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id E368DDDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 11:41:37 +1000 (EST)
Date: Thu, 24 Jul 2008 11:41:34 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: ehrhardt@linux.vnet.ibm.com
Subject: Re: [PATCH 1/6] kvmppc: read device tree hypervisor node
	infrastructure
Message-ID: <20080724014133.GH20457@bakeyournoodle.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-2-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1216802207-32675-2-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, embedded-hypervisor@power.org, hollisb@us.ibm.com,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2008 at 10:36:42AM +0200, ehrhardt@linux.vnet.ibm.com wrote:

Hi Christian,
	A few comments inlined ...

> diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
> --- a/include/asm-powerpc/kvm_para.h
> +++ b/include/asm-powerpc/kvm_para.h
> @@ -14,7 +14,9 @@
>   *
>   * Copyright IBM Corp. 2008
>   *
> - * Authors: Hollis Blanchard <hollisb@us.ibm.com>
> + * Authors:
> + * 	Hollis Blanchard <hollisb@us.ibm.com>
> + * 	Christian Ehrhardt <ehrhardt@de.ibm.com>
>   */
>  
>  #ifndef __POWERPC_KVM_PARA_H__
> @@ -22,15 +24,44 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/of.h>
> +
> +static struct kvmppc_para_features {
> +	char *dtcell;
> +	int feature;
> +} para_features[] = {
> +};
> +
>  static inline int kvm_para_available(void)
>  {
> -	return 0;
> +	struct device_node *dn;
> +
> +	dn = of_find_node_by_path("/hypervisor");

You need an of_node_put(dn);

> +
> +	return !!dn;
>  }
>  
>  static inline unsigned int kvm_arch_para_features(void)
>  {
> -	return 0;
> +	struct device_node *dn;
> +	const int *dtval;
> +	unsigned int features = 0;
> +	int i;
> +
> +	dn = of_find_node_by_path("/hypervisor");
> +	if (!dn)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(para_features)-1; i++) {

Why -1?  Isn't ARRAY_SIZE(para_features) adequate?

> +		dtval = of_get_property(dn, para_features[i].dtcell, NULL);
> +		if (dtval && *dtval == 1)
> +			features |= (1 << para_features[i].feature);
> +	}
> +

You need an of_node_put(dn);

> +	return features;
>  }

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!

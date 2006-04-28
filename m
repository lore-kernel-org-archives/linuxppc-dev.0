Return-Path: <ntl@pobox.com>
Received: from proof.pobox.com (proof.pobox.com [207.106.133.28])
	by ozlabs.org (Postfix) with ESMTP id 63D36679FC
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 05:32:19 +1000 (EST)
Date: Fri, 28 Apr 2006 14:31:59 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [RFC , PATCH] support for the ibm,pa_features cpu property
Message-ID: <20060428193159.GJ8550@localdomain>
References: <1146249684.27214.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1146249684.27214.18.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt wrote:
> +static int get_pa_features(int pabyte,int pabit)
> +{
> +	struct device_node *cpu;
> +	char *pa_feature_table;
> +
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	pa_feature_table = 
> +		(char *)get_property(cpu, "ibm,pa-features", NULL);
> +
> +	if ( pa_feature_table == NULL ) {
> +		printk("ibm,pa-features property is missing.\n");
> +		return -1;
> +	}
> +
> +	/* sanity check */
> +	if ( pabyte > pa_feature_table[0] ) {
> +		printk("%s: %d out of range for table of size %d\n",
> +			__FUNCTION__,pabyte,pa_feature_table[0]);
> +		return -1;
> +	}
> +	
> +	return pa_feature_table[2+pabyte*8+pabit];
> +}

This function needs to of_node_put(cpu) before returning or we won't
be able to deconfigure the processor.

Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Use 1TB segments 
In-reply-to: <18095.59959.698141.565343@cargo.ozlabs.ibm.com> 
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
Date: Fri, 10 Aug 2007 13:53:08 +1000
Message-ID: <32438.1186717988@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static int __init htab_dt_scan_seg_sizes(unsigned long node,
> +					 const char *uname, int depth,
> +					 void *data)
> +{
> +	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +	u32 *prop;
> +	unsigned long size = 0;
> +
> +	/* We are scanning "cpu" nodes only */
> +	if (type == NULL || strcmp(type, "cpu") != 0)
> +		return 0;
> +
> +	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,processor-segment-sizes",
> +					  &size);
> +	if (prop != NULL && size >= 8) {
> +		if (prop[0] == 0x1c && prop[1] == 0x28) {
> +			DBG("1T segment support detected\n");
> +			cur_cpu_spec->cpu_features |= CPU_FTR_1T_SEGMENT;
> +		}

Shouldn't this iterate through the property prop and _only_ look for a
0x28 entry rather than assuming the first two are going to be 0x1c and
0x28?

Something like:
	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,processor-segment-sizes",
					  &size);
	if (prop != NULL) 
		for (i = 0; i < size/4; i++)
			if (prop[1] == 0x28)
				DBG("1T segment support detected\n");
				cur_cpu_spec->cpu_features |=
					  CPU_FTR_1T_SEGMENT;

Mikey

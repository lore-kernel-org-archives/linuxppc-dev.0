Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACB9BDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 08:28:04 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6AMRuIh024239
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 18:27:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6AMRuEr109940
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 18:27:56 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6AMRupf018931
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 18:27:56 -0400
Message-ID: <48768CE9.2080802@austin.ibm.com>
Date: Thu, 10 Jul 2008 17:27:53 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Chandru <chandru@in.ibm.com>
Subject: Re: [PATCH 1/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
References: <200807080014.24910.chandru@in.ibm.com>
In-Reply-To: <200807080014.24910.chandru@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Chandru,

>  static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  {
> -	cell_t *dm, *ls;
> +	cell_t *dm, *ls, *endp, *usm;
>  	unsigned long l, n, flags;
>  	u64 base, size, lmb_size;
> +	char buf[32], t[8];
>  
>  	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
>  	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
> @@ -917,7 +918,33 @@ static int __init early_init_dt_scan_drc
>  			if ((base + size) > 0x80000000ul)
>  				size = 0x80000000ul - base;
>  		}
> -		lmb_add(base, size);
> +		strcpy(buf, "linux,usable-memory");
> +		sprintf(t, "%d", (int)n);
> +		strcat(buf, t);
> +		usm = (cell_t *)of_get_flat_dt_prop(node,
> +						 (const char *)buf, &l);
> +		if (usm != NULL) {
> +			endp = usm + (l / sizeof(cell_t));
> +			while ((endp - usm) >= (dt_root_addr_cells +
> +						 dt_root_size_cells)) {
> +				base = dt_mem_next_cell(dt_root_addr_cells,
> +								 &usm);
> +				size = dt_mem_next_cell(dt_root_size_cells,
> +								 &usm);
> +				if (size == 0)
> +					continue;
> +				if (iommu_is_off) {
> +					if ((base + size) > 0x80000000ul)
> +						size = 0x80000000ul - base;
> +				}
> +				lmb_add(base, size);
> +			}
> +
> +			/* Continue with next lmb entry */
> +			continue;
> +		} else {
> +			lmb_add(base, size);
> +		}
>  	}

I am still digging through the kexec tools but I don't think you want
the processing of the linux,usable-memory property inside of the
for (; n!= 0; --n) loop.  This should be moved up so that it looks for
the linux,usable-memory property and parses it, then if it is not found
look for the ibm,dynamic-reconfiguration-memory property and parse it.

There is no need to look for the linux-usable-memory property every time
a piece of the ibm,dynamic-reconfiguration-memory property is parsed.

-Nathan

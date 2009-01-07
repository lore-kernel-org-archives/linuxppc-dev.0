Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 656C14758F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 03:16:01 +1100 (EST)
Message-Id: <A90B9CD7-787A-4E57-81BB-AEE3A84BAB36@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-3-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/5] powerpc: booke: Remove code duplication in lowmem
	mapping
Date: Wed, 7 Jan 2009 10:13:53 -0600
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
	<1228793699-23110-3-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> void __init
> adjust_total_lowmem(void)
> {
> -	phys_addr_t max_lowmem_size = __max_low_memory;
> -	phys_addr_t cam_max_size = 0x10000000;
> 	phys_addr_t ram;
> +	unsigned int max_cam = 28;	/* 2^28 = 256 Mb */
> +	char buf[ARRAY_SIZE(cam) * 5 + 1], *p = buf;
> +	int i;
>
> -	/* adjust CAM size to max_lowmem_size */
> -	if (max_lowmem_size < cam_max_size)
> -		cam_max_size = max_lowmem_size;
> -
> -	/* adjust lowmem size to max_lowmem_size */
> -	ram = min(max_lowmem_size, total_lowmem);
> +	/* adjust lowmem size to __max_low_memory */
> +	ram = min((phys_addr_t)__max_low_memory, (phys_addr_t)total_lowmem);
>
> 	/* Calculate CAM values */
> -	__cam0 = 1UL << 2 * (__ilog2(ram) / 2);
> -	if (__cam0 > cam_max_size)
> -		__cam0 = cam_max_size;
> -	ram -= __cam0;
> -	if (ram) {
> -		__cam1 = 1UL << 2 * (__ilog2(ram) / 2);
> -		if (__cam1 > cam_max_size)
> -			__cam1 = cam_max_size;
> -		ram -= __cam1;
> -	}
> -	if (ram) {
> -		__cam2 = 1UL << 2 * (__ilog2(ram) / 2);
> -		if (__cam2 > cam_max_size)
> -			__cam2 = cam_max_size;
> -		ram -= __cam2;
> +	__max_low_memory = 0;
> +	for (i = 0; ram && i < ARRAY_SIZE(cam); i++) {
> +		unsigned int camsize = __ilog2(ram) & ~1U;
> +		if (camsize > max_cam)
> +			camsize = max_cam;
> +		cam[i] = 1UL << camsize;
> +		ram -= cam[i];
> +		__max_low_memory += cam[i];
> +
> +		p += sprintf(p, "%lu/", cam[i] >> 20);
> 	}
> +	for (; i < ARRAY_SIZE(cam); i++)
> +		p += sprintf(p, "0/");
> +	p[-1] = '\0';

this all seems like overkill.  Can we use string_get_size() from lib/ 
string_helpers.c and just printf in a loop?

> -	printk(KERN_INFO "Memory CAM mapping: CAM0=%ldMb, CAM1=%ldMb,"
> -			" CAM2=%ldMb residual: %ldMb\n",
> -			__cam0 >> 20, __cam1 >> 20, __cam2 >> 20,
> -			(long int)((total_lowmem - __cam0 - __cam1 - __cam2)
> -				   >> 20));
> -	__max_low_memory = __cam0 + __cam1 + __cam2;
> +	pr_info("Memory CAM mapping: %s Mb, residual: %ldMb\n", buf,
> +	        (total_lowmem - __max_low_memory) >> 20);
> 	__initial_memory_limit_addr = memstart_addr + __max_low_memory;
> }

- k

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B840DDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 04:50:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l29HoHnb009910
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 12:50:17 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l29HoHnE246606
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 12:50:17 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l29HoGjZ007896
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 12:50:17 -0500
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070305032452.EDB2BDDF1D@ozlabs.org>
References: <20070305032452.EDB2BDDF1D@ozlabs.org>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 11:50:11 -0600
Message-Id: <1173462611.4861.51.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-05 at 14:24 +1100, David Gibson wrote:
> Index: working-2.6/arch/powerpc/boot/ebony.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/ebony.c	2007-02-26 13:46:05.000000000 +1100

> +
> +static inline u32 mfpvr(void)
> +{
> +	u32 pvr;
> +	asm volatile ("mfpvr	%0" : "=r"(pvr));
> +	return pvr;
> +}

This could probably go in a generic util.h file.

> +
> +void poke_tree(const char *path, const char *name, void *val, int size)
> +{
> +	void *devp;
> +	int ret;
> +
> +	devp = finddevice(path);
> +	if (! devp) {
> +		printf("Couldn't find node %s to poke\n\r", path);
> +		exit();
> +	}
> +
> +	ret = setprop(devp, name, val, size);
> +	if (ret != 0) {
> +		printf("Couldn't set %s property in %s\n\r", name, path);
> +		exit();
> +	}
> +}
> +
> +#define poke_tree_val(path, name, val)	\
> +	do { \
> +		typeof(val) x = val; \
> +		poke_tree((path),(name),&x,sizeof(x)); \
> +	} while (0)
> +
> +/* Read the 44x memory controller to get size of system memory. */
> +static void ibm44x_fixup_memsize(void)
> +{
> +	int i;
> +	unsigned long memsize, bank_config;
> +	u32 memreg[3];
> +
> +	memsize = 0;
> +	for (i = 0; i < ARRAY_SIZE(sdram_bxcr); i++) {
> +		mtdcr(DCRN_SDRAM0_CFGADDR, sdram_bxcr[i]);
> +		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
> +
> +		if (bank_config & SDRAM_CONFIG_BANK_ENABLE)
> +			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
> +	}
> +
> +	printf("PPC44X: %dM RAM\n\r", memsize / 1024 / 1024);
> +	memreg[0] = memreg[1] = 0;
> +	memreg[2] = memsize;
> +	poke_tree("/memory", "reg", memreg, sizeof(memreg));
> +}

Is it possible to pull these three out into a 4xx_misc.c file?  The
exact same memory fixup can be used on boards other than Ebony (Bamboo
for example).

josh

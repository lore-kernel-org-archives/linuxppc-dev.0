Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4E6DDDEDD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 23:00:16 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4FD0Da5000696
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:00:13 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4FD0CoV211220
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:00:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4FD0CKB007095
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:00:12 -0600
Subject: Re: [PATCH 2/3] Derive ebc ranges property from EBC registers
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070515045415.5B05ADDECE@ozlabs.org>
References: <20070515045415.5B05ADDECE@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 May 2007 07:59:58 -0500
Message-Id: <1179233998.3084.28.camel@zod.rchland.ibm.com>
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

On Tue, 2007-05-15 at 14:54 +1000, David Gibson wrote:
>  void ebony_init(void *mac0, void *mac1)
> Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:38:39.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:56.000000000 +1000
> @@ -136,11 +136,9 @@
>  				#address-cells = <2>;
>  				#size-cells = <1>;
>  				clock-frequency = <0>; // Filled in by zImage
> -				ranges = <0 00000000 fff00000 100000
> -					  1 00000000 48000000 100000
> -					  2 00000000 ff800000 400000
> -					  3 00000000 48200000 100000
> -					  7 00000000 48300000 100000>;
> +				// ranges property is supplied by zImage
> +				// based on firmware's configuration of the
> +				// EBC bridge

Do we want a "ranges;" here as a placeholder?  I don't see where it's
absolutely required, but it makes me feel better for some reason...

> +
> +/* Read 4xx EBC bus bridge registers to get mappings of the peripheral
> + * banks into the OPB address space */
> +void ibm4xx_fixup_ebc_ranges(const char *ebc)
> +{
> +	void *devp;
> +	u32 bxcr;
> +	u32 ranges[EBC_NUM_BANKS*4];
> +	u32 *p = ranges;
> +	int i;
> +
> +	for (i = 0; i < EBC_NUM_BANKS; i++) {
> +		mtdcr(DCRN_EBC0_CFGADDR, EBC_BXCR(i));
> +		bxcr = mfdcr(DCRN_EBC0_CFGDATA);
> +
> +		if ((bxcr & EBC_BXCR_BU) != EBC_BXCR_BU_OFF) {
> +			*p++ = i;
> +			*p++ = 0;
> +			*p++ = bxcr & EBC_BXCR_BAS;
> +			*p++ = EBC_BXCR_BANK_SIZE(bxcr);
> +		}
> +	}
> +
> +	devp = finddevice(ebc);
> +	if (! devp)
> +		fatal("Couldn't locate EBC node %s\n\r", ebc);
> +
> +	setprop(devp, "ranges", ranges, (p - ranges) * sizeof(u32));
> +}

So this sets the ranges for the EBC bus, but not the "regs" properties
of the child nodes.  Without that, the child nodes will not be mapped to
the correct addresses...

Did you have a plan on how to fixup the child "regs" properties so that
when the DIP switches are flipped around, the children show up
correctly?

josh

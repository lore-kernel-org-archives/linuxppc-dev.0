Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E342FDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 20:18:43 +1000 (EST)
Date: Wed, 18 Jul 2007 12:44:02 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 46/61] mpc885ads: Rework initialization.
Message-ID: <20070718124402.18197206@localhost.localdomain>
In-Reply-To: <20070718013600.GR15238@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013600.GR15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Overall looks good, though mentioned mutually exclusive SoC devices adding some pain
and extra code having relevant parts removed but not covered (see below).

I think it makes sense to work ontop of this code to address known quirks/issues though, hence will cover this.
yet, there are little chances to play with the 8xx inside this merge window, so I basically don't object from it being merged
as is.

On Tue, 17 Jul 2007 20:36:00 -0500
Scott Wood wrote:
> -#ifdef CONFIG_SERIAL_CPM_SMC1
> -	clrbits32(bcsr_io, BCSR1_RS232EN_1);
> -	clrbits32(&cp->cp_simode, 0xe0000000 >> 17);	/* brg1
> */
> -	tmpval8 = in_8(&(cp->cp_smc[0].smc_smcm)) | (SMCM_RX |
> SMCM_TX);
> -	out_8(&(cp->cp_smc[0].smc_smcm), tmpval8);
> -	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN |
> SMCMR_TEN);	/* brg1 */ -#else
> -	setbits32(bcsr_io,BCSR1_RS232EN_1);
> -	out_be16(&cp->cp_smc[0].smc_smcmr, 0);
> -	out_8(&cp->cp_smc[0].smc_smce, 0);
> -#endif

these are not just for beauty: if corresponding not-used uart regs are not cleared, second one has a
good chances to be hosed.

> -void init_scc_ioports(struct fs_platform_info *fpi)
> -{
> -	int scc_no = fs_get_scc_index(fpi->fs_no);
> +	/* The SCC3 enet registers overlap the SMC1 registers, so
> +	 * one of the two must be removed from the device tree.
> +	 */
Unfortunately,
this approach has very little chances to work. IIRC, SCC3 eth and SMC1 do have overlapping pins,
and just removing it from the tree is not going to save the world because now we have all-in-one early condensed
pins setup.

Also, we have to be very careful with corresponding ports shutdown: say turn off smc1 if scc3 is enabled: most prolly
it was turned on by the firmware/bootwrapper, and eth won't be alive.


-- 
Sincerely, Vitaly

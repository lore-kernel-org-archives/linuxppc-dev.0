Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC829DE01C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:40:13 +1000 (EST)
Message-ID: <469E4267.2040001@freescale.com>
Date: Wed, 18 Jul 2007 11:40:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 46/61] mpc885ads: Rework initialization.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>	<20070718013600.GR15238@ld0162-tx32.am.freescale.net>
	<20070718124402.18197206@localhost.localdomain>
In-Reply-To: <20070718124402.18197206@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
>>-#ifdef CONFIG_SERIAL_CPM_SMC1
>>-	clrbits32(bcsr_io, BCSR1_RS232EN_1);
>>-	clrbits32(&cp->cp_simode, 0xe0000000 >> 17);	/* brg1
>>*/
>>-	tmpval8 = in_8(&(cp->cp_smc[0].smc_smcm)) | (SMCM_RX |
>>SMCM_TX);
>>-	out_8(&(cp->cp_smc[0].smc_smcm), tmpval8);
>>-	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN |
>>SMCMR_TEN);	/* brg1 */ -#else
>>-	setbits32(bcsr_io,BCSR1_RS232EN_1);
>>-	out_be16(&cp->cp_smc[0].smc_smcmr, 0);
>>-	out_8(&cp->cp_smc[0].smc_smce, 0);
>>-#endif
> 
> 
> these are not just for beauty: if corresponding not-used uart regs are not cleared, second one has a
> good chances to be hosed.

The CPM reset should take care of that.

>>-void init_scc_ioports(struct fs_platform_info *fpi)
>>-{
>>-	int scc_no = fs_get_scc_index(fpi->fs_no);
>>+	/* The SCC3 enet registers overlap the SMC1 registers, so
>>+	 * one of the two must be removed from the device tree.
>>+	 */
> 
> Unfortunately,
> this approach has very little chances to work. IIRC, SCC3 eth and SMC1 do have overlapping pins,
> and just removing it from the tree is not going to save the world because now we have all-in-one early condensed
> pins setup.

It may not save the world, but it's needed to keep the driver from 
poking at the disabled device.

> Also, we have to be very careful with corresponding ports shutdown: say turn off smc1 if scc3 is enabled: most prolly
> it was turned on by the firmware/bootwrapper, and eth won't be alive.

The conflict is in register space, not pins -- why would the smc1 pins 
matter?

-Scott

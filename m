Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EBA51B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 04:12:09 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5033BDDDD4
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 04:12:08 +1000 (EST)
Message-Id: <3887C2A7-3566-43A9-A863-4670B039E5DA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <20090708161954.GC14979@ovro.caltech.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] edac: mpc85xx: add support for mpc83xx memory controller
Date: Wed, 8 Jul 2009 13:09:39 -0500
References: <20090708161954.GC14979@ovro.caltech.edu>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2009, at 11:19 AM, Ira W. Snyder wrote:

> Add support for the Freescale MPC83xx memory controller to the  
> existing
> driver for the Freescale MPC85xx memory controller. The only  
> difference
> between the two processors are in the CS_BNDS register parsing code.
>
> The L2 cache controller does not exist on the MPC83xx, but the OF  
> subsystem
> will not use the driver if the device is not present in the OF  
> device tree.
>
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>
> This was tested on an MPC8349EMDS-based board.
>
> I don't really like how the MCE disable works on mpc85xx (clearing the
> HID1 register), but this can be revisited when mpc86xx support gets
> added. It sucks to have this happen before the probe() routine is  
> called
> and we know what kind of hardware we're actually running on.
>
> drivers/edac/Kconfig        |    6 +++---
> drivers/edac/mpc85xx_edac.c |   38 +++++++++++++++++++++++++++ 
> +----------
> drivers/edac/mpc85xx_edac.h |    3 +++
> 3 files changed, 34 insertions(+), 13 deletions(-)

[snip]

> /************************ MC SYSFS parts  
> ***********************************/
>
> @@ -738,7 +740,8 @@ static irqreturn_t mpc85xx_mc_isr(int irq, void  
> *dev_id)
> 	return IRQ_HANDLED;
> }
>
> -static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
> +static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci,
> +					  const struct of_device_id *match)
> {
> 	struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
> 	struct csrow_info *csrow;
> @@ -784,18 +787,26 @@ static void __devinit  
> mpc85xx_init_csrows(struct mem_ctl_info *mci)
> 	}
>
> 	for (index = 0; index < mci->nr_csrows; index++) {
> -		u32 start;
> -		u32 end;
> +		u32 start, end, extra;
>
> 		csrow = &mci->csrows[index];
> 		cs_bnds = in_be32(pdata->mc_vbase + MPC85XX_MC_CS_BNDS_0 +
> 				  (index * MPC85XX_MC_CS_BNDS_OFS));
> -		start = (cs_bnds & 0xfff0000) << 4;
> -		end = ((cs_bnds & 0xfff) << 20);
> +
> +		if (match->data && match->data == MPC83xx) {
> +			start = (cs_bnds & 0x00ff0000) << 8;
> +			end   = (cs_bnds & 0x000000ff) << 24;
> +			extra = 0x00ffffff;
> +		} else {
> +			start = (cs_bnds & 0x0fff0000) << 4;
> +			end   = (cs_bnds & 0x00000fff) << 20;
> +			extra = 0x000fffff;
> +		}

I don't understand this at all.. The only difference between 83xx &  
85xx is that we should have an extra 4-bits for 36-bit physical  
addresses.

We should be able to write this code in such a way that it works for  
both 83xx & 85xx.

                 start = (cs_bnds & 0xffff0000) >> 16;
                 end = (cs_bnds & 0xffff);

		if (start == end)
			continue;
		start <<= (20 - PAGE_SHIFT);
		end <<= (20 - PAGE_SHIFT);
		end |= (1 << (20 - PAGE_SHIFT)) - 1;

- k

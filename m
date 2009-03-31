Return-Path: <wg@grandegger.com>
Message-ID: <49D21145.3060400@grandegger.com>
Date: Tue, 31 Mar 2009 14:49:09 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/8] powerpc: i2c-mpc: make I2C bus speed configurable
References: <20090331123727.853787299@denx.de>
In-Reply-To: <20090331123727.853787299@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please *FORGET* this series of patches. Only the I2C related patches are
relevant but I accidentally sent out the complete patch stack :-(. I
will resent them in a second.

Sorry for any inconvenience this has caused.

Wolfgang.

Wolfgang Grandegger wrote:
> Following (most of) Grant's suggestions to my RFC:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2009-March/069820.html
> 
> this new patch series now uses:
> 
> - the I2c node property "fsl,preserve-clocking" to overtake the
>   clock settings from the boot loader. The first patch provides this
>   feature and can be applied *without* delay. This rest will take
>   more time and discussion, I'm afraid :-(.
> 
> - the OF match table to define the I2C clock properties, especially
>   the source clock pre-scaler:
> 
>   static const struct of_device_id mpc_i2c_of_match[] = {
> 	{.compatible = "fsl,mpc5200b-i2c",
> 	 .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
> 	{.compatible = "fsl,mpc5200-i2c",
> 	 .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
> 	{.compatible = "fsl,mpc8313-i2c",
> 	 .data = (void *)FSL_I2C_DEV_SEPARATE_DFSRR, },
> 	{.compatible = "fsl,mpc8543-i2c",
> 	 .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
> 			  FSL_I2C_DEV_CLOCK_DIV2), },
> 	{.compatible = "fsl,mpc8544-i2c",
> 	 .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
> 			  FSL_I2C_DEV_CLOCK_DIV23), },
> 	/* Backward compatibility */
> 	{.compatible = "fsl-i2c", },
> 	{},
>   };
> 
>   The "data" field defines the relevant I2C flags.
> 
> - arch-specific tables and functions to get the proper Freqency
>   Divider Register (fdr). I added them to sysdev/fsl_soc.c for
>   the MPC8xxx and to platforms/52xx/mpc52xx_common.c for the
>   MPC52xx. This also solves the problem with arch-specific
>   functions, e.g. for getting the bus frequency.
> 
> - dev_dbg() and dev_info() to profit from a more descriptive output.
> 
> Hope this solution is OK now?
> 
> Thanks,
> 
> Wolfgang.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

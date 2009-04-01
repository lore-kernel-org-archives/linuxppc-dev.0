Return-Path: <wg@grandegger.com>
Message-ID: <49D31D1D.6020004@grandegger.com>
Date: Wed, 01 Apr 2009 09:51:57 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/8] powerpc: i2c-mpc: make I2C bus speed configurable
References: <20090331123727.853787299@denx.de>	
	<20090331124035.908249543@denx.de>
	<fa686aa40903310841x42876819rafe3e8bf24b8646e@mail.gmail.com>
In-Reply-To: <fa686aa40903310841x42876819rafe3e8bf24b8646e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Tue, Mar 31, 2009 at 6:37 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> This patch makes the I2C bus speed configurable by using the I2C node
>> property "clock-frequency". If the property is not defined, the old
>> fixed clock settings will be used for backward comptibility.
>>
>> The generic I2C clock properties, especially the CPU-specific source
>> clock pre-scaler are defined via the OF match table:
>>
>>  static const struct of_device_id mpc_i2c_of_match[] = {
>>        {.compatible = "fsl,mpc5200b-i2c",
>>         .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
>>        {.compatible = "fsl,mpc5200-i2c",
>>         .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
>>        {.compatible = "fsl,mpc8313-i2c",
>>         .data = (void *)FSL_I2C_DEV_SEPARATE_DFSRR, },
>>        {.compatible = "fsl,mpc8543-i2c",
>>         .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
>>                          FSL_I2C_DEV_CLOCK_DIV2), },
>>        {.compatible = "fsl,mpc8544-i2c",
>>         .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
>>                          FSL_I2C_DEV_CLOCK_DIV23), },
>>        /* Backward compatibility */
>>        {.compatible = "fsl-i2c", },
>>        {},
>>  };
> 
> 
> Instead passing in a flag (and using an ugly cast to do it) which is
> then checked inside the mpc_i2c_setclock(), you should do this
> instead:
> 
> struct fsl_i2c_match_data {
>         int static void *(setclock)(struct device_node *node, struct
> mpc_i2c *i2c, u32 clock);
>         int flags;
>         /* Other stuff can go here */
> };
> 
> static const struct of_device_id mpc_i2c_of_match[] = {
>         {.compatible = "fsl,mpc5200b-i2c",
>          .data = (struct fsl_i2c_match_data[]) { .setclock =
> mpc_i2c_setclock_mpc5200, },
>         },
>         {.compatible = "fsl,mpc5200-i2c",
>          .data = (struct fsl_i2c_match_data[]) { .setclock =
> mpc_i2c_setclock_mpc5200, },
>         },
>         {.compatible = "fsl,mpc8313-i2c",
>          .data = (struct fsl_i2c_match_data[]) { .setclock =
> mpc_i2c_setclock_separate_dfsrr, },
>         },
>         {.compatible = "fsl,mpc8543-i2c",
>          .data = (struct fsl_i2c_match_data[]) { .setclock =
> mpc_i2c_setclock_separate_dfsrr, },
>          .flags = FSL_I2C_DEV_CLOCK_DIV2,
>         },
>         {.compatible = "fsl,mpc8544-i2c",
>          .data = (struct fsl_i2c_match_data[]) { .setclock =
> mpc_i2c_setclock_separate_dfsrr, },
>          .flags = FSL_I2C_DEV_CLOCK_DIV23,
>         },
>         /* Backward compatibility */
>         {.compatible = "fsl-i2c",
>          .data = (struct fsl_i2c_match_data[]) { .setclock =
> mpc_i2c_setclock, },
>         },
>         {},
>   };
> 
> The table definition is more verbose this way, but I think it results
> in more understandable and easier to extend code.  It also adds lets
> the compiler do more type checking for you.

OK but I don't like the callback function to do the settings. We need
backward compatibility with old DTS files including the ugly "dfsrr"
property, right? Then it seems consequent to continue using i2c->flags
for that purpose and not to introduce another method. If we don't need
backward compatibility, we could drop the flags completely and just use
callback functions.

> Also, this ...
> 
>> --- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c        2009-03-31 13:25:08.000000000 +0200
>> +++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c     2009-03-31 13:34:40.531721011 +0200
>> +int fsl_i2c_get_fdr(struct device_node *node, u32 i2c_clock, u32 i2c_flags)
>> +{
>> [...]
>> +}
>> +EXPORT_SYMBOL(fsl_i2c_get_fdr);
> 
> ... and this ...
> 
>> --- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c 2009-03-31 13:25:08.000000000 +0200
>> +++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c      2009-03-31 13:28:54.309718526 +0200
>> +int fsl_i2c_get_fdr(struct device_node *node, u32 i2c_clock, u32 i2c_flags)
>> +{
>> [...]
>> +}
>> +EXPORT_SYMBOL(fsl_i2c_get_fdr);
> 
> does not work on a multiplatform kernel.  Both 8xxx and 52xx support
> can be selected at the same time.

OK, then we need different functions including stubs.

Wolfgang.

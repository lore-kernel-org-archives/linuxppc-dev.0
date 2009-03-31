Return-Path: <wg@grandegger.com>
Message-ID: <49D21EF1.9050200@grandegger.com>
Date: Tue, 31 Mar 2009 15:47:29 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
References: <20090331125028.066613801@denx.de>
	<20090331125451.600446749@denx.de>
	<20090331133953.GB3044@pengutronix.de>
In-Reply-To: <20090331133953.GB3044@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
> On Tue, Mar 31, 2009 at 02:50:29PM +0200, Wolfgang Grandegger wrote:
>> The I2c node property "fsl,preserve-clocking" allows to overtake the
>> clock settings from the boot loader and avoids the hard-coded setting.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  drivers/i2c/busses/i2c-mpc.c |   24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> Index: linux-2.6/drivers/i2c/busses/i2c-mpc.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:25:08.000000000 +0200
>> +++ linux-2.6/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:28:03.000000000 +0200
>> @@ -318,17 +318,24 @@
>>  {
>>  	int result = 0;
>>  	struct mpc_i2c *i2c;
>> +	int set_clock;
>>  
>>  	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
>>  	if (!i2c)
>>  		return -ENOMEM;
>>  
>> -	if (of_get_property(op->node, "dfsrr", NULL))
>> -		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
>> -
>> -	if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
>> -			of_device_is_compatible(op->node, "mpc5200-i2c"))
>> -		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
>> +	if (of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
>> +		set_clock = 0;
>> +	} else {
>> +		set_clock = 1;
>> +
>> +		if (of_get_property(op->node, "dfsrr", NULL))
>> +			i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
>> +
>> +		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
>> +		    of_device_is_compatible(op->node, "mpc5200-i2c"))
>> +			i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
>> +	}
>>  
>>  	init_waitqueue_head(&i2c->queue);
>>  
>> @@ -348,8 +355,9 @@
>>  			goto fail_request;
>>  		}
>>  	}
>> -	
>> -	mpc_i2c_setclock(i2c);
>> +
>> +	if (set_clock)
>> +		mpc_i2c_setclock(i2c);
> 
> Can't we drop 'set_clock' with something like this here?
> 
> +	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> +
> +		if (of_get_property(op->node, "dfsrr", NULL))
> +			i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
> +
> +		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
> +		    of_device_is_compatible(op->node, "mpc5200-i2c"))
> +			i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
> +
> +		mpc_i2c_setclock(i2c);
> +	}

No, because the I2C registers are not yet mapped.

Wolfgang.

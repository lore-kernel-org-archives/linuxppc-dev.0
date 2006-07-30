Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3D77679E0
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 02:23:06 +1000 (EST)
In-Reply-To: <20060730131440.1d4fcbe6.khali@linux-fr.org>
References: <20060609095421.7157dc53.khali@linux-fr.org>
	<20060730131440.1d4fcbe6.khali@linux-fr.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A18434C2-2C6F-4052-B3F3-AE9D2CE38BE3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] I2C-MPC: Fix up error handling
Date: Sun, 30 Jul 2006 11:23:24 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 30, 2006, at 6:14 AM, Jean Delvare wrote:

> Quoting myself:
>> Could anyone please comment on this i2c-mpc patch, and give it some
>> testing on different systems? I'm fine with the error propagation
>> fixes, but less fine with the random resets being added, and rather
>> unhappy with the "retry once more just in case" thing, which I think,
>> if really needed, should instead be implemented using the standard
>> i2c_adapter.retries mechanism.
>
> Can anyone please comment on this patch? Andrew Morton keeps  
> forwarding
> it to me, but I don't think I can accept it as is (see my complaints
> above.)

If I find some time, let me split out the error propagation so we can  
get that fix up stream.  The other code was to handle a buggy device  
that was connected in one system I was working on.

- kumar

>> From: Kumar Gala <galak@kernel.crashing.org>
>>
>> * If we have an Unfinished (MCF) or Arbitration Lost (MAL) error and
>>   the bus is still busy reset the controller.  This prevents the
>>   controller from getting in a hung state for transactions for other
>>   devices.
>>
>> * Fixed up propogating the errors from i2c_wait.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Greg KH <greg@kroah.com>
>> Signed-off-by: Andrew Morton <akpm@osdl.org>
>> ---
>>
>>  drivers/i2c/busses/i2c-mpc.c |   43 ++++++++++++++++++++++ 
>> +----------
>>  1 file changed, 31 insertions(+), 12 deletions(-)
>>
>> diff -puN drivers/i2c/busses/i2c-mpc.c~i2c-mpc-fix-up-error- 
>> handling drivers/i2c/busses/i2c-mpc.c
>> --- devel/drivers/i2c/busses/i2c-mpc.c~i2c-mpc-fix-up-error- 
>> handling	2006-06-01 20:22:55.000000000 -0700
>> +++ devel-akpm/drivers/i2c/busses/i2c-mpc.c	2006-06-01  
>> 20:22:55.000000000 -0700
>> @@ -115,11 +115,20 @@ static int i2c_wait(struct mpc_i2c *i2c,
>>
>>  	if (!(x & CSR_MCF)) {
>>  		pr_debug("I2C: unfinished\n");
>> +
>> +		/* reset the controller if the bus is still busy */
>> +		if (x & CSR_MBB)
>> +			writeccr(i2c, 0);
>> +
>>  		return -EIO;
>>  	}
>>
>>  	if (x & CSR_MAL) {
>>  		pr_debug("I2C: MAL\n");
>> +
>> +		/* reset the controller if the bus is still busy */
>> +		if (x & CSR_MBB)
>> +			writeccr(i2c, 0);
>>  		return -EIO;
>>  	}
>>
>> @@ -160,7 +169,7 @@ static void mpc_i2c_stop(struct mpc_i2c
>>  static int mpc_write(struct mpc_i2c *i2c, int target,
>>  		     const u8 * data, int length, int restart)
>>  {
>> -	int i;
>> +	int i, ret;
>>  	unsigned timeout = i2c->adap.timeout;
>>  	u32 flags = restart ? CCR_RSTA : 0;
>>
>> @@ -172,15 +181,17 @@ static int mpc_write(struct mpc_i2c *i2c
>>  	/* Write target byte */
>>  	writeb((target << 1), i2c->base + MPC_I2C_DR);
>>
>> -	if (i2c_wait(i2c, timeout, 1) < 0)
>> -		return -1;
>> +	ret = i2c_wait(i2c, timeout, 1);
>> +	if (ret < 0)
>> +		return ret;
>>
>>  	for (i = 0; i < length; i++) {
>>  		/* Write data byte */
>>  		writeb(data[i], i2c->base + MPC_I2C_DR);
>>
>> -		if (i2c_wait(i2c, timeout, 1) < 0)
>> -			return -1;
>> +		ret = i2c_wait(i2c, timeout, 1);
>> +		if (ret < 0)
>> +			return ret;
>>  	}
>>
>>  	return 0;
>> @@ -190,7 +201,7 @@ static int mpc_read(struct mpc_i2c *i2c,
>>  		    u8 * data, int length, int restart)
>>  {
>>  	unsigned timeout = i2c->adap.timeout;
>> -	int i;
>> +	int i, ret;
>>  	u32 flags = restart ? CCR_RSTA : 0;
>>
>>  	/* Start with MEN */
>> @@ -201,8 +212,9 @@ static int mpc_read(struct mpc_i2c *i2c,
>>  	/* Write target address byte - this time with the read flag set */
>>  	writeb((target << 1) | 1, i2c->base + MPC_I2C_DR);
>>
>> -	if (i2c_wait(i2c, timeout, 1) < 0)
>> -		return -1;
>> +	ret = i2c_wait(i2c, timeout, 1);
>> +	if (ret < 0)
>> +		return ret;
>>
>>  	if (length) {
>>  		if (length == 1)
>> @@ -214,8 +226,9 @@ static int mpc_read(struct mpc_i2c *i2c,
>>  	}
>>
>>  	for (i = 0; i < length; i++) {
>> -		if (i2c_wait(i2c, timeout, 0) < 0)
>> -			return -1;
>> +		ret = i2c_wait(i2c, timeout, 0);
>> +		if (ret < 0)
>> +			return ret;
>>
>>  		/* Generate txack on next to last byte */
>>  		if (i == length - 2)
>> @@ -246,8 +259,13 @@ static int mpc_xfer(struct i2c_adapter *
>>  			return -EINTR;
>>  		}
>>  		if (time_after(jiffies, orig_jiffies + HZ)) {
>> -			pr_debug("I2C: timeout\n");
>> -			return -EIO;
>> +			writeccr(i2c, 0);
>> +
>> +			/* try one more time before we error */
>> +			if (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
>> +				pr_debug("I2C: timeout\n");
>> +				return -EIO;
>> +			}
>>  		}
>>  		schedule();
>>  	}
>> @@ -325,6 +343,7 @@ static int fsl_i2c_probe(struct platform
>>  			goto fail_irq;
>>  		}
>>
>> +	writeccr(i2c, 0);
>>  	mpc_i2c_setclock(i2c);
>>  	platform_set_drvdata(pdev, i2c);
>
> -- 
> Jean Delvare

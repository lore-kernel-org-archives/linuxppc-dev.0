Return-Path: <robherring2@gmail.com>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75859B6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Aug 2011 09:22:43 +1000 (EST)
Received: by yib12 with SMTP id 12so1908215yib.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Aug 2011 16:22:39 -0700 (PDT)
Message-ID: <4E3C7B3C.1090100@gmail.com>
Date: Fri, 05 Aug 2011 18:22:36 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] i2c: move of_i2c_register_devices call into core
References: <1312579468-19365-1-git-send-email-robherring2@gmail.com>
	<1312579468-19365-2-git-send-email-robherring2@gmail.com>
	<20110805225435.GA6404@ponder.secretlab.ca>
In-Reply-To: <20110805225435.GA6404@ponder.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Warren <swarren@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Dirk Brandewie <dirk.brandewie@gmail.com>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	Jean Delvare <khali@linux-fr.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant,

On 08/05/2011 05:54 PM, Grant Likely wrote:
> On Fri, Aug 05, 2011 at 04:24:26PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> All callers of of_i2c_register_devices are immediately preceded by a call
>> to i2c_add_adapter or i2c_add_numbered_adapter. Add call to
>> of_i2c_register_devices and remove all other callers.
>>
>> This causes a module dependency loop that is resolved by the next commit.
> 
> Wrong way around.  Don't break bisectability.  I'll leave it up to Ben
> and Jean on weather or not they want to move this code.  I intend to
> do the same thing for spi/gpio, but I maintain those subsystems so I
> get to choose.  i2c is not up to me.
> 

Well, I know, but it's only broken for bisect in the case of both being
modules. So it's only run-time brokenness. That's better than the 3
months it was broken before. I couldn't come up with a better way. The
choices I thought of were:

-temporarily exporting and adding of_i2c_register_devices to i2c.h and
then removing it. I'm not a fan of adding that churn.
-just combining it all into 1 patch.
-reverse the order and leave i2c device registration broken for 1
commit. Thinking some more about it, perhaps that is a bit better than
broken module loading. Guess it depends if you are doing modules or
built-in.

Rob

> g.
> 
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Jochen Friedrich <jochen@scram.de>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
>> Cc: Stephen Warren <swarren@nvidia.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-i2c@vger.kernel.org
>> ---
>>  drivers/i2c/busses/i2c-cpm.c     |    6 ------
>>  drivers/i2c/busses/i2c-ibm_iic.c |    4 ----
>>  drivers/i2c/busses/i2c-mpc.c     |    2 --
>>  drivers/i2c/busses/i2c-pxa.c     |    2 --
>>  drivers/i2c/busses/i2c-tegra.c   |    3 ---
>>  drivers/i2c/i2c-core.c           |    4 ++++
>>  6 files changed, 4 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
>> index b1d9cd2..7cbc82a 100644
>> --- a/drivers/i2c/busses/i2c-cpm.c
>> +++ b/drivers/i2c/busses/i2c-cpm.c
>> @@ -42,7 +42,6 @@
>>  #include <linux/dma-mapping.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_platform.h>
>> -#include <linux/of_i2c.h>
>>  #include <sysdev/fsl_soc.h>
>>  #include <asm/cpm.h>
>>  
>> @@ -673,11 +672,6 @@ static int __devinit cpm_i2c_probe(struct platform_device *ofdev)
>>  	dev_dbg(&ofdev->dev, "hw routines for %s registered.\n",
>>  		cpm->adap.name);
>>  
>> -	/*
>> -	 * register OF I2C devices
>> -	 */
>> -	of_i2c_register_devices(&cpm->adap);
>> -
>>  	return 0;
>>  out_shut:
>>  	cpm_i2c_shutdown(cpm);
>> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
>> index 3c110fb..5ba15ba 100644
>> --- a/drivers/i2c/busses/i2c-ibm_iic.c
>> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
>> @@ -42,7 +42,6 @@
>>  #include <linux/io.h>
>>  #include <linux/i2c.h>
>>  #include <linux/of_platform.h>
>> -#include <linux/of_i2c.h>
>>  
>>  #include "i2c-ibm_iic.h"
>>  
>> @@ -759,9 +758,6 @@ static int __devinit iic_probe(struct platform_device *ofdev)
>>  	dev_info(&ofdev->dev, "using %s mode\n",
>>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
>>  
>> -	/* Now register all the child nodes */
>> -	of_i2c_register_devices(adap);
>> -
>>  	return 0;
>>  
>>  error_cleanup:
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index 107397a..a433f59 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -18,7 +18,6 @@
>>  #include <linux/sched.h>
>>  #include <linux/init.h>
>>  #include <linux/of_platform.h>
>> -#include <linux/of_i2c.h>
>>  #include <linux/slab.h>
>>  
>>  #include <linux/io.h>
>> @@ -637,7 +636,6 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
>>  		dev_err(i2c->dev, "failed to add adapter\n");
>>  		goto fail_add;
>>  	}
>> -	of_i2c_register_devices(&i2c->adap);
>>  
>>  	return result;
>>  
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index d603646..c1c2885 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -29,7 +29,6 @@
>>  #include <linux/errno.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/i2c-pxa.h>
>> -#include <linux/of_i2c.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/err.h>
>>  #include <linux/clk.h>
>> @@ -1147,7 +1146,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
>>  		printk(KERN_INFO "I2C: Failed to add bus\n");
>>  		goto eadapt;
>>  	}
>> -	of_i2c_register_devices(&i2c->adap);
>>  
>>  	platform_set_drvdata(dev, i2c);
>>  
>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
>> index 2440b74..9ec0a58 100644
>> --- a/drivers/i2c/busses/i2c-tegra.c
>> +++ b/drivers/i2c/busses/i2c-tegra.c
>> @@ -26,7 +26,6 @@
>>  #include <linux/delay.h>
>>  #include <linux/slab.h>
>>  #include <linux/i2c-tegra.h>
>> -#include <linux/of_i2c.h>
>>  
>>  #include <asm/unaligned.h>
>>  
>> @@ -653,8 +652,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>>  		goto err_free_irq;
>>  	}
>>  
>> -	of_i2c_register_devices(&i2c_dev->adapter);
>> -
>>  	return 0;
>>  err_free_irq:
>>  	free_irq(i2c_dev->irq, i2c_dev);
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 131079a..011e195 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/init.h>
>>  #include <linux/idr.h>
>>  #include <linux/mutex.h>
>> +#include <linux/of_i2c.h>
>>  #include <linux/of_device.h>
>>  #include <linux/completion.h>
>>  #include <linux/hardirq.h>
>> @@ -863,6 +864,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>>  		i2c_scan_static_board_info(adap);
>>  
>> +	/* Register devices from the device tree */
>> +	of_i2c_register_devices(adap);
>> +
>>  	/* Notify drivers */
>>  	mutex_lock(&core_lock);
>>  	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_new_adapter);
>> -- 
>> 1.7.4.1
>>

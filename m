Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C84567D27
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 06:39:20 +1100 (EST)
In-Reply-To: <200612072035.56514.arnd@arndb.de>
References: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
	<200612072035.56514.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BB352E50-2E63-45D7-BE87-7318D8092DB5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc: Call of_register_i2c_devices() for fsl-i2c.
Date: Thu, 7 Dec 2006 13:39:15 -0600
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2006, at 1:35 PM, Arnd Bergmann wrote:

> On Thursday 07 December 2006 18:35, Scott Wood wrote:
>> --- a/arch/powerpc/sysdev/fsl_soc.c
>> +++ b/arch/powerpc/sysdev/fsl_soc.c
>> @@ -345,6 +345,8 @@ static int __init fsl_i2c_of_init(void)
>>                                                      
>> fsl_i2c_platform_data));
>>                 if (ret)
>>                         goto unreg;
>> +
>> +               of_register_i2c_devices(np, i);
>>         }
>
> I get the impression that this fsl_i2c_of_init function is doing the
> probing in the opposite way it should. Instead of searching the
> whole device tree for type="i2c" devices to call
> platform_device_register_simple, can't you use of_platform_bus_probe
> to create the i2c device in the first place, and then have a
> of_platform_driver that calls of_register_i2c_devices() in its probe
> function?

Some of this is historic because of arch/ppc legacy.  We explicitly  
spec'd devices as platform devices.  At some point we will move to  
having the drivers be proper of_platform drivers instead of platform  
drivers.

- k

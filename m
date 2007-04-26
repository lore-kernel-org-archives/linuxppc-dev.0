Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 2D5E8DDEC8
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 02:55:40 +1000 (EST)
Message-ID: <4630D9AB.2040605@mvista.com>
Date: Thu, 26 Apr 2007 09:56:11 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add EDAC platform devices for 85xx
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
In-Reply-To: <9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Apr 25, 2007, at 7:37 PM, Dave Jiang wrote:
>
>   
>> +		mem-ctrl@2000 {
>> +			device_type = "mem-ctrl";
>> +			compatible = "85xx";
>>     
> I'm concerned this is too generic.
>   
I'm supposing not all 85xx uses the same soc? Is there something more
appropriate you can suggest? Thx!

>> +			reg = <2000 1000>;
>> +			interrupt-parent = <&mpic>;
>> +			interrupts = <2 2>;
>> +		};
>> +
>> +		l2-cache@20000 {
>> +			device_type = "l2-cache";
>> +			compatible = "85xx";
>> +			reg = <20000 1000>;
>> +			cache-line-size = <20>;	// 32 bytes
>> +			cache-size = <40000>;	// L2, 256K
>> +			32-bit;
>>     
>
> Why the 32-bit?
>   
No reason particular. Bad assumption. I will remove it.
>> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
>> fsl_soc.c
>> index 8a123c7..a0beb8b 100644
>> --- a/arch/powerpc/sysdev/fsl_soc.c
>> +++ b/arch/powerpc/sysdev/fsl_soc.c
>> @@ -1103,3 +1103,118 @@ err:
>>  arch_initcall(cpm_smc_uart_of_init);
>>
>>  #endif /* CONFIG_8xx */
>> +
>> +/* platform device setup for EDAC */
>>     
>
> Why not have the EDAC code for 85xx use of_device?
>
>   
I will give that a try.

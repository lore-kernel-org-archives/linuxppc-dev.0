Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9812DDEBB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 10:10:18 +1100 (EST)
Date: Thu, 8 Nov 2007 02:10:23 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1789464912.20071108021023@emcraft.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re[2]: [PATCH 2/2] [PPC 44x] enable L2-cache for ALPR, Katmai, Ocotea,
	and Taishan
In-Reply-To: <20071107040608.GB22637@lixom.net>
References: <1416528026.20071107014041@emcraft.com>
	<20071107040608.GB22637@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: Yuri Tikhonov <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi Olof,

On 07.11.2007, 7:06:08 you wrote:
...
>> +
>> +config L2_CACHE
>> +       bool "Enable Level-2 Cache"
>> +       depends on NOT_COHERENT_CACHE && (KATMAI || TAISHAN || OCOTEA || ALPR)
>> +       default y
>> +       help
>> +         This option enables L2-cache on ppc44x controllers.
>> +         If unsure, say Y.

> That's a very generic config name. Maybe something like PPC_4XX_L2_CACHE?

 Having the ppc_machdep for invalidating L2-cache lines we can avoid introducing the new configuration options at all. See below.

> Is there ever a case where a user would NOT want l2 cache enabled (and
> disabled permanently enough to rebuild the kernel instead of giving a
> kernel command line option?)

 Theoretically - yes. Internal SRAM of ppc44x may be used for something else than L2 cache. 

 Admittedly, the configuration option was necessary for me to enable or disable my L2-cache synchronization routine in the generic dma_sync() function. Per your suggestion, now, instead of introducing the new kernel option I initialize the L2-cache sync ppc_machdep right in the L2-cache enable routine: thus if the user will not enable L2-cache (will not want internal SRAM to act as L2-cache and will not call the L2-cache enabling routine) then my new ppc_machdep will remain set to zero and will not affect on SRAM used for some specific purposes.

...

>> @@ -567,7 +569,9 @@ void __init platform_init(unsigned long r3, unsigned long r4,
>>  #ifdef CONFIG_KGDB
>>         ppc_md.early_serial_map = alpr_early_serial_map;
>>  #endif
>> +#ifdef CONFIG_L2_CACHE
>>         ppc_md.init = alpr_init;
>> +#endif

> Why do you take out the above calls if the new option is selected? Seems
> odd to remove something that worked(?) before.

 Umm.. Quite the contrary, the option selected made these calls avaiable. Though it doesn't matter anymore since there is no CONFIG_L2_CACHE option anymore (i.e. all the four boards dealt with in this patch-set now have L2-cache enabled regardless of configuration, as it was initially).

>>         ppc_md.restart = alpr_restart;
>>  }
>>  

...

>> +#ifdef CONFIG_L2_CACHE
>> +static void __init katmai_init(void)
>> +{
>> +       ibm440gx_l2c_setup(&clocks);
>> +}
>> +#endif
>> +
>>  void __init platform_init(unsigned long r3, unsigned long r4,
>>                           unsigned long r5, unsigned long r6, unsigned long r7)
>>  {
>> @@ -599,4 +607,7 @@ void __init platform_init(unsigned long r3, unsigned long r4,
>>         ppc_md.early_serial_map = katmai_early_serial_map;
>>  #endif
>>         ppc_md.restart = katmai_restart;
>> +#ifdef CONFIG_L2_CACHE
>> +       ppc_md.init = katmai_init;
>> +#endif

> See comment above. Should the above init be called for all configs, not just
> when L2_CACHE is enabled?

> Also, it looks like the init function is the same on every board. It would
> be better to make a common function instead of duplicating it everywhere.

 Agree, but perhaps it's not the case for the ppc branch. Will do this in the powerpc branch as soon as support for these boards will be ported there.. by someone :)

Regards,
 Yuri 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com

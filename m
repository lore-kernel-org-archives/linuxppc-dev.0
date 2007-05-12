Return-Path: <tnt@246tNt.com>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A99EDDE1F
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 09:52:28 +1000 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4CNqLGt015042
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 01:52:21 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <46465295.90309@246tNt.com>
Date: Sun, 13 May 2007 01:49:41 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<11790019223925-git-send-email-tnt@246tNt.com>
	<11790019234031-git-send-email-tnt@246tNt.com>
	<200705130127.08761.arnd@arndb.de>
In-Reply-To: <200705130127.08761.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

Arnd Bergmann wrote:
> On Saturday 12 May 2007, Sylvain Munaut wrote:
>
>> This patch adds support for the core of the BestComm API
>> for the Freescale MPC5200(b). The BestComm engine is a
>> microcode-controlled / tasks-based DMA used by several
>> of the onchip devices.
>
> Have you tried if the DMA engine API that is now in drivers/dma
> fits the hardware interfaces? Could they perhaps be extended to
> do so?
BestComm has some pretty specific needs and I think trying to
somehow extends a generic interface to fit those needs would just
pollute it.

However, you could totally implement a "DMA devices" that would just
use a simple "copy from there to there" task using this BestComm driver.
So other part of the kernel (like network) could use that interface to
use the dma engine ...

>> +struct bcom_engine *bcom = NULL;
>
> Doe this need to be a global? In most cases, you get a cleaner driver by
> passing around pointers through function calls and your own device specific
> data structures.
>
> If you can't make that work, at least give it a longer name to make sure
> it doesn't conflict with other global variables.
Yes, it kinda needs to be global. It's used in many many places.
I didn't like it much but I finally resigned because it ends up being a
lot easier, and more readable code to have it global.

I can rename it bcom_eng, quite unlikely to conflict.


>> +/* ======================================================================== */
>> +/* Public and private API                                                   */
>> +/* ======================================================================== */
>> +
>> +/* Debug Dump */
>> +
>> +#define BCOM_DPRINTK(a,b...) printk(KERN_DEBUG DRIVER_NAME ": " a, ## b)
>
> just use pr_debug in new code instead of defining your own
>
Noted, will be fixed.

>> +static int __init
>> +mpc52xx_bcom_init(void)
>> +{
>> +	struct device_node *ofn_bcom, *ofn_sram;
>> +	struct resource res_bcom;
>> +
>> +	int rv;
>> +
>> +	/* Find the bestcomm node. If none, fails 'silently' since
>> +	 * we may just be on another platform */
>> +	ofn_bcom = of_find_compatible_node(
>> +			NULL, "dma-controller", "mpc5200-bestcomm");
>> +	if (!ofn_bcom)
>> +		return -ENODEV;
>
> I know, my usual rant is getting old, but why is this one not an
> of_platform_driver? It's not shared with arch/ppc or with arch/mips,
> and it's not needed before module_init() time.
It needs to be initialized before _any_ other driver that uses bestcomm.
When compiled as module that could be an of_platform_driver but when
built-in there is apparently no way to ensure it's going to be probed
first. (At least no clean way ... )

>> +
>> +#ifdef MODULE
>> +module_init(mpc52xx_bcom_init);
>> +module_exit(mpc52xx_bcom_exit);
>> +#endif
>> +
>> +/* If we're not a module, we must make sure everything is setup before anyone */
>> +/* tries to use us ... */
>> +#ifndef MODULE
>> +subsys_initcall(mpc52xx_bcom_init);
>> +#endif
>
> You can make it subsys_initcall() unconditionally. If the driver gets built
> as a module, it will turn into module_init() by itself.
Oh, great, I didn't know that. I guess the module_exit still has to be
conditionnal.

>> +MODULE_DESCRIPTION("Freescale MPC52xx BestComm DMA");
>> +MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
>> +MODULE_AUTHOR("Andrey Volkov <avolkov@varma-el.com>");
>> +MODULE_AUTHOR("Dale Farnsworth <dfarnsworth@mvista.com>");
>> +MODULE_LICENSE("GPL v2");
>
> I didn't know that you could have multiple MODULE_AUTHOR statements.
> Does this do the right thing with /bin/modinfo?
I wasn't sure before I tried it myself. And it worked, so I used it ;)

tnt@efika:~$ /sbin/modinfo bestcomm-core
filename:      
/lib/modules/2.6.21-efika-g4f18984a-dirty/kernel/arch/powerpc/sysdev/bestcomm/bestcomm-core.ko
license:        GPL v2
author:         Sylvain Munaut <tnt@246tNt.com>
author:         Andrey Volkov <avolkov@varma-el.com>
author:         Dale Farnsworth <dfarnsworth@mvista.com>
description:    Freescale MPC52xx BestComm DMA
depends:       
vermagic:       2.6.21-efika-g4f18984a-dirty mod_unload

>> +EXPORT_SYMBOL(bcom);
>> +EXPORT_SYMBOL(bcom_dump_status);
>> +EXPORT_SYMBOL(bcom_dump_task);
>> +EXPORT_SYMBOL(bcom_dump_bdring);
>> +EXPORT_SYMBOL(bcom_task_alloc);
>> +EXPORT_SYMBOL(bcom_task_release);
>> +EXPORT_SYMBOL(bcom_load_image);
>> +EXPORT_SYMBOL(bcom_set_initiator);
>> +EXPORT_SYMBOL(bcom_enable);
>> +EXPORT_SYMBOL(bcom_disable);
>
> Please put every EXPORT_SYMBOL right after the definition of the symbol
> you are exporting.
Ok, I've seen both style I didn't know which to use.
> Why don't you use EXPORT_SYMBOL_GPL?
Why would I ? Is it mandatory now ?
I don't really have an objection to non-gpl modules to use the exported
functions ...
If Dale or Andrey have, they're free to post a patch to change to _GPL.



    Sylvain

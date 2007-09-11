Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58BA5DDF1F
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 01:57:39 +1000 (EST)
In-Reply-To: <20070911155558.GA10743@lixom.net>
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
	<20070911141821.GA32545@lixom.net>
	<230A7A2A-3184-4BC2-B8AC-C94090B532B0@kernel.crashing.org>
	<20070911155558.GA10743@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11B85E70-D643-4013-A9B3-59CD76F9D7AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Tue, 11 Sep 2007 11:00:28 -0500
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 11, 2007, at 10:55 AM, Olof Johansson wrote:

> On Tue, Sep 11, 2007 at 10:50:18AM -0500, Kumar Gala wrote:
>>>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>>>> b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>>>> index 3a5c3c4..1e2eba8 100644
>>>> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>>>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>>>> @@ -181,6 +181,23 @@ static int __init mpc8544_ds_probe(void)
>>>>  	}
>>>>  }
>>>>
>>>> +/*
>>>> + * Called very early, device-tree isn't unflattened
>>>> + */
>>>> +static int __init mpc8572_ds_probe(void)
>>>> +{
>>>> +	unsigned long root = of_get_flat_dt_root();
>>>> +
>>>> +	if (of_flat_dt_is_compatible(root, "MPC8572DS")) {
>>>> +#ifdef CONFIG_PCI
>>>> +		primary_phb_addr = 0x8000;
>>>> +#endif
>>>> +		return 1;
>>>> +	} else {
>>>> +		return 0;
>>>> +	}
>>>> +}
>>>> +
>>>>  define_machine(mpc8544_ds) {
>>>>  	.name			= "MPC8544 DS",
>>>>  	.probe			= mpc8544_ds_probe,
>>>> @@ -194,3 +211,17 @@ define_machine(mpc8544_ds) {
>>>>  	.calibrate_decr		= generic_calibrate_decr,
>>>>  	.progress		= udbg_progress,
>>>>  };
>>>> +
>>>> +define_machine(mpc8572_ds) {
>>>> +	.name			= "MPC8572 DS",
>>>> +	.probe			= mpc8572_ds_probe,
>>>> +	.setup_arch		= mpc85xx_ds_setup_arch,
>>>> +	.init_IRQ		= mpc85xx_ds_pic_init,
>>>> +#ifdef CONFIG_PCI
>>>> +	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
>>>> +#endif
>>>> +	.get_irq		= mpic_get_irq,
>>>> +	.restart		= mpc85xx_restart,
>>>> +	.calibrate_decr		= generic_calibrate_decr,
>>>> +	.progress		= udbg_progress,
>>>> +};
>>>
>>> How different are these boards really? Could you just detect  
>>> MPC85xxDS
>>> and have a generic platform for them, or are they different  
>>> enough that
>>> you need individual ones for it?
>>
>> I wanted a different probe.  I figured having a different struct  
>> was a
>> simple solution.
>
> Seems like the only reason to need that is the setting of
> primary_phb_addr.  Can't that information be derived out of the device
> tree instead? That'd avoid alot of code duplication (code that  
> includes
> ifdefs, FWIW :-)

well the ifdefs are orthogonal.  We don't have a way of knowing  
primary from the device tree today.

> It just seems like a slippery slope. I'm not objecting directly to  
> this
> patch, but I think it should be fixed for the longer term.

Once we have a clean way of knowing primary PHB than I'm happy to fixup.

- k

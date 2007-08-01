Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 815C0DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 03:38:52 +1000 (EST)
In-Reply-To: <002901c7d44b$bc5b6350$6e00a8c0@ESIDT>
References: <1185928568.21198.10.camel@server>
	<EFF6CD19-4700-41CD-843F-9AF818F7DB82@kernel.crashing.org>
	<002901c7d44b$bc5b6350$6e00a8c0@ESIDT>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <29EB3377-0E61-46CD-A673-FED6F51B32D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for Wind River SBC8641D board
Date: Wed, 1 Aug 2007 12:39:59 -0500
To: <joe.hamman@embeddedspecialties.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 1, 2007, at 9:53 AM, Joe Hamman wrote:

> Sorry, I replied to only the first question.
>
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Wednesday, August 01, 2007 9:18 AM
>> To: joe.hamman@embeddedspecialties.com
>> Cc: linuxppc-embedded@ozlabs.org
>> Subject: Re: [PATCH] Add support for Wind River SBC8641D board
>>
>>
>> On Jul 31, 2007, at 7:36 PM, Joe Hamman wrote:
>>
>>> Add support for Wind River's SBC8641D reference board.
>>
>> Is this a single core or dual core chip?
>>
>
> The board I have is single core.  I would have to see if I could  
> get access
> to a dual core board.

You may want to think about having both core's in the .dts and build  
with !CONFIG_SMP for single and CONFIG_SMP for dual.

>>> +void
>>> +sbc8641d_show_cpuinfo(struct seq_file *m)
>>> +{
>>> +	struct device_node *root;
>>> +	uint memsize = total_memory;
>>> +	const char *model = "";
>>> +	uint svid = mfspr(SPRN_SVR);
>>> +
>>> +	seq_printf(m, "Vendor\t\t: Wind River Systems\n");
>>> +
>>> +	root = of_find_node_by_path("/");
>>> +	if (root)
>>> +		model = get_property(root, "model", NULL);
>>> +	seq_printf(m, "Machine\t\t: %s\n", model);
>>> +	of_node_put(root);
>>> +
>>> +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
>>> +	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
>>> +}
>>> +
>>
>> This is mostly redundant with the basic show cpu info, do you need
>> your own?
>
> The plan is to add code to read the EEPROM device and show more info.

Ok thats fine than.

>>> +
>>> +/*
>>> + * Called very early, device-tree isn't unflattened
>>> + */
>>> +static int __init sbc8641d_probe(void)
>>> +{
>>> +	unsigned long root = of_get_flat_dt_root();
>>> +
>>> +	if (of_flat_dt_is_compatible(root, "mpc86xx"))
>>> +		return 1;	/* Looks good */
>>
>> the check you have is too generic, you probably need something more
>> specific in the top level compatible property.
>
> Will do.
>
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +
>>> +void
>>> +sbc8641d_restart(char *cmd)
>>> +{
>>> +	void __iomem *rstcr;
>>> +
>>> +	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);
>>> +
>>> +	local_irq_disable();
>>> +
>>> +	/* Assert reset request to Reset Control Register */
>>> +	out_be32(rstcr, 0x2);
>>> +
>>> +	/* not reached */
>>> +}
>>> +
>>> +
>>> +long __init
>>> +sbc8641d_time_init(void)
>>> +{
>>> +	unsigned int temp;
>>> +
>>> +	/* Set the time base to zero */
>>> +	mtspr(SPRN_TBWL, 0);
>>> +	mtspr(SPRN_TBWU, 0);
>>> +
>>> +	temp = mfspr(SPRN_HID0);
>>> +	temp |= HID0_TBEN;
>>> +	mtspr(SPRN_HID0, temp);
>>> +	asm volatile("isync");
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +
>>> +define_machine(sbc8641d) {
>>> +	.name			= "SBC8641D",
>>> +	.probe			= sbc8641d_probe,
>>> +	.setup_arch		= sbc8641d_setup_arch,
>>> +	.init_IRQ		= sbc8641d_init_irq,
>>> +	.show_cpuinfo		= sbc8641d_show_cpuinfo,
>>> +	.get_irq		= mpic_get_irq,
>>> +	.restart		= sbc8641d_restart,
>>> +	.time_init		= sbc8641d_time_init,
>>> +	.calibrate_decr		= generic_calibrate_decr,
>>> +	.progress		= udbg_progress,
>>> +
>>> +#ifdef CONFIG_GEN_RTC
>>> +	/* RTC interface, using functions in include/asm-generic/rtc.h */
>>> +	.get_rtc_time		= get_rtc_time,
>>> +	.set_rtc_time		= set_rtc_time,
>>> +#endif
>>> +};

Noticed you didn't have an PCIe support.  Is that something that  
exists on the board?  is wired to anything?

>>> diff -purN -X dontdiff linux-2.6/drivers/net/gianfar.h linux-2.6-
>>> esi/drivers/net/gianfar.h
>>> --- linux-2.6/drivers/net/gianfar.h	2007-07-31 10:15:39.000000000
>>> -0500
>>> +++ linux-2.6-esi/drivers/net/gianfar.h	2007-07-31
>>> 10:39:10.000000000 -0500
>>> @@ -131,7 +131,7 @@ extern const char gfar_driver_version[];
>>>  #define DEFAULT_RXCOUNT	16
>>>  #define DEFAULT_RXTIME	4
>>>
>>> -#define TBIPA_VALUE		0x1f
>>> +#define TBIPA_VALUE		0x1e
>>
>> we need to turn this into a config option or something.
>
> I was a little concerned when I saw a hard-coded address.  I never  
> would
> have found the conflict with the QUAD PHY (it starts at 0x1f and  
> increments
> for each device) without your help.
>
> Let me know what you think and I'll put something together.

I'll talk to someone here and see.  I think a simple thing would be  
to make it a Kconfig'ble option to what the value is for TBIPA_VALUE  
and default to 0x1f but changeable in your defconfig.

>>>  #define MIIMCFG_INIT_VALUE	0x00000007
>>>  #define MIIMCFG_RESET           0x80000000
>>>  #define MIIMIND_BUSY            0x00000001
>>>

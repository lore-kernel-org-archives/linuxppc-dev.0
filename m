Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 662A4DDE45
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 14:31:42 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D41BC@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D41BC@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <501DC278-8AC8-4874-A213-3CC729E86B8B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Mon, 5 Feb 2007 21:30:41 -0600
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2007, at 9:15 PM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Monday, February 05, 2007 11:04 PM
>> To: Li Yang-r58472
>> Cc: Paul; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>>
>>
>> On Feb 5, 2007, at 3:09 AM, Li Yang wrote:
>>
>> You have no description about what this patch does and why its  
>> needed.
>
> Add cpu and board specific initialization code for USB to work in both
> MPH and DR mode for MPC8349EMDS PB board.
>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> arch/powerpc/platforms/83xx/Kconfig       |    4 ++
>>> arch/powerpc/platforms/83xx/mpc834x_sys.c |   77 +++++++++++++++++++
>>> ++++++++++
>>> arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 +++++++++
>>> 3 files changed, 104 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
>>> platforms/83xx/Kconfig
>>> index edcd5b8..5371645 100644
>>> --- a/arch/powerpc/platforms/83xx/Kconfig
>>> +++ b/arch/powerpc/platforms/83xx/Kconfig
>>> @@ -59,4 +59,8 @@ config PPC_MPC836x
>>> 	select PPC_INDIRECT_PCI
>>> 	default y if MPC8360E_PB
>>> +config 834x_USB_SUPPORT
>>> +	bool
>>> +	default y if MPC834x_SYS && (USB || USB_GADGET)
>>> +
>>
>> Do we really need to introduce a new config option?
>
> It will be neater to make use of the Kconfig feature than judging all
> the macros and module variations.  It will be a very long #if defined
> the other way.

Huh, it would look like:

#if defined(CONFIG_USB) || defined(CONFIG_USB_GADGET).

Not very long.

>>> @@ -65,6 +120,7 @@ static void __init mpc834x_sys_setup_arch(void)
>>> 			loops_per_jiffy = 50000000 / HZ;
>>> 		of_node_put(np);
>>> 	}
>>> +
>>> #ifdef CONFIG_PCI
>>> 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
>>> 		add_bridge(np);
>>> @@ -72,6 +128,27 @@ static void __init mpc834x_sys_setup_arch(void)
>>> 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
>>> #endif
>>> +#ifdef CONFIG_834x_USB_SUPPORT
>>> +	mpc834x_usb_cfg();
>>> +
>>> +	/* Map BCSR area */
>>> +	np = of_find_node_by_name(NULL, "bcsr");
>>> +	if (np != 0) {
>>> +		struct resource res;
>>> +
>>> +		of_address_to_resource(np, 0, &res);
>>> +		bcsr_regs = ioremap(res.start, res.end - res.start + 1);
>>> +		of_node_put(np);
>>> +	}
>>> +
>>> +	/*
>>> +	 * if SYS board is plug into PIB board,
>>> +	 * force to use the PHY on SYS board
>>> +	 * */
>>> +	if ((bcsr_regs != NULL) && !(bcsr_regs[5] & BCSR5_INT_USB))
>>> +		bcsr_regs[5] |= BCSR5_INT_USB;
>>
>> why not fold all this into mpc834x_usb_cfg() since its all board
>> related config code?
>
> Well, not quite.  The code in mpc834x_usb_cfg() is 834x CPU specific
> initialization.  The bcsr is board specific.

If that's the case what are they doing in mpc834x_sys.c which is a  
board specific file?

Rather, I see the setting for SCCR/SICRL as board specific.

- k

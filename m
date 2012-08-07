Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7698D2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 04:55:26 +1000 (EST)
Message-ID: <50216492.60904@freescale.com>
Date: Tue, 7 Aug 2012 13:55:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 3/3 v4] powerpc/mpic: FSL MPIC error interrupt support.
References: <1344257045-11200-1-git-send-email-Varun.Sethi@freescale.com>
 <FAD36277-EA2D-49D7-BD98-2F132CA886AA@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D15BA0D@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D15BA0D@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Hamciuc Bogdan-BHAMCIU1 <bhamciu1@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2012 11:22 AM, Sethi Varun-B16395 wrote:
> 
> 
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Monday, August 06, 2012 9:23 PM
>> To: Sethi Varun-B16395
>> Cc: linuxppc-dev@lists.ozlabs.org; Hamciuc Bogdan-BHAMCIU1
>> Subject: Re: [PATCH 3/3 v4] powerpc/mpic: FSL MPIC error interrupt
>> support.
>>
>>
>> On Aug 6, 2012, at 7:44 AM, Varun Sethi wrote:
>>
>>> All SOC device error interrupts are muxed and delivered to the core as
>>> a single MPIC error interrupt. Currently all the device drivers
>>> requiring access to device errors have to register for the MPIC error
>>> interrupt as a shared interrupt.
>>>
>>> With this patch we add interrupt demuxing capability in the mpic
>>> driver, allowing device drivers to register for their individual error
>> interrupts.
>>> This is achieved by handling error interrupts in a cascaded fashion.
>>>
>>> MPIC error interrupt is handled by the "error_int_handler", which
>>> subsequently demuxes it using the EISR and delivers it to the
>>> respective drivers.
>>>
>>> The error interrupt capability is dependent on the MPIC EIMR register,
>>> which was introduced in FSL MPIC version 4.1 (P4080 rev2). So, error
>>> interrupt demuxing capability is dependent on the MPIC version and can
>>> be used for versions >= 4.1.
>>>
>>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>>> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@freescale.com> [In the
>>> initial version of the patch we were using handle_simple_irq as the
>>> handler for cascaded error interrupts, this resulted in issues in case
>>> of threaded isrs (with RT kernel). This issue was debugged by Bogdan
>>> and decision was taken to use the handle_level_irq handler]
>>> ---
>>> arch/powerpc/include/asm/mpic.h    |   16 ++++
>>> arch/powerpc/sysdev/Makefile       |    2 +-
>>> arch/powerpc/sysdev/fsl_mpic_err.c |  153
>> ++++++++++++++++++++++++++++++++++++
>>> arch/powerpc/sysdev/mpic.c         |   45 ++++++++++-
>>> arch/powerpc/sysdev/mpic.h         |   22 +++++
>>> 5 files changed, 236 insertions(+), 2 deletions(-) create mode 100644
>>> arch/powerpc/sysdev/fsl_mpic_err.c
>>>
>>> diff --git a/arch/powerpc/include/asm/mpic.h
>>> b/arch/powerpc/include/asm/mpic.h index e14d35d..6c8e53b 100644
>>> --- a/arch/powerpc/include/asm/mpic.h
>>> +++ b/arch/powerpc/include/asm/mpic.h
>>> @@ -118,6 +118,9 @@
>>> #define MPIC_MAX_CPUS		32
>>> #define MPIC_MAX_ISU		32
>>>
>>> +#define MPIC_MAX_ERR      32
>>> +#define MPIC_FSL_ERR_INT  16
>>> +
>>> /*
>>>  * Tsi108 implementation of MPIC has many differences from the
>>> original one  */ @@ -270,6 +273,7 @@ struct mpic
>>> 	struct irq_chip		hc_ipi;
>>> #endif
>>> 	struct irq_chip		hc_tm;
>>> +	struct irq_chip		hc_err;
>>> 	const char		*name;
>>> 	/* Flags */
>>> 	unsigned int		flags;
>>> @@ -283,6 +287,8 @@ struct mpic
>>> 	/* vector numbers used for internal sources (ipi/timers) */
>>> 	unsigned int		ipi_vecs[4];
>>> 	unsigned int		timer_vecs[8];
>>> +	/* vector numbers used for FSL MPIC error interrupts */
>>> +	unsigned int		err_int_vecs[MPIC_MAX_ERR];
>>>
>>> 	/* Spurious vector to program into unused sources */
>>> 	unsigned int		spurious_vec;
>>> @@ -306,6 +312,11 @@ struct mpic
>>> 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
>>> 	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
>>>
>>> +	/* ioremap'ed base for error interrupt registers */
>>> +	u32 __iomem	*err_regs;
>>> +	/* error interrupt config */
>>> +	u32			err_int_config_done;
>>
>> I thought we were going to remove this as it don't really provide any
>> value.
>>
> [Sethi Varun-B16395] We need a way to determine that irq handle got registered for 
> Mpic error interrupt, only then can we go ahead and assign individual (cascaded)
> error interrupts. Initially we were doing the same thing while translating 
> error interrupt specifier, now we are registering the handler in mpic_init.

If you register it in mpic_init(), when would you be unsure about
whether the registration has happened?

-Scott

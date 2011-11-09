Return-Path: <r58472@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0848A1007D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 19:32:16 +1100 (EST)
Received: from mail116-am1 (localhost.localdomain [127.0.0.1])	by
 mail116-am1-R.bigfish.com (Postfix) with ESMTP id 620831280506	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 08:32:00 +0000 (UTC)
Received: from AM1EHSMHS019.bigfish.com (unknown [10.3.201.242])	by
 mail116-am1.bigfish.com (Postfix) with ESMTP id EF42E1950054	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 08:31:17 +0000 (UTC)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
Date: Wed, 9 Nov 2011 08:31:23 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052BD4A4@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320409889-14408-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4305C.6030303@freescale.com>
 <3F607A5180246847A760FD34122A1E052BC6F1@039-SN1MPN1-004.039d.mgd.msft.net>
 <4EB997C5.60105@freescale.com>
In-Reply-To: <4EB997C5.60105@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: Wood Scott-B07421
>Sent: Wednesday, November 09, 2011 4:58 AM
>To: Li Yang-R58472
>Cc: Wood Scott-B07421; Zhao Chenhui-B35336; linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
>
>On 11/08/2011 04:05 AM, Li Yang-R58472 wrote:
>>> Subject: Re: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
>>>
>>> On 11/04/2011 07:31 AM, Zhao Chenhui wrote:
>>>> +static int is_corenet;
>>>> +static void __cpuinit smp_85xx_setup_cpu(int cpu_nr);
>>>> +
>>>> +#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
>>>
>>> Why PPC32?
>>
>> Not sure if it is the same for e5500.  E5500 support will be verified
>later.
>
>It's better to have 64-bit silently do nothing here?
>
>>>> +	flush_disable_L1();
>>>
>>> You'll also need to take down L2 on e500mc.
>>
>> Right.  E500mc support is beyond this patch series.  We will work on it
>after the e500v2 support is finalized.
>
>I saw some support with "is_corenet"...  If we don't support e500mc, make
>sure the code doesn't try to run on e500mc.

The is_corenet code is just a start of the e500mc support and is far from c=
omplete.

>
>This isn't an e500v2-only BSP you're putting the code into. :-)

Yes, I know.  But it will take quite some time to perfect the support for d=
ifferent type of cores.  I'd like to make the effort into stages.  We want =
to push the e500v2 support in first and add support to newer cores later so=
 that we don't need to re-spin the patches again and again.  And the upstre=
am kernel can get the PM functionality at least for e500v2 earlier.  Anyway=
, we need to update the title of the patch to be more specific on e500v2.

>
>>>> +	tmp =3D 0;
>>>> +	if (cpu_has_feature(CPU_FTR_CAN_NAP))
>>>> +		tmp =3D HID0_NAP;
>>>> +	else if (cpu_has_feature(CPU_FTR_CAN_DOZE))
>>>> +		tmp =3D HID0_DOZE;
>>>
>>> Those FTR bits are for what we can do in idle, and can be cleared if
>>> the user sets CONFIG_BDI_SWITCH.
>>
>> It is powersave_nap variable shows what we can do in idle.
>
>No, that shows what the user wants to do in idle.
>
>> I think it's correct to use the CPU_FTR_CAN_* macro as CPU capability.
>
>This is 85xx-specific code.  We always can, and want to, nap here (though
>the way we enter nap will be different on e500mc and up) -- even if it's
>broken to use it for idle (such as on p4080, which would miss doorbells as
>wake events).

Ok.  Will stick to Nap.

>
>>>> +static void __cpuinit smp_85xx_reset_core(int nr) {
>>>> +	__iomem u32 *vaddr, *pir_vaddr;
>>>> +	u32 val, cpu_mask;
>>>> +
>>>> +	/* If CoreNet platform, use BRR as release register. */
>>>> +	if (is_corenet) {
>>>> +		cpu_mask =3D 1 << nr;
>>>> +		vaddr =3D ioremap(get_immrbase() + MPC85xx_BRR_OFF, 4);
>>>> +	} else {
>>>> +		cpu_mask =3D 1 << (24 + nr);
>>>> +		vaddr =3D ioremap(get_immrbase() + MPC85xx_ECM_EEBPCR_OFF, 4);
>>>> +	}
>>>
>>> Please use the device tree node, not get_immrbase().
>>
>> The get_immrbase() implementation uses the device tree node.
>
>I mean the guts node.  get_immrbase() should be avoided where possible.

Ok.  I got your point to use offset from guts.

>
>Also, some people might care about latency to enter/exit deep sleep.
>Searching through the device tree at this point (rather than on init)
>slows that down.

Actually the get_immrbase() is smarter than you thought. :) It only search =
the device tree on first call and returns the saved value on follow up call=
s.

>
>>>> +static int __cpuinit smp_85xx_map_bootpg(u32 page) {
>>>> +	__iomem u32 *bootpg_ptr;
>>>> +	u32 bptr;
>>>> +
>>>> +	/* Get the BPTR */
>>>> +	bootpg_ptr =3D ioremap(get_immrbase() + MPC85xx_BPTR_OFF, 4);
>>>> +
>>>> +	/* Set the BPTR to the secondary boot page */
>>>> +	bptr =3D MPC85xx_BPTR_EN | (page & MPC85xx_BPTR_BOOT_PAGE_MASK);
>>>> +	out_be32(bootpg_ptr, bptr);
>>>> +
>>>> +	iounmap(bootpg_ptr);
>>>> +	return 0;
>>>> +}
>>>
>>> Shouldn't the boot page already be set by U-Boot?
>>
>> The register should be lost after a deep sleep.   Better to do it again.
>
>How can it be lost after a deep sleep if we're relying on it to hold our
>wakeup code?

In order to wake up from deep sleep, the boot page has been set to the deep=
 sleep restoration function.  We need to set it back to the bootpage from u=
-boot.

>
>It's not "better to do it again" if we're making a bad assumption about
>the code and the table being in the same page.

Currently we are reusing the whole boot page including the spin-table from =
u-boot.  Are you suggesting to move just the boot page to kernel?

>
>>>>  	local_irq_save(flags);
>>>>
>>>> -	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
>>>> +	out_be32(&epapr->pir, hw_cpu);
>>>>  #ifdef CONFIG_PPC32
>>>> -	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
>>>> +#ifdef CONFIG_HOTPLUG_CPU
>>>> +	if (system_state =3D=3D SYSTEM_RUNNING) {
>>>> +		out_be32(&epapr->addr_l, 0);
>>>> +		smp_85xx_map_bootpg((u32)(*cpu_rel_addr >> PAGE_SHIFT));
>>>
>>> Why is this inside PPC32?
>>
>> Not tested on 64-bit yet.  Might require a different implementation on
>PPC64.
>
>Please make a reasonable effort to do things in a way that works on both.
>It shouldn't be a big deal to test that it doesn't break booting on p5020.

Will do.  But in stages.

>
>>>>  	if (!ioremappable)
>>>> -		flush_dcache_range((ulong)bptr_vaddr,
>>>> -				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
>>>> +		flush_dcache_range((ulong)epapr,
>>>> +				(ulong)epapr + sizeof(struct epapr_entry));
>>>
>>> We don't wait for the core to come up on 64-bit?
>>
>> Not sure about it.  But at least the normal boot up should be tested on
>P5020, right?
>
>Well, that's a special case in that it only has one secondary. :-)
>
>Or we could be getting lucky with timing.  It's not a new issue with this
>patch, it just looks odd.

We will look into it more when doing the e5500 support.

- Leo

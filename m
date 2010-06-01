Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8959AB7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Jun 2010 02:06:37 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o51G6Xo5013293 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 1 Jun 2010 09:06:33 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o51G6c6V023983
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 1 Jun 2010 11:06:38 -0500 (CDT)
Message-ID: <4C053008.50306@freescale.com>
Date: Tue, 01 Jun 2010 11:06:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Martyn Welch <martyn.welch@ge.com>
Subject: Re: [PATCH] PowerPC: Remove hardcoded BAT configuration of IMMR in
	CPM	early debug console
References: <20100528151836.5889.10393.stgit@ES-J7S4D2J.amer.consind.ge.com>	<4BFFECF1.9060809@freescale.com>
	<4C050295.408@ge.com> <4C050E84.2010602@ge.com>
In-Reply-To: <4C050E84.2010602@ge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2010 08:43 AM, Martyn Welch wrote:
>>>> diff --git a/arch/powerpc/kernel/head_32.S
>>>> b/arch/powerpc/kernel/head_32.S
>>>> index e025e89..861cace 100644
>>>> --- a/arch/powerpc/kernel/head_32.S
>>>> +++ b/arch/powerpc/kernel/head_32.S
>>>> @@ -1194,12 +1194,13 @@ setup_disp_bat:
>>>>    #endif /* CONFIG_BOOTX_TEXT */
>>>>
>>>>    #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
>>>> +#define PPC_EARLY_DEBUG_CPM_ADDR
>>>> ASM_CONST(CONFIG_PPC_EARLY_DEBUG_CPM_ADDR)
>>>>    setup_cpm_bat:
>>>> -    lis    r8, 0xf000
>>>> +    lis    r8, PPC_EARLY_DEBUG_CPM_ADDR@ha
>>>>        ori    r8, r8,    0x002a
>>>>        mtspr    SPRN_DBAT1L, r8
>>>>
>>>> -    lis    r11, 0xf000
>>>> +    lis    r11, PPC_EARLY_DEBUG_CPM_ADDR@ha
>>>>        ori    r11, r11, (BL_1M<<  2) | 2
>>>>        mtspr    SPRN_DBAT1U, r11
>>>>
>>> Only the physical address should depend on where IMMR is.  We should
>>> use fixmap instead of an arbitrary address for the effective address.
>>> There's a existing FIX_EARLY_DEBUG_BASE, but it's only 128 KiB so
>>> we'll have to either grow it, or map only a subset of IMMR.
>>>
>>>
>>
>> I think that's a more fundamental change to CPM early debug than I can
>> handle right now.

Is IMMRBASE on your board at some address that has a low likelihood of 
conflicting when treated as a kernel effective address?

>>> Plus, CONFIG_PPC_EARLY_DEBUG_CPM_ADDR points to the TX descriptor, not
>>> to the beginning of IMMR, so you should mask off the lower 20 bits
>>> (the offset is probably less than 64K, and the BAT might just ignore
>>> the extra bits anyway, but why take chances?).
>>>
>>>
>>
>> I assume that an extra instruction "andi   r8, r8, 0xfff0" after each
>> "lis" instruction  would be what you are looking for?
>>
>>
> "andis" even.

"lis r8, (PPC_EARLY_DEBUG_CPM_ADDR & 0xfff00000)@h" should work too.

-Scott

Return-Path: <martyn.welch@ge.com>
Received: from exprod5og107.obsmtp.com (exprod5og107.obsmtp.com [64.18.0.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 938D7B7D74
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Jun 2010 18:06:22 +1000 (EST)
Message-ID: <4C0610F8.6020801@ge.com>
Date: Wed, 02 Jun 2010 09:06:16 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] PowerPC: Remove hardcoded BAT configuration of IMMR in
	CPM	early debug console
References: <20100528151836.5889.10393.stgit@ES-J7S4D2J.amer.consind.ge.com>	<4BFFECF1.9060809@freescale.com>
	<4C050295.408@ge.com> <4C050E84.2010602@ge.com>
	<4C053008.50306@freescale.com>
In-Reply-To: <4C053008.50306@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On 06/01/2010 08:43 AM, Martyn Welch wrote:
>>>>> diff --git a/arch/powerpc/kernel/head_32.S
>>>>> b/arch/powerpc/kernel/head_32.S
>>>>> index e025e89..861cace 100644
>>>>> --- a/arch/powerpc/kernel/head_32.S
>>>>> +++ b/arch/powerpc/kernel/head_32.S
>>>>> @@ -1194,12 +1194,13 @@ setup_disp_bat:
>>>>>    #endif /* CONFIG_BOOTX_TEXT */
>>>>>
>>>>>    #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
>>>>> +#define PPC_EARLY_DEBUG_CPM_ADDR
>>>>> ASM_CONST(CONFIG_PPC_EARLY_DEBUG_CPM_ADDR)
>>>>>    setup_cpm_bat:
>>>>> -    lis    r8, 0xf000
>>>>> +    lis    r8, PPC_EARLY_DEBUG_CPM_ADDR@ha
>>>>>        ori    r8, r8,    0x002a
>>>>>        mtspr    SPRN_DBAT1L, r8
>>>>>
>>>>> -    lis    r11, 0xf000
>>>>> +    lis    r11, PPC_EARLY_DEBUG_CPM_ADDR@ha
>>>>>        ori    r11, r11, (BL_1M<<  2) | 2
>>>>>        mtspr    SPRN_DBAT1U, r11
>>>>>
>>>> Only the physical address should depend on where IMMR is.  We should
>>>> use fixmap instead of an arbitrary address for the effective address.
>>>> There's a existing FIX_EARLY_DEBUG_BASE, but it's only 128 KiB so
>>>> we'll have to either grow it, or map only a subset of IMMR.
>>>>
>>>>
>>>
>>> I think that's a more fundamental change to CPM early debug than I can
>>> handle right now.
>
> Is IMMRBASE on your board at some address that has a low likelihood of
> conflicting when treated as a kernel effective address?

It's at 0x0f000000, is seems ok, but then I'm not sure I fully
understand kernel effective addresses.

Martyn

-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189

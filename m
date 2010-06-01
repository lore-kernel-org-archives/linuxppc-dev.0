Return-Path: <martyn.welch@ge.com>
Received: from exprod5og101.obsmtp.com (exprod5og101.obsmtp.com [64.18.0.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5156B7D1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Jun 2010 23:43:38 +1000 (EST)
Message-ID: <4C050E84.2010602@ge.com>
Date: Tue, 01 Jun 2010 14:43:32 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] PowerPC: Remove hardcoded BAT configuration of IMMR in
	CPM	early debug console
References: <20100528151836.5889.10393.stgit@ES-J7S4D2J.amer.consind.ge.com>	<4BFFECF1.9060809@freescale.com>
	<4C050295.408@ge.com>
In-Reply-To: <4C050295.408@ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Martyn Welch wrote:
> Scott Wood wrote:
>   
>> On 05/28/2010 10:18 AM, Martyn Welch wrote:
>>     
>>> The CPM early debug console hardcodes the BAT to cover the IMMR at
>>> 0xf0000000. The IMMR (on the mpc8270 at the very least) can be set to a
>>> number of locations with bootstrap configuration, which are outside the
>>> hardcoded BAT configuration.
>>>
>>> This patch determines the correct location at which to configure a BAT
>>> during the boot process from the supplied PPC_EARLY_DEBUG_CPM_ADDR.
>>>
>>> Signed-off-by: Martyn Welch<martyn.welch@ge.com>
>>> ---
>>>
>>>   arch/powerpc/kernel/head_32.S    |    5 +++--
>>>   arch/powerpc/sysdev/cpm_common.c |    4 +++-
>>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/head_32.S
>>> b/arch/powerpc/kernel/head_32.S
>>> index e025e89..861cace 100644
>>> --- a/arch/powerpc/kernel/head_32.S
>>> +++ b/arch/powerpc/kernel/head_32.S
>>> @@ -1194,12 +1194,13 @@ setup_disp_bat:
>>>   #endif /* CONFIG_BOOTX_TEXT */
>>>
>>>   #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
>>> +#define PPC_EARLY_DEBUG_CPM_ADDR
>>> ASM_CONST(CONFIG_PPC_EARLY_DEBUG_CPM_ADDR)
>>>   setup_cpm_bat:
>>> -    lis    r8, 0xf000
>>> +    lis    r8, PPC_EARLY_DEBUG_CPM_ADDR@ha
>>>       ori    r8, r8,    0x002a
>>>       mtspr    SPRN_DBAT1L, r8
>>>
>>> -    lis    r11, 0xf000
>>> +    lis    r11, PPC_EARLY_DEBUG_CPM_ADDR@ha
>>>       ori    r11, r11, (BL_1M << 2) | 2
>>>       mtspr    SPRN_DBAT1U, r11
>>>       
>> Only the physical address should depend on where IMMR is.  We should
>> use fixmap instead of an arbitrary address for the effective address.
>> There's a existing FIX_EARLY_DEBUG_BASE, but it's only 128 KiB so
>> we'll have to either grow it, or map only a subset of IMMR.
>>
>>     
>
> I think that's a more fundamental change to CPM early debug than I can
> handle right now.
>
>   
>> Plus, CONFIG_PPC_EARLY_DEBUG_CPM_ADDR points to the TX descriptor, not
>> to the beginning of IMMR, so you should mask off the lower 20 bits
>> (the offset is probably less than 64K, and the BAT might just ignore
>> the extra bits anyway, but why take chances?).
>>
>>     
>
> I assume that an extra instruction "andi   r8, r8, 0xfff0" after each
> "lis" instruction  would be what you are looking for?
>
>   
"andis" even.

Martyn

> Martyn
>
>   
>> -Scott
>>     
>
>
>   


-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189

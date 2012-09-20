Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D43542C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 23:36:44 +1000 (EST)
Subject: Re: [PATCH][v2] powerpc/mm: using two zones for freescale 64 bit
 kernel
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <ED492CCEAF882048BC2237DE806547C9079ED987@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Thu, 20 Sep 2012 08:36:24 -0500
Message-Id: <B042FA91-05A5-4AE8-BCCE-74F843491F50@kernel.crashing.org>
References: <1345805425-3829-1-git-send-email-Shaohui.Xie@freescale.com>
 <9EADE983-F25D-41BC-8A04-E69A20BF68E3@kernel.crashing.org>
 <1347233868.2385.128.camel@pasglop>
 <ED492CCEAF882048BC2237DE806547C9079ED987@039-SN2MPN1-013.039d.mgd.msft.net>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Cc: Hu Mingkai-B21284 <B21284@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Chen Yuanquan-B41889 <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 20, 2012, at 5:14 AM, Xie Shaohui-B21989 wrote:

>>> On Thu, 2012-08-30 at 15:49 -0500, Kumar Gala wrote:
>>>> On Aug 24, 2012, at 5:50 AM, Shaohui Xie wrote:
>>>>=20
>>>>> PowerPC platform only supports ZONE_DMA zone for 64bit kernel, so
>>>>> all the memory will be put into this zone. If the memory size is
>>>>> greater than the device's DMA capability and device uses
>>>>> dma_alloc_coherent to allocate memory, it will get an address
>>>>> which is over the device's DMA addressing, the device will fail.
>>>>>=20
>>>>> So we split the memory to two zones: zone ZONE_DMA32 &
>>>>> ZONE_NORMAL, since we already allocate PCICSRBAR/PEXCSRBAR right
>>>>> below the 4G boundary (if the lowest PCI address is above 4G), so
>>>>> we constrain the DMA zone ZONE_DMA32 to 2GB, also, we clear flag
>>>>> __GFP_DMA &
>>>>> __GFP_DMA32 and set __GFP_DMA32 only if the device's dma_mask <
>>>>> total memory size. By doing this, devices which cannot DMA all the
>>>>> memory will be limited to ZONE_DMA32, but devices which can DMA
>>>>> all
>>> the memory will not be affected by this limitation.
>>>>>=20
>>>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>>>> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>>>>> Signed-off-by: Chen Yuanquan <B41889@freescale.com>
>>>>> ---
>>>>> changes for v2:
>>>>> 1. use a config option for using two zones (ZONE_DMA32 &
>>>>> ZONE_NORMAL) in freescale 64 bit kernel.
>>>>>=20
>>>=20
>>> There must have been a misunderstanding. I think this should be a
>>> runtime choice, possibly by the platform code. Any reason that can't =
be
>> done ?
>>>=20
>> [S.H] Do you mean this:
>>=20
>> phys_addr_t platform_dma_size (maybe a default value should be used, =
then
>> platform code will change it)
>>=20
>> if (top_of_ram > platform_dma_size)
>> 	max_zone_pfns[ZONE_DMA] =3D platform_dma_size >> PAGE_SHIFT; =
else
>> 	max_zone_pfns[ZONE_DMA] =3D top_of_ram >> PAGE_SHIFT;
>>=20
>> max_zone_pfns[ZONE_NORMAL] =3D top_of_ram >> PAGE_SHIFT;
>>=20
>>> Also how does Intel do it ?
>> [S.H] below are codes in Intel:
>>=20
>> 403 void __init zone_sizes_init(void)
>> 404 {
>> 405         unsigned long max_zone_pfns[MAX_NR_ZONES];
>> 406
>> 407         memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
>> 408
>> 409 #ifdef CONFIG_ZONE_DMA
>> 410         max_zone_pfns[ZONE_DMA]         =3D MAX_DMA_PFN;
>> 411 #endif
>> 412 #ifdef CONFIG_ZONE_DMA32
>> 413         max_zone_pfns[ZONE_DMA32]       =3D MAX_DMA32_PFN;
>> 414 #endif
>> 415         max_zone_pfns[ZONE_NORMAL]      =3D max_low_pfn;
>> 416 #ifdef CONFIG_HIGHMEM
>> 417         max_zone_pfns[ZONE_HIGHMEM]     =3D max_pfn;
>> 418 #endif
>> 419
>>=20
>> For x86_64, there is no CONFIG_HIGHMEM, so there will be three zones:
>> ZONE_DMA/ZONE_DMA32/ZONE_NORMAL.
>>=20
> [S.H] Hello, Ben,
>=20
> I have some questions, though I'm still expecting your comments.
> PPC does not have ZONE_DMA32 by default, if we want to use it, we need =
to add "config ZONE_DMA32" in Kconfig first.
> If setting multiple zones without ZONE_DMA, kmalloc in =
"include/linux/slab_def.h" will fail if it uses flag GFP_DMA.
> For the runtime choice in 64-bit kernel, what exactly multiple zones =
should be used?
> "ZONE_DMA & ZONE_NORMAL" or "ZONE_DMA & ZONE_DMA32 & ZONE_NORMAL"?
> Then what the size should be set for them respectively?
>=20
> Please comment, Thanks!

I think Ben is saying that Kconfig would enable ZONE_DMA32 for all =
PPC64, but make it runtime/per platform how we setup the zone's such =
that either ZONE_DMA32 is set to MAX_DMA32_PFN or it set to same value =
as ZONE_DMA.

However that's just a guess.

- k=

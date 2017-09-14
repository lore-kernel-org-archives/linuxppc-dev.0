Return-Path: <roy.pledge@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0081.outbound.protection.outlook.com [104.47.1.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtSjB6Lr6zDrWJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 05:07:57 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Leo Li <leoyang.li@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "Madalin-cristian
 Bucur" <madalin.bucur@nxp.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "oss@buserror.net" <oss@buserror.net>
Subject: Re: [v4 07/11] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
Date: Thu, 14 Sep 2017 19:07:50 +0000
Message-ID: <DB6PR04MB29990A7A076761DDACCC1904866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-8-git-send-email-roy.pledge@nxp.com>
 <20170914140014.taz7qwphfqm66kw7@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/14/2017 10:00 AM, Catalin Marinas wrote:=0A=
> On Thu, Aug 24, 2017 at 04:37:51PM -0400, Roy Pledge wrote:=0A=
>> diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c=
=0A=
>> index ff8998f..e31c843 100644=0A=
>> --- a/drivers/soc/fsl/qbman/bman.c=0A=
>> +++ b/drivers/soc/fsl/qbman/bman.c=0A=
>> @@ -154,7 +154,7 @@ struct bm_mc {=0A=
>>   };=0A=
>>   =0A=
>>   struct bm_addr {=0A=
>> -	void __iomem *ce;	/* cache-enabled */=0A=
>> +	void *ce;		/* cache-enabled */=0A=
>>   	void __iomem *ci;	/* cache-inhibited */=0A=
>>   };=0A=
> =0A=
> You dropped __iomem from ce, which is fine since it is now set via=0A=
> memremap. However, I haven't seen (at least not in this patch), a change=
=0A=
> to bm_ce_in() which still uses __raw_readl().=0A=
> =0A=
> (it may be worth checking this code with sparse, it may warn about this)=
=0A=
Thanks, you're correct I missed this. I will fix this (and the qman =0A=
version) and run sparse.=0A=
> =0A=
>> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman=
/bman_portal.c=0A=
>> index 39b39c8..bb03503 100644=0A=
>> --- a/drivers/soc/fsl/qbman/bman_portal.c=0A=
>> +++ b/drivers/soc/fsl/qbman/bman_portal.c=0A=
>> @@ -91,7 +91,6 @@ static int bman_portal_probe(struct platform_device *p=
dev)=0A=
>>   	struct device_node *node =3D dev->of_node;=0A=
>>   	struct bm_portal_config *pcfg;=0A=
>>   	struct resource *addr_phys[2];=0A=
>> -	void __iomem *va;=0A=
>>   	int irq, cpu;=0A=
>>   =0A=
>>   	pcfg =3D devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);=0A=
>> @@ -123,23 +122,34 @@ static int bman_portal_probe(struct platform_devic=
e *pdev)=0A=
>>   	}=0A=
>>   	pcfg->irq =3D irq;=0A=
>>   =0A=
>> -	va =3D ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), =
0);=0A=
>> -	if (!va) {=0A=
>> -		dev_err(dev, "ioremap::CE failed\n");=0A=
>> +	/*=0A=
>> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable=0A=
>> +	 * (coherent) mapping for the portal on both architectures but that=0A=
>> +	 * isn't currently available in the kernel.  Because of HW differences=
=0A=
>> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with non=
=0A=
>> +	 * cacheable mappings=0A=
>> +	 */=0A=
> =0A=
> This comment mentions "cacheable/non-shareable (coherent)". Was this=0A=
> meant for ARM platforms? Because non-shareable is not coherent, nor is=0A=
> this combination guaranteed to work with different CPUs and=0A=
> interconnects.=0A=
My wording is poor I should have been clearer that non-shareable =3D=3D =0A=
non-coherent.  I will fix this.=0A=
=0A=
We do understand that cacheable/non shareable isn't supported on all =0A=
CPU/interconnect combinations but we have verified with ARM that for the =
=0A=
CPU/interconnects we have integrated QBMan on our use is OK. The note is =
=0A=
here to try to explain why the mapping is different right now. Once we =0A=
get the basic QBMan support integrated for ARM we do plan to try to have =
=0A=
patches integrated that enable the cacheable mapping as it gives a =0A=
significant performance boost.  This is a step 2 as we understand the =0A=
topic is complex and a little controversial so I think treating it as an =
=0A=
independent change will be easier than mixing it with the less =0A=
interesting changes in this patchset.=0A=
=0A=
> =0A=
>> +#ifdef CONFIG_PPC=0A=
>> +	/* PPC requires a cacheable/non-coherent mapping of the portal */=0A=
>> +	pcfg->addr_virt_ce =3D memremap(addr_phys[0]->start,=0A=
>> +				resource_size(addr_phys[0]), MEMREMAP_WB);=0A=
>> +#else=0A=
>> +	/* ARM can use a write combine mapping. */=0A=
>> +	pcfg->addr_virt_ce =3D memremap(addr_phys[0]->start,=0A=
>> +				resource_size(addr_phys[0]), MEMREMAP_WC);=0A=
>> +#endif=0A=
> =0A=
> Nitpick: you could define something like QBMAN_MAP_ATTR to be different=
=0A=
> between PPC and the rest and just keep a single memremap() call.=0A=
I will change this - it will be a little more compact.=0A=
> =0A=
> One may complain that "ce" is no longer "cache enabled" but I'm=0A=
> personally fine to keep the same name for historical reasons.=0A=
Cache Enabled is also how the 'data sheet' for the processor describes =0A=
the region and I think it is useful to keep it aligned so that anyone =0A=
looking at the manual and the code can easily correlate the ter >=0A=
>> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dp=
aa_sys.h=0A=
>> index 81a9a5e..0a1d573 100644=0A=
>> --- a/drivers/soc/fsl/qbman/dpaa_sys.h=0A=
>> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h=0A=
>> @@ -51,12 +51,12 @@=0A=
>>   =0A=
>>   static inline void dpaa_flush(void *p)=0A=
>>   {=0A=
>> +	/*=0A=
>> +	 * Only PPC needs to flush the cache currently - on ARM the mapping=0A=
>> +	 * is non cacheable=0A=
>> +	 */=0A=
>>   #ifdef CONFIG_PPC=0A=
>>   	flush_dcache_range((unsigned long)p, (unsigned long)p+64);=0A=
>> -#elif defined(CONFIG_ARM)=0A=
>> -	__cpuc_flush_dcache_area(p, 64);=0A=
>> -#elif defined(CONFIG_ARM64)=0A=
>> -	__flush_dcache_area(p, 64);=0A=
>>   #endif=0A=
>>   }=0A=
> =0A=
> Dropping the private API cache maintenance is fine and the memory is WC=
=0A=
> now for ARM (mapping to Normal NonCacheable). However, do you require=0A=
> any barriers here? Normal NC doesn't guarantee any ordering.=0A=
The barrier is done in the code where the command is formed. We follow =0A=
this pattern=0A=
a) Zero the command cache line (the device never reacts to a 0 command =0A=
verb so a cast out of this will have no effect)=0A=
b) Fill in everything in the command except the command verb (byte 0)=0A=
c) Execute a memory barrier=0A=
d) Set the command verb (byte 0)=0A=
e) Flush the command=0A=
If a castout happens between d) and e) doesn't matter since it was about =
=0A=
to be flushed anyway .  Any castout before d) will not cause HW to =0A=
process the command because verb is still 0. The barrier at c) prevents =0A=
reordering so the HW cannot see the verb set before the command is formed.=
=0A=
=0A=
> =0A=
>> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman=
/qman_portal.c=0A=
>> index cbacdf4..41fe33a 100644=0A=
>> --- a/drivers/soc/fsl/qbman/qman_portal.c=0A=
>> +++ b/drivers/soc/fsl/qbman/qman_portal.c=0A=
>> @@ -224,7 +224,6 @@ static int qman_portal_probe(struct platform_device =
*pdev)=0A=
>>   	struct device_node *node =3D dev->of_node;=0A=
>>   	struct qm_portal_config *pcfg;=0A=
>>   	struct resource *addr_phys[2];=0A=
>> -	void __iomem *va;=0A=
>>   	int irq, cpu, err;=0A=
>>   	u32 val;=0A=
>>   =0A=
>> @@ -262,23 +261,34 @@ static int qman_portal_probe(struct platform_devic=
e *pdev)=0A=
>>   	}=0A=
>>   	pcfg->irq =3D irq;=0A=
>>   =0A=
>> -	va =3D ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), =
0);=0A=
>> -	if (!va) {=0A=
>> -		dev_err(dev, "ioremap::CE failed\n");=0A=
>> +	/*=0A=
>> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable=0A=
>> +	 * (coherent) mapping for the portal on both architectures but that=0A=
>> +	 * isn't currently available in the kernel.  Because of HW differences=
=0A=
>> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with non=
=0A=
>> +	 * cacheable mappings=0A=
>> +	 */=0A=
> =0A=
> Same comment as above non non-shareable.=0A=
> =0A=
>> +#ifdef CONFIG_PPC=0A=
>> +	/* PPC requires a cacheable mapping of the portal */=0A=
>> +	pcfg->addr_virt_ce =3D memremap(addr_phys[0]->start,=0A=
>> +				resource_size(addr_phys[0]), MEMREMAP_WB);=0A=
>> +#else=0A=
>> +	/* ARM can use write combine mapping for the cacheable area */=0A=
>> +	pcfg->addr_virt_ce =3D memremap(addr_phys[0]->start,=0A=
>> +				resource_size(addr_phys[0]), MEMREMAP_WT);=0A=
>> +#endif=0A=
> =0A=
> Same nitpick: a single memremap() call.=0A=
> =0A=
=0A=

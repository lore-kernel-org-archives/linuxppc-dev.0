Return-Path: <roy.pledge@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xww5d0TkSzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 04:49:07 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>, Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li
 <leoyang.li@nxp.com>, "oss@buserror.net" <oss@buserror.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v4 07/11] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
Date: Mon, 18 Sep 2017 18:48:57 +0000
Message-ID: <DB6PR04MB29996429111F806DADFEA28386630@DB6PR04MB2999.eurprd04.prod.outlook.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-8-git-send-email-roy.pledge@nxp.com>
 <20170914140014.taz7qwphfqm66kw7@localhost>
 <DB6PR04MB29990A7A076761DDACCC1904866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
 <20170915214902.5argyl7d7bz4wykf@localhost>
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

On 9/15/2017 5:49 PM, Catalin Marinas wrote:=0A=
> On Thu, Sep 14, 2017 at 07:07:50PM +0000, Roy Pledge wrote:=0A=
>> On 9/14/2017 10:00 AM, Catalin Marinas wrote:=0A=
>>> On Thu, Aug 24, 2017 at 04:37:51PM -0400, Roy Pledge wrote:=0A=
>>>> @@ -123,23 +122,34 @@ static int bman_portal_probe(struct platform_dev=
ice *pdev)=0A=
>>>>    	}=0A=
>>>>    	pcfg->irq =3D irq;=0A=
>>>>    =0A=
>>>> -	va =3D ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0])=
, 0);=0A=
>>>> -	if (!va) {=0A=
>>>> -		dev_err(dev, "ioremap::CE failed\n");=0A=
>>>> +	/*=0A=
>>>> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable=
=0A=
>>>> +	 * (coherent) mapping for the portal on both architectures but that=
=0A=
>>>> +	 * isn't currently available in the kernel.  Because of HW differenc=
es=0A=
>>>> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with no=
n=0A=
>>>> +	 * cacheable mappings=0A=
>>>> +	 */=0A=
>>>=0A=
>>> This comment mentions "cacheable/non-shareable (coherent)". Was this=0A=
>>> meant for ARM platforms? Because non-shareable is not coherent, nor is=
=0A=
>>> this combination guaranteed to work with different CPUs and=0A=
>>> interconnects.=0A=
>>=0A=
>> My wording is poor I should have been clearer that non-shareable =3D=3D=
=0A=
>> non-coherent.  I will fix this.=0A=
>>=0A=
>> We do understand that cacheable/non shareable isn't supported on all=0A=
>> CPU/interconnect combinations but we have verified with ARM that for the=
=0A=
>> CPU/interconnects we have integrated QBMan on our use is OK. The note is=
=0A=
>> here to try to explain why the mapping is different right now. Once we=
=0A=
>> get the basic QBMan support integrated for ARM we do plan to try to have=
=0A=
>> patches integrated that enable the cacheable mapping as it gives a=0A=
>> significant performance boost.=0A=
> =0A=
> I will definitely not ack those patches (at least not in the form I've=0A=
> seen, assuming certain eviction order of the bytes in a cacheline). The=
=0A=
> reason is that it is incredibly fragile, highly dependent on the CPU=0A=
> microarchitecture and interconnects. Assuming that you ever only have a=
=0A=
> single SoC with this device, you may get away with #ifdefs in the=0A=
> driver. But if you support two or more SoCs with different behaviours,=0A=
> you'd have to make run-time decisions in the driver or run-time code=0A=
> patching. We are very keen on single kernel binary image/drivers and=0A=
> architecturally compliant code (the cacheable mapping hacks are well=0A=
> outside the architecture behaviour).=0A=
> =0A=
=0A=
Let's put this particular point on hold for now, I would like to focus =0A=
on getting the basic functions merged in ASAP. I removed the comment in =0A=
question (it sort of happened naturally when I applied your other =0A=
comments) in the next revision of the patchset.  I have submitted the =0A=
patches to our automated test system for sanity checking and I will sent =
=0A=
a new patchset once I get the results.=0A=
=0A=
Thanks again for your comments - they have been very useful and have =0A=
improved the quality of the code for sure.=0A=
=0A=
>>>> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/=
dpaa_sys.h=0A=
>>>> index 81a9a5e..0a1d573 100644=0A=
>>>> --- a/drivers/soc/fsl/qbman/dpaa_sys.h=0A=
>>>> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h=0A=
>>>> @@ -51,12 +51,12 @@=0A=
>>>>    =0A=
>>>>    static inline void dpaa_flush(void *p)=0A=
>>>>    {=0A=
>>>> +	/*=0A=
>>>> +	 * Only PPC needs to flush the cache currently - on ARM the mapping=
=0A=
>>>> +	 * is non cacheable=0A=
>>>> +	 */=0A=
>>>>    #ifdef CONFIG_PPC=0A=
>>>>    	flush_dcache_range((unsigned long)p, (unsigned long)p+64);=0A=
>>>> -#elif defined(CONFIG_ARM)=0A=
>>>> -	__cpuc_flush_dcache_area(p, 64);=0A=
>>>> -#elif defined(CONFIG_ARM64)=0A=
>>>> -	__flush_dcache_area(p, 64);=0A=
>>>>    #endif=0A=
>>>>    }=0A=
>>>=0A=
>>> Dropping the private API cache maintenance is fine and the memory is WC=
=0A=
>>> now for ARM (mapping to Normal NonCacheable). However, do you require=
=0A=
>>> any barriers here? Normal NC doesn't guarantee any ordering.=0A=
>>=0A=
>> The barrier is done in the code where the command is formed. We follow=
=0A=
>> this pattern=0A=
>> a) Zero the command cache line (the device never reacts to a 0 command=
=0A=
>> verb so a cast out of this will have no effect)=0A=
>> b) Fill in everything in the command except the command verb (byte 0)=0A=
>> c) Execute a memory barrier=0A=
>> d) Set the command verb (byte 0)=0A=
>> e) Flush the command=0A=
>> If a castout happens between d) and e) doesn't matter since it was about=
=0A=
>> to be flushed anyway .  Any castout before d) will not cause HW to=0A=
>> process the command because verb is still 0. The barrier at c) prevents=
=0A=
>> reordering so the HW cannot see the verb set before the command is forme=
d.=0A=
> =0A=
> I think that's fine, the dpaa_flush() can be a no-op with non-cacheable=
=0A=
> memory (I had forgotten the details).=0A=
> =0A=
=0A=

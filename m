Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xv8Dk1l15zDrbS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 07:49:09 +1000 (AEST)
Date: Fri, 15 Sep 2017 14:49:02 -0700
From: Catalin Marinas <catalin.marinas@arm.com>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "oss@buserror.net" <oss@buserror.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v4 07/11] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
Message-ID: <20170915214902.5argyl7d7bz4wykf@localhost>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-8-git-send-email-roy.pledge@nxp.com>
 <20170914140014.taz7qwphfqm66kw7@localhost>
 <DB6PR04MB29990A7A076761DDACCC1904866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB6PR04MB29990A7A076761DDACCC1904866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 07:07:50PM +0000, Roy Pledge wrote:
> On 9/14/2017 10:00 AM, Catalin Marinas wrote:
> > On Thu, Aug 24, 2017 at 04:37:51PM -0400, Roy Pledge wrote:
> >> @@ -123,23 +122,34 @@ static int bman_portal_probe(struct platform_device *pdev)
> >>   	}
> >>   	pcfg->irq = irq;
> >>   
> >> -	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
> >> -	if (!va) {
> >> -		dev_err(dev, "ioremap::CE failed\n");
> >> +	/*
> >> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable
> >> +	 * (coherent) mapping for the portal on both architectures but that
> >> +	 * isn't currently available in the kernel.  Because of HW differences
> >> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with non
> >> +	 * cacheable mappings
> >> +	 */
> > 
> > This comment mentions "cacheable/non-shareable (coherent)". Was this
> > meant for ARM platforms? Because non-shareable is not coherent, nor is
> > this combination guaranteed to work with different CPUs and
> > interconnects.
> 
> My wording is poor I should have been clearer that non-shareable == 
> non-coherent.  I will fix this.
> 
> We do understand that cacheable/non shareable isn't supported on all 
> CPU/interconnect combinations but we have verified with ARM that for the 
> CPU/interconnects we have integrated QBMan on our use is OK. The note is 
> here to try to explain why the mapping is different right now. Once we 
> get the basic QBMan support integrated for ARM we do plan to try to have 
> patches integrated that enable the cacheable mapping as it gives a 
> significant performance boost.

I will definitely not ack those patches (at least not in the form I've
seen, assuming certain eviction order of the bytes in a cacheline). The
reason is that it is incredibly fragile, highly dependent on the CPU
microarchitecture and interconnects. Assuming that you ever only have a
single SoC with this device, you may get away with #ifdefs in the
driver. But if you support two or more SoCs with different behaviours,
you'd have to make run-time decisions in the driver or run-time code
patching. We are very keen on single kernel binary image/drivers and
architecturally compliant code (the cacheable mapping hacks are well
outside the architecture behaviour).

> >> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
> >> index 81a9a5e..0a1d573 100644
> >> --- a/drivers/soc/fsl/qbman/dpaa_sys.h
> >> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h
> >> @@ -51,12 +51,12 @@
> >>   
> >>   static inline void dpaa_flush(void *p)
> >>   {
> >> +	/*
> >> +	 * Only PPC needs to flush the cache currently - on ARM the mapping
> >> +	 * is non cacheable
> >> +	 */
> >>   #ifdef CONFIG_PPC
> >>   	flush_dcache_range((unsigned long)p, (unsigned long)p+64);
> >> -#elif defined(CONFIG_ARM)
> >> -	__cpuc_flush_dcache_area(p, 64);
> >> -#elif defined(CONFIG_ARM64)
> >> -	__flush_dcache_area(p, 64);
> >>   #endif
> >>   }
> > 
> > Dropping the private API cache maintenance is fine and the memory is WC
> > now for ARM (mapping to Normal NonCacheable). However, do you require
> > any barriers here? Normal NC doesn't guarantee any ordering.
> 
> The barrier is done in the code where the command is formed. We follow 
> this pattern
> a) Zero the command cache line (the device never reacts to a 0 command 
> verb so a cast out of this will have no effect)
> b) Fill in everything in the command except the command verb (byte 0)
> c) Execute a memory barrier
> d) Set the command verb (byte 0)
> e) Flush the command
> If a castout happens between d) and e) doesn't matter since it was about 
> to be flushed anyway .  Any castout before d) will not cause HW to 
> process the command because verb is still 0. The barrier at c) prevents 
> reordering so the HW cannot see the verb set before the command is formed.

I think that's fine, the dpaa_flush() can be a no-op with non-cacheable
memory (I had forgotten the details).

-- 
Catalin

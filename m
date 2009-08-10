Return-Path: <gary@mlbassoc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7F31DB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 22:07:10 +1000 (EST)
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id CDFB0DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 22:07:09 +1000 (EST)
Message-ID: <4A800B08.4020708@mlbassoc.com>
Date: Mon, 10 Aug 2009 05:56:56 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 03/14] powerpc: use printk_once
References: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>	<1249847649-11631-4-git-send-email-marcin.slusarz@gmail.com>	<20090810080049.GA3132@pengutronix.de>
	<1249904809.4958.4.camel@concordia>
In-Reply-To: <1249904809.4958.4.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Marcin Slusarz <marcin.slusarz@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Mon, 2009-08-10 at 10:00 +0200, Wolfram Sang wrote:
>> On Sun, Aug 09, 2009 at 09:53:58PM +0200, Marcin Slusarz wrote:
>>> Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: linuxppc-dev@ozlabs.org
>>> ---
>>>  arch/powerpc/kernel/iommu.c      |    6 +-----
>>>  arch/powerpc/kernel/irq.c        |    5 ++---
>>>  arch/powerpc/sysdev/ppc4xx_pci.c |    9 ++-------
>>>  3 files changed, 5 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>>> index fd51578..c7fa258 100644
>>> --- a/arch/powerpc/kernel/iommu.c
>>> +++ b/arch/powerpc/kernel/iommu.c
>>> @@ -502,7 +502,6 @@ static void iommu_table_clear(struct iommu_table *tbl)
>>>  struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
>>>  {
>>>  	unsigned long sz;
>>> -	static int welcomed = 0;
>>>  	struct page *page;
>>>  
>>>  	/* Set aside 1/4 of the table for large allocations. */
>>> @@ -523,11 +522,8 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
>>>  
>>>  	iommu_table_clear(tbl);
>>>  
>>> -	if (!welcomed) {
>>> -		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
>>> +	printk_once(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
>>>  		       novmerge ? "disabled" : "enabled");
>>> -		welcomed = 1;
>>> -	}
>>>  
>>>  	return tbl;
>>>  }
>>> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
>>> index f7f376e..05ebd21 100644
>>> --- a/arch/powerpc/kernel/irq.c
>>> +++ b/arch/powerpc/kernel/irq.c
>>> @@ -231,7 +231,6 @@ skip:
>>>  void fixup_irqs(cpumask_t map)
>>>  {
>>>  	unsigned int irq;
>>> -	static int warned;
>>>  
>>>  	for_each_irq(irq) {
>>>  		cpumask_t mask;
>>> @@ -246,8 +245,8 @@ void fixup_irqs(cpumask_t map)
>>>  		}
>>>  		if (irq_desc[irq].chip->set_affinity)
>>>  			irq_desc[irq].chip->set_affinity(irq, &mask);
>>> -		else if (irq_desc[irq].action && !(warned++))
>>> -			printk("Cannot set affinity for irq %i\n", irq);
>>> +		else if (irq_desc[irq].action)
>>> +			printk_once("Cannot set affinity for irq %i\n", irq);
>> Maybe we should add a loglevel to this printk (and the other one in fix_irqs)
>> while we are here?
> 
> I think you should drop it, it's stupid. If we actually care about irqs
> that don't have a set affinity we should keep a count and report that at
> the end of the loop.

In addition, this change would prevent reporting missing
affinity on more than one IRQ if there were such.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

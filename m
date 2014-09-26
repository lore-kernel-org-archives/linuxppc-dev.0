Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A66BE1A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 12:13:40 +1000 (EST)
Message-ID: <5424CB70.9020800@huawei.com>
Date: Fri, 26 Sep 2014 10:12:00 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 12/22] MIPS/Octeon/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-13-git-send-email-wangyijing@huawei.com>
 <20140925073435.GJ12423@ulmo>
In-Reply-To: <20140925073435.GJ12423@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>, Sergei
 Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 David Vrabel <david.vrabel@citrix.com>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/9/25 15:34, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:22AM +0800, Yijing Wang wrote:
> [...]
>> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> [...]
>> @@ -132,12 +132,12 @@ msi_irq_allocated:
>>  	/* Make sure the search for available interrupts didn't fail */
>>  	if (irq >= 64) {
>>  		if (request_private_bits) {
>> -			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying just one",
>> +			pr_err("octeon_setup_msi_irq: Unable to find %d free interrupts, trying just one",
>>  			       1 << request_private_bits);
> 
> Perhaps while at it make this (and other similar changes in this patch):
> 
> 	pr_err("%s(): Unable to ...", __func__, ...);

Will update it, thanks!

> 
> So that it becomes more resilient against this kind of rename?
> 
>>  			request_private_bits = 0;
>>  			goto try_only_one;
>>  		} else
>> -			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
>> +			panic("octeon_setup_msi_irq: Unable to find a free MSI interrupt");
> 
>> @@ -210,14 +210,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>  
>>  	return 0;
>>  }
>> -
> 
> This...

OK

> 
>> @@ -240,7 +239,7 @@ void arch_teardown_msi_irq(unsigned int irq)
>>  	 */
>>  	number_irqs = 0;
>>  	while ((irq0 + number_irqs < 64) &&
>> -	       (msi_multiple_irq_bitmask[index]
>> +		(msi_multiple_irq_bitmask[index]
> 
> ... and this seem like unrelated whitespace changes.

OK

> 
>>  		& (1ull << (irq0 + number_irqs))))
>>  		number_irqs++;
>>  	number_irqs++;
>> @@ -249,8 +248,8 @@ void arch_teardown_msi_irq(unsigned int irq)
>>  	/* Shift the mask to the correct bit location */
>>  	bitmask <<= irq0;
>>  	if ((msi_free_irq_bitmask[index] & bitmask) != bitmask)
>> -		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
>> -		      "interrupt (%d) not in use", irq);
>> +		panic("octeon_teardown_msi_irq: Attempted to teardown MSI "
>> +			"interrupt (%d) not in use", irq);
> 
> And the second line here also needlessly changes the indentation.

OK
> 
> Thierry
> 


-- 
Thanks!
Yijing

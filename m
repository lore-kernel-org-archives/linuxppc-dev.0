Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE5491A160A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 12:16:48 +1000 (EST)
Message-ID: <5424CC54.1040507@huawei.com>
Date: Fri, 26 Sep 2014 10:15:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>, Thierry Reding
 <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/22] PCI/MSI: Clean up struct msi_chip argument
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-2-git-send-email-wangyijing@huawei.com>
 <20140925071536.GG12423@ulmo> <alpine.DEB.2.10.1409251208420.4604@nanos>
In-Reply-To: <alpine.DEB.2.10.1409251208420.4604@nanos>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
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

On 2014/9/25 18:20, Thomas Gleixner wrote:
> On Thu, 25 Sep 2014, Thierry Reding wrote:
> 
>> On Thu, Sep 25, 2014 at 11:14:11AM +0800, Yijing Wang wrote:
>>> Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
>>> argument.
>>
>> That's not true. Out of the four drivers that you modify two use the
>> parameter. And the two that don't probably should be using it too.
>>
>> 50% is not "rarely". =)
>>
>>>           We can look up msi_chip pointer by the device pointer
>>> or irq number, so clean up msi_chip argument.
>>
>> I don't like this particular change. The idea was to keep the API object
>> oriented so that drivers wouldn't have to know where to get the MSI chip
>> from. It also makes it more resilient against code reorganizations since
>> the core code is the only place that needs to know where to get the chip
>> from.
> 
> Right. We have the same thing in the irq_chip callbacks. All of them
> take "struct irq_data", because it's already available in the core
> code and it gives easy access to all information (chip, chipdata ...)
> which is necessary for the callback implementations.

OK, I will drop this change, tglx, thanks for your review and comments!

Thanks!
Yijing.


> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing

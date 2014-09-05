Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E2C21A00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 21:41:47 +1000 (EST)
Received: by mail-lb0-f173.google.com with SMTP id c11so13316543lbj.32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 04:41:42 -0700 (PDT)
Message-ID: <5409A174.3050205@cogentembedded.com>
Date: Fri, 05 Sep 2014 15:41:40 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: wangyijing <wangyijing0307@gmail.com>
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
 <540994D4.6040500@cogentembedded.com>
 <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
In-Reply-To: <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Yijing Wang <wangyijing@huawei.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 "x86@kernel.org" <x86@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "arnab.basu@freescale.com" <arnab.basu@freescale.com>,
 Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Wuyun <wuyun.wu@huawei.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/5/2014 3:33 PM, wangyijing wrote:

>>> Use MSI chip framework instead of arch MSI functions to configure
>>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> ---
>>>   arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>>>   1 files changed, 12 insertions(+), 2 deletions(-)

>>> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
>>> index 71bd161..01781a4 100644
>>> --- a/arch/powerpc/kernel/msi.c
>>> +++ b/arch/powerpc/kernel/msi.c
>> [...]
>>> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>>       return ppc_md.setup_msi_irqs(dev, nvec, type);
>>>   }
>>>
>>> -void arch_teardown_msi_irqs(struct pci_dev *dev)
>>> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)

>>    Shouldn't this function take IRQ # instead?

> This function need to teardown all msi irqs of the pci dev, we should pass the pci dev as argument .

    Ah, I've mixed up the teardown_irqs() method with teardown_irq()! Too 
similar. :-)

> Thanks!
> Yijing.

WBR, Sergei

Return-Path: <david.vrabel@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C86CE1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 23:10:00 +1000 (EST)
Message-ID: <54119ED2.3070802@citrix.com>
Date: Thu, 11 Sep 2014 14:08:34 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>, David Vrabel
 <david.vrabel@citrix.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Xen-devel] [PATCH v1 04/21] x86/xen/MSI: Eliminate
 arch_msix_mask_irq() and arch_msi_mask_irq()
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>	<1409911806-10519-5-git-send-email-wangyijing@huawei.com>	<541045BE.9050804@citrix.com>
 <5410F955.80609@huawei.com>
In-Reply-To: <5410F955.80609@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Joerg
 Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Bharat.Bhushan@freescale.com,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/09/14 02:22, Yijing Wang wrote:
> On 2014/9/10 20:36, David Vrabel wrote:
>> On 05/09/14 11:09, Yijing Wang wrote:
>>> Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
>>> and arch_msi_mask_irq() to fix a bug found when running xen in x86.
>>> Introduced these two funcntions make MSI code complex. And mask/unmask
>>> is the irq actions related to interrupt controller, should not use
>>> weak arch functions to override mask/unmask interfaces. This patch
>>> reverted commit 0e4ccb150 and export struct irq_chip msi_chip, modify
>>> msi_chip->irq_mask/irq_unmask() in xen init functions to fix this
>>> bug for simplicity. Also this is preparation for using struct
>>> msi_chip instead of weak arch MSI functions in all platforms.
>>
>> Acked-by: David Vrabel <david.vrabel@citrix.com>
>>
>> But I wonder if it would be better the Xen subsystem to provide its own
>> struct irq_chip instead of adjusting the fields in the generic x86 one.
> 
> Thanks! Currently, Xen and the bare x86 system only have the different irq_chip->irq_mask/irq_unmask.
> So I chose to override the two ops of bare x86 irq_chip in xen. Konrad Rzeszutek Wilk has been tested it
> ok in his platform, so I think we could use its own irq_chip for xen later if the difference become large.

This sounds reasonable.

David

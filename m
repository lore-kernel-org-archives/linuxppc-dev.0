Return-Path: <wangyijing0307@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81E611A0174
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 21:33:17 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id fa1so22189642pad.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 04:33:12 -0700 (PDT)
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
 <540994D4.6040500@cogentembedded.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <540994D4.6040500@cogentembedded.com>
Content-Type: text/plain;
	charset=gb2312
Message-Id: <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
From: wangyijing <wangyijing0307@gmail.com>
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Fri, 5 Sep 2014 19:33:08 +0800
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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



> =D4=DA 2014=C4=EA9=D4=C25=C8=D5=A3=AC18:47=A3=ACSergei Shtylyov <sergei.sh=
tylyov@cogentembedded.com> =D0=B4=B5=C0=A3=BA
>=20
> Hello.
>=20
>> On 9/5/2014 2:10 PM, Yijing Wang wrote:
>>=20
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>=20
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>>  1 files changed, 12 insertions(+), 2 deletions(-)
>=20
>> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
>> index 71bd161..01781a4 100644
>> --- a/arch/powerpc/kernel/msi.c
>> +++ b/arch/powerpc/kernel/msi.c
> [...]
>> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec,=
 int type)
>>      return ppc_md.setup_msi_irqs(dev, nvec, type);
>>  }
>>=20
>> -void arch_teardown_msi_irqs(struct pci_dev *dev)
>> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)
>=20
>   Shouldn't this function take IRQ # instead?

This function need to teardown all msi irqs of the pci dev, we should pass t=
he pci dev as argument .

Thanks!
Yijing.

>=20
>>  {
>>      ppc_md.teardown_msi_irqs(dev);
>>  }
>> +
>> +static struct msi_chip ppc_msi_chip =3D {
>> +    .setup_irqs =3D ppc_setup_msi_irqs,
>> +    .teardown_irqs =3D ppc_teardown_msi_irqs,
>> +};
>> +
>> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
>> +{
>> +    return &ppc_msi_chip;
>> +}
>=20
> WBR, Sergei
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

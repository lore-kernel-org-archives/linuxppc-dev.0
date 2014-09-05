Return-Path: <wangyijing0307@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5201A012C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 21:30:07 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id w10so6221360pde.21
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 04:30:02 -0700 (PDT)
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
 <540993B3.1000701@cogentembedded.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <540993B3.1000701@cogentembedded.com>
Content-Type: text/plain;
	charset=gb2312
Message-Id: <58C2E84C-7080-4FDA-8684-5D0B2DAD7C20@gmail.com>
From: wangyijing <wangyijing0307@gmail.com>
Subject: Re: [PATCH v1 09/21] Irq_remapping/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Date: Fri, 5 Sep 2014 19:30:01 +0800
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


> =D4=DA 2014=C4=EA9=D4=C25=C8=D5=A3=AC18:42=A3=ACSergei Shtylyov <sergei.sh=
tylyov@cogentembedded.com> =D0=B4=B5=C0=A3=BA
>=20
> Hello.
>=20
>> On 9/5/2014 2:09 PM, Yijing Wang wrote:
>>=20
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>=20
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/iommu/irq_remapping.c |    8 +++++++-
>>  1 files changed, 7 insertions(+), 1 deletions(-)
>=20
>> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.=
c
>> index 33c4395..e75026e 100644
>> --- a/drivers/iommu/irq_remapping.c
>> +++ b/drivers/iommu/irq_remapping.c
> [...]
>> @@ -165,9 +170,10 @@ static void __init irq_remapping_modify_x86_ops(void=
)
>>      x86_io_apic_ops.set_affinity    =3D set_remapped_irq_affinity;
>>      x86_io_apic_ops.setup_entry    =3D setup_ioapic_remapped_entry;
>>      x86_io_apic_ops.eoi_ioapic_pin    =3D eoi_ioapic_pin_remapped;
>> -    x86_msi.setup_msi_irqs        =3D irq_remapping_setup_msi_irqs;
>> +    x86_msi.setup_msi_irqs          =3D irq_remapping_setup_msi_irqs;
>=20
>   AFAICS, this change only converts tabs to spaces, so not needed at all.

Will update,  thanks.

>=20
>>      x86_msi.setup_hpet_msi        =3D setup_hpet_msi_remapped;
>>      x86_msi.compose_msi_msg        =3D compose_remapped_msi_msg;
>> +    x86_msi_chip =3D &remap_msi_chip;
>=20
>   Please align =3D with the rest of assignments.

Ok.

Thanks!
Yijing.

>=20
> WBR, Sergei
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

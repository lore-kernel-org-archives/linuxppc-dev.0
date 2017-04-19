Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w74dC6tc8zDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:47:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>, Yongji Xie <elohimes@gmail.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v11 4/7] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
In-Reply-To: <CAErSpo6gtDos6GH5Z7aOoW4a3uS4X-HOOHtPFtyg=F+B6+osrw@mail.gmail.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAErSpo6gtDos6GH5Z7aOoW4a3uS4X-HOOHtPFtyg=F+B6+osrw@mail.gmail.com>
Date: Wed, 19 Apr 2017 11:47:43 +1000
Message-ID: <87bmrt6udc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <bhelgaas@google.com> writes:

> On Mon, Apr 17, 2017 at 4:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> From: Yongji Xie <elohimes@gmail.com>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 6901a06da2f9..b724487cbd0f 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -3287,6 +3287,11 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>>         }
>>  }
>>
>> +static resource_size_t pnv_pci_default_alignment(struct pci_dev *pdev)
>> +{
>> +       return PAGE_SIZE;
>> +}
>
> Is it necessary that pcibios_default_alignment() take a pci_dev
> pointer?

It's not necessary given the current implementation, obviously.

But it did strike me as a good idea to pass it in case we ever want to
do anything device specific in future.

> I'd like this better if it were:
>
>   resource_size_t pcibios_default_alignment(void) { ... }
>
> because the last patch relies on the assumption that all resources of
> *all* devices will be realigned to the same alignment.

But I guess that precludes doing anything device specific, at least
without further changes. So in that case it would be better if the API
didn't include the pci_dev.

Hopefully Yongji can confirm that there were no plans to use the
pci_dev in future patches.

cheers

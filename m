Return-Path: <bhelgaas@google.com>
Received: from mail-wr0-x233.google.com (mail-wr0-x233.google.com
 [IPv6:2a00:1450:400c:c0c::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7V4V3vbczDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:54:17 +1000 (AEST)
Received: by mail-wr0-x233.google.com with SMTP id c55so20607595wrc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 10:54:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAONzpcaGfO5bcSdjpX4NC=Ui9oTWORaj-v1vTDUTckPC5WWjqQ@mail.gmail.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAErSpo6gtDos6GH5Z7aOoW4a3uS4X-HOOHtPFtyg=F+B6+osrw@mail.gmail.com>
 <87bmrt6udc.fsf@concordia.ellerman.id.au>
 <CAONzpcaGfO5bcSdjpX4NC=Ui9oTWORaj-v1vTDUTckPC5WWjqQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Apr 2017 12:53:54 -0500
Message-ID: <CAErSpo5HkiiCMCyFZbOZu__KZ0DhAgwC9rcDtSdLuLL+3VDBFg@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
To: Yongji Xie <elohimes@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Li Zhong <zhong@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 18, 2017 at 9:12 PM, Yongji Xie <elohimes@gmail.com> wrote:
> On 19 April 2017 at 09:47, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Bjorn Helgaas <bhelgaas@google.com> writes:
>>
>>> On Mon, Apr 17, 2017 at 4:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> From: Yongji Xie <elohimes@gmail.com>
>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> index 6901a06da2f9..b724487cbd0f 100644
>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> @@ -3287,6 +3287,11 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>>>>         }
>>>>  }
>>>>
>>>> +static resource_size_t pnv_pci_default_alignment(struct pci_dev *pdev)
>>>> +{
>>>> +       return PAGE_SIZE;
>>>> +}
>>>
>>> Is it necessary that pcibios_default_alignment() take a pci_dev
>>> pointer?
>>
>> It's not necessary given the current implementation, obviously.
>>
>> But it did strike me as a good idea to pass it in case we ever want to
>> do anything device specific in future.
>>
>>> I'd like this better if it were:
>>>
>>>   resource_size_t pcibios_default_alignment(void) { ... }
>>>
>>> because the last patch relies on the assumption that all resources of
>>> *all* devices will be realigned to the same alignment.
>>
>> But I guess that precludes doing anything device specific, at least
>> without further changes. So in that case it would be better if the API
>> didn't include the pci_dev.
>>
>> Hopefully Yongji can confirm that there were no plans to use the
>> pci_dev in future patches.
>>
>
> Yes, seems like pci_dev pointer doesn't match the assumption
> that all resources will be realigned to the same alignment. It's OK
> to me to remove it.

I made this change (removing the pci_dev parameter) on my pci/resource branch.

Bjorn

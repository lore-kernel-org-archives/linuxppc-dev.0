Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F6062C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 10:38:33 +1000 (EST)
Message-ID: <51EDD048.1000404@asianux.com>
Date: Tue, 23 Jul 2013 08:37:28 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] powerpc: platforms: powernv: add '__init' for
 pnv_pci_init_ioda2_phb()
References: <51ECD6A4.3050408@asianux.com>
 <CAErSpo6_537nW9+7MtLcA70HhiZwQG3TFCZCUumPk+b8GAgq3Q@mail.gmail.com>
In-Reply-To: <CAErSpo6_537nW9+7MtLcA70HhiZwQG3TFCZCUumPk+b8GAgq3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 08:28 AM, Bjorn Helgaas wrote:
> On Mon, Jul 22, 2013 at 12:52 AM, Chen Gang <gang.chen@asianux.com> wrote:
>> pnv_pci_init_ioda2_phb() is only used during boot up, so need add
>> '__init' to save the related memory, and avoid related warning:
>>
>>   The function .pnv_pci_init_ioda2_phb() references
>>   the function __init .pnv_pci_init_ioda_phb().
>>   This is often because .pnv_pci_init_ioda2_phb lacks a __init
>>   annotation or the annotation of .pnv_pci_init_ioda_phb is wrong.
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> 
> Looks right to me.
> 

Thanks.

>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 49b57b9..d8140b1 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1266,7 +1266,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>                 opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
>>  }
>>
>> -void pnv_pci_init_ioda2_phb(struct device_node *np)
>> +void __init pnv_pci_init_ioda2_phb(struct device_node *np)
>>  {
>>         pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA2);
>>  }
>> --
>> 1.7.7.6
> 
> 


-- 
Chen Gang

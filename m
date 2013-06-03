Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 770022C0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 11:02:47 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 2 Jun 2013 21:02:44 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8C125C90026
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 21:02:40 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5312e9L328976
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 21:02:41 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5312eub014807
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 21:02:40 -0400
Date: Mon, 3 Jun 2013 09:02:40 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/23] powerpc/eeh: Make eeh_phb_pe_get() public
Message-ID: <20130603010239.GB7316@shangw.(null)>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1370060064.3766.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370060064.3766.2.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 01, 2013 at 02:14:24PM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2013-05-30 at 16:23 +0800, Gavin Shan wrote:
>> While processing EEH event interrupt from P7IOC, we need function
>> to retrieve the PE according to the indicated PCI host controller
>> (struct pci_controller). The patch makes function eeh_phb_pe_get()
>> public so that other source files can call it for that purpose.
>
>Just to make things clear to me... You always have the concept of a
>"controller PE" ? What does it actually correspond to in terms of HW
>setting ? Bus 0 ? Bus 0..255 ? IE, A "catch all" fallback ?
>

Ben, each PHB has its corresponding PE and we call it as "PHB PE", and
it can be regarded as domain to bus 0 ... 255. I'll update the change
log to make that more clear.

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/eeh.h          |    1 +
>>  arch/powerpc/platforms/pseries/eeh_pe.c |    2 +-
>>  2 files changed, 2 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index eeaeab6..4b48178 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -185,6 +185,7 @@ static inline void eeh_unlock(void)
>>  typedef void *(*eeh_traverse_func)(void *data, void *flag);
>>  typedef void *(*eeh_pci_traverse_func)(struct pci_dev *dev, void *flag);
>>  int eeh_phb_pe_create(struct pci_controller *phb);
>> +struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
>>  int eeh_add_to_parent_pe(struct eeh_dev *edev);
>>  int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
>>  void *eeh_pe_dev_traverse(struct eeh_pe *root,
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
>> index fe43d1a..6e3eb43 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pe.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pe.c
>> @@ -95,7 +95,7 @@ int eeh_phb_pe_create(struct pci_controller *phb)
>>   * hierarchy tree is composed of PHB PEs. The function is used
>>   * to retrieve the corresponding PHB PE according to the given PHB.
>>   */
>> -static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
>> +struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
>>  {
>>  	struct eeh_pe *pe;
>>  
>
>

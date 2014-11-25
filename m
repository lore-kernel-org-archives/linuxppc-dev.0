Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 133ED1A018C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 10:57:30 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 05:27:28 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4A838E0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:27:48 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAPNve2A62783558
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:27:40 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAPNvPQI026797
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:27:25 +0530
Date: Wed, 26 Nov 2014 10:57:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/8] powerpc/pci: Don't scan empty slot
Message-ID: <20141125235724.GA20556@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416869365-7671-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416956282.5089.4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416956282.5089.4.camel@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 09:58:02AM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2014-11-25 at 09:49 +1100, Gavin Shan wrote:
>> In hotplug case, function pcibios_add_pci_devices() is called to
>> rescan the specified PCI bus, which possibly doesn't have any child
>> devices. Access to the PCI bus's child device node will cause kernel
>> crash without exception. The patch adds two more conditions to avoid
>> the kernel crash.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/pci-hotplug.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>> index 6e2b4e3..ea5513b 100644
>> --- a/arch/powerpc/kernel/pci-hotplug.c
>> +++ b/arch/powerpc/kernel/pci-hotplug.c
>> @@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
>>   * is how this routine differs from other, similar pcibios
>>   * routines.)
>>   */
>> -void pcibios_add_pci_devices(struct pci_bus * bus)
>> +void pcibios_add_pci_devices(struct pci_bus *bus)
>
>Unrelated whitespace change
>

I'll remove this change out of the patch.

Thanks,
Gavin

>>  {
>>  	int slotno, mode, pass, max;
>>  	struct pci_dev *dev;
>> @@ -120,7 +120,8 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
>>  	if (mode == PCI_PROBE_DEVTREE) {
>>  		/* use ofdt-based probe */
>>  		of_rescan_bus(dn, bus);
>> -	} else if (mode == PCI_PROBE_NORMAL) {
>> +	} else if (mode == PCI_PROBE_NORMAL &&
>> +		   dn->child && PCI_DN(dn->child)) {
>>  		/*
>>  		 * Use legacy probe. In the partial hotplug case, we
>>  		 * probably have grandchildren devices unplugged. So
>
>

Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22B321A0127
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:45:47 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 Nov 2015 09:45:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 685CB2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:45:42 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA5NjZBS17105052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 10:45:43 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA5Nj9Id023622
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 10:45:10 +1100
Date: Fri, 6 Nov 2015 10:44:14 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 02/50] powerpc/pci: Override pcibios_setup_bridge()
Message-ID: <20151105234414.GA30465@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <87wptwhyjl.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wptwhyjl.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 06, 2015 at 09:27:42AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>>  
>> +void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
>> +{
>> +	struct pci_controller *hose = pci_bus_to_host(bus);
>Very much a nit-pick, but I thought we were trying to move towards using
>phb instead of hose in new code?
>

Take PowerNV platform as an example, "hose" means "struct pci_controller",
but "phb" means "struct pnv_phb". We don't have the movement to use "phb"
to represent "struct pci_controller".

>Apart from that this looks good. I would probably have merged it with
>the previous patch, but I know Alexey has been suggesting a lot of
>splitting and merging previously, so whatever he prefers here is OK.
>

I'd like to keep them separate as they're for different subsystem:
PCI generic subsystem and PowerPC subsystem. Separate maintainers
for them can pick them as they will.

>> +
>> +	if (hose->controller_ops.setup_bridge)
>> +		hose->controller_ops.setup_bridge(bus, type);
>> +}
>> +
>>  void pcibios_reset_secondary_bus(struct pci_dev *dev)
>>  {
>>  	struct pci_controller *phb = pci_bus_to_host(dev->bus);
>> -- 
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

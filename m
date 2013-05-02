Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 625132C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 01:21:50 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Thu, 2 May 2013 12:21:43 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 678CC3520064
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 11:21:41 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r42FKihc45219928
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 May 2013 12:20:45 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r42FLcDi018243
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 May 2013 12:21:40 -0300
Message-ID: <51828481.2090406@linux.vnet.ibm.com>
Date: Thu, 02 May 2013 12:21:37 -0300
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
MIME-Version: 1.0
To: tony@bakeyournoodle.com
Subject: Re: [PATCHv4 1/2] ppc64: perform proper max_bus_speed detection
References: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1366844090-5492-2-git-send-email-lucaskt@linux.vnet.ibm.com>
 <20130424234838.GA1971@thor.bakeyournoodle.com>
 <51796928.2050406@linux.vnet.ibm.com>
In-Reply-To: <51796928.2050406@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2013 02:34 PM, Lucas Kannebley Tavares wrote:
> On 04/24/2013 08:48 PM, Tony Breeds wrote:
>>> diff --git a/arch/powerpc/platforms/pseries/pci.c
>>> b/arch/powerpc/platforms/pseries/pci.c
>>> index 0b580f4..7f9c956 100644
>>> --- a/arch/powerpc/platforms/pseries/pci.c
>>> +++ b/arch/powerpc/platforms/pseries/pci.c
>>> @@ -108,3 +108,54 @@ static void fixup_winbond_82c105(struct pci_dev*
>>> dev)
>>>   }
>>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND,
>>> PCI_DEVICE_ID_WINBOND_82C105,
>>>                fixup_winbond_82c105);
>>> +
>>> +int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
>>> +{
>>> +    struct device_node *dn, *pdn;
>>> +    struct pci_bus *bus;
>>> +    const uint32_t *pcie_link_speed_stats;
>>> +
>>> +    bus = bridge->bus;
>>> +
>>> +    dn = pcibios_get_phb_of_node(bus);
>>> +    if (!dn)
>>> +        return 0;
>>> +
>>> +    for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
>>> +        pcie_link_speed_stats = (const uint32_t *) of_get_property(dn,
>>> +            "ibm,pcie-link-speed-stats", NULL);
>>> +        if (pcie_link_speed_stats)
>>> +            break;
>>> +    }
>>
>> Please use the helpers in include/linux/of.h rather than open coding
>> this.
>>
>> Yours Tony
> 
> 
> Hi Tony,
> 
> 
> This is what I can find as an equivalent code:
> 
>     for (pdn = dn; pdn != NULL; pdn = of_get_next_parent(pdn)) {
>         pcie_link_speed_stats = (const uint32_t *)
>             of_get_property(dn,
>                 "ibm,pcie-link-speed-stats", NULL);
>         if (pcie_link_speed_stats)
>             break;
>     }
> 
> is this your suggestion, or was it another approach that will have the
> same result?
> 
> Thanks,
> 

Hi Tony,

It seems Lucas' change is a bit incomplete and is not handling the reference counter to
the device_node correctly. Is the following change what you had in mind?


	dn = pcibios_get_phb_of_node(bus);
	if (!dn)
		return 0;

	for (pdn = dn; pdn != NULL; pdn = of_get_next_parent(pdn)) {
		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
			"ibm,pcie-link-speed-stats", NULL);
		if (pcie_link_speed_stats)
			break;
	}

	of_node_put(pdn);


Thanks,

-- 
Kleber Sacilotto de Souza
IBM Linux Technology Center

Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBC412C0162
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 03:34:42 +1000 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 14:34:37 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 90980352006A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 13:34:34 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3PHXXsI40108190
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 14:33:33 -0300
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3PFYtoj031476
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 12:34:56 -0300
Message-ID: <51796928.2050406@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 14:34:32 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "David Airlie <airlied@linux.ie> Michael Ellerman" <michael@ellerman.id.au>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCHv4 1/2] ppc64: perform proper max_bus_speed detection
References: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1366844090-5492-2-git-send-email-lucaskt@linux.vnet.ibm.com>
 <20130424234838.GA1971@thor.bakeyournoodle.com>
In-Reply-To: <20130424234838.GA1971@thor.bakeyournoodle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2013 08:48 PM, Tony Breeds wrote:
> On Wed, Apr 24, 2013 at 07:54:49PM -0300, lucaskt@linux.vnet.ibm.com wrote:
>> From: Lucas Kannebley Tavares<lucaskt@linux.vnet.ibm.com>
>>
>> On pseries machines the detection for max_bus_speed should be done
>> through an OpenFirmware property. This patch adds a function to perform
>> this detection and a hook to perform dynamic adding of the function only for
>> pseries. This is done by overwriting the weak
>> pcibios_root_bridge_prepare function which is called by pci_create_root_bus().
>>
>> Signed-off-by: Lucas Kannebley Tavares<lucaskt@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/machdep.h       |  2 ++
>>   arch/powerpc/kernel/pci-common.c         |  8 +++++
>>   arch/powerpc/platforms/pseries/pci.c     | 51 ++++++++++++++++++++++++++++++++
>>   arch/powerpc/platforms/pseries/pseries.h |  4 +++
>>   arch/powerpc/platforms/pseries/setup.c   |  2 ++
>>   5 files changed, 67 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>> index 3d6b410..8f558bf 100644
>> --- a/arch/powerpc/include/asm/machdep.h
>> +++ b/arch/powerpc/include/asm/machdep.h
>> @@ -107,6 +107,8 @@ struct machdep_calls {
>>   	void		(*pcibios_fixup)(void);
>>   	int		(*pci_probe_mode)(struct pci_bus *);
>>   	void		(*pci_irq_fixup)(struct pci_dev *dev);
>> +	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
>> +				*bridge);
>>
>>   	/* To setup PHBs when using automatic OF platform driver for PCI */
>>   	int		(*pci_setup_phb)(struct pci_controller *host);
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index fa12ae4..80986cf 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -844,6 +844,14 @@ int pci_proc_domain(struct pci_bus *bus)
>>   	return 1;
>>   }
>>
>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>> +{
>> +	if (ppc_md.pcibios_root_bridge_prepare)
>> +		return ppc_md.pcibios_root_bridge_prepare(bridge);
>> +
>> +	return 0;
>> +}
>> +
>>   /* This header fixup will do the resource fixup for all devices as they are
>>    * probed, but not for bridge ranges
>>    */
>> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
>> index 0b580f4..7f9c956 100644
>> --- a/arch/powerpc/platforms/pseries/pci.c
>> +++ b/arch/powerpc/platforms/pseries/pci.c
>> @@ -108,3 +108,54 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>>   }
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
>>   			 fixup_winbond_82c105);
>> +
>> +int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
>> +{
>> +	struct device_node *dn, *pdn;
>> +	struct pci_bus *bus;
>> +	const uint32_t *pcie_link_speed_stats;
>> +
>> +	bus = bridge->bus;
>> +
>> +	dn = pcibios_get_phb_of_node(bus);
>> +	if (!dn)
>> +		return 0;
>> +
>> +	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
>> +		pcie_link_speed_stats = (const uint32_t *) of_get_property(dn,
>> +			"ibm,pcie-link-speed-stats", NULL);
>> +		if (pcie_link_speed_stats)
>> +			break;
>> +	}
>
> Please use the helpers in include/linux/of.h rather than open coding
> this.
>
> Yours Tony


Hi Tony,


This is what I can find as an equivalent code:

	for (pdn = dn; pdn != NULL; pdn = of_get_next_parent(pdn)) {
		pcie_link_speed_stats = (const uint32_t *)
			of_get_property(dn,
				"ibm,pcie-link-speed-stats", NULL);
		if (pcie_link_speed_stats)
			break;
	}

is this your suggestion, or was it another approach that will have the 
same result?

Thanks,

-- 
Lucas Kannebley Tavares
Software Engineer
IBM Linux Technology Center

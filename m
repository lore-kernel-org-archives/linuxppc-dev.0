Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34C5C04FFE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 May 2024 06:29:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VbwpD2J1Jz3d36
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 May 2024 16:29:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=gmail.com (client-ip=62.142.5.84; helo=fgw23-7.mail.saunalahti.fi; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2710 seconds by postgrey-1.37 at boromir; Sat, 11 May 2024 16:29:14 AEST
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vbwnk1002z30fm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2024 16:29:12 +1000 (AEST)
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 4b7fdbe9-0f59-11ef-abf4-005056bdd08f;
	Sat, 11 May 2024 08:42:48 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 11 May 2024 08:42:46 +0300
To: Krishna Kumar <krishnak@linux.ibm.com>
Subject: Re: [PATCH 2/2] arch/powerpc: hotplug driver bridge support
Message-ID: <Zj8FVva9G9_r6-cZ@surfacebook.localdomain>
References: <20240509120644.653577-1-krishnak@linux.ibm.com>
 <20240509120644.653577-3-krishnak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509120644.653577-3-krishnak@linux.ibm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: nathanl@linux.ibm.com, aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org, npiggin@gmail.com, gbatra@linux.ibm.com, bhelgaas@google.com, tpearson@raptorengineering.com, oohall@gmail.com, linux-pci@vger.kernel.org, brking@linux.vnet.ibm.com, mahesh.salgaonkar@in.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thu, May 09, 2024 at 05:35:54PM +0530, Krishna Kumar kirjoitti:
> There is an issue with the hotplug operation when it's done on the
> bridge/switch slot. The bridge-port and devices behind the bridge, which
> become offline by hot-unplug operation, don't get hot-plugged/enabled by
> doing hot-plug operation on that slot. Only the first port of the bridge
> gets enabled and the remaining port/devices remain unplugged. The hot
> plug/unplug operation is done by the hotplug driver
> (drivers/pci/hotplug/pnv_php.c).
> 
> Root Cause Analysis: This behavior is due to missing code for the DPC
> switch/bridge. The existing driver depends on pci_hp_add_devices()
> function for device enablement. This function calls pci_scan_slot() on
> only one device-node/port of the bridge, not on all the siblings'
> device-node/port.
> 
> The missing code needs to be added which will find all the sibling
> device-nodes/bridge-ports and will run explicit pci_scan_slot() on
> those.  A new function has been added for this purpose which gets
> invoked from pci_hp_add_devices(). This new function
> pci_traverse_sibling_nodes_and_scan_slot() gets all the sibling
> bridge-ports by traversal and explicitly invokes pci_scan_slot on them.
> 
> 

One blank line is enough here.

> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>

...

> +void *pci_traverse_sibling_nodes_and_scan_slot(struct device_node *start, struct pci_bus *bus)
> +{
> +	struct device_node *dn;
> +	struct device_node *parent;
> +	int slotno;
> +
> +	const __be32 *classp1;
> +	u32 class1 = 0;

> +	classp1 = of_get_property(start->child, "class-code", NULL);
> +	if (classp1)
> +		class1 = of_read_number(classp1, 1);

What's wrong with of_property_read_u32()?


> +	/* Call of pci_scan_slot for non-bridge/EP case */
> +	if (!((class1 >> 8) == PCI_CLASS_BRIDGE_PCI)) {
> +		slotno = PCI_SLOT(PCI_DN(start->child)->devfn);
> +		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> +		return NULL;
> +	}
> +
> +	/* Iterate all siblings */
> +	parent = start;
> +	for_each_child_of_node(parent, dn) {
> +		const __be32 *classp;
> +		u32 class = 0;
> +
> +		classp = of_get_property(dn, "class-code", NULL);
> +		if (classp)
> +			class = of_read_number(classp, 1);

Ditto.

> +		/* Call of pci_scan_slot on each sibling-nodes/bridge-ports */
> +		if ((class >> 8) == PCI_CLASS_BRIDGE_PCI) {
> +			slotno = PCI_SLOT(PCI_DN(dn)->devfn);
> +			pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> +		}
> +	}
> +
> +	return NULL;
> +}

-- 
With Best Regards,
Andy Shevchenko



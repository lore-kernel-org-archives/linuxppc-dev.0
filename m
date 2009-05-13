Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21C95DDFD5
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 01:17:30 +1000 (EST)
Message-Id: <E3137750-3D9B-40FF-AB03-7F0999C97C4A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: removing pcibios_fixup_bus
Date: Wed, 13 May 2009 10:17:25 -0500
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

We have:

         /* Platform specific bus fixups. This is currently only used
          * by fsl_pci and I'm hoping to get rid of it at some point
          */
         if (ppc_md.pcibios_fixup_bus)
                 ppc_md.pcibios_fixup_bus(bus);

I can remove this but would need to replace it with:

         if (bus->self != NULL) {
                 pci_read_bridge_bases(bus);
		if (ppc_md.pcibios_fixup_bridge_resources)
			ppc_md.pcibios_fixup_bridge_resources(bus);
	}

This is only moving the issue, but its a bit cleaner as the fixup I'm  
doing is because when we read the BARs on the virtual P2P bridge on  
our PCIe PHBs we get bogus values back.

Thoughts?

- k

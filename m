Return-Path: <bhelgaas@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24B361A09D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:09:22 +1100 (AEDT)
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 950251401AF
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 09:09:21 +1100 (AEDT)
Received: by mail-ob0-f178.google.com with SMTP id uz6so58530982obc.9
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:09:19 -0800 (PST)
Date: Tue, 17 Feb 2015 16:09:16 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v2 7/7] PCI/hotplug: PowerPC PowerNV PCI hotplug
 driver
Message-ID: <20150217220916.GA26424@google.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 17, 2015 at 06:13:23PM +1100, Gavin Shan wrote:
> The patch intends to add standalone driver to support PCI hotplug
> for PowerPC PowerNV platform, which runs on top of skiboot firmware.
> The firmware identified hotpluggable slots and marked their device
> tree node with proper "ibm,slot-pluggable" and "ibm,reset-by-firmware".
> The driver simply scans device-tree to create/register PCI hotplug slot
> accordingly.
> 
> If the skiboot firmware doesn't support slot status retrieval, the PCI
> slot device node shouldn't have property "ibm,reset-by-firmware". In
> that case, none of valid PCI slots will be detected from device tree.
> The skiboot firmware doesn't export the capability to access attention
> LEDs yet and it's something for TBD.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ...

> +static int disable_slot(struct hotplug_slot *php_slot)
> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +
> +	if (slot->state != POWERNV_PHP_SLOT_STATE_POPULATED)
> +		return 0;
> +
> +	pci_lock_rescan_remove();
> +	pcibios_remove_pci_devices(slot->bus);
> +	pci_unlock_rescan_remove();
> +	vm_unmap_aliases();

What is vm_unmap_aliases() for?  I see this is probably copied from
rpaphp_core.c, where it was added by b4a26be9f6f8 ("powerpc/pseries: Flush
lazy kernel mappings after unplug operations").

But I don't know whether:

  - this is something specific to powerpc,
  - the lack of vm_unmap_aliases() in other hotplug paths is a bug,
  - the fact that we only do this on powerpc is covering up a
    powerpc bug somewhere

> +
> +	/* Detach the child hotpluggable slots */
> +	powernv_php_unregister(slot->dn);
> +
> +	/* Update slot state */
> +	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
> +	return 0;
> +}
> 

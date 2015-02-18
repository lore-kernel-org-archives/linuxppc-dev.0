Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C081E1A0157
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 11:17:24 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 980251401DD
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 11:17:24 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 18 Feb 2015 10:17:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 93B36357804F
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 11:17:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1I0HAKx35061802
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 11:17:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1I0Giwi008222
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 11:16:45 +1100
Date: Wed, 18 Feb 2015 11:16:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND v2 7/7] PCI/hotplug: PowerPC PowerNV PCI hotplug
 driver
Message-ID: <20150218001620.GA22042@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150217220916.GA26424@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150217220916.GA26424@google.com>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 17, 2015 at 04:09:16PM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 17, 2015 at 06:13:23PM +1100, Gavin Shan wrote:
>> The patch intends to add standalone driver to support PCI hotplug
>> for PowerPC PowerNV platform, which runs on top of skiboot firmware.
>> The firmware identified hotpluggable slots and marked their device
>> tree node with proper "ibm,slot-pluggable" and "ibm,reset-by-firmware".
>> The driver simply scans device-tree to create/register PCI hotplug slot
>> accordingly.
>> 
>> If the skiboot firmware doesn't support slot status retrieval, the PCI
>> slot device node shouldn't have property "ibm,reset-by-firmware". In
>> that case, none of valid PCI slots will be detected from device tree.
>> The skiboot firmware doesn't export the capability to access attention
>> LEDs yet and it's something for TBD.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ...
>
>> +static int disable_slot(struct hotplug_slot *php_slot)
>> +{
>> +	struct powernv_php_slot *slot = php_slot->private;
>> +
>> +	if (slot->state != POWERNV_PHP_SLOT_STATE_POPULATED)
>> +		return 0;
>> +
>> +	pci_lock_rescan_remove();
>> +	pcibios_remove_pci_devices(slot->bus);
>> +	pci_unlock_rescan_remove();
>> +	vm_unmap_aliases();
>
>What is vm_unmap_aliases() for?  I see this is probably copied from
>rpaphp_core.c, where it was added by b4a26be9f6f8 ("powerpc/pseries: Flush
>lazy kernel mappings after unplug operations").
>
>But I don't know whether:
>
>  - this is something specific to powerpc,
>  - the lack of vm_unmap_aliases() in other hotplug paths is a bug,
>  - the fact that we only do this on powerpc is covering up a
>    powerpc bug somewhere
>

Yes, I copied this piece of code from rpaphp_core.c. I think Ben might
help to answer the questions as he added the patch. I had very quick
check on mm/vmalloc.c and it's reasonable to have vm_unmap_aliases()
here to flush TLB entries for ioremap() regions, which were unmapped
previously. if I'm correct. I don't think it's powerpc specific.

Thanks,
Gavin

>> +
>> +	/* Detach the child hotpluggable slots */
>> +	powernv_php_unregister(slot->dn);
>> +
>> +	/* Update slot state */
>> +	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
>> +	return 0;
>> +}
>> 
>

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 600B9DDF49
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 13:19:26 +1000 (EST)
Message-Id: <3EF69848-F5B3-4C73-B7B6-8D61207B2306@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080813051657.GF17587@secretlab.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 5121 pci 3/3] powerpc: pci: 5121: Hide pci bridge.
Date: Wed, 13 Aug 2008 22:19:15 -0500
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
	<1218130587-31176-2-git-send-email-jrigby@freescale.com>
	<1218130587-31176-3-git-send-email-jrigby@freescale.com>
	<20080813051657.GF17587@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 13, 2008, at 12:16 AM, Grant Likely wrote:

> On Thu, Aug 07, 2008 at 11:36:27AM -0600, John Rigby wrote:
>> The class of the MPC5121 pci host bridge is PCI_CLASS_BRIDGE_OTHER
>> while other freescale host bridges have class set to
>> PCI_CLASS_PROCESSOR_POWERPC.
>>
>> This patch makes fixup_hide_host_resource_fsl match
>> PCI_CLASS_BRIDGE_OTHER in addition to PCI_CLASS_PROCESSOR_POWERPC.
>>
>> Signed-off-by: John Rigby <jrigby@freescale.com>
>
> I think this is okay, but it might need to be more conservative.  I'm
> not the PCI expert.  Kumar, thoughts?

This is fine, since we qualify this with an FSL VendorID.

- k

>> ---
>> arch/powerpc/kernel/pci_32.c |    5 +++--
>> 1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/ 
>> pci_32.c
>> index 88db4ff..162c3a8 100644
>> --- a/arch/powerpc/kernel/pci_32.c
>> +++ b/arch/powerpc/kernel/pci_32.c
>> @@ -54,11 +54,12 @@ LIST_HEAD(hose_list);
>> static int pci_bus_count;
>>
>> static void
>> -fixup_hide_host_resource_fsl(struct pci_dev* dev)
>> +fixup_hide_host_resource_fsl(struct pci_dev *dev)
>> {
>> 	int i, class = dev->class >> 8;
>>
>> -	if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
>> +	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
>> +	     class == PCI_CLASS_BRIDGE_OTHER) &&
>> 		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
>> 		(dev->bus->parent == NULL)) {
>> 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>> -- 
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev

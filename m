Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F01941A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:56:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 11 May 2015 14:56:13 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 58C773578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:56:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B4u2w524510522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:56:11 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B4tcjW029382
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:55:38 +1000
Date: Mon, 11 May 2015 14:55:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v4 06/21] powerpc/powernv: Create PEs dynamically
Message-ID: <20150511045513.GA28073@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-7-git-send-email-gwshan@linux.vnet.ibm.com>
 <554DF2D4.6090605@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <554DF2D4.6090605@ozlabs.ru>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 09, 2015 at 09:43:16PM +1000, Alexey Kardashevskiy wrote:
>On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>Currently, the PEs and their associated resources are assigned
>>in ppc_md.pcibios_fixup(). The function is called for once after
>>PCI probing and resources assignment are finished. Obviously, it's
>>not hotplug friendly. The patch creates PEs dynamically by
>>ppc_md.pcibios_setup_bridge(), which is called on the event during
>>system bootup and PCI hotplug: updating PCI bridge's windows after
>>resource assignment/reassignment are finished. For partial hotplug
>>case, where not all PCI devices belonging to the PE are unplugged
>>and plugged again, we just need unbinding/binding the affected
>>PCI devices with the corresponding PE without creating new one.
>
>
>Some PEs are already created dynamically (SRIOV). I'd suggest to make subject
>more specific.
>

Sure, will do.

>>Besides, it might require addtional resources (e.g. M32) to the
>>windows of the PCI bridge when unplugging current adapter, and
>>insert a different adapter if there is one PCI slot, which is
>>assumed behind root port, or the downstream bridge of the PCIE
>>switch behind root port. The parent bridge of the newly plugged
>>adapter would reject the request to add more resources, leading
>>to hotplug failure. For the issue, the patch extends the windows
>>of root port, or the upstream port of the PCIe switch behind root
>>port to PHB's windows when ppc_md.pcibios_setup_bridge() is called.
>>
>>There is no upstream bridge for root bus, so we have to reserve
>>PE#, which is next to the reserved PE# in advance and fixing the
>>PE for root bus in ppc_md.pcibios_setup_bridge().
>>
>>The patch also changes the rule assigning PE#: PE# reserved for
>>prefetchable 64-bits memory resource and SRIOV VFs starts from
>>zero while PE# for dynamic allocations starts from ioda.total_pe
>>reversely. It's because PE# for prefetchable 64-bits memory resource,
>>which is ually allocated begining with the PHB's aperatus and PE#
>
>s/aperatus/apertures/?
>

I need look into Chinese-English dictionary to confirm :-)

>May be it is just me but it looks like the patch moves existing bits and also
>adds this dynamic PE creation, cannot it be separated somehow into smaller
>patches as it is really hard to track all the changes you are making here?
>

It's good suggestion as I said in previous replies. Yeah, I'll see
if I can split it up to help review and bisecting.

Thanks,
Gavin

Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 746F61A0E0F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 21:43:24 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so71317763pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2015 04:43:22 -0700 (PDT)
Message-ID: <554DF2D4.6090605@ozlabs.ru>
Date: Sat, 09 May 2015 21:43:16 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 06/21] powerpc/powernv: Create PEs dynamically
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-7-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2015 04:02 PM, Gavin Shan wrote:
> Currently, the PEs and their associated resources are assigned
> in ppc_md.pcibios_fixup(). The function is called for once after
> PCI probing and resources assignment are finished. Obviously, it's
> not hotplug friendly. The patch creates PEs dynamically by
> ppc_md.pcibios_setup_bridge(), which is called on the event during
> system bootup and PCI hotplug: updating PCI bridge's windows after
> resource assignment/reassignment are finished. For partial hotplug
> case, where not all PCI devices belonging to the PE are unplugged
> and plugged again, we just need unbinding/binding the affected
> PCI devices with the corresponding PE without creating new one.


Some PEs are already created dynamically (SRIOV). I'd suggest to make 
subject more specific.


> Besides, it might require addtional resources (e.g. M32) to the
> windows of the PCI bridge when unplugging current adapter, and
> insert a different adapter if there is one PCI slot, which is
> assumed behind root port, or the downstream bridge of the PCIE
> switch behind root port. The parent bridge of the newly plugged
> adapter would reject the request to add more resources, leading
> to hotplug failure. For the issue, the patch extends the windows
> of root port, or the upstream port of the PCIe switch behind root
> port to PHB's windows when ppc_md.pcibios_setup_bridge() is called.
>
> There is no upstream bridge for root bus, so we have to reserve
> PE#, which is next to the reserved PE# in advance and fixing the
> PE for root bus in ppc_md.pcibios_setup_bridge().
>
> The patch also changes the rule assigning PE#: PE# reserved for
> prefetchable 64-bits memory resource and SRIOV VFs starts from
> zero while PE# for dynamic allocations starts from ioda.total_pe
> reversely. It's because PE# for prefetchable 64-bits memory resource,
> which is ually allocated begining with the PHB's aperatus and PE#

s/aperatus/apertures/?

May be it is just me but it looks like the patch moves existing bits and 
also adds this dynamic PE creation, cannot it be separated somehow into 
smaller patches as it is really hard to track all the changes you are 
making here?




-- 
Alexey

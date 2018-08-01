Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMDg2pdpzF1BS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:24:19 +1000 (AEST)
In-Reply-To: <e63eb03c87a1a54257aa2bcc384cf07761824a7e.1532915951.git.sbobroff@linux.ibm.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: Re: [v3,1/1] powerpc/pseries: fix EEH recovery of some IOV devices
Message-Id: <41gMDd5RDWz9sCq@ozlabs.org>
Date: Wed,  1 Aug 2018 15:24:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-30 at 01:59:14 UTC, Sam Bobroff wrote:
> EEH recovery currently fails on pSeries for some IOV capable PCI
> devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
> certain device tree properties for the device. (Found on an IOV
> capable device using the ipr driver.)
> 
> Recovery fails in pci_enable_resources() at the check on r->parent,
> because r->flags is set and r->parent is not.  This state is due to
> sriov_init() setting the start, end and flags members of the IOV BARs
> but the parent not being set later in
> pseries_pci_fixup_iov_resources(), because the
> "ibm,open-sriov-vf-bar-info" property is missing.
> 
> Correct this by zeroing the resource flags for IOV BARs when they
> can't be configured (this is the same method used by sriov_init() and
> __pci_read_base()).
> 
> VFs cleared this way can't be enabled later, because that requires
> another device tree property, "ibm,number-of-configurable-vfs" as well
> as support for the RTAS function "ibm_map_pes". These are all part of
> hypervisor support for IOV and it seems unlikely that a hypervisor
> would ever partially, but not fully, support it. (None are currently
> provided by QEMU/KVM.)
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> Reviewed-by: Bryant G. Ly <bryantly@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b87b9cf4935325c98522823caeddd3

cheers

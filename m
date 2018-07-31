Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fn2M1Vt1zF1Cq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 16:43:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: Re: [PATCH v3 1/1] powerpc/pseries: fix EEH recovery of some IOV
 devices
In-Reply-To: <20180730212155.GB45322@bhelgaas-glaptop.roam.corp.google.com>
References: <e63eb03c87a1a54257aa2bcc384cf07761824a7e.1532915951.git.sbobroff@linux.ibm.com>
 <20180730212155.GB45322@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 31 Jul 2018 16:43:22 +1000
Message-ID: <87y3drhpmd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Mon, Jul 30, 2018 at 11:59:14AM +1000, Sam Bobroff wrote:
>> EEH recovery currently fails on pSeries for some IOV capable PCI
>> devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
>> certain device tree properties for the device. (Found on an IOV
>> capable device using the ipr driver.)
>> 
>> Recovery fails in pci_enable_resources() at the check on r->parent,
>> because r->flags is set and r->parent is not.  This state is due to
>> sriov_init() setting the start, end and flags members of the IOV BARs
>> but the parent not being set later in
>> pseries_pci_fixup_iov_resources(), because the
>> "ibm,open-sriov-vf-bar-info" property is missing.
>> 
>> Correct this by zeroing the resource flags for IOV BARs when they
>> can't be configured (this is the same method used by sriov_init() and
>> __pci_read_base()).
>> 
>> VFs cleared this way can't be enabled later, because that requires
>> another device tree property, "ibm,number-of-configurable-vfs" as well
>> as support for the RTAS function "ibm_map_pes". These are all part of
>> hypervisor support for IOV and it seems unlikely that a hypervisor
>> would ever partially, but not fully, support it. (None are currently
>> provided by QEMU/KVM.)
>> 
>> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
>
> Michael, I assume you'll take this, since it only touches powerpc.
> Let me know if you need anything from me.

Yeah I'll take it, thanks.

cheers

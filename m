Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skHLc33plzDrWW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:37:27 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RNXHsY120056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 19:37:25 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25qv5xg73y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 19:37:24 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 09:37:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C90C13578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:37:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RNbKWZ40566910
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:37:20 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RNbKWT018049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:37:20 +1000
Date: Wed, 28 Sep 2016 09:37:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 bhelgaas@google.com, linux-pci@vger.kernel.org, clsoto@us.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: Add parameter @mmio_force_on to pci_update_resource()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160927192003.GA14642@localhost>
 <1475012732.2857.293.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475012732.2857.293.camel@au1.ibm.com>
Message-Id: <20160927233749.GA19797@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 07:45:32AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2016-09-27 at 14:20 -0500, Bjorn Helgaas wrote:
>> On Mon, Sep 19, 2016 at 09:53:30AM +1000, Gavin Shan wrote:
>> > In pci_update_resource(), the PCI device's memory decoding (0x2 in
>> > PCI_COMMAND) is disabled when 64-bits memory BAR is updated if the
>> > PCI device's memory space wasn't asked to be always on by @pdev->
>> > mmio_always_on. The PF's memory decoding might be disabled when
>> > updating its IOV BARs in the following path. Actually, the PF's
>> > memory decoding shouldn't be disabled in this scenario as the PF
>> > has been started to provide services:
>> 
>> The reason we disable memory decoding while updating a 64-bit BAR is
>> because we can't do the update atomically, and a half-updated BAR might
>> conflict with other devices.
>> 
>> You need to explain what is special about these SR-IOV BARs that makes it
>> safe to update them non-atomically while decoding is enabled.
>
>The IOV BAR won't decode until SR-IOV is enabled right ? Gavin, I don't
>think we update it "live", so it should be safe...
>

Yeah, it's safe to update it with memory decoding on. As the function call
flow I listed in the changelog (as below), nobody should access the IOV BAR
when pci_update_resource() is called. However, the PF's memory BARs might
be accessed that time and it's not safe to disable PF's memory decoding.

   sriov_numvfs_store
   pdev->driver->sriov_configure
   mlx5_core_sriov_configure
   pci_enable_sriov
   sriov_enable
   pcibios_sriov_enable
   pnv_pci_sriov_enable
   pnv_pci_vf_resource_shift
   pci_update_resource

Thanks,
Gavin

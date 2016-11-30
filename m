Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTbWm0NPqzDsyK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 10:01:39 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAUMs8Gf135824
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 18:01:36 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2724mx136f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 18:01:36 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 1 Dec 2016 09:01:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1DBFD2CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 10:01:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAUN1Wgk58589396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 10:01:32 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAUN1VgO005565
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 10:01:31 +1100
Date: Thu, 1 Dec 2016 10:02:54 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/7] PCI: Separate VF BAR updates from standard BAR
 updates
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041506.21453.18478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129045546.GB20642@gwshan>
 <20161129144826.GB7285@bhelgaas-glaptop.roam.corp.google.com>
 <20161129232028.GA8143@gwshan>
 <20161130000605.GC7375@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161130000605.GC7375@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161130230254.GA10567@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 29, 2016 at 06:06:05PM -0600, Bjorn Helgaas wrote:
>On Wed, Nov 30, 2016 at 10:20:28AM +1100, Gavin Shan wrote:
>> On Tue, Nov 29, 2016 at 08:48:26AM -0600, Bjorn Helgaas wrote:
>> >On Tue, Nov 29, 2016 at 03:55:46PM +1100, Gavin Shan wrote:
>> >> On Mon, Nov 28, 2016 at 10:15:06PM -0600, Bjorn Helgaas wrote:
>> >> >Previously pci_update_resource() used the same code path for updating
>> >> >standard BARs and VF BARs in SR-IOV capabilities.
>> >> >
>> >> >Split the VF BAR update into a new pci_iov_update_resource() internal
>> >> >interface, which makes it simpler to compute the BAR address (we can get
>> >> >rid of pci_resource_bar() and pci_iov_resource_bar()).
>> >> >
>> >> >This patch:
>> >> >
>> >> >  - Renames pci_update_resource() to pci_std_update_resource(),
>> >> >  - Adds pci_iov_update_resource(),
>> >> >  - Makes pci_update_resource() a wrapper that calls the appropriate one,
>> >> >
>> >> >No functional change intended.
>
>> >However, I don't think this code in pci_update_resource() is obviously
>> >correct:
>> >
>> >  new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
>> >
>> >PCI_REGION_FLAG_MASK is 0xf.  For memory BARs, bits 0-3 are read-only
>> >property bits.  For I/O BARs, bits 0-1 are read-only and bits 2-3 are
>> >part of the address, so on the face of it, the above could corrupt two
>> >bits of an I/O address.
>> >
>> >It's true that decode_bar() initializes flags correctly, using
>> >PCI_BASE_ADDRESS_IO_MASK for I/O BARs and PCI_BASE_ADDRESS_MEM_MASK
>> >for memory BARs, but it would take a little more digging to be sure
>> >that we never set bits 2-3 of flags for an I/O resource elsewhere.
>> >
>> 
>> The BAR's property bits are probed from device-tree, not hardware
>> on some platforms (e.g. pSeries). Also, there is only one (property)
>> bit if it's a ROM BAR. So more check as below might be needed because
>> the code (without the enhancement) should also work fine.
>
>Ah, right, I forgot about that.  I didn't do enough digging :)
>
>> >How about this in pci_std_update_resource():
>> >
>> >        pcibios_resource_to_bus(dev->bus, &region, res);
>> >        new = region.start;
>> >
>> >        if (res->flags & IORESOURCE_IO) {
>> >                mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
>> >                new |= res->flags & ~PCI_BASE_ADDRESS_IO_MASK;
>> >        } else {
>> >                mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
>> >                new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
>> >        }
>> >
>> 
>> 	if (res->flags & IORESOURCE_IO) {
>> 		mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
>> 		new |= res->flags & ~PCI_BASE_ADDRESS_IO_MASK;
>> 	} else if (resno < PCI_ROM_RESOURCE) {
>> 		mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
>> 		new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
>> 	} else if (resno == PCI_ROM_RESOURCE) {
>> 		mask = ~((u32)IORESOURCE_ROM_ENABLE);
>> 		new |= res->flags & IORESOURCE_ROM_ENABLE);
>> 	} else {
>> 		dev_warn(&dev->dev, "BAR#%d out of range\n", resno);
>> 		return;
>> 	}
>
>After this patch, the only thing we OR into a ROM BAR value is
>PCI_ROM_ADDRESS_ENABLE, and that's done below, only if the ROM is
>already enabled.
>
>I did update the ROM mask (to PCI_ROM_ADDRESS_MASK).  I'm not 100%
>sure about doing that -- it follows the spec, but it is a change from
>what we've been doing before.  I guess it should be safe because it
>means we're checking fewer bits than before (only the top 21 bits for
>ROMs, where we used check the top 28), so the only possible difference
>is that we might not warn about "error updating" in some case where we
>used to.
>
>I'm not really sure about the value of the "error updating" checks to
>begin with, though I guess it does help us find broken devices that
>put non-BARs where BARs are supposed to be.
>

Yeah, agree. Bjorn, I don't have more comments. please take your time
to respin the series and maybe applied it. I really want to see the
fixes can be in 4.10 if possible :-)

Thanks,
Gavin

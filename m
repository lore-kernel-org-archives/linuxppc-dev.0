Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2795E1A01B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 17:26:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 16:26:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1F5912CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 17:26:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A6QQm748824472
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 17:26:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A6Q06B028634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 17:26:00 +1100
Date: Tue, 10 Feb 2015 14:25:44 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
Message-ID: <20150210062544.GB31098@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423528584.4924.70.camel@au1.ibm.com>
 <20150210015123.GC6326@richard>
 <1423534451.4924.79.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423534451.4924.79.camel@au1.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2015 at 01:14:11PM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2015-02-10 at 09:51 +0800, Wei Yang wrote:
>> On Tue, Feb 10, 2015 at 11:36:24AM +1100, Benjamin Herrenschmidt wrote:
>> >On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
>> >> If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
>> >> resources will be cleaned out during device header fixup time and then get
>> >> reassigned by PCI core. However, the VF resources won't be reassigned and
>> >> thus, we shouldn't clean them out.
>> >> 
>> >> This patch adds a condition. If the pci_dev is a VF, skip the resource
>> >> unset process.
>> >
>> >I don't understand this, can you elaborate ? Why wouldn't we reassign
>> >the IOV resource just like everything else ?
>> 
>> Sure.
>> 
>> VFs work a little bit different from normal devices. On powernv platform, we
>> have PCI_REASSIGN_ALL_RSRC set, which means all resource retrieved from
>> hardware will be cleaned and re-assigned by kernel. While VF's resources are
>> calculated from PF's IOV BAR, in virtfn_add(). And after this, there is not
>> re-assign process for VFs.
>
>I still don't undertand, you mean SR-IOV is assigned before we assign
>everybody else ? That doesn't make sense to me...
>

PF's resource will be assigned first, including normal BARs and IOV BARs.

Then PF's driver will create VFs, in virtfn_add(). In this function, VF's
resources is calculated from its PF's IOV BAR.

If you reset VF's resource as PFs, no one will try to assign it again.

>Ben.
>
>> >
>> >Ben.
>> >
>> >> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> >> ---
>> >>  arch/powerpc/kernel/pci-common.c |    4 ++++
>> >>  1 file changed, 4 insertions(+)
>> >> 
>> >> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> >> index 37d512d..889f743 100644
>> >> --- a/arch/powerpc/kernel/pci-common.c
>> >> +++ b/arch/powerpc/kernel/pci-common.c
>> >> @@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
>> >>  		       pci_name(dev));
>> >>  		return;
>> >>  	}
>> >> +
>> >> +	if (dev->is_virtfn)
>> >> +		return;
>> >> +
>> >>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>> >>  		struct resource *res = dev->resource + i;
>> >>  		struct pci_bus_region reg;
>> >
>> 
>

-- 
Richard Yang
Help you, Help me

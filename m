Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D77751A0198
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 17:10:16 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 2 Mar 2015 16:10:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ACF143578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 17:10:12 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t226A23s51642460
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 17:10:10 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2269cUM013784
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 17:09:39 +1100
Date: Mon, 2 Mar 2015 14:09:23 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
Message-ID: <20150302060923.GB21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423528584.4924.70.camel@au1.ibm.com>
 <20150210015123.GC6326@richard>
 <1423534451.4924.79.camel@au1.ibm.com>
 <20150210062544.GB31098@richard>
 <1423556085.4924.91.camel@au1.ibm.com>
 <20150220234709.GD21131@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150220234709.GD21131@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2015 at 05:47:09PM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 10, 2015 at 07:14:45PM +1100, Benjamin Herrenschmidt wrote:
>> On Tue, 2015-02-10 at 14:25 +0800, Wei Yang wrote:
>> > PF's resource will be assigned first, including normal BARs and IOV
>> > BARs.
>> > 
>> > Then PF's driver will create VFs, in virtfn_add(). In this function,
>> > VF's
>> > resources is calculated from its PF's IOV BAR.
>> > 
>> > If you reset VF's resource as PFs, no one will try to assign it again.
>> 
>> So the problem is that the flag indicating VF is lost ? IE. We should
>> still mark them unset, but preserve that flag ?
>
>I think the problem is that the normal path for PCI_REASSIGN_ALL_RSRC is
>at boot-time, where we do this:
>
>    pcibios_init
>      pcibios_scan_phb
>        pci_scan_child_bus
>          ...
>            pci_device_add
>              pci_fixup_device(pci_fixup_header)
>		pcibios_fixup_resources                       # header fixup
>		  for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
>		    dev->resource[i].start = 0
>      pcibios_resource_survey
>        pcibios_allocate_resources
>
>and we assign dev->resource[] for everything in
>pcibios_allocate_resources().
>
>But VFs are enumerated later, when they are enabled by the PF driver after
>boot, so we have this path:
>
>    pci_enable_sriov
>      sriov_enable
>        virtfn_add(vf_id)
>          for (i = 0; i < 6; i++)
>            vf->resource[i].start = pf->resource[IOV + i].start + (size * vf_id)
>          pci_device_add
>            pci_fixup_device(pci_fixup_header)
>              pcibios_fixup_resources                   # header fixup
>                for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
>                  vf->resource[i].start = 0
>
>Here, we clear out vf->resource[0..5] in the header fixup, but we're not
>going to call pcibios_allocate_resources() again to reassign them.
>
>So I think the *intent* of PCI_REASSIGN_ALL_RSRC is preserved if
>pcibios_fixup_resources() leaves the VF resources alone, because the VF
>resources are completely determined by the PF resources, and the PF
>resources have already been reassigned.
>
>If my understanding is correct, I think the patch is reasonable, and I
>would try to put some of this explanation into the changelog.

Yep, it is correct, thanks for your explanation.

I did a chat on IRC with Ben, I guess he has got the idea :-)

>
>Bjorn

-- 
Richard Yang
Help you, Help me

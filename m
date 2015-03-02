Return-Path: <benh@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5812C1A0475
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 18:57:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 2 Mar 2015 17:57:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C8FF52CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 18:57:21 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t227vDmE40632488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 18:57:21 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t227umvo017056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 18:56:48 +1100
Message-ID: <1425282979.4636.10.camel@au1.ibm.com>
Subject: Re: [PATCH v12 14/21] powerpc/powernv: Allocate struct pnv_ioda_pe
 iommu_table dynamically
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Mon, 02 Mar 2015 18:56:19 +1100
In-Reply-To: <20150302075036.GH21571@richard>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083435.32124.65099.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224084653.GI6220@google.com> <20150302075036.GH21571@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-02 at 15:50 +0800, Wei Yang wrote:
> >
> >Is there a hotplug remove path where we should also be calling
> >iommu_free_table()?
> 
> When VF is not introduced, no one calls this on powernv platform.
> 
> Each PCI bus is a PE and it has its own iommu table, even a device is
> hotpluged, the iommu table will not be released.

Actually, I believe Alexey patches to add support for dynamic DMA
windows for KVM guests using VFIO will also alloc/free iommu tables. In
fact his patches somewhat change quite a few things in that area, and
I'm currently reviewing them.

Wei, can you post a new series when you've finished sync'ing with
Bjorn ? At that point, I'll try to work with Alexey to evaluate the
impact of his changes on your patches.

Cheers,
Ben.

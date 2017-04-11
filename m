Return-Path: <srs0=gg/w=3t=linux.vnet.ibm.com=gwshan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Dw03NWQzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 14:43:44 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2Dw02fLzz8t5G
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 14:43:44 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2Dvz6cj1z9sNQ
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 14:43:43 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3B4hepf022326
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 00:43:41 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rku02ey1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 00:43:41 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 14:43:39 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3B4hSwV47120550
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 14:43:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3B4h3FR011499
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 14:43:03 +1000
Date: Tue, 11 Apr 2017 14:42:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: IanJiang <ianjiang.cn@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: EEH error in doing DMA with PEX 8619
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1491826953201-121121.post@n7.nabble.com>
 <20170410222442.GA11610@gwshan>
 <1491876268752-121154.post@n7.nabble.com>
 <1491876910.4166.219.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491876910.4166.219.camel@au1.ibm.com>
Message-Id: <20170411044238.GA8157@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 11, 2017 at 12:15:10PM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2017-04-10 at 19:04 -0700, IanJiang wrote:
>> Thanks for your replay.
>> 
>> I fixed my test according your suggestion. The CPU physical addresses (0x
>> 1f9e400000 and 0x 1f82c00000) converted with virt_to_phys() are used ,
>> instead of DMA addresses, or BUS physical addresses (0x 60a00000 and 0x
>> 60c00000). However, EEH still reports error.
>
>That's incorrect. The system has an IOMMU, only addressed properly
>mapped/translated by the IOMMU can be used for DMA. That is addresses
>returned by things like dma_map_single/sg, dma_alloc_coherent, etc...
>
>You also need to ensure you configure a proper dma mask.
>
>Using virt_to_phys() is NEVER correct on *any* architecture.
>

Ben is correct that PCI device needs to use DMA address instead of
memory address. I was suggesting to ensure that in the driver's code
and was misunderstood. It seems the driver has used the DMA address,
which is correct. But it seems the TCE entry for the DMA address isn't
built correctly. Could you please share the kernel log with original
driver code? I am not sure if I can find somethere there, but worthy
to check.

Thanks,
Gavin

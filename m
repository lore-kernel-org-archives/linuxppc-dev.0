Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSkdg577xzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 15:19:03 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1M4IYDw048707
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 23:19:01 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rp4q0t2u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 23:19:00 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 14:18:57 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4615B2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 15:18:54 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1M4Ik737012510
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 15:18:54 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1M4ILp2022082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 15:18:21 +1100
Date: Wed, 22 Feb 2017 15:17:56 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Update iommu table base on
 ownership change
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170221024131.47753-1-aik@ozlabs.ru>
 <20170221232844.GA8704@gwshan>
 <766ce18c-e155-75df-7afe-f5a37cbb69a4@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <766ce18c-e155-75df-7afe-f5a37cbb69a4@ozlabs.ru>
Message-Id: <20170222041756.GA8826@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2017 at 02:05:15PM +1100, Alexey Kardashevskiy wrote:
>On 22/02/17 10:28, Gavin Shan wrote:
>> On Tue, Feb 21, 2017 at 01:41:31PM +1100, Alexey Kardashevskiy wrote:

[The subsequent discussion isn't related to the patch itself anymore]

>> One thing would be improved in future, which isn't relevant to
>> this patch if my understanding is correct enough: The TCE table for
>> DMA32 space created during system boot is destroyed when VFIO takes
>> the ownership. The same TCE table (same level, page size, window size
>> etc) is created and associated to the PE again. Some CPU cycles would
>> be saved if the original table is picked up without creating a new one.
>
>It is not necessary same levels or window size, could be something
>different. Also carrying a table will just make code bit more complicated
>and it is complicated enough already - we need to consider very possible
>case of IOMMU tables sharing.
>

Right after host boots up and VFIO isn't involved yet, each PE is associated
with a DMA32 space (0 - 2G) and the IO page size is 4KB. If the whole (window)
size, IO page size or levels are changed after the PE is released from guest
to host, it's not so much reasonable as the device (including its TCE table)
needs to be restored to previous state. Or we are talking about different
DMA space (TCE tables)?

Regarding the possiblity of sharing IOMMU tables, I don't quite understand.
Do you mean the situation of multiple functions adapter, some of them are
passed to guest and the left owned by host? I don't see how it works from
the DMA path. Would you please explain a bit?

>
>> The involved function is pnv_pci_ioda2_create_table(). Its primary work
>> is to allocate pages from buddy.
>
>It allocates pages via alloc_pages_node(), not buddy.
>

page allocator maybe? It's fetching page from PCP (PerCPU Pages) or buddy's
freelist depending on the requested size.

>> It's usually fast if there are enough
>> free pages. Otherwise, it would be relatively slow. It also has the risk
>> to fail the allocation. I guess it's not bad to save CPU cycles in this
>> critical (maybe hot?) path.
>
>It is not a critical path - it happens on a guest (re)boot only.
>

My point is: it sounds nice if less time needs for guest to (re)boot. I
don't know how much time could be saved though.

Thanks,
Gavin

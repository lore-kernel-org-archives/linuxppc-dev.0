Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E787E1A0743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 10:12:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 10:12:43 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 054B22BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 10:12:39 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5F0CUhE27918396
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 10:12:39 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5F0C6jj027703
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 10:12:06 +1000
Date: Mon, 15 Jun 2015 10:11:41 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add devices only from
 buses which belong to PE
Message-ID: <20150615001141.GA8213@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1434089957-27135-1-git-send-email-aik@ozlabs.ru>
 <20150612064703.GA17776@gwshan>
 <20150612150643.GA55122@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150612150643.GA55122@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 12, 2015 at 08:06:43AM -0700, Nishanth Aravamudan wrote:
>On 12.06.2015 [16:47:03 +1000], Gavin Shan wrote:
>> On Fri, Jun 12, 2015 at 04:19:17PM +1000, Alexey Kardashevskiy wrote:
>> >The existing code puts all devices from a root PE to the same IOMMU group.
>> >However it is a possible situation when subordinate buses belong to
>> >separate PEs, in this case devices from these subordinate buses
>> >should be added to lower level PE rather to the root PE.
>> >
>> >This limits pnv_ioda_setup_bus_dma() invocation to only PEs which own
>> >all subordinate buses.
>> >
>> >Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> >Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> 
>> Alexey, I think it's good candidate for stable.
>
>Why? This commit message doesn't imply there is a serious bug just a
>"possible" (does that mean theoretical?) situtation and the following:
>

The problem depends on the PCI topology. Below topology, existing on
firestone machine, is one of the cases that wrong IOMMU group is used
for devices behind the upstream port of the PCIe switch: The PE for
Bus#2 has same IOMMU group as that one of the PE for "Root Bus" wrongly
here.

                        |
                        +---------------+       (Root Bus)
                        |               |
                  [ Root Port ]    [ System Peripheral ]
                        +
                        |			(Bus#1)
                        +
                  [ Up Port ]
			+
			|
           +------------+-----------+           (Bus#2)
           |                        |
     [ Dn port]                [ Dn Port]

>> >This would be nice to have together with the DDW patchset.
>> >This does not fix anything DDW patchset did, it fixes IOMMU
>> >groups management which is essential for the whole feature to work.
>
>implies it is both related and independent of DDW?
>

The problem is independent of DDW.

Thanks,
Gavin

>-Nish

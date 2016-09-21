Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf9kJ3Z9QzDsgk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:10:15 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8L78VQX048637
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 03:10:14 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25k6ckjetk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 03:10:13 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 01:10:11 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm: enable CONFIG_MOVABLE_NODE on powerpc
In-Reply-To: <20160921054500.lrqktzjqjhuzewqg@arbab-laptop>
References: <1473883618-14998-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1473883618-14998-4-git-send-email-arbab@linux.vnet.ibm.com>
 <87h99cxv00.fsf@linux.vnet.ibm.com>
 <20160921054500.lrqktzjqjhuzewqg@arbab-laptop>
Date: Wed, 21 Sep 2016 12:39:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87oa3hwwxs.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> On Mon, Sep 19, 2016 at 11:59:35AM +0530, Aneesh Kumar K.V wrote:
>>Movable node also does.
>>	memblock_set_bottom_up(true);
>>What is the impact of that. Do we need changes equivalent to that ? Also
>>where are we marking the nodes which can be hotplugged, ie where do we
>>do memblock_mark_hotplug() ?
>
> These are related to the mechanism x86 uses to create movable nodes at 
> boot. The SRAT is parsed to mark any hotplug memory. That marking is 
> used later when initializing ZONE_MOVABLE for each node. [1]
>
> The bottom-up allocation is due to a timing issue [2]. There is a window 
> where kernel memory may be allocated before the SRAT is parsed. Any 
> bottom-up allocations done during that time will likely be in the same 
> (nonmovable) node as the kernel image.
>
> On power, I don't think we have a heuristic equivalent to that SRAT 
> memory hotplug info. So, we'll be limited to dynamically adding movable 
> nodes after boot.
>
> 1. http://events.linuxfoundation.org/sites/events/files/lcjp13_chen.pdf
> 2. commit 79442ed189ac ("mm/memblock.c: introduce bottom-up allocation 
> mode")
>

What I was checking was how will one mark a node movable in ppc64 ? I
don't see ppc64 code doing the equivalent of memblock_mark_hotplug().

So when you say "Onlining memory into ZONE_MOVABLE requires
CONFIG_MOVABLE_NODE" where is that restriction ?. IIUC,
should_add_memory_movable() will only return ZONE_MOVABLE only if it is
non empty and MOVABLE_NODE will create a ZONE_MOVABLE zone by default
only if it finds a memblock marked hotpluggable. So wondering if we
are not calling memblock_mark_hotplug() how is it working. Or am I
missing something ?

-aneesh

    

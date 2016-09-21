Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf7rD6VmqzDsgf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 15:45:16 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8L5cDBu019610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 01:45:14 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kkqahjqv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 01:45:14 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 20 Sep 2016 23:45:12 -0600
Date: Wed, 21 Sep 2016 00:45:01 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
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
References: <1473883618-14998-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1473883618-14998-4-git-send-email-arbab@linux.vnet.ibm.com>
 <87h99cxv00.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87h99cxv00.fsf@linux.vnet.ibm.com>
Message-Id: <20160921054500.lrqktzjqjhuzewqg@arbab-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2016 at 11:59:35AM +0530, Aneesh Kumar K.V wrote:
>Movable node also does.
>	memblock_set_bottom_up(true);
>What is the impact of that. Do we need changes equivalent to that ? Also
>where are we marking the nodes which can be hotplugged, ie where do we
>do memblock_mark_hotplug() ?

These are related to the mechanism x86 uses to create movable nodes at 
boot. The SRAT is parsed to mark any hotplug memory. That marking is 
used later when initializing ZONE_MOVABLE for each node. [1]

The bottom-up allocation is due to a timing issue [2]. There is a window 
where kernel memory may be allocated before the SRAT is parsed. Any 
bottom-up allocations done during that time will likely be in the same 
(nonmovable) node as the kernel image.

On power, I don't think we have a heuristic equivalent to that SRAT 
memory hotplug info. So, we'll be limited to dynamically adding movable 
nodes after boot.

1. http://events.linuxfoundation.org/sites/events/files/lcjp13_chen.pdf
2. commit 79442ed189ac ("mm/memblock.c: introduce bottom-up allocation 
mode")

-- 
Reza Arbab

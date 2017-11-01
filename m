Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRn4V3YDGzDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 23:06:17 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA1C5Mtl019827
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 08:06:14 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dyaq8k257-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 08:06:06 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 1 Nov 2017 12:05:57 -0000
Subject: Re: [RFC PATCH 0/7] powerpc/64s/radix TLB flush performance
 improvements
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20171031064504.25245-1-npiggin@gmail.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 17:35:51 +0530
MIME-Version: 1.0
In-Reply-To: <20171031064504.25245-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c9c80f5a-9a53-1b7b-99c8-b40049355722@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2017 12:14 PM, Nicholas Piggin wrote:
> Here's a random mix of performance improvements for radix TLB flushing
> code. The main aims are to reduce the amount of translation that gets
> invalidated, and to reduce global flushes where we can do local.
> 
> To that end, a parallel kernel compile benchmark using powerpc:tlbie
> tracepoint shows a reduction in tlbie instructions from about 290,000
> to 80,000, and a reduction in tlbiel instructions from 49,500,000 to
> 15,000,000. Looks great, but unfortunately does not translate to a
> statistically significant performance improvement! The needle on TLB
> misses does not move much, I suspect because a lot of the flushing is
> done a startup and shutdown, and because a significant cost of TLB
> flushing itself is in the barriers.

Does memory barrier initiate a single global invalidation with tlbie ?

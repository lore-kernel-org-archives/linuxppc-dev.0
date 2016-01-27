Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA2761A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 21:09:45 +1100 (AEDT)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 27 Jan 2016 10:09:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1D59F2190056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 10:09:27 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0RA9dHD31588458
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 10:09:39 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0RA9cIH008387
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 03:09:39 -0700
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 0/3] Optimize CONFIG_DEBUG_PAGEALLOC
Date: Wed, 27 Jan 2016 11:09:58 +0100
Message-Id: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew, since the arch patches depend on the base patch, maybe the mm
tree is the right one? I have acks/reviews for the s390/x86 part.


As CONFIG_DEBUG_PAGEALLOC can be enabled/disabled via kernel
parameters we can optimize some cases by checking the enablement
state.

I have done s390 and x86 as examples.
s390 should be ok, I tested several combinations, x86 seems to
work as well.

Power can probably do the same, Michael/Ben?
I am not sure about sparc. Sparc seems to allocate the TSB buffer
really early. David?


V2->V3:
- Fix whitespace/indent breakage in s390 patch
V1->V2:
- replace DEBUG_PAGEALLOC(disabled/enabled) with DEBUG_PAGEALLOC
  dump_stack for s390/x86
- add /* CONFIG_DEBUG_PAGEALLOC */ to else and endif


Christian Borntraeger (3):
  mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC
  x86: query dynamic DEBUG_PAGEALLOC setting
  s390: query dynamic DEBUG_PAGEALLOC setting

 arch/s390/kernel/dumpstack.c |  6 +++---
 arch/s390/mm/vmem.c          | 10 ++++------
 arch/x86/kernel/dumpstack.c  |  5 ++---
 arch/x86/mm/init.c           |  7 ++++---
 arch/x86/mm/pageattr.c       | 14 ++++----------
 include/linux/mm.h           |  9 +++++++--
 6 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.3.0

Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mpR14v7tzF1Rc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 21:06:53 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4HB4EAG138450
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 07:06:51 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j18149p3f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 07:06:50 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 17 May 2018 12:06:47 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
 kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 sergey.senozhatsky.work@gmail.com, Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Minchan Kim <minchan@kernel.org>, Punit Agrawal <punitagrawal@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v11 01/26] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
Date: Thu, 17 May 2018 13:06:08 +0200
In-Reply-To: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1526555193-7242-2-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This configuration variable will be used to build the code needed to
handle speculative page fault.

By default it is turned off, and activated depending on architecture
support, ARCH_HAS_PTE_SPECIAL, SMP and MMU.

The architecture support is needed since the speculative page fault handler
is called from the architecture's page faulting code, and some code has to
be added there to handle the speculative handler.

The dependency on ARCH_HAS_PTE_SPECIAL is required because vm_normal_page()
does processing that is not compatible with the speculative handling in the
case ARCH_HAS_PTE_SPECIAL is not set.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 1d0888c5b97a..a38796276113 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -761,3 +761,25 @@ config GUP_BENCHMARK
 
 config ARCH_HAS_PTE_SPECIAL
 	bool
+
+config ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
+       def_bool n
+
+config SPECULATIVE_PAGE_FAULT
+       bool "Speculative page faults"
+       default y
+       depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
+       depends on ARCH_HAS_PTE_SPECIAL && MMU && SMP
+       help
+         Try to handle user space page faults without holding the mmap_sem.
+
+	 This should allow better concurrency for massively threaded process
+	 since the page fault handler will not wait for other threads memory
+	 layout change to be done, assuming that this change is done in another
+	 part of the process's memory space. This type of page fault is named
+	 speculative page fault.
+
+	 If the speculative page fault fails because of a concurrency is
+	 detected or because underlying PMD or PTE tables are not yet
+	 allocating, it is failing its processing and a classic page fault
+	 is then tried.
-- 
2.7.4

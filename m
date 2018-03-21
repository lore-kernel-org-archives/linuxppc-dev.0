Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4060853w36zF1p4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:23:17 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LJIYn6122001
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:23:15 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2guvm8ag26-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:23:15 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 19:23:12 -0000
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 02/32] docs/vm: balance: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:18 +0200
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1521660168-14372-3-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/balance | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/balance b/Documentation/vm/balance
index 9645954..6a1fadf 100644
--- a/Documentation/vm/balance
+++ b/Documentation/vm/balance
@@ -1,3 +1,9 @@
+.. _balance:
+
+================
+Memory Balancing
+================
+
 Started Jan 2000 by Kanoj Sarcar <kanoj@sgi.com>
 
 Memory balancing is needed for !__GFP_ATOMIC and !__GFP_KSWAPD_RECLAIM as
@@ -62,11 +68,11 @@ for non-sleepable allocations. Second, the HIGHMEM zone is also balanced,
 so as to give a fighting chance for replace_with_highmem() to get a
 HIGHMEM page, as well as to ensure that HIGHMEM allocations do not
 fall back into regular zone. This also makes sure that HIGHMEM pages
-are not leaked (for example, in situations where a HIGHMEM page is in 
+are not leaked (for example, in situations where a HIGHMEM page is in
 the swapcache but is not being used by anyone)
 
 kswapd also needs to know about the zones it should balance. kswapd is
-primarily needed in a situation where balancing can not be done, 
+primarily needed in a situation where balancing can not be done,
 probably because all allocation requests are coming from intr context
 and all process contexts are sleeping. For 2.3, kswapd does not really
 need to balance the highmem zone, since intr context does not request
@@ -89,7 +95,8 @@ pages is below watermark[WMARK_LOW]; in which case zone_wake_kswapd is also set.
 
 
 (Good) Ideas that I have heard:
+
 1. Dynamic experience should influence balancing: number of failed requests
-for a zone can be tracked and fed into the balancing scheme (jalvo@mbay.net)
+   for a zone can be tracked and fed into the balancing scheme (jalvo@mbay.net)
 2. Implement a replace_with_highmem()-like replace_with_regular() to preserve
-dma pages. (lkd@tantalophile.demon.co.uk)
+   dma pages. (lkd@tantalophile.demon.co.uk)
-- 
2.7.4

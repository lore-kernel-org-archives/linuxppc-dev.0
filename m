Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlCsl5CX0zDr3n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 07:03:55 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66Krs7g077439
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 17:03:53 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xm82a8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 17:03:53 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 18:03:51 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 5E0A71DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 17:03:40 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66L3mc812190152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:03:48 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66L3k67017460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:03:47 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/3] dma: introduce DMA_ATTR_NO_WARN
Date: Wed,  6 Jul 2016 18:03:31 -0300
In-Reply-To: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1467839013-22481-2-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce the DMA_ATTR_NO_WARN attribute, and document it.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 Documentation/DMA-attributes.txt | 17 +++++++++++++++++
 include/linux/dma-attrs.h        |  1 +
 2 files changed, 18 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index e8cf9cf..841e771 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -126,3 +126,20 @@ means that we won't try quite as hard to get them.
 
 NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
 though ARM64 patches will likely be posted soon.
+
+DMA_ATTR_NO_WARN
+----------------
+
+This tells the DMA-mapping subsystem to supress allocation failure reports
+(similarly to __GFP_NOWARN).
+
+On some architectures allocation failures are reported with error messages
+to the system logs.  Although this can help to identify and debug problems,
+drivers which handle failures (eg, retry later) have no problems with them,
+and can actually flood the system logs with error messages that aren't any
+problem at all, depending on the implementation of the retry mechanism.
+
+So, this provides a way for drivers to avoid those error messages on calls
+where allocation failures are not a problem, and shouldn't bother the logs.
+
+NOTE: At the moment DMA_ATTR_NO_WARN is only implemented on PowerPC.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index f3c5aea..0577389 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -19,6 +19,7 @@ enum dma_attr {
 	DMA_ATTR_SKIP_CPU_SYNC,
 	DMA_ATTR_FORCE_CONTIGUOUS,
 	DMA_ATTR_ALLOC_SINGLE_PAGES,
+	DMA_ATTR_NO_WARN,
 	DMA_ATTR_MAX,
 };
 
-- 
1.8.3.1

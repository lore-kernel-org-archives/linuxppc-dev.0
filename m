Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3FKj5SC7zDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 09:05:13 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71N48kJ136800
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 19:05:11 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grracq9s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 19:05:11 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 20:05:08 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id A81DB3520070
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 19:04:47 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71N57Z69568534
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71N56uP023864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] dma-mapping: introduce the DMA_ATTR_NO_WARN attribute
Date: Mon,  1 Aug 2016 20:05:04 -0300
In-Reply-To: <1470092706-28075-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470092706-28075-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1470092706-28075-2-git-send-email-mauricfo@linux.vnet.ibm.com>
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
 include/linux/dma-mapping.h      |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 2d455a5..98bf7ac 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -126,3 +126,20 @@ means that we won't try quite as hard to get them.
 
 NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
 though ARM64 patches will likely be posted soon.
+
+DMA_ATTR_NO_WARN
+----------------
+
+This tells the DMA-mapping subsystem to suppress allocation failure reports
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
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 66533e1..6efbd27 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -56,6 +56,11 @@
  * that gives better TLB efficiency.
  */
 #define DMA_ATTR_ALLOC_SINGLE_PAGES	(1UL << 7)
+/*
+ * DMA_ATTR_NO_WARN: This tells the DMA-mapping subsystem to suppress
+ * allocation failure reports (similarly to __GFP_NOWARN).
+ */
+#define DMA_ATTR_NO_WARN	(1UL << 8)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
-- 
1.8.3.1

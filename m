Return-Path: <srs0=h10r=hj=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S3jW4r2pzF258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:06:23 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40S3jW3kMBz8tKK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:06:23 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40S3jW0JGWz9s5H
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 15:06:22 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3K560DP019195
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 01:06:21 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hf2jwffcp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 01:06:10 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 20 Apr 2018 06:04:56 +0100
Subject: [PATCH v4 5/7] powerpc/fadump: Update documentation to reflect CMA
 reservation.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 20 Apr 2018 10:34:51 +0530
In-Reply-To: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152420069171.31037.10578740903757971568.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 30b32f879219..2ab13270b050 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -113,7 +113,15 @@ header, is usually reserved at an offset greater than boot memory
 size (see Fig. 1). This area is *not* released: this region will
 be kept permanently reserved, so that it can act as a receptacle
 for a copy of the boot memory content in addition to CPU state
-and HPTE region, in the case a crash does occur.
+and HPTE region, in the case a crash does occur. Since this reserved
+memory area is used only after the system crash, there is no point in
+blocking this significant chunk of memory from production kernel.
+Hence, the implementation uses the Linux kernel's Contiguous Memory
+Allocator (CMA) for memory reservation. With CMA reservation this memory
+will be available for applications to use it, while kernel is prevented
+from using it. With this fadump will still be able to capture all of
+the kernel memory and most of the user space memory except the user
+pages that were present in CMA region.
 
 The first kernel, during fadump registration, prepares ELF core header
 that contains necessary information for the coredump of the 1st kernel

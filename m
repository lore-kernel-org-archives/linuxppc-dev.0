Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Qr718n9zDqdc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 04:27:34 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u78H5brP015795
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 14:27:32 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24nc30ax1k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 14:27:31 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 12:27:31 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm: enable CONFIG_MOVABLE_NODE on powerpc
Date: Mon,  8 Aug 2016 13:27:23 -0500
In-Reply-To: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1470680843-28702-5-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Onlining memory into ZONE_MOVABLE requires CONFIG_MOVABLE_NODE.

Enable the use of this config option on PPC64 platforms.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt | 2 +-
 mm/Kconfig                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 46c030a..07fefd8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2344,7 +2344,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			that the amount of memory usable for all allocations
 			is not too small.
 
-	movable_node	[KNL,X86] Boot-time switch to enable the effects
+	movable_node	[KNL,X86,PPC] Boot-time switch to enable the effects
 			of CONFIG_MOVABLE_NODE=y. See mm/Kconfig for details.
 
 	MTD_Partition=	[MTD]
diff --git a/mm/Kconfig b/mm/Kconfig
index 78a23c5..4154638 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -153,7 +153,7 @@ config MOVABLE_NODE
 	bool "Enable to assign a node which has only movable memory"
 	depends on HAVE_MEMBLOCK
 	depends on NO_BOOTMEM
-	depends on X86_64
+	depends on X86_64 || PPC64
 	depends on NUMA
 	default n
 	help
-- 
1.8.3.1

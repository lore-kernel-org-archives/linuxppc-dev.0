Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLr1d1XmJzDsV8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 06:01:24 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VK0iso029652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:22 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c2a1xbegs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:22 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 16:01:22 -0400
Subject: [RFC PATCH 2/3] powerpc/numa: Get device node whenn retreiving usm
 memory
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com
Date: Mon, 31 Jul 2017 15:48:21 -0400
In-Reply-To: <20170731193259.8956.18833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170731193259.8956.18833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170731194821.8956.35324.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we move to using the kernel lmb structs instead of accessing
the device tree directly for LMB information we will no longer have
a pointer to the device node for memory to pass to
of_get_usable_memory().

This patch updates of_get_usable_memory() to no longer take a
device node pointer and does the lookup of the memory device node
itself.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9c21953..24d9299 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -184,11 +184,19 @@ static const __be32 *of_get_associativity(struct device_node *dev)
  * it exists (the property exists only in kexec/kdump kernels,
  * added by kexec-tools)
  */
-static const __be32 *of_get_usable_memory(struct device_node *memory)
+static const __be32 *of_get_usable_memory(void)
 {
+	struct device_node *memory;
 	const __be32 *prop;
 	u32 len;
+
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!memory)
+		return NULL;
+
 	prop = of_get_property(memory, "linux,drconf-usable-memory", &len);
+	of_node_put(memory);
+
 	if (!prop || len < sizeof(unsigned int))
 		return NULL;
 	return prop;
@@ -674,7 +682,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 		return;
 
 	/* check if this is a kexec/kdump kernel */
-	usm = of_get_usable_memory(memory);
+	usm = of_get_usable_memory();
 	if (usm != NULL)
 		is_kexec_kdump = 1;
 

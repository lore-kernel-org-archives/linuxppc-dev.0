Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y67VN6Gz7zDqny
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 05:54:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v93InReX011554
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 14:54:02 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dccvkun0u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 14:54:02 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 14:54:01 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v93IrwPC2556348
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 18:53:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F5352803D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:53:52 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id EA1F32803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:53:51 -0400 (EDT)
Subject: [PATCH2/8] powerpc/numa: Look up device node in of_get_usable_memory()
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 03 Oct 2017 13:39:47 -0500
In-Reply-To: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150705598703.7318.10871466165226107733.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Look up the device node for the usable memory property instead
of having it passed in as a parameter. This changes precedes an update
in which the calling routines for of_get_usable_memory() will not have
the device node pointer to pass in.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index ca5cc1d4d387..a9aa353d41cd 100644
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
 

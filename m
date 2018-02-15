Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zj97B1PV6zF1MV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 08:55:17 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1FLsPPf018623
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 16:55:15 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g5g93n39w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 16:55:15 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 14:55:14 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC 1/4] powerpc/hotplug/drcinfo: Fix bugs parsing ibm,drc-info
 structs
In-Reply-To: <531f98fb-a29b-53e2-e7d5-870a531b76fd@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 15:54:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <16091b05-aa76-efed-fcd6-c6b410b8b5ee@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a memory parsing bug when using of_prop_next_u32
calls at the start of a structure.  Depending upon the value of
"cur" memory pointer argument to of_prop_next_u32, it will or it
won't advance the value of the returned memory pointer by the
size of one u32.  This patch corrects the code to deal with that
indexing feature when parsing the ibm,drc-info structs for CPUs.
Also, need to advance the pointer at the end of_read_drc_info_cell
for same reason.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmware feature" -- end of patch series applied to powerpc next)
---
 arch/powerpc/platforms/pseries/of_helpers.c     |    4 +---
 arch/powerpc/platforms/pseries/pseries_energy.c |    2 ++
 drivers/pci/hotplug/rpaphp_core.c               |    1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 7eea891..20598b2 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -65,9 +65,7 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
 
 	/* Get drc-index-start:encode-int */
 	p2 = (const __be32 *)p;
-	p2 = of_prop_next_u32(*prop, p2, &data->drc_index_start);
-	if (!p2)
-		return -EINVAL;
+	data->drc_index_start = of_read_number(p2, 1);
 
 	/* Get drc-name-suffix-start:encode-int */
 	p2 = of_prop_next_u32(*prop, p2, &data->drc_name_suffix_start);
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 6ed2212..c7d84aa 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -64,6 +64,7 @@ static u32 cpu_to_drc_index(int cpu)
 		value = of_prop_next_u32(info, NULL, &num_set_entries);
 		if (!value)
 			goto err_of_node_put;
+		value++;
 
 		for (j = 0; j < num_set_entries; j++) {
 
@@ -126,6 +127,7 @@ static int drc_index_to_cpu(u32 drc_index)
 		value = of_prop_next_u32(info, NULL, &num_set_entries);
 		if (!value)
 			goto err_of_node_put;
+		value++;
 
 		for (j = 0; j < num_set_entries; j++) {
 
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 53902c7..477a21c 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -253,6 +253,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 	value = of_prop_next_u32(info, NULL, &entries);
 	if (!value)
 		return -EINVAL;
+	value++;
 
 	for (j = 0; j < entries; j++) {
 		of_read_drc_info_cell(&info, &value, &drc);

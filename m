Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcG7R10DFzDr8c
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 09:23:30 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w17MJUpN077617
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Feb 2018 17:23:27 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g06461xtb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 17:23:27 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 7 Feb 2018 15:23:26 -0700
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC] powerpc/hotplug/drcinfo: Fix bugs parsing ibm,drc-info structs
Date: Wed, 7 Feb 2018 16:22:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <50f12908-d174-9806-61ca-7515b4b5b90e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Replace/withdraw previous patch submission to ensure that testing
of related patches on similar hardware progresses together.
Request comments about current state.]

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
index 6df192f..17b5938 100644
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

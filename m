Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04EB21A1D69
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 07:01:58 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 15:01:56 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D21B53E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 15:01:54 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5ML1r1k49283142
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:01:53 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5ML1rD8016258
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 15:01:53 -0600
Received: from [9.41.105.93] (dhcp-9-41-105-93.austin.ibm.com [9.41.105.93])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t5ML1pD2016014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 15:01:52 -0600
Message-ID: <558877BC.5030903@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 16:01:48 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] pseries: Add CPU dlpar add functionality
References: <558875FF.2040000@linux.vnet.ibm.com>
In-Reply-To: <558875FF.2040000@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the ability to hotplug add cpus via rtas hotplug events by either
specifying the drc index of the CPU to add, or providing a count of the
number of CPUs to add.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   76 ++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 49b7196..a5d4c89 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -673,6 +673,74 @@ static int dlpar_cpu_remove_by_count(struct device_node *parent,
 	return rc;
 }
 
+static int dlpar_cpu_add_by_count(struct device_node *parent, u32 cpus_to_add)
+{
+	struct dr_cpu *dr_cpus;
+	int dr_cpus_added = 0;
+	int dr_cpus_available = 0;
+	int dr_cpus_possible;
+	int i, rc;
+
+	pr_info("Attempting to hot-add %d CPUs\n", cpus_to_add);
+
+	dr_cpus = get_dlpar_cpus(parent);
+	if (!dr_cpus) {
+		pr_info("Could not gather dr CPU info\n");
+		return -EINVAL;
+	}
+
+	dr_cpus_possible = dlpar_cpus_possible(parent);
+
+	for (i = 0; i < dr_cpus_possible; i++) {
+		if (!dr_cpus[i].present)
+			dr_cpus_available++;
+	}
+
+	/* Validate the available CPUs to add. */
+	if (cpus_to_add > dr_cpus_available) {
+		pr_err("Insufficient CPUs (%d) to satisfy add request\n",
+		       dr_cpus_available);
+		kfree(dr_cpus);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dr_cpus_possible; i++) {
+		if (dr_cpus_added == cpus_to_add)
+			break;
+
+		if (dr_cpus[i].present)
+			continue;
+
+		rc = dlpar_cpu_add(parent, dr_cpus[i].drc_index);
+		if (!rc) {
+			dr_cpus_added++;
+			dr_cpus[i].modified = true;
+		}
+	}
+
+	if (dr_cpus_added < cpus_to_add) {
+		pr_err("CPU hot-add failed, removing any added CPUs\n");
+
+		for (i = 0; i < dr_cpus_possible; i++) {
+			if (!dr_cpus[i].modified)
+				continue;
+
+			rc = dlpar_cpu_remove_by_index(parent,
+						       dr_cpus[i].drc_index);
+			if (rc)
+				pr_info("Failed to remove added CPU (%x)\n",
+					dr_cpus[i].drc_index);
+		}
+
+		rc = -EINVAL;
+	} else {
+		rc = 0;
+	}
+
+	kfree(dr_cpus);
+	return rc;
+}
+
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 {
 	struct device_node *parent;
@@ -697,6 +765,14 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_ADD:
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+			rc = dlpar_cpu_add_by_count(parent, count);
+		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+			rc = dlpar_cpu_add(parent, drc_index);
+		else
+			rc = -EINVAL;
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;

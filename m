Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcwNW6gSCzDw1N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 08:05:47 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBCKwtg7052189
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:05:45 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27a26nw0q3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:05:45 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Mon, 12 Dec 2016 16:05:44 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 70254C90045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:05:24 -0500 (EST)
Subject: [PATCH 1/2] powerpc/pseries: Introduce memory hotplug READD operation
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <7125fe8e-60f9-2152-d159-0f4c07183547@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 15:05:40 -0600
MIME-Version: 1.0
In-Reply-To: <7125fe8e-60f9-2152-d159-0f4c07183547@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8d2c4307-4815-2c41-f2a2-4221a61f239b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, memory must be hot removed and subsequently re-added in order
to dynamically update the affinity of LMBs specified by a PRRN event.
Earlier implementations of the PRRN event handler ran into issues in which
the hot remove would occur successfully, but a hotplug event would be
initiated from another source and grab the hotplug lock preventing the hot
add from occurring. To prevent this situation, this patch introduces the
notion of a hot "readd" action for memory which atomizes a hot remove and
a hot add into a single, serialized operation on the hotplug queue.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 9c23baa..076b892 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -318,6 +318,7 @@ struct pseries_hp_errorlog {

 #define PSERIES_HP_ELOG_ACTION_ADD	1
 #define PSERIES_HP_ELOG_ACTION_REMOVE	2
+#define PSERIES_HP_ELOG_ACTION_READD	3

 #define PSERIES_HP_ELOG_ID_DRC_NAME	1
 #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 76ec104..291d49b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -766,6 +766,11 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD:
+		rc = dlpar_memory_remove_by_index(drc_index, prop);
+		if (!rc)
+			dlpar_memory_add_by_index(drc_index, prop);
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;

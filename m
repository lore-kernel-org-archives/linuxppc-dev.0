Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HWB66zxrzF29m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:13:18 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TM8frl064169
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:13:16 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwujkbdp2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:13:16 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:13:15 -0400
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v02 3/5] migration/memory: Add hotplug READD_MULTIPLE
In-Reply-To: <adc67a97-b800-b533-7993-516fc254b6a2@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 17:13:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <6cf5f4c0-7784-8437-eb0b-dbe6e0d22d49@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migration/memory: This patch adds a new pseries hotplug action
for CPU and memory operations, PSERIES_HP_ELOG_ACTION_READD_MULTIPLE.
This is a variant of the READD operation which performs the action
upon multiple instances of the resource at one time.  The operation
is to be triggered by device-tree analysis of updates by RTAS events
analyzed by 'migation_store' during post-migration processing.  It
will be used for memory updates, initially.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |    1 +
 arch/powerpc/mm/drmem.c         |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 4ab605a..bb4294b 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -322,6 +322,7 @@ struct pseries_hp_errorlog {
 #define PSERIES_HP_ELOG_ACTION_ADD	1
 #define PSERIES_HP_ELOG_ACTION_REMOVE	2
 #define PSERIES_HP_ELOG_ACTION_READD	3
+#define PSERIES_HP_ELOG_ACTION_READD_MULTIPLE	4
 
 #define PSERIES_HP_ELOG_ID_DRC_NAME	1
 #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index fd2cae92..2228586 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -422,6 +422,7 @@ static void init_drmem_v2_lmbs(const __be32 *prop,
 
 			lmb->aa_index = dr_cell.aa_index;
 			lmb->flags = dr_cell.flags;
+			lmb->internal_flags = 0;
 		}
 	}
 }

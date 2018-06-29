Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HWB20PKdzF2Z7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:13:13 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TM9Abk054173
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:13:11 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jws618gu0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:13:11 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:13:10 -0400
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v02 2/5] powerpc/drmem: Add internal_flags feature
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <adc67a97-b800-b533-7993-516fc254b6a2@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 17:13:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <7c84dea4-fd73-9598-0bb6-0008a5c8fcab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/drmem: Add internal_flags field to each LMB to allow
marking of kernel software-specific operations that need not
be exported to other users.  For instance, if information about
selected LMBs needs to be maintained for subsequent passes
through the system, it can be encoded into the LMB array itself
without requiring the allocation and maintainance of additional
data structures.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h |   18 ++++++++++++++++++
 arch/powerpc/mm/drmem.c          |    2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index b0e70fd..acb6539 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -17,6 +17,7 @@ struct drmem_lmb {
 	u32     drc_index;
 	u32     aa_index;
 	u32     flags;
+	u32     internal_flags;
 };
 
 struct drmem_lmb_info {
@@ -101,6 +102,23 @@ static inline bool drmem_lmb_reserved(struct drmem_lmb *lmb)
 	return lmb->flags & DRMEM_LMB_RESERVED;
 }
 
+#define DRMEM_LMBINT_UPDATE	0x00000001
+
+static inline void drmem_mark_lmb_update(struct drmem_lmb *lmb)
+{
+	lmb->internal_flags |= DRMEM_LMBINT_UPDATE;
+}
+
+static inline void drmem_remove_lmb_update(struct drmem_lmb *lmb)
+{
+	lmb->internal_flags &= ~DRMEM_LMBINT_UPDATE;
+}
+
+static inline bool drmem_lmb_update(struct drmem_lmb *lmb)
+{
+	return lmb->internal_flags & DRMEM_LMBINT_UPDATE;
+}
+
 u64 drmem_lmb_memory_max(void);
 void __init walk_drmem_lmbs(struct device_node *dn,
 			void (*func)(struct drmem_lmb *, const __be32 **));
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 13d2abb..fd2cae92 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -207,6 +207,7 @@ static void read_drconf_v1_cell(struct drmem_lmb *lmb,
 
 	lmb->aa_index = of_read_number(p++, 1);
 	lmb->flags = of_read_number(p++, 1);
+	lmb->internal_flags = 0;
 
 	*prop = p;
 }
@@ -265,6 +266,7 @@ static void __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
 
 			lmb.aa_index = dr_cell.aa_index;
 			lmb.flags = dr_cell.flags;
+			lmb.internal_flags = 0;
 
 			func(&lmb, &usm);
 		}

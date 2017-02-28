Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXV0F4jHgzDqKG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:03:09 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S6sFt4023102
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:03:07 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28vqj17uy3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:03:06 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 12:33:02 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2D5DC394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:33:00 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S71skZ12189866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:31:54 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S72wsd020914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:32:59 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
 frederic.barrat@fr.ibm.com
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie <ianmunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [RFC 2/3] powerpc/eeh: Introduce function eeh_pe_reset_freeze_counter
Date: Tue, 28 Feb 2017 12:32:21 +0530
In-Reply-To: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
References: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20170228070222.21126-3-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces function eeh_pe_reset_freeze_counter which can
be used to reset the PE's freeze count variable outside eeh code. This
is useful for devices that can acquire a different personality after
a PERST event (e.g FPGA Adapters). Presently an existing freeze
count for an adapter with personality N will be taken into account
when the adapter acquired personality N+1.

By calling eeh_pe_reset_freeze_counter drivers can reset the freeze
counter for an adapter once it has acquired a new personality and
ideally wont be plagued by the failures similar to the one before.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 68806be..19ac6d0 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -266,6 +266,13 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
 int eeh_pe_update_freeze_counter(struct eeh_pe *pe);
+
+/* Reset the PE freeze counter */
+static inline void eeh_pe_reset_freeze_counter(struct eeh_pe *pe)
+{
+	pe->freeze_count = 0;
+}
+
 void *eeh_pe_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
@@ -339,6 +346,8 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
 	return 0;
 }
 
+static inline void eeh_pe_reset_freeze_counter(struct eeh_pe *pe) { }
+
 #define eeh_dev_check_failure(x) (0)
 
 static inline void eeh_addr_cache_build(void) { }
-- 
2.9.3

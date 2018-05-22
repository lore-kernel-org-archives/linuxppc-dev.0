Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r1Wy3J2kzDr0r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 02:37:18 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MGXwEC062770
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 12:37:15 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j4kwqj8jd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 12:37:15 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 10:37:14 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v4 2/4] hotplug/drcinfo: Provide parser with callback
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <47581596-1d6e-a1a9-9490-5b5ff0f5304f@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 11:37:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <2e2261b4-c0b3-3b6d-d649-541bc8802546@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides a common parse function for the ibm,drc-info
property that can be modified by a callback function.  The caller
provides a pointer to the function and a pointer to their unique
data, and the parser provides the current lmb set from the struct.
The callback function may return codes indicating that the parsing
is complete, or should continue, along with an error code that may
be returned to the caller.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmwar
e feature" -- end of patch series applied to powerpc next)
---
Changes in V4:
  -- Update code to account for latest kernel checkins.
  -- Rebased to 4.17-rc5 kernel
  -- Some patch cleanup including file combination
---
 arch/powerpc/include/asm/prom.h             |    7 +++++
 arch/powerpc/platforms/pseries/of_helpers.c |   37 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index b04c5ce..2e947b3 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -94,6 +94,13 @@ struct of_drc_info {
 extern int of_read_drc_info_cell(struct property **prop,
 			const __be32 **curval, struct of_drc_info *data);
 
+extern int drc_info_parser(struct device_node *dn,
+			int (*usercb)(struct of_drc_info *drc,
+					void *data,
+					void *optional_data,
+					int *ret_code),
+			char *opt_drc_type,
+			void *data);
 
 /*
  * There are two methods for telling firmware what our capabilities are.
diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 11b2ef1..a588ee6 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -6,6 +6,9 @@
 #include <asm/prom.h>
 
 #include "of_helpers.h"
+#include "pseries.h"
+
+#define	MAX_DRC_NAME_LEN 64
 
 /**
  * pseries_of_derive_parent - basically like dirname(1)
@@ -87,3 +90,37 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
 	return 0;
 }
 EXPORT_SYMBOL(of_read_drc_info_cell);
+
+int drc_info_parser(struct device_node *dn,
+		int (*usercb)(struct of_drc_info *drc,
+				void *data,
+				void *optional_data,
+				int *ret_code),
+		char *opt_drc_type,
+		void *data)
+{
+	struct property *info;
+	unsigned int entries;
+	struct of_drc_info drc;
+	const __be32 *value;
+	int j, done = 0, ret_code = -EINVAL;
+
+	info = of_find_property(dn, "ibm,drc-info", NULL);
+	if (info == NULL)
+		return -EINVAL;
+
+	value = info->value;
+	entries = of_read_number(value++, 1);
+
+	for (j = 0, done = 0; (j < entries) && (!done); j++) {
+		of_read_drc_info_cell(&info, &value, &drc);
+
+		if (opt_drc_type && strcmp(opt_drc_type, drc.drc_type))
+			continue;
+
+		done = usercb(&drc, data, NULL, &ret_code);
+	}
+
+	return ret_code;
+}
+EXPORT_SYMBOL(drc_info_parser);

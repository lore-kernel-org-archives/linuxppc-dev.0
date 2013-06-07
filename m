Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75B7C2C02A6
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Jun 2013 06:41:34 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 7 Jun 2013 16:41:31 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 97EDA6E805E
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Jun 2013 16:41:24 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r57KfSv0238694
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Jun 2013 16:41:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r57KfQF5026092
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Jun 2013 17:41:28 -0300
Date: Fri, 7 Jun 2013 13:40:43 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] perf: Add support for the mem_xlvl field.
Message-ID: <20130607204043.GB3281@us.ibm.com>
References: <20130607204008.GA3281@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130607204008.GA3281@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 9f1a8a16e0ef36447e343d1cd4797c2b6a81225f Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 7 Jun 2013 13:26:31 -0700
Subject: [PATCH 2/2] perf: Add support for the mem_xlvl field.

A follow-on patch to adding perf_mem_data_src support for Power7.
At this point, this is only  touch-tested as am looking for feedback
on the main kernel patch.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/sort.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 5f52d49..24bbf4d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -631,9 +631,11 @@ static int hist_entry__tlb_snprintf(struct hist_entry *self, char *bf,
 static int64_t
 sort__lvl_cmp(struct hist_entry *left, struct hist_entry *right)
 {
+	int64_t rc;
 	union perf_mem_data_src data_src_l;
 	union perf_mem_data_src data_src_r;
 
+	data_src_l.val = data_src_r.val = (int64_t)0;
 	if (left->mem_info)
 		data_src_l = left->mem_info->data_src;
 	else
@@ -644,7 +646,11 @@ sort__lvl_cmp(struct hist_entry *left, struct hist_entry *right)
 	else
 		data_src_r.mem_lvl = PERF_MEM_LVL_NA;
 
-	return (int64_t)(data_src_r.mem_lvl - data_src_l.mem_lvl);
+	rc = data_src_r.mem_lvl - data_src_l.mem_lvl;
+	if (!rc)
+		rc = data_src_r.mem_xlvl - data_src_l.mem_xlvl;
+		
+	return rc;
 }
 
 static const char * const mem_lvl[] = {
@@ -663,7 +669,14 @@ static const char * const mem_lvl[] = {
 	"I/O",
 	"Uncached",
 };
+
+static const char * const mem_xlvl[] = {
+	"Remote RAM (3 hops)",
+	"Remote Cache (3 hops)",
+};
+
 #define NUM_MEM_LVL (sizeof(mem_lvl)/sizeof(const char *))
+#define NUM_MEM_XLVL (sizeof(mem_xlvl)/sizeof(const char *))
 
 static int hist_entry__lvl_snprintf(struct hist_entry *self, char *bf,
 				    size_t size, unsigned int width)
@@ -695,6 +708,22 @@ static int hist_entry__lvl_snprintf(struct hist_entry *self, char *bf,
 		strncat(out, mem_lvl[i], sz - l);
 		l += strlen(mem_lvl[i]);
 	}
+
+	m = 0;
+	if (self->mem_info)
+		m = self->mem_info->data_src.mem_xlvl;
+
+	for (i = 0; m && i < NUM_MEM_XLVL; i++, m >>= 1) {
+		if (!(m & 0x1))
+			continue;
+		if (l) {
+			strcat(out, " or ");
+			l += 4;
+		}
+		strncat(out, mem_xlvl[i], sz - l);
+		l += strlen(mem_xlvl[i]);
+	}
+
 	if (*out == '\0')
 		strcpy(out, "N/A");
 	if (hit)
-- 
1.7.1

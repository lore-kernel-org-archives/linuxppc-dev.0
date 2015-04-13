Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C7AF1A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 17:52:54 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 13:22:51 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C9A22125805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 13:24:39 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3D7qkMM58589324
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 13:22:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3D7qjTJ016889
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 13:22:45 +0530
Message-ID: <1428911317.19714.5.camel@TP420>
Subject: [PATCH v3 powerpc] perf/hv-24x7  fail 24x7 initcall if
 create_events_from_catalog() fails
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 13 Apr 2015 15:48:37 +0800
In-Reply-To: <1428663358.21137.4.camel@ellerman.id.au>
References: <1423993377.2932.23.camel@TP420>
 <20150325095120.8F48F1400EA@ozlabs.org> <20150325184153.GA6579@us.ibm.com>
 <1427341876.16501.2.camel@ellerman.id.au> <1428655351.16563.11.camel@TP420>
 <1428663358.21137.4.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Michael pointed out, create_events_from_catalog() fails when 
we either have:
 - a kernel bug
 - some sort of hypervisor misconfiguration
 - ENOMEM

In all the above cases, we can also fail 24x7 initcall. 

For hypervisor errors, EIO is used so there is something reported 
in dmesg.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9445a82..ead1420 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -637,7 +637,7 @@ static ssize_t catalog_event_len_validate(struct hv_24x7_event_data *event,
 
 #define MAX_4K (SIZE_MAX / 4096)
 
-static void create_events_from_catalog(struct attribute ***events_,
+static int create_events_from_catalog(struct attribute ***events_,
 		struct attribute ***event_descs_,
 		struct attribute ***event_long_descs_)
 {
@@ -655,19 +655,25 @@ static void create_events_from_catalog(struct attribute ***events_,
 	void *event_data, *end;
 	struct hv_24x7_event_data *event;
 	struct rb_root ev_uniq = RB_ROOT;
+	int ret = 0;
 
-	if (!page)
+	if (!page) {
+		ret = -ENOMEM;
 		goto e_out;
+	}
 
 	hret = h_get_24x7_catalog_page(page, 0, 0);
-	if (hret)
+	if (hret) {
+		ret = -EIO;
 		goto e_free;
+	}
 
 	catalog_version_num = be64_to_cpu(page_0->version);
 	catalog_page_len = be32_to_cpu(page_0->length);
 
 	if (MAX_4K < catalog_page_len) {
 		pr_err("invalid page count: %zu\n", catalog_page_len);
+		ret = -EIO;
 		goto e_free;
 	}
 
@@ -686,6 +692,7 @@ static void create_events_from_catalog(struct attribute ***events_,
 			|| (MAX_4K - event_data_offs < event_data_len)) {
 		pr_err("invalid event data offs %zu and/or len %zu\n",
 				event_data_offs, event_data_len);
+		ret = -EIO;
 		goto e_free;
 	}
 
@@ -694,12 +701,14 @@ static void create_events_from_catalog(struct attribute ***events_,
 				event_data_offs,
 				event_data_offs + event_data_len,
 				catalog_page_len);
+		ret = -EIO;
 		goto e_free;
 	}
 
 	if (SIZE_MAX / MAX_EVENTS_PER_EVENT_DATA - 1 < event_entry_count) {
 		pr_err("event_entry_count %zu is invalid\n",
 				event_entry_count);
+		ret = -EIO;
 		goto e_free;
 	}
 
@@ -712,6 +721,7 @@ static void create_events_from_catalog(struct attribute ***events_,
 	event_data = vmalloc(event_data_bytes);
 	if (!event_data) {
 		pr_err("could not allocate event data\n");
+		ret = -ENOMEM;
 		goto e_free;
 	}
 
@@ -731,6 +741,7 @@ static void create_events_from_catalog(struct attribute ***events_,
 		if (hret) {
 			pr_err("failed to get event data in page %zu\n",
 					i + event_data_offs);
+			ret = -EIO;
 			goto e_event_data;
 		}
 	}
@@ -778,18 +789,24 @@ static void create_events_from_catalog(struct attribute ***events_,
 				event_idx_last, event_entry_count, junk_events);
 
 	events = kmalloc_array(attr_max + 1, sizeof(*events), GFP_KERNEL);
-	if (!events)
+	if (!events) {
+		ret = -ENOMEM;
 		goto e_event_data;
+	}
 
 	event_descs = kmalloc_array(event_idx + 1, sizeof(*event_descs),
 				GFP_KERNEL);
-	if (!event_descs)
+	if (!event_descs) {
+		ret = -ENOMEM;
 		goto e_event_attrs;
+	}
 
 	event_long_descs = kmalloc_array(event_idx + 1,
 			sizeof(*event_long_descs), GFP_KERNEL);
-	if (!event_long_descs)
+	if (!event_long_descs) {
+		ret = -ENOMEM;
 		goto e_event_descs;
+	}
 
 	/* Iterate over the catalog filling in the attribute vector */
 	for (junk_events = 0, event_attr_ct = 0, desc_ct = 0, long_desc_ct = 0,
@@ -843,7 +860,7 @@ static void create_events_from_catalog(struct attribute ***events_,
 	*events_ = events;
 	*event_descs_ = event_descs;
 	*event_long_descs_ = event_long_descs;
-	return;
+	return 0;
 
 e_event_descs:
 	kfree(event_descs);
@@ -857,6 +874,7 @@ e_out:
 	*events_ = NULL;
 	*event_descs_ = NULL;
 	*event_long_descs_ = NULL;
+	return ret;
 }
 
 static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
@@ -1219,10 +1237,13 @@ static int hv_24x7_init(void)
 	/* sampling not supported */
 	h_24x7_pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 
-	create_events_from_catalog(&event_group.attrs,
+	r = create_events_from_catalog(&event_group.attrs,
 				   &event_desc_group.attrs,
 				   &event_long_desc_group.attrs);
 
+	if (r)
+		return r;
+
 	r = perf_pmu_register(&h_24x7_pmu, h_24x7_pmu.name, -1);
 	if (r)
 		return r;

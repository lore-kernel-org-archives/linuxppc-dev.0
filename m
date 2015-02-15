Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D82571A0739
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 20:43:20 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Sun, 15 Feb 2015 09:43:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 977581B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 09:43:26 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1F9hFO67537014
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 09:43:15 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1F4cmb2023342
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Feb 2015 23:38:48 -0500
Message-ID: <1423993377.2932.23.camel@TP420>
Subject: [RFC PATCH powerpc] perf/hv-24x7 set the attr group to NULL if
 events failed to be initialized
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 15 Feb 2015 17:42:57 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sysfs_create_groups() creates groups one by one in the attr_groups array
before a NULL entry is encountered. But if an error is seen, it stops
and removes all the groups already created:
        for (i = 0; groups[i]; i++) {
                error = sysfs_create_group(kobj, groups[i]);
                if (error) {
                        while (--i >= 0)
                                sysfs_remove_group(kobj, groups[i]);
                        break;
                }
        }

And for the three event groups of 24x7, if it is not supported,
according to the above logic, it causes format and interface group to be
removed because of the error.

This patch moves the three events groups to the end of the attr groups,
and if create_events_from_catalog() fails to set their attributes, we
set them to NULL in attr_groups.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9445a82..1e433f7 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -637,7 +637,7 @@ static ssize_t catalog_event_len_validate(struct hv_24x7_event_data *event,
 
 #define MAX_4K (SIZE_MAX / 4096)
 
-static void create_events_from_catalog(struct attribute ***events_,
+static int create_events_from_catalog(struct attribute ***events_,
 		struct attribute ***event_descs_,
 		struct attribute ***event_long_descs_)
 {
@@ -843,7 +843,7 @@ static void create_events_from_catalog(struct attribute ***events_,
 	*events_ = events;
 	*event_descs_ = event_descs;
 	*event_long_descs_ = event_long_descs;
-	return;
+	return 0;
 
 e_event_descs:
 	kfree(event_descs);
@@ -857,6 +857,7 @@ e_out:
 	*events_ = NULL;
 	*event_descs_ = NULL;
 	*event_long_descs_ = NULL;
+	return -1;
 }
 
 static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
@@ -967,13 +968,25 @@ static struct attribute_group if_group = {
 	.attrs = if_attrs,
 };
 
+enum GROUP_INDEX {
+	FORMAT,
+	IF,
+	EVENT,
+	EVENT_DESC,
+	EVENT_LONG_DESC,
+	MAX
+};
+
+/*
+ * keep the attr group whose attr is set in init (may fail)
+ * at the end
+ */
 static const struct attribute_group *attr_groups[] = {
-	&format_group,
-	&event_group,
-	&event_desc_group,
-	&event_long_desc_group,
-	&if_group,
-	NULL,
+	[FORMAT] = &format_group,
+	[IF] = &if_group,
+	[EVENT] = &event_group,
+	[EVENT_DESC] = &event_desc_group,
+	[EVENT_LONG_DESC] = &event_long_desc_group
 };
 
 DEFINE_PER_CPU(char, hv_24x7_reqb[4096]) __aligned(4096);
@@ -1219,10 +1232,16 @@ static int hv_24x7_init(void)
 	/* sampling not supported */
 	h_24x7_pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 
-	create_events_from_catalog(&event_group.attrs,
+	r = create_events_from_catalog(&event_group.attrs,
 				   &event_desc_group.attrs,
 				   &event_long_desc_group.attrs);
 
+	if (r) {
+		h_24x7_pmu.attr_groups[EVENT] =
+		h_24x7_pmu.attr_groups[EVENT_DESC] =
+		h_24x7_pmu.attr_groups[EVENT_LONG_DESC] = 0;
+	}
+
 	r = perf_pmu_register(&h_24x7_pmu, h_24x7_pmu.name, -1);
 	if (r)
 		return r;

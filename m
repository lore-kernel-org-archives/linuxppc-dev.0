Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzD4q0X6wzDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 07:56:10 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TLs0ME096412
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:56:08 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd8cwk5nu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:56:08 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 18:56:05 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TLu3Ab4587786
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:56:04 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TLu4hK030274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:56:04 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v3 5/8] powerpc/perf/hv-24x7: Fix return value of hcalls
Date: Thu, 29 Jun 2017 18:55:35 -0300
In-Reply-To: <20170629215538.1645-1-bauerman@linux.vnet.ibm.com>
References: <20170629215538.1645-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20170629215538.1645-6-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The H_GET_24X7_CATALOG_PAGE hcall can return a signed error code, so fix
this in the code.

The H_GET_24X7_DATA hcall can return a signed error code, so fix this in
the code. Also, don't truncate it to 32 bit to use as return value for
make_24x7_request. In case of error h_24x7_event_commit_txn passes that
return value to generic code, so it should be a proper errno. The other
caller of make_24x7_request is single_24x7_request, whose callers don't
actually care which error code is returned so they are not affected by this
change.

Finally, h_24x7_get_value doesn't use the error code from
single_24x7_request, so there's no need to store it.

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 111c61ea7416..7e47dcdea62a 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -264,9 +264,8 @@ static void *event_end(struct hv_24x7_event_data *ev, void *end)
 	return start + nl + dl + ldl;
 }
 
-static unsigned long h_get_24x7_catalog_page_(unsigned long phys_4096,
-					      unsigned long version,
-					      unsigned long index)
+static long h_get_24x7_catalog_page_(unsigned long phys_4096,
+				     unsigned long version, unsigned long index)
 {
 	pr_devel("h_get_24x7_catalog_page(0x%lx, %lu, %lu)",
 			phys_4096, version, index);
@@ -277,8 +276,7 @@ static unsigned long h_get_24x7_catalog_page_(unsigned long phys_4096,
 			phys_4096, version, index);
 }
 
-static unsigned long h_get_24x7_catalog_page(char page[],
-					     u64 version, u32 index)
+static long h_get_24x7_catalog_page(char page[], u64 version, u32 index)
 {
 	return h_get_24x7_catalog_page_(virt_to_phys(page),
 					version, index);
@@ -668,7 +666,7 @@ static int create_events_from_catalog(struct attribute ***events_,
 				      struct attribute ***event_descs_,
 				      struct attribute ***event_long_descs_)
 {
-	unsigned long hret;
+	long hret;
 	size_t catalog_len, catalog_page_len, event_entry_count,
 	       event_data_len, event_data_offs,
 	       event_data_bytes, junk_events, event_idx, event_attr_ct, i,
@@ -907,7 +905,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 			    struct bin_attribute *bin_attr, char *buf,
 			    loff_t offset, size_t count)
 {
-	unsigned long hret;
+	long hret;
 	ssize_t ret = 0;
 	size_t catalog_len = 0, catalog_page_len = 0;
 	loff_t page_offset = 0;
@@ -992,7 +990,7 @@ static ssize_t _name##_show(struct device *dev,			\
 			    struct device_attribute *dev_attr,	\
 			    char *buf)				\
 {								\
-	unsigned long hret;					\
+	long hret;						\
 	ssize_t ret = 0;					\
 	void *page = kmem_cache_alloc(hv_page_cache, GFP_USER);	\
 	struct hv_24x7_catalog_page_0 *page_0 = page;		\
@@ -1065,7 +1063,7 @@ static void init_24x7_request(struct hv_24x7_request_buffer *request_buffer,
 static int make_24x7_request(struct hv_24x7_request_buffer *request_buffer,
 			     struct hv_24x7_data_result_buffer *result_buffer)
 {
-	unsigned long ret;
+	long ret;
 
 	/*
 	 * NOTE: Due to variable number of array elements in request and
@@ -1085,9 +1083,10 @@ static int make_24x7_request(struct hv_24x7_request_buffer *request_buffer,
 				      req->starting_ix, req->starting_lpar_ix,
 				      ret, ret, result_buffer->detailed_rc,
 				      result_buffer->failing_request_ix);
+		return -EIO;
 	}
 
-	return ret;
+	return 0;
 }
 
 /*
@@ -1135,10 +1134,10 @@ static int add_event_to_24x7_request(struct perf_event *event,
 	return 0;
 }
 
-static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
+static int single_24x7_request(struct perf_event *event, u64 *count)
 {
+	int ret;
 	u16 num_elements;
-	unsigned long ret;
 	struct hv_24x7_result *result;
 	struct hv_24x7_request_buffer *request_buffer;
 	struct hv_24x7_data_result_buffer *result_buffer;
@@ -1253,10 +1252,9 @@ static int h_24x7_event_init(struct perf_event *event)
 
 static u64 h_24x7_get_value(struct perf_event *event)
 {
-	unsigned long ret;
 	u64 ct;
-	ret = single_24x7_request(event, &ct);
-	if (ret)
+
+	if (single_24x7_request(event, &ct))
 		/* We checked this in event init, shouldn't fail here... */
 		return 0;
 
-- 
2.13.0

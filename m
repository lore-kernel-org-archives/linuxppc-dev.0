Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDE811A0739
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:57 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:55 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 37BA73E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:52 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1sdVB35192962
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:54:39 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1spIn003183
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:52 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 08/10] perf/hv24x7: Whitespace cleanup
Date: Mon, 30 Mar 2015 18:53:45 -0700
Message-Id: <1427766828-771-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix minor whitespace damages.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index fe74221..676fb2f9 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -161,6 +161,7 @@ static char *event_desc(struct hv_24x7_event_data *ev, int *len)
 {
 	unsigned nl = be16_to_cpu(ev->event_name_len);
 	__be16 *desc_len = (__be16 *)(ev->remainder + nl - 2);
+
 	*len = be16_to_cpu(*desc_len) - 2;
 	return (char *)ev->remainder + nl;
 }
@@ -171,6 +172,7 @@ static char *event_long_desc(struct hv_24x7_event_data *ev, int *len)
 	__be16 *desc_len_ = (__be16 *)(ev->remainder + nl - 2);
 	unsigned desc_len = be16_to_cpu(*desc_len_);
 	__be16 *long_desc_len = (__be16 *)(ev->remainder + nl + desc_len - 2);
+
 	*len = be16_to_cpu(*long_desc_len) - 2;
 	return (char *)ev->remainder + nl + desc_len;
 }
@@ -248,14 +250,12 @@ static unsigned long h_get_24x7_catalog_page_(unsigned long phys_4096,
 					      unsigned long index)
 {
 	pr_devel("h_get_24x7_catalog_page(0x%lx, %lu, %lu)",
-			phys_4096,
-			version,
-			index);
+			phys_4096, version, index);
+
 	WARN_ON(!IS_ALIGNED(phys_4096, 4096));
+
 	return plpar_hcall_norets(H_GET_24X7_CATALOG_PAGE,
-			phys_4096,
-			version,
-			index);
+			phys_4096, version, index);
 }
 
 static unsigned long h_get_24x7_catalog_page(char page[],
@@ -309,6 +309,7 @@ static ssize_t device_show_string(struct device *dev,
 	struct dev_ext_attribute *d;
 
 	d = container_of(attr, struct dev_ext_attribute, attr);
+
 	return sprintf(buf, "%s\n", (char *)d->var);
 }
 
@@ -323,6 +324,7 @@ static struct attribute *device_str_attr_create_(char *name, char *str)
 	attr->attr.attr.name = name;
 	attr->attr.attr.mode = 0444;
 	attr->attr.show = device_show_string;
+
 	return &attr->attr.attr;
 }
 
@@ -396,7 +398,6 @@ static struct attribute *event_to_attr(unsigned ix,
 		a_ev_name = kasprintf(GFP_KERNEL, "%.*s%s__%d",
 				(int)event_name_len, ev_name, ev_suffix, nonce);
 
-
 	if (!a_ev_name)
 		goto out_val;
 
@@ -881,6 +882,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 	uint64_t catalog_version_num = 0;
 	void *page = kmem_cache_alloc(hv_page_cache, GFP_USER);
 	struct hv_24x7_catalog_page_0 *page_0 = page;
+
 	if (!page)
 		return -ENOMEM;
 
@@ -1077,7 +1079,6 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
 	}
 
 	resb = &result_buffer->results[0];
-
 	*count = be64_to_cpu(resb->elements[0].element_data[0]);
 out:
 	return ret;
@@ -1175,6 +1176,7 @@ static void h_24x7_event_read(struct perf_event *event)
 {
 	s64 prev;
 	u64 now;
+
 	now = h_24x7_get_value(event);
 	prev = local64_xchg(&event->hw.prev_count, now);
 	local64_add(now - prev, &event->count);
-- 
1.8.3.1

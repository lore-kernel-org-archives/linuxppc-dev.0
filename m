Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BDA31A1759
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 16:03:56 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 02:03:54 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5F24538C8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 02:03:51 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9163pcc655660
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 06:03:51 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9163mbU007180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 02:03:50 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/5] Simplify catalog_read()
Date: Tue, 30 Sep 2014 23:03:18 -0700
Message-Id: <1412143402-26061-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1412143402-26061-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1412143402-26061-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 dev@codyps.com, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

catalog_read() implements the read interface for the sysfs file

	/sys/bus/event_source/devices/hv_24x7/interface/catalog

It essentially takes a buffer, an offset and count as parameters
to the read() call.  It makes a hypervisor call to read a specific
page from the catalog and copy the required bytes into the given
buffer. Each call to catalog_read() returns at most one 4K page.

Given these requirements, we should be able to simplify the
catalog_read().

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v3]
	[Michael Ellerman] offset_in_page must be based on offsetr;
	page_count is unnecessary.

 arch/powerpc/perf/hv-24x7.c | 101 ++++++--------------------------------------
 1 file changed, 14 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 697759d..6c8710d 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -75,86 +75,6 @@ static struct attribute_group format_group = {
 
 static struct kmem_cache *hv_page_cache;
 
-/*
- * read_offset_data - copy data from one buffer to another while treating the
- *                    source buffer as a small view on the total avaliable
- *                    source data.
- *
- * @dest: buffer to copy into
- * @dest_len: length of @dest in bytes
- * @requested_offset: the offset within the source data we want. Must be > 0
- * @src: buffer to copy data from
- * @src_len: length of @src in bytes
- * @source_offset: the offset in the sorce data that (src,src_len) refers to.
- *                 Must be > 0
- *
- * returns the number of bytes copied.
- *
- * The following ascii art shows the various buffer possitioning we need to
- * handle, assigns some arbitrary varibles to points on the buffer, and then
- * shows how we fiddle with those values to get things we care about (copy
- * start in src and copy len)
- *
- * s = @src buffer
- * d = @dest buffer
- * '.' areas in d are written to.
- *
- *                       u
- *   x         w	 v  z
- * d           |.........|
- * s |----------------------|
- *
- *                      u
- *   x         w	z     v
- * d           |........------|
- * s |------------------|
- *
- *   x         w        u,z,v
- * d           |........|
- * s |------------------|
- *
- *   x,w                u,v,z
- * d |..................|
- * s |------------------|
- *
- *   x        u
- *   w        v		z
- * d |........|
- * s |------------------|
- *
- *   x      z   w      v
- * d            |------|
- * s |------|
- *
- * x = source_offset
- * w = requested_offset
- * z = source_offset + src_len
- * v = requested_offset + dest_len
- *
- * w_offset_in_s = w - x = requested_offset - source_offset
- * z_offset_in_s = z - x = src_len
- * v_offset_in_s = v - x = request_offset + dest_len - src_len
- */
-static ssize_t read_offset_data(void *dest, size_t dest_len,
-				loff_t requested_offset, void *src,
-				size_t src_len, loff_t source_offset)
-{
-	size_t w_offset_in_s = requested_offset - source_offset;
-	size_t z_offset_in_s = src_len;
-	size_t v_offset_in_s = requested_offset + dest_len - src_len;
-	size_t u_offset_in_s = min(z_offset_in_s, v_offset_in_s);
-	size_t copy_len = u_offset_in_s - w_offset_in_s;
-
-	if (requested_offset < 0 || source_offset < 0)
-		return -EINVAL;
-
-	if (z_offset_in_s <= w_offset_in_s)
-		return 0;
-
-	memcpy(dest, src + w_offset_in_s, copy_len);
-	return copy_len;
-}
-
 static unsigned long h_get_24x7_catalog_page_(unsigned long phys_4096,
 					      unsigned long version,
 					      unsigned long index)
@@ -183,8 +103,10 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 {
 	unsigned long hret;
 	ssize_t ret = 0;
-	size_t catalog_len = 0, catalog_page_len = 0, page_count = 0;
+	size_t catalog_len = 0, catalog_page_len = 0;
 	loff_t page_offset = 0;
+	loff_t offset_in_page;
+	size_t copy_len;
 	uint64_t catalog_version_num = 0;
 	void *page = kmem_cache_alloc(hv_page_cache, GFP_USER);
 	struct hv_24x7_catalog_page_0 *page_0 = page;
@@ -202,7 +124,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 	catalog_len = catalog_page_len * 4096;
 
 	page_offset = offset / 4096;
-	page_count  = count  / 4096;
+	offset_in_page = offset % 4096;
 
 	if (page_offset >= catalog_page_len)
 		goto e_free;
@@ -216,8 +138,13 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 		}
 	}
 
-	ret = read_offset_data(buf, count, offset,
-				page, 4096, page_offset * 4096);
+	copy_len = 4096 - offset_in_page;
+	if (copy_len > count)
+		copy_len = count;
+
+	memcpy(buf, page+offset_in_page, copy_len);
+	ret = copy_len;
+
 e_free:
 	if (hret)
 		pr_err("h_get_24x7_catalog_page(ver=%lld, page=%lld) failed:"
@@ -225,9 +152,9 @@ e_free:
 		       catalog_version_num, page_offset, hret);
 	kmem_cache_free(hv_page_cache, page);
 
-	pr_devel("catalog_read: offset=%lld(%lld) count=%zu(%zu) catalog_len=%zu(%zu) => %zd\n",
-			offset, page_offset, count, page_count, catalog_len,
-			catalog_page_len, ret);
+	pr_devel("catalog_read: offset=%lld(%lld) count=%zu "
+			"catalog_len=%zu(%zu) => %zd\n", offset, page_offset,
+			count, catalog_len, catalog_page_len, ret);
 
 	return ret;
 }
-- 
1.8.3.1

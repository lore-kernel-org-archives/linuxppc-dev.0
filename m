Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09DAC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 18:02:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48D72146D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 18:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48D72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4362L260f9zDr8r
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 05:02:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4362Gl3rSNzDrFF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 04:59:59 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4937F8E664;
 Fri, 30 Nov 2018 17:59:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-126-156.rdu2.redhat.com [10.10.126.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 734C55D9C9;
 Fri, 30 Nov 2018 17:59:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH RFCv2 1/4] mm/memory_hotplug: Introduce memory block types
Date: Fri, 30 Nov 2018 18:59:19 +0100
Message-Id: <20181130175922.10425-2-david@redhat.com>
In-Reply-To: <20181130175922.10425-1-david@redhat.com>
References: <20181130175922.10425-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 30 Nov 2018 17:59:57 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Oscar Salvador <osalvador@suse.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, x86@kernel.org,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andrew Banman <andrew.banman@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Memory onlining should always be handled by user space, because only user
space knows which use cases it wants to satisfy. E.g. memory might be
onlined to the MOVABLE zone even if it can never be removed from the
system, e.g. to make usage of huge pages more reliable.

However to implement such rules (especially default rules in distributions)
we need more information about the memory that was added in user space.

E.g. on x86 we want to online memory provided by balloon devices (e.g.
XEN, Hyper-V) differently (-> will not be unplugged by offlining the whole
block) than ordinary DIMMs (-> might eventually be unplugged by offlining
the whole block). This might also become relevat for other architectures.

Also, udev rules right now check if running on s390x and treat all added
memory blocks as standby memory (-> don't online automatically). As soon as
we support other memory hotplug mechanism (e.g. virtio-mem) checks would
have to get more involved (e.g. also check if under KVM) but eventually
also wrong (e.g. if KVM ever supports standby memory we are doomed).

I decided to allow to specify the type of memory that is getting added
to the system. Let's start with two types, BOOT and UNSPECIFIED to get the
basic infrastructure running. We'll introduce and use further types in
follow-up patches. For now we classify any hotplugged memory temporarily
as as UNSPECIFIED (which will eventually be dropped later on).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Banman <andrew.banman@hpe.com>
Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Suchánek <msuchanek@suse.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/memory.h | 27 +++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 0c290f86ab20..17f2985c07c5 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -381,6 +381,29 @@ static ssize_t show_phys_device(struct device *dev,
 	return sprintf(buf, "%d\n", mem->phys_device);
 }
 
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct memory_block *mem = to_memory_block(dev);
+	ssize_t len = 0;
+
+	switch (mem->type) {
+	case MEMORY_BLOCK_UNSPECIFIED:
+		len = sprintf(buf, "unspecified\n");
+		break;
+	case MEMORY_BLOCK_BOOT:
+		len = sprintf(buf, "boot\n");
+		break;
+	default:
+		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
+				mem->state);
+		WARN_ON(1);
+		break;
+	}
+
+	return len;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static void print_allowed_zone(char *buf, int nid, unsigned long start_pfn,
 		unsigned long nr_pages, int online_type,
@@ -442,6 +465,7 @@ static DEVICE_ATTR(phys_index, 0444, show_mem_start_phys_index, NULL);
 static DEVICE_ATTR(state, 0644, show_mem_state, store_mem_state);
 static DEVICE_ATTR(phys_device, 0444, show_phys_device, NULL);
 static DEVICE_ATTR(removable, 0444, show_mem_removable, NULL);
+static DEVICE_ATTR_RO(type);
 
 /*
  * Block size attribute stuff
@@ -620,6 +644,7 @@ static struct attribute *memory_memblk_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_phys_device.attr,
 	&dev_attr_removable.attr,
+	&dev_attr_type.attr,
 #ifdef CONFIG_MEMORY_HOTREMOVE
 	&dev_attr_valid_zones.attr,
 #endif
@@ -657,13 +682,17 @@ int register_memory(struct memory_block *memory)
 }
 
 static int init_memory_block(struct memory_block **memory,
-			     struct mem_section *section, unsigned long state)
+			     struct mem_section *section, unsigned long state,
+			     int type)
 {
 	struct memory_block *mem;
 	unsigned long start_pfn;
 	int scn_nr;
 	int ret = 0;
 
+	if (type == MEMORY_BLOCK_NONE)
+		return -EINVAL;
+
 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
@@ -675,6 +704,7 @@ static int init_memory_block(struct memory_block **memory,
 	mem->state = state;
 	start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
+	mem->type = type;
 
 	ret = register_memory(mem);
 
@@ -699,7 +729,8 @@ static int add_memory_block(int base_section_nr)
 
 	if (section_count == 0)
 		return 0;
-	ret = init_memory_block(&mem, __nr_to_section(section_nr), MEM_ONLINE);
+	ret = init_memory_block(&mem, __nr_to_section(section_nr), MEM_ONLINE,
+				MEMORY_BLOCK_BOOT);
 	if (ret)
 		return ret;
 	mem->section_count = section_count;
@@ -722,7 +753,8 @@ int hotplug_memory_register(int nid, struct mem_section *section)
 		mem->section_count++;
 		put_device(&mem->dev);
 	} else {
-		ret = init_memory_block(&mem, section, MEM_OFFLINE);
+		ret = init_memory_block(&mem, section, MEM_OFFLINE,
+					MEMORY_BLOCK_UNSPECIFIED);
 		if (ret)
 			goto out;
 		mem->section_count++;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index d75ec88ca09d..06268e96e0da 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -34,12 +34,39 @@ struct memory_block {
 	int (*phys_callback)(struct memory_block *);
 	struct device dev;
 	int nid;			/* NID for this memory block */
+	int type;			/* type of this memory block */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
 int set_memory_block_size_order(unsigned int order);
 
+/*
+ * Memory block types allow user space to formulate rules if and how to
+ * online memory blocks. The types are exposed to user space as text
+ * strings in sysfs.
+ *
+ * MEMORY_BLOCK_NONE:
+ *  No memory block is to be created (e.g. device memory). Not exposed to
+ *  user space.
+ *
+ * MEMORY_BLOCK_UNSPECIFIED:
+ *  The type of memory block was not further specified when adding the
+ *  memory block.
+ *
+ * MEMORY_BLOCK_BOOT:
+ *  This memory block was added during boot by the basic system. No
+ *  specific device driver takes care of this memory block. This memory
+ *  block type is onlined automatically by the kernel during boot and might
+ *  later be managed by a different device driver, in which case the type
+ *  might change.
+ */
+enum {
+	MEMORY_BLOCK_NONE = 0,
+	MEMORY_BLOCK_UNSPECIFIED,
+	MEMORY_BLOCK_BOOT,
+};
+
 /* These states are exposed to userspace as text strings in sysfs */
 #define	MEM_ONLINE		(1<<0) /* exposed to userspace */
 #define	MEM_GOING_OFFLINE	(1<<1) /* exposed to userspace */
-- 
2.17.2


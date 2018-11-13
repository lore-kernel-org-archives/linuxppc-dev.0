Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7531FC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 06:02:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62BA206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 06:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXfAn86H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62BA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vH976Q5pzF361
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 17:02:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OXfAn86H";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="OXfAn86H"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vGwf74kCzF3Kv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 16:52:02 +1100 (AEDT)
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E35C72250E;
 Tue, 13 Nov 2018 05:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542088320;
 bh=G0rtieCTs+2MB/XSLV2mduzEoQTupZgtep6myjSfa0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OXfAn86HBfj3VKrU0ll77idA0aAxgxTFj2E2HkaLj7LbflYd/ZtWexyTf44BfPl6h
 N5/J4IfN8H9di06pzacoWLOT1GCk0z0UKroT78xFGVpI90hRcdkaJpOsLrQfYp2Ybu
 QXJ3k0cGMokjZDunfEb73PqpgcljO2qWeamAxnGM=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/26] mm/memory_hotplug: make add_memory() take
 the device_hotplug_lock
Date: Tue, 13 Nov 2018 00:51:32 -0500
Message-Id: <20181113055150.78773-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Sasha Levin <sashal@kernel.org>,
 Michael Neuling <mikey@neuling.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-acpi@vger.kernel.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, linuxppc-dev@lists.ozlabs.org,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Juergen Gross <jgross@suse.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 John Allen <jallen@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 8df1d0e4a265f25dc1e7e7624ccdbcb4a6630c89 ]

add_memory() currently does not take the device_hotplug_lock, however
is aleady called under the lock from
	arch/powerpc/platforms/pseries/hotplug-memory.c
	drivers/acpi/acpi_memhotplug.c
to synchronize against CPU hot-remove and similar.

In general, we should hold the device_hotplug_lock when adding memory to
synchronize against online/offline request (e.g.  from user space) - which
already resulted in lock inversions due to device_lock() and
mem_hotplug_lock - see 30467e0b3be ("mm, hotplug: fix concurrent memory
hot-add deadlock").  add_memory()/add_memory_resource() will create memory
block devices, so this really feels like the right thing to do.

Holding the device_hotplug_lock makes sure that a memory block device
can really only be accessed (e.g. via .online/.state) from user space,
once the memory has been fully added to the system.

The lock is not held yet in
	drivers/xen/balloon.c
	arch/powerpc/platforms/powernv/memtrace.c
	drivers/s390/char/sclp_cmd.c
	drivers/hv/hv_balloon.c
So, let's either use the locked variants or take the lock.

Don't export add_memory_resource(), as it once was exported to be used by
XEN, which is never built as a module.  If somebody requires it, we also
have to export a locked variant (as device_hotplug_lock is never
exported).

Link: http://lkml.kernel.org/r/20180925091457.28651-3-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platforms/pseries/hotplug-memory.c        |  2 +-
 drivers/acpi/acpi_memhotplug.c                |  2 +-
 drivers/base/memory.c                         |  9 ++++++--
 drivers/xen/balloon.c                         |  3 +++
 include/linux/memory_hotplug.h                |  1 +
 mm/memory_hotplug.c                           | 22 ++++++++++++++++---
 6 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 1d48ab424bd9..c197ea8dde01 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -784,7 +784,7 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 	nid = memory_add_physaddr_to_nid(lmb->base_addr);
 
 	/* Add the memory */
-	rc = add_memory(nid, lmb->base_addr, block_sz);
+	rc = __add_memory(nid, lmb->base_addr, block_sz);
 	if (rc) {
 		dlpar_remove_device_tree_lmb(lmb);
 		return rc;
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 6b0d3ef7309c..2ccfbb61ca89 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -228,7 +228,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		if (node < 0)
 			node = memory_add_physaddr_to_nid(info->start_addr);
 
-		result = add_memory(node, info->start_addr, info->length);
+		result = __add_memory(node, info->start_addr, info->length);
 
 		/*
 		 * If the memory block has been used by the kernel, add_memory()
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 1d60b58a8c19..9a9aebb4bd19 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -517,15 +517,20 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
 		return -EINVAL;
 
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		goto out;
+
 	nid = memory_add_physaddr_to_nid(phys_addr);
-	ret = add_memory(nid, phys_addr,
-			 MIN_MEMORY_BLOCK_SIZE * sections_per_block);
+	ret = __add_memory(nid, phys_addr,
+			   MIN_MEMORY_BLOCK_SIZE * sections_per_block);
 
 	if (ret)
 		goto out;
 
 	ret = count;
 out:
+	unlock_device_hotplug();
 	return ret;
 }
 
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 065f0b607373..6e39a0c10f93 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -401,7 +401,10 @@ static enum bp_state reserve_additional_memory(void)
 	 * callers drop the mutex before trying again.
 	 */
 	mutex_unlock(&balloon_mutex);
+	/* add_memory_resource() requires the device_hotplug lock */
+	lock_device_hotplug();
 	rc = add_memory_resource(nid, resource, memhp_auto_online);
+	unlock_device_hotplug();
 	mutex_lock(&balloon_mutex);
 
 	if (rc) {
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 58e110aee7ab..d36a02935391 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -316,6 +316,7 @@ static inline void remove_memory(int nid, u64 start, u64 size) {}
 
 extern int walk_memory_range(unsigned long start_pfn, unsigned long end_pfn,
 		void *arg, int (*func)(struct memory_block *, void *));
+extern int __add_memory(int nid, u64 start, u64 size);
 extern int add_memory(int nid, u64 start, u64 size);
 extern int add_memory_resource(int nid, struct resource *resource, bool online);
 extern int arch_add_memory(int nid, u64 start, u64 size, bool want_memblock);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d4b5f29906b9..dc60f2f27389 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1109,7 +1109,12 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 	return device_online(&mem->dev);
 }
 
-/* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
+/*
+ * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
+ * and online/offline operations (triggered e.g. by sysfs).
+ *
+ * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
+ */
 int __ref add_memory_resource(int nid, struct resource *res, bool online)
 {
 	u64 start, size;
@@ -1202,9 +1207,9 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	mem_hotplug_done();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(add_memory_resource);
 
-int __ref add_memory(int nid, u64 start, u64 size)
+/* requires device_hotplug_lock, see add_memory_resource() */
+int __ref __add_memory(int nid, u64 start, u64 size)
 {
 	struct resource *res;
 	int ret;
@@ -1218,6 +1223,17 @@ int __ref add_memory(int nid, u64 start, u64 size)
 		release_memory_resource(res);
 	return ret;
 }
+
+int add_memory(int nid, u64 start, u64 size)
+{
+	int rc;
+
+	lock_device_hotplug();
+	rc = __add_memory(nid, start, size);
+	unlock_device_hotplug();
+
+	return rc;
+}
 EXPORT_SYMBOL_GPL(add_memory);
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-- 
2.17.1


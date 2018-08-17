Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sFw35hjyzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 17:59:15 +1000 (AEST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, devel@linuxdriverproject.org,
 linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Rientjes <rientjes@google.com>
Subject: [PATCH RFC 1/2] drivers/base: export
 lock_device_hotplug/unlock_device_hotplug
Date: Fri, 17 Aug 2018 09:59:00 +0200
Message-Id: <20180817075901.4608-2-david@redhat.com>
In-Reply-To: <20180817075901.4608-1-david@redhat.com>
References: <20180817075901.4608-1-david@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Well require to call add_memory()/add_memory_resource() with
device_hotplug_lock held, to avoid a lock inversion. Allow external modules
(e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
lock device hotplug.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
[modify patch description]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..9010b9e942b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -700,11 +700,13 @@ void lock_device_hotplug(void)
 {
 	mutex_lock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lock_device_hotplug);
 
 void unlock_device_hotplug(void)
 {
 	mutex_unlock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(unlock_device_hotplug);
 
 int lock_device_hotplug_sysfs(void)
 {
-- 
2.17.1

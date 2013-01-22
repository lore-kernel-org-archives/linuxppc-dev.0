Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id E8DC92C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 22:44:03 +1100 (EST)
From: Tang Chen <tangchen@cn.fujitsu.com>
To: akpm@linux-foundation.org, rientjes@google.com, len.brown@intel.com,
 benh@kernel.crashing.org, paulus@samba.org, cl@linux.com,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com,
 wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com,
 laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org,
 glommer@parallels.com, jiang.liu@huawei.com, julian.calaby@gmail.com,
 sfr@canb.auug.org.au
Subject: [PATCH Bug fix 4/5] Bug fix: Fix section mismatch problem of
 release_firmware_map_entry().
Date: Tue, 22 Jan 2013 19:43:03 +0800
Message-Id: <1358854984-6073-5-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
Cc: linux-mm@kvack.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function release_firmware_map_entry() references the function
__meminit firmware_map_find_entry_in_list(). So it should also have
__meminit.

And since the firmware_map_entry->kobj is initialized with memmap_ktype,
the memmap_ktype should also be prefixed by __refdata.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/firmware/memmap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 0710179..658fdd4 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -103,7 +103,7 @@ to_memmap_entry(struct kobject *kobj)
 	return container_of(kobj, struct firmware_map_entry, kobj);
 }
 
-static void release_firmware_map_entry(struct kobject *kobj)
+static void __meminit release_firmware_map_entry(struct kobject *kobj)
 {
 	struct firmware_map_entry *entry = to_memmap_entry(kobj);
 
@@ -127,7 +127,7 @@ static void release_firmware_map_entry(struct kobject *kobj)
 	kfree(entry);
 }
 
-static struct kobj_type memmap_ktype = {
+static struct kobj_type __refdata memmap_ktype = {
 	.release	= release_firmware_map_entry,
 	.sysfs_ops	= &memmap_attr_ops,
 	.default_attrs	= def_attrs,
-- 
1.7.1

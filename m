Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 1AB03DDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 07:35:22 +1000 (EST)
Date: Tue, 12 Aug 2008 16:34:57 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] remove redundant sysfs_remove_file calls for cache info
Message-ID: <20080812213457.GO6967@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When removing a directory, the sysfs core takes care of removing files
in the directory (see sysfs_remove_dir()).  So when we are about to
delete a kobject (and thus cause its sysfs directory to be removed),
we don't have to explicitly remove the files attached to it, although
it's harmless to do so.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/sysfs.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 56d172d..12058db 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -641,16 +641,9 @@ static void remove_cache_info(struct sys_device *sysdev)
 	int cpu = sysdev->id;
 
 	cache_desc = per_cpu(cache_desc, cpu);
-	if (cache_desc != NULL) {
-		sysfs_remove_file(&cache_desc->kobj, &cache_size_attr.attr);
-		sysfs_remove_file(&cache_desc->kobj, &cache_line_size_attr.attr);
-		sysfs_remove_file(&cache_desc->kobj, &cache_type_attr.attr);
-		sysfs_remove_file(&cache_desc->kobj, &cache_level_attr.attr);
-		sysfs_remove_file(&cache_desc->kobj, &cache_nr_sets_attr.attr);
-		sysfs_remove_file(&cache_desc->kobj, &cache_assoc_attr.attr);
-
+	if (cache_desc != NULL)
 		kobject_put(&cache_desc->kobj);
-	}
+
 	cache_toplevel = per_cpu(cache_toplevel, cpu);
 	if (cache_toplevel != NULL)
 		kobject_put(cache_toplevel);
-- 
1.5.5

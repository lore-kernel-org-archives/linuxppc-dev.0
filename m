Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD01n2DWbzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 11:37:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: matthew.brown.dev@gmail.com
Subject: [PATCH] powerpc/powernv: Fix missing attr initialisation in
 opal_export_attrs()
Date: Thu, 27 Apr 2017 11:37:32 +1000
Message-Id: <1493257052-828-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In opal_export_attrs() we dynamically allocate some bin_attributes. They're
allocated with kmalloc() and although we initialise most of the fields, we don't
initialise write() or mmap(), and in particular we don't initialise the lockdep
related fields in the embedded struct attribute.

This leads to a lockdep warning at boot:

  BUG: key c0000000f11906d8 not in .data!
  WARNING: CPU: 0 PID: 1 at ../kernel/locking/lockdep.c:3136 lockdep_init_map+0x28c/0x2a0
  ...
  Call Trace:
    lockdep_init_map+0x288/0x2a0 (unreliable)
    __kernfs_create_file+0x8c/0x170
    sysfs_add_file_mode_ns+0xc8/0x240
    __machine_initcall_powernv_opal_init+0x60c/0x684
    do_one_initcall+0x60/0x1c0
    kernel_init_freeable+0x2f4/0x3d4
    kernel_init+0x24/0x160
    ret_from_kernel_thread+0x5c/0xb0

Fix it by kzalloc'ing the attr, which fixes the uninitialised write() and
mmap(), and calling sysfs_bin_attr_init() on it to initialise the lockdep
fields.

Fixes: 11fe909d2362 ("powerpc/powernv: Add OPAL exports attributes to sysfs")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 76e153fc1f93..7925a9d72cca 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -637,13 +637,14 @@ static void opal_export_attrs(void)
 		if (of_property_read_u64_array(np, prop->name, &vals[0], 2))
 			continue;
 
-		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 
 		if (attr == NULL) {
 			pr_warn("Failed kmalloc for bin_attribute!");
 			continue;
 		}
 
+		sysfs_bin_attr_init(attr);
 		attr->attr.name = kstrdup(prop->name, GFP_KERNEL);
 		attr->attr.mode = 0400;
 		attr->read = export_attr_read;
-- 
2.7.4

Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6GxR3ZQNzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 19:29:15 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y129so1350984pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 02:29:15 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, paulus@samba.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] PCI: hotplug: constify attribute_group structures.
Date: Tue, 11 Jul 2017 14:58:44 +0530
Message-Id: <1499765324-617-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1499765324-617-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1499765324-617-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    418	    160	      8	    586	    24a	drivers/pci/hotplug/rpadlpar_sysfs.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
    482	     96	      8	    586	    232	drivers/pci/hotplug/rpadlpar_sysfs.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/hotplug/rpadlpar_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index a796301..edb5d8a 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -102,7 +102,7 @@ static ssize_t remove_slot_show(struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group dlpar_attr_group = {
+static const struct attribute_group dlpar_attr_group = {
 	.attrs = default_attrs,
 };
 
-- 
1.9.1

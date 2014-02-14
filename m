Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6CD2A2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 09:02:33 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 14 Feb 2014 17:02:30 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CC03938C803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:02:27 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1EM2RoX6160852
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:02:27 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1EM2PfI026722
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:02:27 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 03/11] sysfs: create bin_attributes under the requested
 group
Date: Fri, 14 Feb 2014 14:02:07 -0800
Message-Id: <1392415338-16288-4-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <michael@ellerman.id.au>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

bin_attributes created/updated in create_files() (such as those listed
via (struct device).attribute_groups) were not placed under the
specified group, and instead appeared in the base kobj directory.

Fix this by making bin_attributes use creating code similar to normal
attributes.

A quick grep shows that no one is using bin_attrs in a named attribute
group yet, so we can do this without breaking anything in usespace.

Note that I do not add is_visible() support to
bin_attributes, though that could be done as well.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 fs/sysfs/group.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 6b57938..aa04068 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -70,8 +70,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 	if (grp->bin_attrs) {
 		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
 			if (update)
-				sysfs_remove_bin_file(kobj, *bin_attr);
-			error = sysfs_create_bin_file(kobj, *bin_attr);
+				kernfs_remove_by_name(parent,
+						(*bin_attr)->attr.name);
+			error = sysfs_add_file_mode_ns(parent,
+					&(*bin_attr)->attr, true,
+					(*bin_attr)->attr.mode, NULL);
 			if (error)
 				break;
 		}
-- 
1.8.5.4

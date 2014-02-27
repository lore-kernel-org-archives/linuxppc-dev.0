Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46D052C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 08:31:34 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 14:31:32 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 03F22C90050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:31:26 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1RLVTHP9240926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 21:31:29 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1RLVR6M030240
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:31:29 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 01/11] sysfs: create bin_attributes under the requested
 group
Date: Thu, 27 Feb 2014 13:04:54 -0800
Message-Id: <1393535105-7528-2-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com,
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

No need to merge, already in driver-core-next as
aabaf4c2050d21d39fe11eec889c508e84d6a328, included for
reference/testing/verification only.

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
1.9.0

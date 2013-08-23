Return-Path: <rui.xiang@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8F302C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 12:57:29 +1000 (EST)
From: Rui Xiang <rui.xiang@huawei.com>
To: <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] fs: implement inode uid/gid setting function
Date: Fri, 23 Aug 2013 10:48:37 +0800
Message-ID: <1377226118-43756-2-git-send-email-rui.xiang@huawei.com>
In-Reply-To: <1377226118-43756-1-git-send-email-rui.xiang@huawei.com>
References: <1377226118-43756-1-git-send-email-rui.xiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Rui Xiang <rui.xiang@huawei.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Supply a interface inode_set_user  to set uid/gid of inode
structs.

Signed-off-by: Rui Xiang <rui.xiang@huawei.com>
---
 fs/inode.c         | 7 +++++++
 include/linux/fs.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index e315c0a..3f90499 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -343,6 +343,13 @@ void inc_nlink(struct inode *inode)
 }
 EXPORT_SYMBOL(inc_nlink);
 
+void inode_set_user(struct inode *inode, kuid_t uid, kgid_t gid)
+{
+	inode->i_uid = uid;
+	inode->i_gid = gid;
+}
+EXPORT_SYMBOL(inode_set_user);
+
 void address_space_init_once(struct address_space *mapping)
 {
 	memset(mapping, 0, sizeof(*mapping));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 729e81b..36ac51b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2619,6 +2619,7 @@ void __inode_sub_bytes(struct inode *inode, loff_t bytes);
 void inode_sub_bytes(struct inode *inode, loff_t bytes);
 loff_t inode_get_bytes(struct inode *inode);
 void inode_set_bytes(struct inode *inode, loff_t bytes);
+void inode_set_user(struct inode *inode, kuid_t uid, kgid_t gid);
 
 extern int vfs_readdir(struct file *, filldir_t, void *);
 extern int iterate_dir(struct file *, struct dir_context *);
-- 
1.8.2.2

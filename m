Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D51E72C029E
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:38 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 16 Jul 2013 02:47:13 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DDD2E2CE8053
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:34 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6FGfCJH590092
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:41:12 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6FGuX01013191
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:34 +1000
Subject: [PATCH 07/11] pstore: Add file extension to pstore file if compressed
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 22:26:19 +0530
Message-ID: <20130715165619.1520.72602.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com,
 keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In case decompression fails, add a ".enc.z" to indicate the file has
compressed data. This will help user space utilities to figure
out the file contents.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 fs/pstore/inode.c    |    9 +++++----
 fs/pstore/internal.h |    5 +++--
 fs/pstore/platform.c |    4 +++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 71bf5f4..259e92c 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -275,8 +275,8 @@ int pstore_is_mounted(void)
  * Set the mtime & ctime to the date that this record was originally stored.
  */
 int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
-		  char *data, size_t size, struct timespec time,
-		  struct pstore_info *psi)
+		  char *data, bool compressed, size_t size,
+		  struct timespec time, struct pstore_info *psi)
 {
 	struct dentry		*root = pstore_sb->s_root;
 	struct dentry		*dentry;
@@ -315,7 +315,8 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
 
 	switch (type) {
 	case PSTORE_TYPE_DMESG:
-		sprintf(name, "dmesg-%s-%lld", psname, id);
+		sprintf(name, "dmesg-%s-%lld%s", psname, id,
+						compressed ? ".enc.z" : "");
 		break;
 	case PSTORE_TYPE_CONSOLE:
 		sprintf(name, "console-%s", psname);
@@ -328,7 +329,7 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
 		break;
 	case PSTORE_TYPE_PPC_RTAS:
 		sprintf(name, "rtas-%s-%lld", psname, id);
-		break;
+	break;
 	case PSTORE_TYPE_PPC_OF:
 		sprintf(name, "powerpc-ofw-%s-%lld", psname, id);
 		break;
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 937d820..3b3d305 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -50,8 +50,9 @@ extern struct pstore_info *psinfo;
 extern void	pstore_set_kmsg_bytes(int);
 extern void	pstore_get_records(int);
 extern int	pstore_mkfile(enum pstore_type_id, char *psname, u64 id,
-			      int count, char *data, size_t size,
-			      struct timespec time, struct pstore_info *psi);
+			      int count, char *data, bool compressed,
+			      size_t size, struct timespec time,
+			      struct pstore_info *psi);
 extern int	pstore_is_mounted(void);
 
 #endif
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 119db58..8f3e5f0 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -481,13 +481,15 @@ void pstore_get_records(int quiet)
 			if (unzipped_len > 0) {
 				buf = big_buf;
 				size = unzipped_len;
+				compressed = false;
 			} else {
 				pr_err("pstore: decompression failed;"
 					"returned %d\n", unzipped_len);
+				compressed = true;
 			}
 		}
 		rc = pstore_mkfile(type, psi->name, id, count, buf,
-				  (size_t)size, time, psi);
+				  compressed, (size_t)size, time, psi);
 		kfree(buf);
 		kfree(stream.workspace);
 		kfree(big_buf);

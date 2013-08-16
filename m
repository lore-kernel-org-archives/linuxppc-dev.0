Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6010D2C0256
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:40:29 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 19:04:07 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8D89F1258054
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 19:10:08 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GDRNB937355676
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 19:11:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7GDIW02018214
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:48:33 +0530
Subject: [RFC PATCH v2 07/11] pstore: Add file extension to pstore file if
 compressed
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 18:48:28 +0530
Message-ID: <20130816131828.3338.65602.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, cbouatmailru@gmail.com,
 mahesh@linux.vnet.ibm.com, ccross@android.com
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
 fs/pstore/inode.c    |    7 ++++---
 fs/pstore/internal.h |    5 +++--
 fs/pstore/platform.c |    4 +++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 71bf5f4..519d278 100644
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
index 0195cca0..cf0b53f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -479,13 +479,15 @@ void pstore_get_records(int quiet)
 			if (unzipped_len > 0) {
 				buf = big_oops_buf;
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
 		if (unzipped_len < 0) {
 			/* Free buffer other than big oops */
 			kfree(buf);

Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA4942C0204
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 19:56:24 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 19:48:25 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C02C13578055
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 19:56:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q9gPAn18808964
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 19:42:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q9uANX009041
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 19:56:11 +1000
Subject: [PATCH 1/3] Retreive header size from pstore.
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 26 Apr 2013 15:25:59 +0530
Message-ID: <20130426095559.14323.86227.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130426094923.14323.80567.stgit@aruna-ThinkPad-T420>
References: <20130426094923.14323.80567.stgit@aruna-ThinkPad-T420>
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

pstore_get_header_size will return the size of the header added by pstore
while logging messages to the registered buffer.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 fs/pstore/platform.c   |    7 ++++++-
 include/linux/pstore.h |    6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 86d1038..e8260ea 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -49,6 +49,7 @@ MODULE_PARM_DESC(update_ms, "milliseconds before pstore updates its content "
 		 "corruption on Oopses)");
 
 static int pstore_new_entry;
+static int hsize;
 
 static void pstore_timefunc(unsigned long);
 static DEFINE_TIMER(pstore_timer, pstore_timefunc, 0, 0);
@@ -68,6 +69,11 @@ static char *backend;
 /* How much of the console log to snapshot */
 static unsigned long kmsg_bytes = 10240;
 
+int pstore_get_header_size(void)
+{
+	return hsize;
+}
+
 void pstore_set_kmsg_bytes(int bytes)
 {
 	kmsg_bytes = bytes;
@@ -147,7 +153,6 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	while (total < kmsg_bytes) {
 		char *dst;
 		unsigned long size;
-		int hsize;
 		size_t len;
 
 		dst = psinfo->buf;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 656699f..f43b64f 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -73,6 +73,7 @@ struct pstore_info {
 #ifdef CONFIG_PSTORE
 extern int pstore_register(struct pstore_info *);
 extern bool pstore_cannot_block_path(enum kmsg_dump_reason reason);
+extern int pstore_get_header_size(void);
 #else
 static inline int
 pstore_register(struct pstore_info *psi)
@@ -84,6 +85,11 @@ pstore_cannot_block_path(enum kmsg_dump_reason reason)
 {
 	return false;
 }
+static inline int
+pstore_get_header_size(void)
+{
+	return 0;
+}
 #endif
 
 #endif /*_LINUX_PSTORE_H*/

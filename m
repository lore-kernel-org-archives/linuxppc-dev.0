Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D590B1A0A68
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 15:45:39 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Sat, 9 Aug 2014 15:45:38 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B93352CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 15:45:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s795MMjO11665740
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Aug 2014 15:22:23 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s795jYPk018493
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Aug 2014 15:45:34 +1000
Subject: [PATCH v3 1/2] printk: Add function to return log buffer address
 and size
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Sat, 09 Aug 2014 11:15:30 +0530
Message-ID: <20140809054424.17676.1090.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Platforms like IBM Power Systems supports service processor
assisted dump. It provides interface to add memory region to
be captured when system is crashed.

During initialization/running we can add kernel memory region
to be collected.

Presently we don't have a way to get the log buffer base address
and size. This patch adds support to return log buffer address
and size.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Next patch extends arch specific code to add log buffer to platform
dump.

Changes in v3:
  As Andrew suggested changed function names and return type.
  (https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/119802.html).

Ben,
  - This patchset applies cleanly on powerpc next branch.
  - Andrew Morton suggested to include this patch in powerpc tree.
    (https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/119802.html)


 include/linux/printk.h |    3 +++
 kernel/printk/printk.c |   12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 319ff7e..b8c0316 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -10,6 +10,9 @@
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
+extern char *log_buf_addr_get(void);
+extern u32 log_buf_len_get(void);
+
 static inline int printk_get_level(const char *buffer)
 {
 	if (buffer[0] == KERN_SOH_ASCII && buffer[1]) {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea2d5f6..d6a984c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -270,6 +270,18 @@ static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
 
+/* Return log buffer address */
+char *log_buf_addr_get(void)
+{
+	return log_buf;
+}
+
+/* Return log buffer size */
+u32 log_buf_len_get(void)
+{
+	return log_buf_len;
+}
+
 /* human readable text of the record */
 static char *log_text(const struct printk_log *msg)
 {

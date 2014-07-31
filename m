Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA7B51A004F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 20:30:18 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 31 Jul 2014 20:30:17 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 16F783578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 20:30:15 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6VA7CXW59900154
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 20:07:13 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6VAUE06017915
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 20:30:14 +1000
Subject: [PATCH v2 1/2] printk: Add function to return log buffer address
 and size
To: linux-kernel@vger.kernel.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Thu, 31 Jul 2014 16:00:06 +0530
Message-ID: <20140731102920.27954.25076.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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
---
  Next patch extends arch specific code to add log buffer to platform
dump.

-Vasant

 include/linux/printk.h |    3 +++
 kernel/printk/printk.c |   12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 319ff7e..aae82c4 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -10,6 +10,9 @@
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
+extern void *get_log_buf_addr(void);
+extern u32 get_log_buf_len(void);
+
 static inline int printk_get_level(const char *buffer)
 {
 	if (buffer[0] == KERN_SOH_ASCII && buffer[1]) {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 13e839d..4049f7b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -270,6 +270,18 @@ static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
 
+/* Return log buffer address */
+void *get_log_buf_addr(void)
+{
+	return log_buf;
+}
+
+/* Return log buffer size */
+u32 get_log_buf_len(void)
+{
+	return log_buf_len;
+}
+
 /* human readable text of the record */
 static char *log_text(const struct printk_log *msg)
 {

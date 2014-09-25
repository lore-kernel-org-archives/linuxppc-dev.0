Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE8001A17A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:42:37 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Thu, 25 Sep 2014 16:42:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3B0772BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:42:33 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P6i43r33882254
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:44:13 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P6g00R023854
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:42:00 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8P6g0jY023220
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:42:00 +1000
Received: from cyril.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 905E9A0330
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:30 +1000 (EST)
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc/pseries: create rtas buffer accessor
Date: Thu, 25 Sep 2014 16:41:29 +1000
Message-Id: <1411627290-20302-3-git-send-email-cyril.bur@au1.ibm.com>
In-Reply-To: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
References: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added simple accessor functions for rtas in memory buffers which performs
accesses of appropriate type and performs endian conversions.

Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/Makefile      |   4 +-
 arch/powerpc/platforms/pseries/pseries.h     |  41 +++++++++
 arch/powerpc/platforms/pseries/rtas_buffer.c | 126 +++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/pseries/rtas_buffer.c

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 0348079..7eb7c46 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -3,7 +3,9 @@ ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o event_sources.o ras.o \
-			   firmware.o power.o dlpar.o mobility.o rng.o
+			   firmware.o power.o dlpar.o mobility.o \
+			   rng.o rtas_buffer.o
+
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh_pseries.o
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 361add6..f24e352 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -66,4 +66,45 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
 
 unsigned long pseries_memory_block_size(void);
 
+/* Manipulation of the in memory data returned from an RTAS call */
+
+/* Data pointed to by ptr is in big endian */
+struct rtas_buffer {
+	void *ptr;
+	int len;
+	int pos;
+};
+
+/* Buffer is already zeroed */
+int make_rtas_buf(struct rtas_buffer *b, size_t size);
+void free_rtas_buf(struct rtas_buffer *b);
+
+/* Return pointer to the buffer being used */
+void *get_rtas_buf(struct rtas_buffer *b);
+
+/* Checks if the buffer exists and the read position is less than the length*/
+bool check_rtas_buf(struct rtas_buffer *b);
+size_t get_rtas_buf_size(struct rtas_buffer *b);
+
+/* Advance the internal position of the buffer by size bytes */
+bool advance_rtas_buf(struct rtas_buffer *b, size_t size);
+
+/* Put a value val into the buffer at position pos. Function expect val in cpu
+ * endian. Returns true if the write to the buffer was successful.
+ */
+bool put_rtas_buf_32(struct rtas_buffer *b, u32 val, int pos);
+
+/* Grab the byte at the current position of the buffer without incrementing
+ * the internal position of the buffer */
+bool peek_rtas_buf(struct rtas_buffer *b, u8 *c);
+
+/* Accessor functions return true if access succeeded and value is written to
+ * val in cpu endian. Automatically advances its reference into the buffer by
+ * the requested amount.
+ */
+bool get_rtas_buf_32(struct rtas_buffer *b, u32 *val);
+bool get_rtas_buf_64(struct rtas_buffer *b, u64 *val);
+bool get_rtas_buf_mem(struct rtas_buffer *b, void **p, size_t len);
+bool get_rtas_buf_str(struct rtas_buffer *b, char **s);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/rtas_buffer.c b/arch/powerpc/platforms/pseries/rtas_buffer.c
new file mode 100644
index 0000000..f06b73c
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/rtas_buffer.c
@@ -0,0 +1,126 @@
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "pseries.h"
+
+
+int make_rtas_buf(struct rtas_buffer *b, size_t sz)
+{
+	b->ptr = kzalloc(sz, GFP_KERNEL);
+	b->len = sz;
+	b->pos = 0;
+	return (!b->ptr) ? -ENOMEM : 0;
+}
+
+void free_rtas_buf(struct rtas_buffer *b)
+{
+	kfree(b->ptr);
+}
+
+void *get_rtas_buf(struct rtas_buffer *b)
+{
+	return (b) ? b->ptr : NULL;
+}
+
+size_t get_rtas_buf_size(struct rtas_buffer *b)
+{
+	return (b) ? b->len : 0;
+}
+
+bool check_rtas_buf(struct rtas_buffer *b)
+{
+	return (b && b->ptr && b->pos < b->len);
+}
+
+static inline void *buf_pos(struct rtas_buffer *b)
+{
+	return (b && b->ptr) ? b->ptr + b->pos : NULL;
+}
+
+bool peek_rtas_buf(struct rtas_buffer *b, u8 *c)
+{
+	if (!b || !c || b->pos >= b->len)
+		return false;
+
+	*c = *(u8 *)buf_pos(b);
+
+	return true;
+}
+
+bool put_rtas_buf_32(struct rtas_buffer *b, u32 val, int pos)
+{
+	if (!b || b->pos >= b->len)
+		return false;
+
+	*((__be32 *)buf_pos(b)) = cpu_to_be32(val);
+
+	return true;
+}
+
+bool get_rtas_buf_32(struct rtas_buffer *b, u32 *val)
+{
+	if (!b || !val || b->len - b->pos < sizeof(u32))
+		return false;
+
+	*val = be32_to_cpu(*((__be32 *)buf_pos(b)));
+	b->pos += sizeof(u32);
+	return true;
+}
+
+bool get_rtas_buf_64(struct rtas_buffer *b, u64 *val)
+{
+	if (!b || !val || b->len - b->pos < sizeof(u64))
+		return false;
+
+	*val = be64_to_cpu(*((__be64 *)buf_pos(b)));
+	b->pos += sizeof(u64);
+	return true;
+}
+
+bool get_rtas_buf_str(struct rtas_buffer *b, char **s)
+{
+	int i;
+	if (!b || !s)
+		return false;
+
+	/* Get length of string */
+	i = b->pos;
+	while (i < b->len) {
+		if (*(char *)(b->ptr + i) == '\0') {
+			*s = (char *)buf_pos(b);
+			if (!*s)
+				return false;
+
+			b->pos = i + 1;
+			return true;
+		}
+		i++;
+	}
+
+	return false;
+}
+
+bool get_rtas_buf_mem(struct rtas_buffer *b, void **p, size_t len)
+{
+	if (!b || !p || b->len - b->pos < len)
+		return false;
+
+	*p = buf_pos(b);
+	if (!*p)
+		return false;
+
+	b->pos += len;
+
+	return true;
+}
+
+bool advance_rtas_buf(struct rtas_buffer *b, size_t len)
+{
+	if (!b || b->len - b->pos < len)
+		return false;
+
+	b->pos += len;
+
+	return true;
+}
+
-- 
1.9.1

Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkJFM1PzbzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 17:18:31 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G68oFD136802
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 02:18:17 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 296nfxm3uj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 02:18:17 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 16:18:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G6I49q38600814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 17:18:12 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G6Hbn1012875
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 17:17:37 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Map OPAL msglog in IOREMAP area
Date: Thu, 16 Mar 2017 17:17:13 +1100
Message-Id: <1489645033-15831-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With OPAL msglog driver, there are two interfaces to retrieve the
firmware (skiboot) logs: /sys/firmware/opal/msglog and xmon "do"
command. The memory console header (descritpor) and output buffer
are resident in memory blocks whose addresses are greater than
0x30000000. The memory blocks needn't be necessarily visible to
kernel. For example when the memory visible to kernel is limited
by "mem=768M" in bootargs. In this case, reading the memory console
header (descriptor) and its output buffer directly causes kernel
crash as the memory blocks aren't mapped in the linear area as the
driver assumed.

This reworks the driver to map the memory console header (descitpor)
and its output buffer as readonly in IOREMAP area as Michael Ellerman
suggested before. Also, the memory console descriptor are readed into
local descriptor so that we needn't care about its endian (big or little)
afterwards, until we need update the output position when dumping the
messages in the output buffer.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-msglog.c | 81 ++++++++++++++++++----------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 7a9cde0..0f2167f 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -18,38 +18,46 @@
 
 /* OPAL in-memory console. Defined in OPAL source at core/console.c */
 struct memcons {
-	__be64 magic;
+	unsigned long	magic;
 #define MEMCONS_MAGIC	0x6630696567726173L
-	__be64 obuf_phys;
-	__be64 ibuf_phys;
-	__be32 obuf_size;
-	__be32 ibuf_size;
-	__be32 out_pos;
+	unsigned long	obuf_phys;
+	unsigned long	ibuf_phys;
+	unsigned int	obuf_size;
+	unsigned int	ibuf_size;
+	unsigned int	out_pos;
 #define MEMCONS_OUT_POS_WRAP	0x80000000u
 #define MEMCONS_OUT_POS_MASK	0x00ffffffu
-	__be32 in_prod;
-	__be32 in_cons;
+	unsigned int	in_prod;
+	unsigned int	in_cons;
 };
 
-static struct memcons *opal_memcons = NULL;
+static struct memcons opal_memcons;
+static void __iomem *opal_memcons_virt;
+static void __iomem *opal_memcons_obuf;
+
+#define OPAL_MEMCONS_GET_FIELD(field, accessor, converter, tmp)	\
+	tmp = accessor(opal_memcons_virt +			\
+		       offsetof(struct memcons, field));	\
+	opal_memcons.field = converter(tmp)
 
 ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
 {
-	const char *conbuf;
+	char *conbuf;
 	ssize_t ret;
 	size_t first_read = 0;
-	uint32_t out_pos, avail;
+	uint32_t out_pos, avail, val32;
 
-	if (!opal_memcons)
+	if (!opal_memcons_obuf)
 		return -ENODEV;
 
-	out_pos = be32_to_cpu(ACCESS_ONCE(opal_memcons->out_pos));
+	OPAL_MEMCONS_GET_FIELD(out_pos, __raw_readl, be32_to_cpu, val32);
+	out_pos = opal_memcons.out_pos;
 
 	/* Now we've read out_pos, put a barrier in before reading the new
 	 * data it points to in conbuf. */
 	smp_rmb();
 
-	conbuf = phys_to_virt(be64_to_cpu(opal_memcons->obuf_phys));
+	conbuf = opal_memcons_obuf;
 
 	/* When the buffer has wrapped, read from the out_pos marker to the end
 	 * of the buffer, and then read the remaining data as in the un-wrapped
@@ -57,7 +65,7 @@ ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
 	if (out_pos & MEMCONS_OUT_POS_WRAP) {
 
 		out_pos &= MEMCONS_OUT_POS_MASK;
-		avail = be32_to_cpu(opal_memcons->obuf_size) - out_pos;
+		avail = opal_memcons.obuf_size - out_pos;
 
 		ret = memory_read_from_buffer(to, count, &pos,
 				conbuf + out_pos, avail);
@@ -75,7 +83,7 @@ ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
 	}
 
 	/* Sanity check. The firmware should not do this to us. */
-	if (out_pos > be32_to_cpu(opal_memcons->obuf_size)) {
+	if (out_pos > opal_memcons.obuf_size) {
 		pr_err("OPAL: memory console corruption. Aborting read.\n");
 		return -EINVAL;
 	}
@@ -104,35 +112,54 @@ static struct bin_attribute opal_msglog_attr = {
 
 void __init opal_msglog_init(void)
 {
-	u64 mcaddr;
-	struct memcons *mc;
+	u64 val64;
+	u32 val32;
 
-	if (of_property_read_u64(opal_node, "ibm,opal-memcons", &mcaddr)) {
+	if (of_property_read_u64(opal_node, "ibm,opal-memcons", &val64)) {
 		pr_warn("OPAL: Property ibm,opal-memcons not found, no message log\n");
 		return;
 	}
 
-	mc = phys_to_virt(mcaddr);
-	if (!mc) {
+	opal_memcons_virt = ioremap_prot(val64, sizeof(opal_memcons),
+					 (_PAGE_BASE | _PAGE_KERNEL_RO));
+	if (!opal_memcons_virt) {
 		pr_warn("OPAL: memory console address is invalid\n");
 		return;
 	}
 
-	if (be64_to_cpu(mc->magic) != MEMCONS_MAGIC) {
+	OPAL_MEMCONS_GET_FIELD(magic,     __raw_readq, be64_to_cpu, val64);
+	OPAL_MEMCONS_GET_FIELD(obuf_phys, __raw_readq, be64_to_cpu, val64);
+	OPAL_MEMCONS_GET_FIELD(ibuf_phys, __raw_readq, be64_to_cpu, val64);
+	OPAL_MEMCONS_GET_FIELD(obuf_size, __raw_readl, be32_to_cpu, val64);
+	OPAL_MEMCONS_GET_FIELD(ibuf_size, __raw_readl, be32_to_cpu, val32);
+	OPAL_MEMCONS_GET_FIELD(out_pos,   __raw_readl, be32_to_cpu, val32);
+	OPAL_MEMCONS_GET_FIELD(in_prod,   __raw_readl, be32_to_cpu, val32);
+	OPAL_MEMCONS_GET_FIELD(in_cons,   __raw_readl, be32_to_cpu, val32);
+
+	if (opal_memcons.magic != MEMCONS_MAGIC) {
 		pr_warn("OPAL: memory console version is invalid\n");
+		iounmap(opal_memcons_virt);
 		return;
 	}
 
-	/* Report maximum size */
-	opal_msglog_attr.size =  be32_to_cpu(mc->ibuf_size) +
-		be32_to_cpu(mc->obuf_size);
+	opal_memcons_obuf = ioremap_prot(opal_memcons.obuf_phys,
+					 opal_memcons.obuf_size,
+					 (_PAGE_BASE | _PAGE_KERNEL_RO));
+	if (!opal_memcons_obuf) {
+		pr_warn("OPAL: Fail mapping output buffer (0x%lx, 0x%x)\n",
+			opal_memcons.obuf_phys, opal_memcons.obuf_size);
+		iounmap(opal_memcons_virt);
+		return;
+	}
 
-	opal_memcons = mc;
+	/* Report maximum size */
+	opal_msglog_attr.size =  opal_memcons.ibuf_size +
+				 opal_memcons.obuf_size;
 }
 
 void __init opal_msglog_sysfs_init(void)
 {
-	if (!opal_memcons) {
+	if (!opal_memcons_obuf) {
 		pr_warn("OPAL: message log initialisation failed, not creating sysfs entry\n");
 		return;
 	}
-- 
2.7.4

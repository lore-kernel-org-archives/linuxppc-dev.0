Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177C3C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 03:58:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EF421720
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 03:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EF421720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PfMC3zg5zDqKS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 14:57:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDF5MKjzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:57 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 9897229525; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <6db46da0ad072e50de32721e2dce9387aa58f4ab.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 16/25] powerpc: Add missing ppc_md.nvram_size for CHRP and
 PowerMac
Date: Wed, 26 Dec 2018 11:37:59 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the nvram_size() function to those PowerPC platforms that don't already
have one: CHRP and PowerMac. This means that the ppc_md.nvram_size()
function can be used to implement arch_nvram_ops.get_size()

Since we are addressing inconsistencies here, also rename chrp_nvram_read
and chrp_nvram_write, which break the naming convention used across
PowerPC platforms for NVRAM accessor functions.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
 arch/powerpc/platforms/chrp/nvram.c     | 14 ++++++++++----
 arch/powerpc/platforms/powermac/nvram.c |  9 +++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/nvram.c b/arch/powerpc/platforms/chrp/nvram.c
index 791b86398e1d..6ec2901d2aa4 100644
--- a/arch/powerpc/platforms/chrp/nvram.c
+++ b/arch/powerpc/platforms/chrp/nvram.c
@@ -24,7 +24,7 @@ static unsigned int nvram_size;
 static unsigned char nvram_buf[4];
 static DEFINE_SPINLOCK(nvram_lock);
 
-static unsigned char chrp_nvram_read(int addr)
+static unsigned char chrp_nvram_read_byte(int addr)
 {
 	unsigned int done;
 	unsigned long flags;
@@ -46,7 +46,7 @@ static unsigned char chrp_nvram_read(int addr)
 	return ret;
 }
 
-static void chrp_nvram_write(int addr, unsigned char val)
+static void chrp_nvram_write_byte(int addr, unsigned char val)
 {
 	unsigned int done;
 	unsigned long flags;
@@ -64,6 +64,11 @@ static void chrp_nvram_write(int addr, unsigned char val)
 	spin_unlock_irqrestore(&nvram_lock, flags);
 }
 
+static ssize_t chrp_nvram_size(void)
+{
+	return nvram_size;
+}
+
 void __init chrp_nvram_init(void)
 {
 	struct device_node *nvram;
@@ -85,8 +90,9 @@ void __init chrp_nvram_init(void)
 	printk(KERN_INFO "CHRP nvram contains %u bytes\n", nvram_size);
 	of_node_put(nvram);
 
-	ppc_md.nvram_read_val = chrp_nvram_read;
-	ppc_md.nvram_write_val = chrp_nvram_write;
+	ppc_md.nvram_read_val  = chrp_nvram_read_byte;
+	ppc_md.nvram_write_val = chrp_nvram_write_byte;
+	ppc_md.nvram_size      = chrp_nvram_size;
 
 	return;
 }
diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index ae54d7fe68f3..9360cdc408c1 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -147,6 +147,11 @@ static ssize_t core99_nvram_size(void)
 static volatile unsigned char __iomem *nvram_addr;
 static int nvram_mult;
 
+static ssize_t ppc32_nvram_size(void)
+{
+	return NVRAM_SIZE;
+}
+
 static unsigned char direct_nvram_read_byte(int addr)
 {
 	return in_8(&nvram_data[(addr & (NVRAM_SIZE - 1)) * nvram_mult]);
@@ -590,21 +595,25 @@ int __init pmac_nvram_init(void)
 		nvram_mult = 1;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 1) {
 		nvram_data = ioremap(r1.start, s1);
 		nvram_mult = (s1 + NVRAM_SIZE - 1) / NVRAM_SIZE;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 2) {
 		nvram_addr = ioremap(r1.start, s1);
 		nvram_data = ioremap(r2.start, s2);
 		ppc_md.nvram_read_val	= indirect_nvram_read_byte;
 		ppc_md.nvram_write_val	= indirect_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 0 && sys_ctrler == SYS_CTRLER_PMU) {
 #ifdef CONFIG_ADB_PMU
 		nvram_naddrs = -1;
 		ppc_md.nvram_read_val	= pmu_nvram_read_byte;
 		ppc_md.nvram_write_val	= pmu_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 #endif /* CONFIG_ADB_PMU */
 	} else {
 		printk(KERN_ERR "Incompatible type of NVRAM\n");
-- 
2.19.2


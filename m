Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1237FB7353
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 02:12:22 +1000 (EST)
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B7ACDDDB6
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 02:12:20 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 1/5] Allow byte length reads from mmio NVRAM driver
To: linuxppc-dev@ozlabs.org
Date: Thu, 02 Jul 2009 17:12:18 +0100
Message-ID: <20090702161218.31202.48200.stgit@ES-J7S4D2J.amer.consind.ge.com>
In-Reply-To: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a byte length read and write interface compatible with the nvram_generic driver interface to the mmio driver.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/sysdev/mmio_nvram.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mmio_nvram.c b/arch/powerpc/sysdev/mmio_nvram.c
index 7b49633..2073242 100644
--- a/arch/powerpc/sysdev/mmio_nvram.c
+++ b/arch/powerpc/sysdev/mmio_nvram.c
@@ -53,6 +53,23 @@ static ssize_t mmio_nvram_read(char *buf, size_t count, loff_t *index)
 	return count;
 }
 
+static unsigned char mmio_nvram_read_val(int addr)
+{
+	unsigned long flags;
+	unsigned char val;
+
+	if (addr >= mmio_nvram_len)
+		return 0xff;
+
+	spin_lock_irqsave(&mmio_nvram_lock, flags);
+
+	val = ioread8(mmio_nvram_start + addr);
+
+	spin_unlock_irqrestore(&mmio_nvram_lock, flags);
+
+	return val;
+}
+
 static ssize_t mmio_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	unsigned long flags;
@@ -72,6 +89,19 @@ static ssize_t mmio_nvram_write(char *buf, size_t count, loff_t *index)
 	return count;
 }
 
+void mmio_nvram_write_val(int addr, unsigned char val)
+{
+	unsigned long flags;
+
+	if (addr < mmio_nvram_len) {
+		spin_lock_irqsave(&mmio_nvram_lock, flags);
+
+		iowrite8(val, mmio_nvram_start + addr);
+
+		spin_unlock_irqrestore(&mmio_nvram_lock, flags);
+	}
+}
+
 static ssize_t mmio_nvram_get_size(void)
 {
 	return mmio_nvram_len;
@@ -114,6 +144,8 @@ int __init mmio_nvram_init(void)
 	printk(KERN_INFO "mmio NVRAM, %luk at 0x%lx mapped to %p\n",
 	       mmio_nvram_len >> 10, nvram_addr, mmio_nvram_start);
 
+	ppc_md.nvram_read_val	= mmio_nvram_read_val;
+	ppc_md.nvram_write_val	= mmio_nvram_write_val;
 	ppc_md.nvram_read	= mmio_nvram_read;
 	ppc_md.nvram_write	= mmio_nvram_write;
 	ppc_md.nvram_size	= mmio_nvram_get_size;

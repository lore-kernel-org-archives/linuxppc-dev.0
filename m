Return-Path: <linuxppc-dev+bounces-26617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A2DC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 03:32:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcwjq6Rjgz2yxB;
	Sun, 06 Sep 2026 13:31:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788665519;
	cv=none; b=jtyzbn/uLri6NVkZzuzUdo1kDq6oD24AtAt5HrV94owbohLUou/tYcJPhLnQB6DyMriHTM4/aUk04GV8u3rWrm1GBzd2pASJ8AoyWJ+n0AVBvViz0v3S3BDEYPEB08cM1TuEbmQkLtm8EbvzLPZ/LXeX0+DZpu8Om+XweJ0uq3cyEJ07Ds6+p0gNFcsL3yRkpn3yneqBfunZ4zxKI8F9lk53x0VTA8obEMJWZKW+g8kMFeJUka5DILIOCaFtsFYVe/njXo3wwXC8jMLufW8f2o2X32dr7IoXKbhgDs1nHR7V9sWeDRU1yQR1/NhHZZrxFbITuqrJBFTUWlgWknWCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788665519; c=relaxed/relaxed;
	bh=z2WWgFmmWq3Iagjk6y3ytw2r2vhXX/82rYG2xs3Iwzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HewpdfUlnj4KRbqGs/6XBP8XhbN1GOZwR0trslpCPfeqswSXdF6UWOPE/bCl0ShBPqxJ82856A4q82GsPB4YsDxe4+z2Z0qX//ogsCvn6G1NpBCc7+c4LjeQsPDi+onb/nTOYkKKH/O/Q42hRTTqB226O7E1IWyVelTkXpojpoOvGoMlGdW2/H7U+K9ia4tMUfZ1RSKLFMTqasVMdTRFleKyaUF7mYLwa0YapApPZlscwVjX6w1wOxzIOKnjrxtY+8ocr2Sh7ixu0IKznbMmrwbvdjgBGZrdlGGkgLImccrSyCBpwCtWKssKKyFpuWz6rrszLz4QJEBb9XH9jMNr6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=zhouminqiang@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=zhouminqiang@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcwjl04Kjz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 13:31:53 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hcwGX5DQqzYQtrf
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Sep 2026 11:11:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1947140577
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Sep 2026 11:12:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBnUAsW2pxqmzytAw--.18069S11;
	Sun, 06 Sep 2026 11:12:35 +0800 (CST)
From: Zhou Minqiang <zhouminqiang2@huawei.com>
To: linux@armlinux.org.uk,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com,
	maddy@linux.ibm.com,
	dwmw2@infradead.org,
	richard@nod.at
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	zhouminqiang <zhouminqiang2@huawei.com>
Subject: [PATCH v4 7/8] jffs2: rename CONFIG_JFFS2_FS_WBUF_VERIFY to CONFIG_JFFS2_FS_WRITE_VERIFY
Date: Sun,  6 Sep 2026 11:03:43 +0800
Message-ID: <20260906030344.2448622-8-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260906030344.2448622-1-zhouminqiang2@huawei.com>
References: <20260906030344.2448622-1-zhouminqiang2@huawei.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnUAsW2pxqmzytAw--.18069S11
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyUAFWfGF1kJFW7ury3Arb_yoWxGry5pF
	n5AwsxJF4kGF1YqrZrAFyvga98tFnrZrWjgr47Cw1UuF95Z342va4qyrnxAr48XrZrKr40
	9a9a9FyfKr1xJ37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxF4iUUUUU
Sender: zhouminqiang@huaweicloud.com
X-CM-SenderInfo: 52kr3z5lqtxttqj6x35dzhxuhorxvhhfrp/

From: zhouminqiang <zhouminqiang2@huawei.com>

Write verification now covers all write paths including NOR direct
writes and write-buffer direct page writes, not just the write-buffer
flush path. The Kconfig option also no longer depends on
CONFIG_JFFS2_FS_WRITEBUFFER.

Rename the option from CONFIG_JFFS2_FS_WBUF_VERIFY to
CONFIG_JFFS2_FS_WRITE_VERIFY to reflect its broader scope and
independence from the write-buffer configuration.

Update defconfig files that explicitly enabled the old symbol to use
the new name, so that platforms which previously relied on this
verification continue to have it enabled.

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 arch/arm/configs/keystone_defconfig     |  2 +-
 arch/arm/configs/lpc32xx_defconfig      |  2 +-
 arch/arm/configs/pxa3xx_defconfig       |  2 +-
 arch/arm/configs/pxa_defconfig          |  2 +-
 arch/powerpc/configs/44x/fsp2_defconfig |  2 +-
 fs/jffs2/Kconfig                        | 23 ++++++++++++++++++-----
 fs/jffs2/os-linux.h                     |  2 +-
 fs/jffs2/writev.c                       |  4 ++--
 8 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index b0cadd878152..d485b8b0b91d 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -212,7 +212,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_FS_WRITE_VERIFY=y
 CONFIG_UBIFS_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index b9e2e603cd95..dd0c6db641be 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -164,7 +164,7 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_FS_WRITE_VERIFY=y
 CONFIG_UBIFS_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index fb272e3a2337..f2121269f7c8 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -84,7 +84,7 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=m
 CONFIG_LEDS_TRIGGER_GPIO=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_FS_WRITE_VERIFY=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_LZO=y
 CONFIG_JFFS2_RUBIN=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 66cc149c5ca4..e05cbebb0d8b 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -596,7 +596,7 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=m
 CONFIG_JFFS2_FS_DEBUG=1
-CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_FS_WRITE_VERIFY=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_FS_XATTR=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index b8b21fa15a07..e626dcb98d34 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -97,7 +97,7 @@ CONFIG_EXT4_FS_SECURITY=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_FS_WRITE_VERIFY=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_FS_XATTR=y
 CONFIG_CRAMFS=y
diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index 560187d61562..556025a5d438 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -42,13 +42,26 @@ config JFFS2_FS_WRITEBUFFER
 	    - NOR flash with transparent ECC
 	    - DataFlash
 
-config JFFS2_FS_WBUF_VERIFY
-	bool "Verify JFFS2 write-buffer reads"
-	depends on JFFS2_FS_WRITEBUFFER
+config JFFS2_FS_WRITE_VERIFY
+	bool "Verify JFFS2 writes"
+	depends on JFFS2_FS
 	default n
 	help
-	  This causes JFFS2 to read back every page written through the
-	  write-buffer, and check for errors.
+	  Read back data immediately after flash writes and compare it
+	  with the in-memory image that was written. This covers both
+	  write-buffer flushes and direct writes to non-writebuffered
+	  devices.
+
+	  This may catch corruption introduced after node CRCs are
+	  calculated but before/while data is transferred to the flash
+	  controller (e.g. RAM or DMA), where mtd_write() may succeed
+	  while the medium does not match what JFFS2 intended.
+
+	  Without an immediate read-back, a later node CRC failure cannot
+	  tell transport/program-time corruption from post-commit media
+	  damage.
+
+	  If unsure, say 'N'.
 
 config JFFS2_SUMMARY
 	bool "JFFS2 summary support"
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index e73ef643fd97..65604a6f8148 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -192,7 +192,7 @@ int jffs2_flash_direct_writev(struct jffs2_sb_info *c, const struct kvec *vecs,
 int jffs2_flash_direct_write(struct jffs2_sb_info *c, loff_t ofs, size_t len,
 			size_t *retlen, const u_char *buf);
 
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
+#ifdef CONFIG_JFFS2_FS_WRITE_VERIFY
 int jffs2_verify_write(struct jffs2_sb_info *c, const unsigned char *buf,
 		       uint32_t ofs, size_t len);
 int jffs2_verify_writev(struct jffs2_sb_info *c,
diff --git a/fs/jffs2/writev.c b/fs/jffs2/writev.c
index e96f10566fe1..604a14bb5710 100644
--- a/fs/jffs2/writev.c
+++ b/fs/jffs2/writev.c
@@ -14,7 +14,7 @@
 #include <linux/mtd/mtd.h>
 #include "nodelist.h"
 
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
+#ifdef CONFIG_JFFS2_FS_WRITE_VERIFY
 int jffs2_verify_write(struct jffs2_sb_info *c, const unsigned char *buf,
 			      uint32_t ofs, size_t len)
 {
@@ -100,7 +100,7 @@ int jffs2_verify_writev(struct jffs2_sb_info *c,
 	}
 	return 0;
 }
-#endif /* CONFIG_JFFS2_FS_WBUF_VERIFY */
+#endif /* CONFIG_JFFS2_FS_WRITE_VERIFY */
 
 int jffs2_flash_direct_writev(struct jffs2_sb_info *c, const struct kvec *vecs,
 			      unsigned long count, loff_t to, size_t *retlen)
-- 
2.52.0



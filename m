Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9973C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:50:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA5820651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA5820651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dyZ86cDMzDqT6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyG010qzDqX9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:29 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id B704329E82; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <5b21de311f1b3b6afae0b7b534ac3de7296ed077.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 18/22] powerpc: Implement nvram ioctls
Date: Tue, 15 Jan 2019 15:18:56 +1100
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

Add the powerpc-specific ioctls to the nvram module. This allows the nvram
module to replace the generic_nvram module.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
On PPC32, the IOC_NVRAM_SYNC ioctl call always returns 0, even for those
platforms that don't implement ppc_md.nvram_sync. This patch retains
that quirk. It may be better to return an error (which is what PPC64 does).

Changed since v8:
 - Changed #else to fully specified #elif conditional.
 - Changed arch_nvram_ops method calls to ppc_md method calls.
---
 drivers/char/nvram.c  | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvram.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index c9e295d73dc5..944f05fddacd 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -48,6 +48,9 @@
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 
+#ifdef CONFIG_PPC
+#include <asm/nvram.h>
+#endif
 
 static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
@@ -283,6 +286,38 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 	long ret = -ENOTTY;
 
 	switch (cmd) {
+#ifdef CONFIG_PPC
+	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
+		pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
+		/* fall through */
+	case IOC_NVRAM_GET_OFFSET:
+		ret = -EINVAL;
+#ifdef CONFIG_PPC_PMAC
+		if (machine_is(powermac)) {
+			int part, offset;
+
+			if (copy_from_user(&part, (void __user *)arg,
+					   sizeof(part)) != 0)
+				return -EFAULT;
+			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
+				return -EINVAL;
+			offset = pmac_get_partition(part);
+			if (copy_to_user((void __user *)arg,
+					 &offset, sizeof(offset)) != 0)
+				return -EFAULT;
+			ret = 0;
+		}
+#endif
+		break;
+	case IOC_NVRAM_SYNC:
+		if (ppc_md.nvram_sync != NULL) {
+			mutex_lock(&nvram_mutex);
+			ppc_md.nvram_sync();
+			mutex_unlock(&nvram_mutex);
+		}
+		ret = 0;
+		break;
+#elif defined(CONFIG_X86) || defined(CONFIG_M68K)
 	case NVRAM_INIT:
 		/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
@@ -306,6 +341,7 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&nvram_mutex);
 		}
 		break;
+#endif /* CONFIG_X86 || CONFIG_M68K */
 	}
 	return ret;
 }
@@ -321,12 +357,14 @@ static int nvram_misc_open(struct inode *inode, struct file *file)
 		return -EBUSY;
 	}
 
+#if defined(CONFIG_X86) || defined(CONFIG_M68K)
 	/* Prevent multiple writers if the set_checksum ioctl is implemented. */
 	if ((arch_nvram_ops.set_checksum != NULL) &&
 	    (file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE)) {
 		spin_unlock(&nvram_state_lock);
 		return -EBUSY;
 	}
+#endif
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 9df85703735c..9e3a957c8f1f 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -31,8 +31,10 @@ struct nvram_ops {
 	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*read)(char *, size_t, loff_t *);
 	ssize_t         (*write)(char *, size_t, loff_t *);
+#if defined(CONFIG_X86) || defined(CONFIG_M68K)
 	long            (*initialize)(void);
 	long            (*set_checksum)(void);
+#endif
 };
 
 extern const struct nvram_ops arch_nvram_ops;
-- 
2.19.2


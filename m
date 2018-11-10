Return-Path: <SRS0=qQPY=NV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A0C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 00:37:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D1C206BA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 00:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Z4dx80CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D1C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42sJ5G564FzF3gS
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 11:37:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Z4dx80CN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="Z4dx80CN"; dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42sJ2T1bJRzF3ZX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 11:35:12 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id i26so2599968lfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 16:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XMRV2yGipuBF9ApADA+TXAr8hu/aCqxWcuczhrEuTnk=;
 b=Z4dx80CNV7E4GV/lLdbydT/nIWvd9Zc+mmVKg0sMlYVMm0FffmwURbPkGRHkSDGJUr
 1BTkdAeG7rxl4j98rnEOmHHTyXgH2xMP9WgT/n8tZZQ+j/Aq5FWakt+IYXQio1ZceBlV
 Y5V46rf3LmLN/a6jW3glIBRAPyJj/FjnhvAEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XMRV2yGipuBF9ApADA+TXAr8hu/aCqxWcuczhrEuTnk=;
 b=tRS20O4cL9YNny1NFhSdrVdvCjydXB41GXM9ywgHJtYTRPffJL++p8cE82QefaqBw7
 hk8fX+9UKiHfOqiDm7iPNMPXi8hLDqmHtNCzt5g9TRB0lqCSt791XAJpH6ltWd6YHeG/
 WemvYqsyoKFLuam3hLa+ywFKGfXxuZ2TXO9vxsRGCgwYFmb4K3xr4XBvEaRASWW3pGyt
 ao6O6jRaoKsMBmufvlOduBuaZQz0yepU9Ym8YAutsjV7LuQks2mm4yN+ZZiRv+Q6BKwZ
 LhBQzCeBmKQ5mXuGDnfeAuYgyIbnc7WC/P0sI3x6fPhiNqAFtHpxzTR7MnCS1/LHRadY
 6xLA==
X-Gm-Message-State: AGRZ1gKFOjI/0FDPVNj5JzcR5JvYp6hQo1IMEz6DVw0hokYhmfQIAWao
 /WCAbf38aG0s8CxwLF1VbNQjPA==
X-Google-Smtp-Source: AJdET5ctlZnHmch8b2GPiHgQc38ggSn+KTAYLMCVUZVmwe+XIhzO8FIS4QxGr4lSjRfOwREtm5Tdpg==
X-Received: by 2002:a19:1365:: with SMTP id j98mr6313453lfi.55.1541810108937; 
 Fri, 09 Nov 2018 16:35:08 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk.
 [5.186.114.252])
 by smtp.gmail.com with ESMTPSA id 26-v6sm2006603lje.18.2018.11.09.16.35.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 09 Nov 2018 16:35:08 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] libfs: make all users of simple_attr_open have the format
 checked
Date: Sat, 10 Nov 2018 01:35:04 +0100
Message-Id: <20181110003504.629-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-fsdevel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Almost all uses of simple_attr_open() happen via macros that do a
__simple_attr_check_format(__fmt, 0ull). One of the few exceptions
actually does not pass a fmt matching an unsigned long long.

So move the check into the call of simple_attr_open() by wrapping it in
a macro of the same name, and fix the powerpc case while at it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/cell/spufs/file.c | 2 +-
 fs/libfs.c                               | 1 +
 include/linux/debugfs.h                  | 1 -
 include/linux/fs.h                       | 6 +++++-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 43e7b93f27c7..b75d70f54f12 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -436,7 +436,7 @@ static int spufs_cntl_open(struct inode *inode, struct file *file)
 		ctx->cntl = inode->i_mapping;
 	mutex_unlock(&ctx->mapping_lock);
 	return simple_attr_open(inode, file, spufs_cntl_get,
-					spufs_cntl_set, "0x%08lx");
+					spufs_cntl_set, "0x%08llx");
 }
 
 static int
diff --git a/fs/libfs.c b/fs/libfs.c
index 0fb590d79f30..327ab701d176 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -792,6 +792,7 @@ struct simple_attr {
 
 /* simple_attr_open is called by an actual attribute open file operation
  * to set the attribute specific access operations. */
+#undef simple_attr_open
 int simple_attr_open(struct inode *inode, struct file *file,
 		     int (*get)(void *, u64 *), int (*set)(void *, u64),
 		     const char *fmt)
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 3b0ba54cc4d5..2ddec401343a 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -42,7 +42,6 @@ extern struct dentry *arch_debugfs_dir;
 #define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt)		\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
-	__simple_attr_check_format(__fmt, 0ull);			\
 	return simple_attr_open(inode, file, __get, __set, __fmt);	\
 }									\
 static const struct file_operations __fops = {				\
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c95c0807471f..cb79b79d2175 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3387,7 +3387,6 @@ void simple_transaction_set(struct file *file, size_t n);
 #define DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)		\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
-	__simple_attr_check_format(__fmt, 0ull);			\
 	return simple_attr_open(inode, file, __get, __set, __fmt);	\
 }									\
 static const struct file_operations __fops = {				\
@@ -3408,6 +3407,11 @@ void __simple_attr_check_format(const char *fmt, ...)
 int simple_attr_open(struct inode *inode, struct file *file,
 		     int (*get)(void *, u64 *), int (*set)(void *, u64),
 		     const char *fmt);
+#define simple_attr_open(inode, file, get, set, fmt) ({	\
+	if (0)						\
+		__simple_attr_check_format(fmt, 0ull);	\
+	simple_attr_open(inode, file, get, set, fmt);	\
+	})
 int simple_attr_release(struct inode *inode, struct file *file);
 ssize_t simple_attr_read(struct file *file, char __user *buf,
 			 size_t len, loff_t *ppos);
-- 
2.19.1.6.gbde171bbf5


Return-Path: <linuxppc-dev+bounces-19170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEFE10F6FDC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:03:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm8sv2yjWz2yqt;
	Thu, 02 Apr 2026 03:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775059411;
	cv=none; b=JekgH+HziJX4KSNsdKtPG5KgbCpQvDTQDpbNohxQOryaMp8y9LhT5AOwH6TLOpwbzYFmGYoAv+ysp9Mojoeb6yCP4AfjlxwIcd9gEF4H0uUK1PMF7cLnuDXuzMSlB6sqiq7XZ+ZtPU0kmjG39xP02QtR7TBDq/P0g64GN9Ry3K/4DP9L92Ikd2ElDzZLn6CB81wt9uu+ix4eKsEi+dR3kp7uU1gQEAfFEOgbuRIs/toKg7/q2UIK2nGQ78XXRbEaHVW2ksfwRX7mWId0T9Ctsmgb4DYQ+fPbFueUvoaGwOxRgNJfzOZswEsbkT9qFb/1+5XqMEoN//uZ5hMGWX+2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775059411; c=relaxed/relaxed;
	bh=QFOjcEuVMKWwzzmomEsQpzbhWwcfdPe+mE1pNR0nVZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIfgpv2TXZaUFc0i0Nl0Xu0TGcjyo+ZUQHLJl2vx+mIT9Alu8FYj/vOvq8KbWT7bgGrTAYKwx+DbB9+AezFgzxgpxOiD3I24FCHaLlTmoVk603VvWdm3ECJe1SqNcfgo42/9Pv3V+6ei4csKiosjDyIAqP7VVLHJoO8QVVKJHuljOkG7zM3/uZq2DDwK4Sfxavyuyjx1SQuVw2gRFGsDf2ug0uNOzQUz55IYdcoUPKloOk7hrII9wTTUD74/47XmCcwljEqR+mmPPghR+JCALsiAqd44Zz/tV6mRLShgotv/XzLA7H4aJFrGy6eS83K9cSv/jL9pp4JUWmvMcVM7Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm8sp6P44z2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 03:03:23 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAC3XWnAQc1pYxThCw--.21090S2;
	Thu, 02 Apr 2026 00:03:13 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	geoff@infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/boot: avoid overflowing the bootwrapper printf buffer with bootargs
Date: Thu,  2 Apr 2026 00:03:12 +0800
Message-ID: <20260401160312.88459-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
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
X-CM-TRANSID:qwCowAC3XWnAQc1pYxThCw--.21090S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw18JFyktF1ruw4UWr4DJwb_yoW5Wry3pw
	4qkFnxJanYk3W5Ja42vFs8uryrZwn7J3srC3yDW3yDZFnxXrZ2qan5Za45t34UJFyrAF10
	vFsIkFyxKF9xCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The bootwrapper printf path formats strings through a fixed 1024-byte
scratch buffer in arch/powerpc/boot/stdio.c.

Both prep_cmdline() in main.c and ps3.c print the full bootargs string
with a %s conversion even though the command line buffer itself is 2048
bytes. A long firmware-provided or built-in command line can therefore
overrun the bootwrapper printf staging buffer while the kernel is still
starting.

Print the command line through console_ops.write() in bounded chunks
instead of passing it to printf() as a single %s argument.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/boot/main.c | 12 +++++++++++-
 arch/powerpc/boot/ps3.c  | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 2c0e2a1cab01..d02f77ad4df7 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -193,6 +193,16 @@ static inline void prep_esm_blob(struct addr_range vmlinux, void *chosen) { }
 static char cmdline[BOOT_COMMAND_LINE_SIZE]
 	__attribute__((__section__("__builtin_cmdline")));
 
+static void print_cmdline(const char *prefix, const char *suffix)
+{
+	size_t len = strnlen(cmdline, BOOT_COMMAND_LINE_SIZE - 1);
+
+	printf("%s", prefix);
+	if (console_ops.write && len)
+		console_ops.write(cmdline, len);
+	printf("%s", suffix);
+}
+
 static void prep_cmdline(void *chosen)
 {
 	unsigned int getline_timeout = 5000;
@@ -207,7 +217,7 @@ static void prep_cmdline(void *chosen)
 	if (cmdline[0] == '\0')
 		getprop(chosen, "bootargs", cmdline, BOOT_COMMAND_LINE_SIZE-1);
 
-	printf("\n\rLinux/PowerPC load: %s", cmdline);
+	print_cmdline("\n\rLinux/PowerPC load: ", "");
 
 	/* If possible, edit the command line */
 	if (console_ops.edit_cmdline && getline_timeout)
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index 89ff46b8b225..2f17b99c713c 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -31,6 +31,16 @@ BSS_STACK(4096);
 static char cmdline[BOOT_COMMAND_LINE_SIZE]
 	__attribute__((__section__("__builtin_cmdline")));
 
+static void print_cmdline(const char *prefix, const char *suffix)
+{
+	size_t len = strnlen(cmdline, BOOT_COMMAND_LINE_SIZE - 1);
+
+	printf("%s", prefix);
+	if (console_ops.write && len)
+		console_ops.write(cmdline, len);
+	printf("%s", suffix);
+}
+
 static void prep_cmdline(void *chosen)
 {
 	if (cmdline[0] == '\0')
@@ -38,7 +48,7 @@ static void prep_cmdline(void *chosen)
 	else
 		setprop_str(chosen, "bootargs", cmdline);
 
-	printf("cmdline: '%s'\n", cmdline);
+	print_cmdline("cmdline: '", "'\n");
 }
 
 static void ps3_console_write(const char *buf, int len)
-- 
2.50.1 (Apple Git-155)



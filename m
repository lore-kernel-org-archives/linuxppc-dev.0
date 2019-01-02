Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE723C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AFA20656
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6LL0kNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AFA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VDtt22fXzDqDP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 02:07:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6LL0kNT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6LL0kNT"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VDmw0LNGzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 02:02:39 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id b7so15287139pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jan 2019 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Eat+r8u+VqdJ2gf8pt6fPlnDCgZGxQ4z1YhcFJx2Y5c=;
 b=A6LL0kNTDc7uhzjcydJoLkqNPWL78vHJ5FoZjsqcv2yeaXsxbH2Ha9pQD2DDJA5sxG
 qxEDwJQjV+Ot4GztgC7y0fOfNyBeaOsCFA1EOCB4jLdQ1xkY558yH5Y9wHTFc1xjBIWD
 3tH4tngZEqEy8CID71SG6KnvwuIBKOwl9Zg5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Eat+r8u+VqdJ2gf8pt6fPlnDCgZGxQ4z1YhcFJx2Y5c=;
 b=oQEKkrlz1/ZLvhhma3XluqPLbwRWOdHv5JZRmjEnWNbjba5fA/9hlBpHqHbo+z2i6+
 LJf9gYgKoUSi00QwhnqyQLkHy8ss1HOj0eIoB1xDJreR+98j7Irbis3VUOLnBST4tih7
 WObc66nlyjtpZXMeVJEycc1HEXfKwZ8U4avl6/0fpwN1E+3LWAn256uZXS4XFjMnaMAO
 eMV4f41f3OxVGNBghOmzLtKEZ967gFrzzD6+I7ADFRnga5J4mQIcJMN6YPeytdgN8e9q
 fkJRVm38W54MS4B/UvotA4M/RdTKAk1udQA4IHi0FVIpAP0EyYpExFmT2aHNiCJXC6XR
 VH2g==
X-Gm-Message-State: AJcUukfHLgWmPqywM+dCEmyXAmqVcI0TcrBwaPn4nCfzlPD2tCoyWSVD
 UrS0L/dPZ0YcOtk8IUsg8fwhlg==
X-Google-Smtp-Source: ALg8bN6fJUR1lVZw7cXCobT9RCVFx5R5C1+/J2rUe/2qe8jqSkWPssMo3yYlyvGezfgi+gT2W5g7eg==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr13295542pge.94.1546441358109; 
 Wed, 02 Jan 2019 07:02:38 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id z14sm66180213pgv.47.2019.01.02.07.02.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 02 Jan 2019 07:02:37 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 1/2] powerpc: remove nargs from __SYSCALL
Date: Wed,  2 Jan 2019 20:32:03 +0530
Message-Id: <1546441324-19774-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
References: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The __SYSCALL macro's arguments are system call number,
system call entry name and number of arguments for the
system call.

Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
calculated nor used anywhere. So it would be better to
keep the implementaion as  __SYSCALL(nr, entry). This will
unifies the implementation with some other architetures
too.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/kernel/syscalls/syscalltbl.sh  | 4 ++--
 arch/powerpc/kernel/systbl.S                | 6 +++---
 arch/powerpc/platforms/cell/spu_callbacks.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
index fd62049..f7393a7 100644
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ b/arch/powerpc/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s,sys_ni_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s,%s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 23265a2..02f28fa 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -25,11 +25,11 @@
 .globl sys_call_table
 sys_call_table:
 #ifdef CONFIG_PPC64
-#define __SYSCALL(nr, entry, nargs) .8byte DOTSYM(entry)
+#define __SYSCALL(nr, entry)	.8byte DOTSYM(entry)
 #include <asm/syscall_table_64.h>
 #undef __SYSCALL
 #else
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 #include <asm/syscall_table_32.h>
 #undef __SYSCALL
 #endif
@@ -38,7 +38,7 @@ sys_call_table:
 .globl compat_sys_call_table
 compat_sys_call_table:
 #define compat_sys_sigsuspend	sys_sigsuspend
-#define __SYSCALL(nr, entry, nargs) .8byte DOTSYM(entry)
+#define __SYSCALL(nr, entry)	.8byte DOTSYM(entry)
 #include <asm/syscall_table_c32.h>
 #undef __SYSCALL
 #endif
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index 125f2a5..b5f35cb 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -34,7 +34,7 @@
  */
 
 static void *spu_syscall_table[] = {
-#define __SYSCALL(nr, entry, nargs) entry,
+#define __SYSCALL(nr, entry)	entry,
 #include <asm/syscall_table_spu.h>
 #undef __SYSCALL
 };
-- 
1.9.1


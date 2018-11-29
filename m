Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA78EC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 04:33:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369882081B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 04:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dw4w+jTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369882081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4354Ql21gBzDqpC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:33:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dw4w+jTE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dw4w+jTE"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4354JG2WkDzDr22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 15:27:58 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id 17so342163pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 20:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XJq1AFUaGxDCB6jFqaj05hzzcUKv19kg30xJpzrgoLo=;
 b=Dw4w+jTE4sHeLHbFY3h8XVpKi3OIVSznCkWDKwpiGYHlzkJKreDJLYtgPydbnATQQv
 qydXXL/H54a76SOH8inBTEx/gd9WTTbN9wU6j1mnRERrsYXrudmaoLihg9uxvYk2Pn5f
 P2928+HzbuFTZvfoT/BuV2wGXyzTRGf6QXVAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XJq1AFUaGxDCB6jFqaj05hzzcUKv19kg30xJpzrgoLo=;
 b=ZmvN0i8dNET1lgBskg6JfthDfekpydITnTVtLhYgtBaCGo3VsVGFzzC2rtrdFtXNqy
 TssfB6YUvQzO/mkd4K9tPBVyVEqmx+CWqHEcEeT1Dechbe9ppOOW7uk96mWCs2a+dnN7
 RFrwpMKyCUZ0/6defsc8tM+jd5WkqGnKm4gU/TtCCmJ+j2nd+09lRyASX/f2zmZzCQ1J
 oQpkkOlqGegXE0aXJf/COskiZOEOd9eEhpWPe2+OPSKOUBEaVPqxcbrAJorpzSBRWUeY
 DL6DfzjCKApkblGLqVeMu/o6QzyZmy2CGixoxBWnoAISCiwFX2WxT0MbEe5s4vtWveK3
 HibQ==
X-Gm-Message-State: AA+aEWYbRs9HiXwUXdHI82Pn0B/XdHlObWdBIBJN4GEP07PfPVJ9vlRc
 ETRaGMVFqNBCoGc7q+59eCbEDv830ZA=
X-Google-Smtp-Source: AFSGD/V6PrHvIlRkpyvYrzQAsI9nx5xntQSkPNk8i3Qz8o777z9I3AiQiy39tAbTNh1b3TgWMRdlMA==
X-Received: by 2002:a63:955a:: with SMTP id t26mr36023391pgn.449.1543465676346; 
 Wed, 28 Nov 2018 20:27:56 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id p2sm770473pfb.28.2018.11.28.20.27.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 28 Nov 2018 20:27:55 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Ram Pai <linuxram@us.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v3 1/4] powerpc: add __NR_syscalls along with NR_syscalls
Date: Thu, 29 Nov 2018 09:56:48 +0530
Message-Id: <1543465611-17122-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
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
Cc: linux-arch@vger.kernel.org, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

NR_syscalls macro holds the number of system call exist
in powerpc architecture. We have to change the value of
NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the number of system call
information. So we have two option to update NR_syscalls
value.

1. Update NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature in above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_syscalls asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/unistd.h      | 3 +--
 arch/powerpc/include/uapi/asm/unistd.h | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index b0de85b..a3c35e6 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -11,8 +11,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		389
+#define NR_syscalls	__NR_syscalls
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d..7195868 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -10,7 +10,6 @@
 #ifndef _UAPI_ASM_POWERPC_UNISTD_H_
 #define _UAPI_ASM_POWERPC_UNISTD_H_
 
-
 #define __NR_restart_syscall	  0
 #define __NR_exit		  1
 #define __NR_fork		  2
@@ -401,4 +400,8 @@
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
 
+#ifdef __KERNEL__
+#define __NR_syscalls		389
+#endif
+
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.9.1


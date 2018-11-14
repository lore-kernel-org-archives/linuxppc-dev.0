Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE6EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 10:10:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F332145D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 10:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrJJrhEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F332145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42w0cs3B1ZzF3SG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 21:10:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NrJJrhEb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="NrJJrhEb"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42w0Sx4vThzF3TQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 21:04:01 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id n10-v6so7136746pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 02:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fBOiHjj1Vb9CM2P9BbAhEtmK+gIGLynoLuGXLaiP/cg=;
 b=NrJJrhEbSERnmq+rxVaUBy/OVX7rGBE4Gde01GM49QoeOfXyZaEWdAZxnSHXkYpBzQ
 rcYdEyz/C4LGFMHKZMcP9o78GWdyQkUrCTEIFfRWVdVpYkNWwtjxcSe4g8mMul+OwoOX
 4KieTnH/cbOq6aDn8FSE2/7dx1hs+yv6Wwuhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fBOiHjj1Vb9CM2P9BbAhEtmK+gIGLynoLuGXLaiP/cg=;
 b=evoe44mHWikWBHGihofJtb24pisFVYhpjUTstqOfvB9p8SgEF287MtWFMsLxn9fo45
 aidblXiMzb3W23wAyXKvUvkOF7qKy1rAHq5Sqb7vIWskISxb9pWf+iO73epcYTdT68uW
 iNNKP7nhb29siXGBpNEFgbFHcQskgncYqF78qS2o5odU9Uv7bz7+PJGYZrnJjxY8TuLy
 xz4UHkY3qRZaLtEYFTuZqi79LspwNeHcGs41KLHMbtIjqA6c3G5Oe/Mglrdfpd0JclVw
 heN5zwxrAvgu+UgGWhpJsa7DL3paw9x/BQ1LHtO3yN1Z/l0F6AuElX7wc573XA9yuknj
 kXEg==
X-Gm-Message-State: AGRZ1gJabP3946sawBPWc2VJFdiKgYawmBo/n4o8bK6foV7PVjbBw4eB
 EdJ1TYL7n80D0sHt9muJHZZfBw==
X-Google-Smtp-Source: AJdET5errrOXabnhrhN0ZzOmW/eV0Uk8AQQALCk7VW0DxRFFgukmiE/nS69/nlq632zwpm9hDV6Aog==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr1118400pgt.137.1542189839712; 
 Wed, 14 Nov 2018 02:03:59 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id g15sm21633873pfj.131.2018.11.14.02.03.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 14 Nov 2018 02:03:59 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Ram Pai <linuxram@us.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v2 2/4] powerpc: move macro definition from asm/systbl.h
Date: Wed, 14 Nov 2018 15:33:16 +0530
Message-Id: <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
References: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
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

Move the macro definition for compat_sys_sigsuspend from
asm/systbl.h to the file which it is getting included.

One of the patch in this patch series is generating uapi
header and syscall table files. In order to come up with
a common implimentation across all architecture, we need
to do this change.

This change will simplify the implementation of system
call table generation script and help to come up a common
implementation across all architecture.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/systbl.h           | 1 -
 arch/powerpc/kernel/systbl.S                | 1 +
 arch/powerpc/kernel/systbl_chk.c            | 1 +
 arch/powerpc/platforms/cell/spu_callbacks.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 01b5171..c4321b9 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -76,7 +76,6 @@
 SYSCALL_SPU(ssetmask)
 SYSCALL_SPU(setreuid)
 SYSCALL_SPU(setregid)
-#define compat_sys_sigsuspend sys_sigsuspend
 SYS32ONLY(sigsuspend)
 SYSX(sys_ni_syscall,compat_sys_sigpending,sys_sigpending)
 SYSCALL_SPU(sethostname)
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 919a327..9ff1913 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -47,4 +47,5 @@
 .globl sys_call_table
 sys_call_table:
 
+#define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
index 4653258..db97da7 100644
--- a/arch/powerpc/kernel/systbl_chk.c
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -56,5 +56,6 @@
 #define getrlimit		ugetrlimit
 
 START_TABLE
+#define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
 END_TABLE NR_syscalls
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index 8ae8620..7517a43 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -47,6 +47,7 @@
 #define COMPAT_SPU_NEW(func)	sys_##func,
 #define SYSX_SPU(f, f3264, f32)	f,
 
+#define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
 };
 
-- 
1.9.1


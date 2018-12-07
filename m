Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DABC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 06:21:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C397D20850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 06:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxOzaXWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C397D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B2R4410KzDrg6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 17:21:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hxOzaXWn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="hxOzaXWn"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B2F12Sc0zDrf6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 17:12:21 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id w73so1409673pfk.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 22:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
 b=hxOzaXWnpR/CWtOGR+Cfrzu5RjQW2/sTKcSx+4jTa2/lG+yOhjzJzEFTVhyv71mMT7
 5TGx5TE+d8IZlCTcGoqQkNgrKVi3G/fGVtE+iGsiKWYet6JfLrBnE9fB2aJfWX+a34QK
 9XJjzVXRnsGz4cUWdIiN1uBX8U7f0x+EYj0jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
 b=I9XotTzx0IkyDerAyG3S140Mu2M8LPEwk6XNeputzkAUrOraY4TOKWBJ54P70iGkGG
 mSVHdULvp7Ee5frru9oqjY6uoKEhOu57NXkyXj2n+NtrrEIZV5hrj0bSabr1kbd/7cFe
 MTCj2lH6cFnVFIjhDr0nuMjM3mfT0XJvorJs4ROgn2DIT6Ha5dBJj8SvyoDOh60Kd6V5
 cnlQ9OFnVXR9OpcV3hJIeAYu1sLd7gMFmbcrIWeUMGED9PL35Ys45zUluL7NW2bcq0qf
 ln4xU3rZrSMdqVE6ofeEc8S1JhPhGB3Z8IvmfnfWtO6vZlclmfwp0qUdm8mwi/FuksQV
 QNVQ==
X-Gm-Message-State: AA+aEWaJLfvj+lQpv9oCCz8br3Uw4m9cIKox/gsVMkDG6JXcdCJwTuNu
 BZEAbBsl7SQ3S4G4OVzgUkHbtqzxnVE=
X-Google-Smtp-Source: AFSGD/Wxxq+0GgsKXcjEEsKDpmADbAPOWkuU8gUE37rYoADE0Tc+SOfiv2oJSfO0yvbOlQbJAKcxvg==
X-Received: by 2002:a62:e201:: with SMTP id a1mr981796pfi.75.1544163139282;
 Thu, 06 Dec 2018 22:12:19 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.25])
 by smtp.gmail.com with ESMTPSA id r4sm5719862pgn.54.2018.12.06.22.12.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 22:12:18 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ram Pai <linuxram@us.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v4 2/5] powerpc: move macro definition from asm/systbl.h
Date: Fri,  7 Dec 2018 11:41:37 +0530
Message-Id: <1544163100-15510-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
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
 arch/powerpc/include/asm/systbl.h | 1 -
 arch/powerpc/kernel/systbl.S      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.9.1


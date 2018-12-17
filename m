Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2280DC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 10:49:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A2920874
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 10:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmXcmuaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A2920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JHw04q3TzDqL4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 21:49:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hmXcmuaD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="hmXcmuaD"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JHky5g34zDqgb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 21:41:30 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id j10so4722795pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 02:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
 b=hmXcmuaDhZ0CcAlynyVIpsXJsLvTnfV0Qt0XU0uZhAH2WL/hrBusGX151JiPMw2ViG
 5/rzLUz41dcdHYEmFfMEmyGe4IAyZIfaLg/JbzndcP+2H1aIEojBM9jvvNVqtbkCCfoM
 0qNn6/c/iJgmb4TgsDVmRR/jyvadAn7lLXmlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
 b=bCXiozRxUJ/V2SKWAwkhHXDhl+kGJdE2KF02kiznbdjXzaOPUTEAHuBeJbyZ009t1t
 dZtUeJbeGmHtil5gJJ9uGHvXtYsYRVw+q5AG9OIJRijp0wnq1gBR7DWplcyY5mqs5e+Y
 otlt54mBoOJJPGpJ9+duZKDHwzohMNy7kk0wGipG3a38SidUx5HBocBat4GdsEAylVDI
 WSwwhFwQzJdavsFK6Li2USpp0Y/KVEdA66fwVzIY3jEK84g0d6TUdrgHgh1k9AsNNiP/
 whvKpCL2/TsmUnUsp+R5SfoLhSnslxEIoK3Uj2M/462/DKz1hppmYOW17HIrz+McI6mn
 DKrg==
X-Gm-Message-State: AA+aEWZersGMhJliGy4Jxn6D6w6dZYfbVH/Uysn/yC1W5irIn3qY4tBQ
 OqN2Zm7AtWH3n1WrWBp816RPwSn/1o0=
X-Google-Smtp-Source: AFSGD/W9a860LsyGGAHNX80o9Wz9NQ2390cYNt81ClIdchniC+cAXy4DvyDCb5I3xZYQ0hdPY0paOA==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr11656442pge.346.1545043288598; 
 Mon, 17 Dec 2018 02:41:28 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id b27sm17224826pfh.113.2018.12.17.02.41.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 02:41:28 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: linuxppc-dev@lists.ozlabs.org, sathnaga@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Ram Pai <linuxram@us.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, Breno Leitao <leitao@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v6 2/5] powerpc: move macro definition from asm/systbl.h
Date: Mon, 17 Dec 2018 16:10:33 +0530
Message-Id: <1545043236-11649-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545043236-11649-1-git-send-email-firoz.khan@linaro.org>
References: <1545043236-11649-1-git-send-email-firoz.khan@linaro.org>
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


Return-Path: <linuxppc-dev+bounces-26902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6744BC79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:53:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgK36NJz2yvv;
	Wed, 09 Sep 2026 18:51:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943901;
	cv=none; b=El3tmOSJ6fc94UnBlT3s1o4tjZ0r2jkAw04fwYj7J5/TtOQ8BjUEsEBkusAR81kxkdZ4sE2RbPRcWfF4C9anVdOeXFY6zugigYc3dn6aGPqMJ/ffF9iHqe6imB0y6vSKDK90PyTVtwxfSHlBK9sIsz/zeSTKn0j2v2qh4zUcvvcvgSdo05ch31oTvWPUKehxYN/bEKOOToe7n993TjPJ/mSxZQZ2SukFgWpr3PDv7BbdN0mMx90GvqCtOvkN4RCaXiVgr+63xnIwN8Y+5DfzDDgoiDlGPQO/eeyBaWqzn81vGMJXOwJccTAv1fNDL9NZ+ffr4mYFZwkExvvyqoB6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943901; c=relaxed/relaxed;
	bh=M2FjQtlKuBRuzu4eO4IKv/TzmPoMG616xBuEpp/c8bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxVDhYVcVFq2GCggqVMwMsSFSL/MCDxvheDh9/IR/dMPuFdhAq8VjCD4szEVUDAVgyXTAJOFadRiUxYdr+KFxt+oTxsjMQDgAZA7z/fnFMkB+LCgv/jdGKbTd/A4zphvaOHjYPAxseDgqWFSjLlGbDrDRecrwCjst/ExCuOCxs1NFAMKqcPh7qPMB7aX0039/upnMHCNVIuFCV1gFEcp4z/rGMsOvcZZzH56JbIeGMbjOFp5LqOXVJngR+hcTFGFZl1jLC+aIiW1e0WfEQtcVzbtZHtSssVVR/fIjVhG/7xln1eg6RsW6BQ5qI7AEUxx0xpuZR1Ran2ABIjXeeXLeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=n2EgP00A; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xg6fz2Oa; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=n2EgP00A;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xg6fz2Oa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvgG14yTz30dM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:38 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2FjQtlKuBRuzu4eO4IKv/TzmPoMG616xBuEpp/c8bc=;
	b=n2EgP00AGy2SQ4LhsPxtPFcrw12hi7WXrNw754S6JRZX1HFzsFe/pseBtP/fjyxUDKlDOn
	/Fr8WjmdlV9A0IGs3lUqPsFYY90n0IUQO5Hj6p21mT64kGEeGvGWuuTZPU5n496dF5M7Ms
	bcj2yDheQqOg+7JhGM0FJ/PojVqBQlQW3GT/MdnO6PBZU8yiPKLKbUCbTSyjQaawwkWvOc
	ntK+a7n4xZNVoAH7QQ2Ttqq2cchue1vDh0sAmhWeszDfCSPhAGfnZTc/nOs1yEvWMAnfNq
	/wvAMUyqxwWoNSKxuUocyo7gSfJX3HzwHWhwoB/5kRRfZSdUz+uRcSaJSayGqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2FjQtlKuBRuzu4eO4IKv/TzmPoMG616xBuEpp/c8bc=;
	b=xg6fz2OaJ/Xk4FVyNOThVXZ9GzDXOqKv0ZM2svim1anJaDd8tHxGt6Dcu201EiLHS+ELJL
	/Qm97XTr0L3JARCQ==
Date: Wed, 09 Sep 2026 10:51:28 +0200
Subject: [PATCH 15/15] vdso: Remove __ASSEMBLER__ guards from vsyscall.h
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-15-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1972;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=C6Fh+EQTCyl+s4g26T56GGCWX2U0MtHr/51cTDgzY94=;
 b=/pF3AoTQzmD4pEP7pZqPjpk1T5eSdh8cNjifxUmXeKgAF4pL9mdehQYC/Qro0bgZ/bG3BCQbX
 AwbkyNhcCofDs37bRkBnMPJkPmAKCpz/Hs/RJAXHs0uvQGQmO5ufIiW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These headers are only used from regular C code.

Remove the unnecessary guards.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/include/asm/vdso/vsyscall.h   | 4 ----
 arch/arm64/include/asm/vdso/vsyscall.h | 4 ----
 include/vdso/vsyscall.h                | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index 14f2ea9d8640..b97dda100e52 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
-
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
 
@@ -14,6 +12,4 @@ void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 }
 #define __arch_sync_vdso_time_data __arch_sync_vdso_time_data
 
-#endif /* !__ASSEMBLY__ */
-
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index 7d9d6bdd58b2..7c46c37fd36f 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLER__
-
 #include <vdso/datapage.h>
 
 #define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
@@ -19,6 +17,4 @@ void __arch_update_vdso_clock(struct vdso_clock *vc)
 }
 #define __arch_update_vdso_clock __arch_update_vdso_clock
 
-#endif /* !__ASSEMBLER__ */
-
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index 29dd4e097220..af62bbf04eac 100644
--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -2,10 +2,6 @@
 #ifndef __VDSO_VSYSCALL_H
 #define __VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLER__
-
 #include <asm/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLER__ */
-
 #endif /* __VDSO_VSYSCALL_H */

-- 
2.55.0



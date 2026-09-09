Return-Path: <linuxppc-dev+bounces-26893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A20C79FBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:52:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvgB09PHz2yw7;
	Wed, 09 Sep 2026 18:51:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788943893;
	cv=none; b=Cm+eR4omejW9BlK8/FPCYSskfEwXDOafn7uwbIepJOZivpYXuF+cIoXSQXofTCMm7dQ/9Yu09fs8mR9g5lEPm2wfW/r3nU6m4nOFI9VESvrF5RpEn6Vb59ywCxY6wXGE3HKlCy+yzxwdXhts7G1o9NZFbHKeuC4by3GAz1Ob8xSVa82IyNURlT/DbYO0Ki88ztImc0epwmhJ6NwGIuSjgx8Yl1e/MI4mTov84vA/DlxPfUEUfObtefroOVBc3M/cxtX5XYcb1lKkCtRwzT1aXpqDKs4QqzvqGtbiKFxkRXWmZ6wIboTV12wrkpZ3lnMWWbXCPpkznV9CHGX/0J+dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788943893; c=relaxed/relaxed;
	bh=Q2Fb4eCjj+zAUQPiYalGdgIWLIgi0C9tMG4Wk6//rL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrIEvG7TY2a+FchfV+xGJz3tH4T9KnOBV3FNLqY0Nb2ljP3MBxA4ywLvGbrubOER1MHyMYJR7iapgjxV1z0j+7UDqcZXO5TsL6TtZFEpnKKPEp+Ut3T9NDlxCRL2h4rpSkZA2Vymv4d0UV0Yj/O8wNsMFWO9WxGvGNt0f2Ed09RMDhQfT0y+W7p//Nhvjkty8tjSSFhg9M9dlRhgy7+4jaAEkuDgxlodRPiGF7ZaQBxMrCCEAOxX/uP+Tp9WuRDp2P1dtfT6JxNf70wRTzSIjFJa2nbxOmCKqOp5O/e1HFaKuUWwfpAEWqqzgiVE6UaZ73pSsayZxvmjymulntnp7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eqP8ughI; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jVX4AN8O; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eqP8ughI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jVX4AN8O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvg84Pv2z2yvH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:51:32 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Fb4eCjj+zAUQPiYalGdgIWLIgi0C9tMG4Wk6//rL0=;
	b=eqP8ughIWhO/zWHJqIcpnE1zH5Z6Uff68ylB3fNburq8lG10nepXJX4mazfWoFN07g/dX7
	5wWpfbwXq9syptiaqVr3s9+qB4IaIQrVCTAykoJ3QyyS89SBjIELA0HirxAHeEao/1LMrn
	mYJ99pvmZ+Cf8lKwtDGgAIK2wgT6AyFSHcC68XUyJBj3+gzEtXFKKntUgyQqG8N1vRRiPb
	DHx18kQ5moP+Qf8QI/7uM00WxhtbVuhIFqEZJMDAJy9seLj+k7Uvfcn2IZ5FrBhRjdrWpp
	6RfkROg5QYm6c7U22E17G5cR6V1fJGvzVdEn0cSjxT4h2w+oBW9Z6HQZd5kfkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Fb4eCjj+zAUQPiYalGdgIWLIgi0C9tMG4Wk6//rL0=;
	b=jVX4AN8Oo8E9jDY7LdgbDqTks4Y9ztR5jIkatGeWIeYHKeeAd8NyDi0CnbjzwTRgsKH/kz
	dZEpI1oJQvAAeWCQ==
Date: Wed, 09 Sep 2026 10:51:19 +0200
Subject: [PATCH 06/15] x86/vdso: Move vDSO page definitions to asm/vdso.h
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
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-6-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1480;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9yrup1COiXMcfGgNW5FQUG/LXYB+NuTSGZ1TprnDeUQ=;
 b=8lsoI5rYTpgQdz12XqHek0bQOa8lDAtlAIBJKnJGQxBA5RZp/X59vjJa3XzdUUOBGktVHG8Xt
 hROTC4EoOEOABpAp1sl+WEhhmKISJWSG/lG/6la5vX3KZWy9RTginJR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Most architectures define the vDSO page macros in asm/vdso.h.

Align the x86 headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/include/asm/vdso.h          | 7 +++++++
 arch/x86/include/asm/vdso/vsyscall.h | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 4e735158c1b2..071e4a262b50 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -6,6 +6,13 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+#define __VDSO_PAGES	6
+
+#define VDSO_NR_VCLOCK_PAGES	2
+#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VDSO_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE)
+#define VDSO_PAGE_PVCLOCK_OFFSET	0
+#define VDSO_PAGE_HVCLOCK_OFFSET	1
+
 #ifndef __ASSEMBLER__
 
 #include <linux/mm_types.h>
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 57598db8763b..65d10f4cc718 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,13 +2,6 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#define __VDSO_PAGES	6
-
-#define VDSO_NR_VCLOCK_PAGES	2
-#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VDSO_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE)
-#define VDSO_PAGE_PVCLOCK_OFFSET	0
-#define VDSO_PAGE_HVCLOCK_OFFSET	1
-
 #ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>

-- 
2.55.0



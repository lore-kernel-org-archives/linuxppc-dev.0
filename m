Return-Path: <linuxppc-dev+bounces-17340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469C6FD9E34
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:45:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2Y2XDyz3cFq;
	Fri, 27 Feb 2026 17:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174693;
	cv=none; b=KZ+l1bDhUjks7kkf02tGV28jz9h+DJOOAWkuxBVl3HjWUl0B7lLrYmWpPFj6eZ1bapmI1Xxxd+CKVnc183WWBDPi+GB5viO7TRbYOK8BgaEJs6JVojPhysrpcHwYMYjrinqzf8w1OSDrGTIxzkILJvj6s8GigEoTy+hQat9Rr441TozNkbZvWfAPJc/InTp4nTXiL0Iwr1v0w6O+HPpk07bCXvMttF420vewJi6ao8b9t+4fvlSgmpYsyMDELzC31qhT7YA64atiwypFU6CKgPNg3ZsJyxfVli16fG3csieLQu5LKyTTRyR+JTX7bTK/tfNqce8xfSxmzGo+3jHkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174693; c=relaxed/relaxed;
	bh=EdFmvezM/13UIBOLqXgkSN+e2a31t12dc0rZR5hjhsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmmZ69gJx0fk1y0rXyxXRKmB4mF+9UScfkY9kEdPMcYyE1I4Y11XLMc38H2Nes2uQdwtWQCR4lw/5UAIT/olybH9qHF7IZ2poKgJ0MA2lJpW4hYawdtdJs1dGSl/syNA1SRreSR4xp99zH/EDSvYlkQdj6xNPTR9HXpwpKWeBK1N/VV1/OQwTgIVssUB4p+DrhCMBVAdbMOkmKviADQja1ShO4U0NQjVdSQku9GIwherkyxfQKxjyp+oXPNpEplgrMRzQQ6ZpIC6sFfrHOKQSJwNihSk+UeDF6UjrngjlN8zNBIeKpCEbRaoO/msicaDhGnKPb81ilHLjOr1/kQocg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=guerkA1Y; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=G6YAL9w5; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=guerkA1Y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=G6YAL9w5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2X5B8gz3cCx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:52 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdFmvezM/13UIBOLqXgkSN+e2a31t12dc0rZR5hjhsY=;
	b=guerkA1YpVG/5ursk9ictXBkrOLUMELSSFYdzfIgzPv24IBuzqV/7wSr6LdLb9JYULTYH8
	dxg4NGR/6WwGdzMw7x315is1hHEdPwGCRT+RigrCiJM8G+wGwMRsqvUjofLAPSSvxvGM0k
	Xs6pJhmYZkiSe7QKqib2OHT0y9E5PjUIyLRVExT8biNiErdN4Uw8GDxoBo/GS1Cx+T5hGe
	V15bDVIbrlwV/AA/8xxHfKCcUmze1+PCsIb0VJJsP1fEcwLUVbM2/ZrcrGaDIDPpk3yH8G
	SzFEq+99OudB8AxOw8z8p12MvcBZj6TWNcPo1wXOuPp2GiFtFe6E+VJPsjzsQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdFmvezM/13UIBOLqXgkSN+e2a31t12dc0rZR5hjhsY=;
	b=G6YAL9w5VJlvv6SIhTbu4Ko1jVx8II4adcQjHgTqP1AVdKPNXJ9EYWoYeJJESJU2w7+TRn
	xkmQHK/gWn5P1HAg==
Date: Fri, 27 Feb 2026 07:44:32 +0100
Subject: [PATCH v2 06/15] LoongArch: vDSO: Explicitly include
 asm/vdso/vdso.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-6-35d60acf7410@linutronix.de>
References: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
In-Reply-To: <20260227-vdso-header-cleanups-v2-0-35d60acf7410@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=1174;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VlobGs7YuJXZk2xwqXObxL44WjrcbSo2bt+/5ArFOMQ=;
 b=YdBHCMUo5DusjEOI4DV+0CTXJaCByr5krSoSQmpxScBLGKDg6mJmHX1d9paPZgVzpjmDM7K0h
 hnUOJW/a1xgBAzNcJyvU1/HV/dCuKogllRNecIi2DdX3xnqN10Ev6BB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of 'struct old_timespec32' requires asm/vdso/vdso.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/kernel/process.c | 1 +
 arch/loongarch/kernel/vdso.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 4ac1c3086152..ac3a0baa5d00 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/unwind.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vdso.h>
 
 #ifdef CONFIG_STACKPROTECTOR
 #include <linux/stackprotector.h>
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 0aa10cadb959..8ce8159c10b9 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -18,6 +18,7 @@
 
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 #include <vdso/datapage.h>

-- 
2.53.0



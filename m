Return-Path: <linuxppc-dev+bounces-17347-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EF6FD460C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:46:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf2c1tyVz3cMX;
	Fri, 27 Feb 2026 17:44:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174696;
	cv=none; b=R5qfgfBii/9+IdOV+aRNyt5SXngg+k+V2+54Sq5UeZfI2nl2KB6q56s9020+MwFU6zMXvSKJGM1Rhd2OoniIBg9ebYCAZHYBmJwwEvHCiNjZrhmpALvbP9ugEqSXThkkBY4I+W8X8VoMYqgSO0XvPBJHW39tij1AqM+ytiPduiUlxUGKwN6zc9NwcDUoI42RchlQDXtRkNCcWDSVkcL94HieFoUVsM1nhXeUG1kSOWNo7ASMye7oYKNxvdb9TsSk5eqsryCBSuxFBfCzsu8j2c/xMmjhkus9c+qa3buVVsO2h0xH1Azas4D/5pZ4mFna+J74kFZMtIfY8z6u5zAhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174696; c=relaxed/relaxed;
	bh=pSXoXgD5yJIajfhr67akWUt2bY9n+zCrk3h+dssSjCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUm4nz1RKOGxtCDNdWJr6GitFjxLNb7XNCAVA5xa5vBS2QJ2c0oSO2TqUsN7ZotqaCl2Xz2GGvX/nSjiUBVNs5h8oKNi44A/QM8sLxs87rQTiOU9vFx4tCWHf6Nw1ph4a5qSELCJTEOfU1cqEk7bNii57jDThldnThFG8N7ewGwyjtjvM0/TQbupOZtcybQwi97FK1dPF3jkukQFrL5k/u60UYaE/U1X9XUko0RyY3RBepGZvwmemVPi6dAHBMK6adaLwQGS/PfVnxGoPU3mRTl1yRKLGnRpLAwvDo2CWklRZUzG/WG8Ec8nfpKYDpYeEleY9Uwa210W9p6axFqL9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gPO8bsbX; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0rOwespI; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gPO8bsbX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0rOwespI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf2b4fjCz3cLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:44:55 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772174684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSXoXgD5yJIajfhr67akWUt2bY9n+zCrk3h+dssSjCs=;
	b=gPO8bsbX2j5pl3+0WQBzSu5zAII6ivXIaw3RktNv3T1snJK//8ViSgk/FSVD2hDd9j9ysr
	B1bxTes2qn5R8L8xhfroQPEX0VodOvldUO+LVdBsZicSmZa12+RGDjsLD9JPo958FuRs4y
	6M6W0ge8+QlTDN2RH6H9ukvja4fuMAzRy26PjhpXHIbaLdNp18SeKsmRGreMp8iDrjtZ36
	6i05guUb3fVT412K/F0xnCSROVcDIJTmtb7cUtBQ8StdKxS1XL7cjPhG66PITQLrTgyKJF
	tguXygrmdxrfub6WJZgsrnnzewChBThOMRXJldwUCXzPOA5Ug8ESwSGC1NaunA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772174684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSXoXgD5yJIajfhr67akWUt2bY9n+zCrk3h+dssSjCs=;
	b=0rOwespIHMPRabYF7luWoTUNp23NVUZgYhbSHbaf/sHV/Zu6ERaXcTcrIs+1kdBlWfCM6b
	VfBKdZcuOKz/V4Cg==
Date: Fri, 27 Feb 2026 07:44:30 +0100
Subject: [PATCH v2 04/15] powerpc/vdso/gettimeofday: Explicitly include
 vdso/time32.h
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
Message-Id: <20260227-vdso-header-cleanups-v2-4-35d60acf7410@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Christophe Leroy <chleroy@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174681; l=856;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZA1UJGWYD01ZyfFBKenlmw61nBxgQh2zO5BzGQCW3/I=;
 b=1TEGpURP99ld8FLPX/3v0rsq45TqqBc12m+p2OErKaencbWyxel0L2MdRiIfvqBXpvSVx4KLS
 hm7MSWrtG0yBi015CNXoPonMQtaW526wKMGNITtIy89L9oupjEmAtlG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of 'struct old_timespec32' requires vdso/time32.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 8ea397e26ad0..a853f853da6c 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -8,6 +8,7 @@
 #include <asm/barrier.h>
 #include <asm/unistd.h>
 #include <uapi/linux/time.h>
+#include <vdso/time32.h>
 
 #define VDSO_HAS_CLOCK_GETRES		1
 

-- 
2.53.0



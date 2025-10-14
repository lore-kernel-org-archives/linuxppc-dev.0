Return-Path: <linuxppc-dev+bounces-12857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890FDCCD184
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:06:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmDx472szz3cjf;
	Wed, 15 Oct 2025 00:06:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760447160;
	cv=none; b=fYkyQYHtFB5BW8duN7xEVh/9b/B1yBppeKfrfc69sMtwyER87rhMyq9wwd29FbOSrLjuk05s6Pgf4gAUK9f5KpyzTgyiyNAkvjFV0A5NamIRjqPa5aLCF09kqM9rale94VwdwRJReFCgMQvcV3dLjhWBx7reBXYq/l8UqKas6iDQlUS5mS9OxG8/aimjcu2tdgFDI5beE6/RwhTZBrC1WuhGeAnspkGT7OjGgdecKGshRGKIzia8JYTuEzHWEy7bm3QKSe6RuFrwpM6xbUWtA45TLG+ytb4Z3aoyvkfLr6ISehb4X6T0otqWffuiZ/HuzFK2jCyF5kzSOfj0iFzFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760447160; c=relaxed/relaxed;
	bh=0CYU5O26JQub+yqWqbpQg+oK8k+3uTAokj7TeaLTkvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2IMCdV9Aw6h7YFcdu9t27AhpP52x06eMhTHtfChibnoU+rVM8LJ1yIiWAPs/jy4kewfR6CtPozpp3244w6T8xKxMNNraLR6uhZrza5PwzuB7n/aCpNTFZGxTlzL0R7iIWIHHR2XHqU+abHTWel8N+Jaad16lF6so6tQ6NZrIW5bcqfZLZDUwITUHWkwyymG4elUsJQa7bcrqlNWwomb69LteQ/UZ+8UNJen6MAGAFEJ71c22DWqXI9PP1pg0AJg9vN34Q2eXSRBoM+X3QmjmyWnYBWU2+T74isUoWPUsk1KicPLYCUKjgR8UYa2fnCBei93rxrFYYJV5HHtw8I8Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Cdzz+KJz; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BwzlN2uX; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Cdzz+KJz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BwzlN2uX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4cmDx41YYgz3cjT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2025 00:06:00 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760447153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CYU5O26JQub+yqWqbpQg+oK8k+3uTAokj7TeaLTkvI=;
	b=Cdzz+KJzTSoATXV5Ljvowdfgd+hQ49C2HiCspOUMSbLN4Y/KVwHbpcJlPKJDrYKwBpV1Cl
	nl8yCfx9g0blauWEMvgfadUL1Xs67s2WkQmzFvJzw9Skl6Se6lLax4sHGzAsfb26klKK4r
	1BR7dCS9II5sV9DxZS2LrinYR6AYT+BArKduD/fSTt/Rp2tk85LB4DGeGNLC0+s3ZjHIEu
	COxW7QHALQxTwh7TIVAWN9EATLtrOBhFbB2fenbToNZVXr9gPZ2uc6XeCAsm5sSbnusf+D
	IkBXOvaPA9/tEih0RaZgPFGhQsTs/IhEkpHFcxJdnU0UXlm4UHC30/jqEm0elg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760447153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CYU5O26JQub+yqWqbpQg+oK8k+3uTAokj7TeaLTkvI=;
	b=BwzlN2uXPCg/X47u0Uh4Y8N28ll/JnhCE8duJmS0jRH2zsnGwBT82W4JCx3IH8lzXaM7kD
	xkxDEF1BudBfnOCA==
Date: Tue, 14 Oct 2025 15:05:20 +0200
Subject: [PATCH v2 05/10] s390: Implement custom CC_CAN_LINK
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
Message-Id: <20251014-kbuild-userprogs-bits-v2-5-faeec46e887a@linutronix.de>
References: <20251014-kbuild-userprogs-bits-v2-0-faeec46e887a@linutronix.de>
In-Reply-To: <20251014-kbuild-userprogs-bits-v2-0-faeec46e887a@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Nicolas Schier <nsc@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760447149; l=1192;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=C5yzpCLqrEUvmfCc9tgMT4vkB0PmGsIVmeRJ/wm+ukg=;
 b=6KMNxZohvV8U55EvTgd5gt+n+aQ06tzHiTyepjAkWCXf3bRHfASgeYcybxotqxOnkE219kD9n
 3f3fejzuvHFChDTTBo0UVdS4/IrKpsCny3q6UyLNz4mbPAvOrT8AK4d
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic CC_CAN_LINK detection relies on -m32/-m64 compiler flags.
s390 uses -m31 instead of -m32.

Use architecture-specific logic using -m31/-m64 instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c4145672ca342a656eece10704706d4b12ff9fd6..77ea17537fa2f938aee1fce0053a48853b1ce638 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -82,6 +82,7 @@ config S390
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+	select ARCH_HAS_CC_CAN_LINK
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
@@ -290,6 +291,16 @@ config PGTABLE_LEVELS
 
 source "kernel/livepatch/Kconfig"
 
+config ARCH_CC_CAN_LINK
+	bool
+	default $(cc_can_link_user,-m64) if 64BIT
+	default $(cc_can_link_user,-m31)
+
+config ARCH_USERFLAGS
+	string
+	default "-m64" if 64BIT
+	default "-m31"
+
 config ARCH_SUPPORTS_KEXEC
 	def_bool y
 

-- 
2.51.0



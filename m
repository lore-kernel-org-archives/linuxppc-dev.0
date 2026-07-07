Return-Path: <linuxppc-dev+bounces-23736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376BBC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrLF0RBmz3brH;
	Wed, 08 Jul 2026 05:06:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451189;
	cv=none; b=LtMGZo4i8giUIWlXBmOrqXLmjgwv3WIheYILl1AdOdW8B37U3/NGMcH9B865WZ/exdWFSZjaLKPTkYAl9LjHvKtwCPFW94LIKaM60uGG4fQ4U+ItkU3Acr8W1cr0WE1ki3OhNNFf+pZwCq58h9PR7weg0Wa1y/1RpqLzkRjwijOzsQ7LqRgIbh9atp4iNxN87O43X0qpz0sNpIRB/LSA+PeL5ritE+S+VXbVA7cMDSRJXC1+9fmX5jLB1LcOWVVskTn2UvvXqg3AKo4aVf+UKlx6vsmrg+E+IMR0Hr3Xma3IVHzvmYYb05joSeugPJfUAM4JmKEKQtXsp3WiufOwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451189; c=relaxed/relaxed;
	bh=EqhpiB2ZofNX2Hns8Xgz4OVDOubexQBaPatIimxnT/c=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bz1fBjGJmez/N5SMHJkMqorE6INsxm+CmaNqcTDdAd0pZC4znXbqbe3rVQAFJPfStdgI8SLmt4j/OxUXNo4PDU3Ds8IXKNNLovgXwl2GHkM4xQVOuFkXx5ktF//DYi8+jKdnW4COsFWW91trLXI1BqIhhl1gzmrUKFR6MqkvB+qreDid0x8PsnWyyqSd9xRBcQoZpt2lgJQl699CsPJtIl7/GwU7cPF63iNJ4A94FKeSGTRPwB0WBkTdLm1A5FKEQ4trDY6s8P/5OzoJhq77v5i4rpuIFRm8ZCtfQnIByDxJEcbAzHepnya7LXYuuKdsvTTvXru0WdETsczymQoZcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAQsikH3; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAQsikH3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrLD2xj6z2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8777661385;
	Tue,  7 Jul 2026 19:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC491F000E9;
	Tue,  7 Jul 2026 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451186;
	bh=EqhpiB2ZofNX2Hns8Xgz4OVDOubexQBaPatIimxnT/c=;
	h=Date:From:To:Cc:Subject:References;
	b=OAQsikH32zcXysH6hCjDCdC0GZdQsSYEYwKYLO4211wdV8Gx5U5QTVE1+P//2FXpn
	 uIqA0JY8lGaPQiDHJVOdRGZSp+QbqEjfTrKS3EEXVNmeOvIQBrVQEfC4uIvhb5uzt+
	 eT9i9M6+UlE8GQ+lRJyRHgkq+kITYoE5ZzhOkYUKb2PU4bWHESCf+nr7SFJdz6XhZt
	 2iGqe+3vU4x0dhlP0lRwEovJHlRUe0zFn5tWw2ueZ7uZSvdCbVVh6SrVwQHTuvbp8Z
	 nNfr1ROiFTyIDkK/ZvtATvAtmDATTdK6yv/sLVE04ZyzvrA9oLmxeUKMvdWrrAByna
	 52gUU2XWEgjgQ==
Date: Tue, 07 Jul 2026 21:06:23 +0200
Message-ID: <20260707190254.030598804@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
References: <20260707181957.433213175@kernel.org>
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
Content-Type: text/plain; charset=UTF-8

enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
the subsequent invocation of add_random_kstack_offset_irqsoff().

As a bonus this avoids the overhead of get/put_cpu_var() in
add_random_kstack_offset().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/syscall.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
 {
 	unsigned long nr;
 
-	enter_from_user_mode(regs);
-	add_random_kstack_offset();
+	enter_from_user_mode_randomize_stack(regs);
+
 	regs->psw = get_lowcore()->svc_old_psw;
 	regs->int_code = get_lowcore()->svc_int_code;
 	update_timer_sys();



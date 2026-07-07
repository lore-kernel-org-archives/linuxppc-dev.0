Return-Path: <linuxppc-dev+bounces-23731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60188C44507
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrKr3MHxz3bsj;
	Wed, 08 Jul 2026 05:06:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451168;
	cv=none; b=BdZzsqMPj/gcMZdz3wL/An9HGsq7Ly/NR4jzTlfd4HFcj5UQmtudM972R4dIkHJ4q6GpuSma3ExA8SaWbyhFdLUq/G8oRKNesUnZ9C3bOXtsDL4KUTV2wH2Tj+ah0WEVq958IFJrBRW72SxlQOpb4odYzMOnQXK8wRidR1OfwXp6Ha138EZBCjeGH/l9kTb0s153uim1UHolqexs+ba0aqh0YhpBoLidpYMSCRvGpRFjaTJYl9P+zCB7xYgPo6oy5RACRgvUyyXFIE7dEbkEtU4tNi1qufrsa7F6spBliJUBWrVSn6jVThkNfAUfcLGWUBYNK2/nLLafMTR1uSHIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451168; c=relaxed/relaxed;
	bh=On6NfRZNP83GQAwWkJi2QY5gy7RW6c7PPEtomv7P1Dc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VsDf+RO0F5YqbaApRXXOuB041texjPSnvJVhF8jnbYzb3AwNUAiGg7OcmMZohmysIv1XgrFkDBO4caS/be7bdJUWWh5NiaFhzLRoHtMrXp4Qf6DoaPY/9rFrJZPZbNHuY+L28LyC9qzz19Mf5sH8UOgAIi4gY2jnQYP+avEKBIWXswlNGG+plVJlFNq2yrCZMCspno9LRQMGegQO7Fgwf26H3mOHX2RxZtxk6rVkBcFZH3T+H/GGushZ6lm5AaYft5/r3V3k722rX7OVqKVYGTO5ZCKdI9U8SfJpu3l0KCy2OZ6yP6654otGLXmDWiROCPWRM0SeFIlin2ov5vckVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kyf4FHpF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kyf4FHpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrKq4NN0z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A2DD86138A;
	Tue,  7 Jul 2026 19:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836131F00A3A;
	Tue,  7 Jul 2026 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451165;
	bh=On6NfRZNP83GQAwWkJi2QY5gy7RW6c7PPEtomv7P1Dc=;
	h=Date:From:To:Cc:Subject:References;
	b=Kyf4FHpFsIS+Ydmvpd4dDjaw6LA3z5qA3tk9jQCRiEW5qX1inNO9gy7FOgieh3baY
	 hYOJJlHaPUBmLHJ7GT1+snJJu9GDe/I9LBY8DO5JtbHEjuAUTNBhEUGadk4Jt3mT6M
	 jfM460+qa8cBdINqLxhonst5REsB87hmc78d5eqMEOoD5gBYWK0lJNv1XzAl9UsuvK
	 VcyLhfQ5RZnjt+w12lkO4zxWbhBNKXx+std7IviKWtj5txrPrCsYKXUlRXGm9L5b6C
	 x3lWCb9/6igNz1lMUWNia6Ofl2ESSU4en1Tc99OlWes1QnxVBl0HIc9O5ffHHzCd75
	 Lv0AL/D7KjB7Q==
Date: Tue, 07 Jul 2026 21:06:02 +0200
Message-ID: <20260707190253.768842729@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
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
Subject: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
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

add_random_kstack_offset() uses get/put_cpu_var() which is pointless
overhead when it is invoked from low level entry code with interrupts
disabled.

Provide a irqsoff() variant, which avoids that.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Kees Cook <kees@kernel.org>
---
 include/linux/randomize_kstack.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
 	}								\
 } while (0)
 
+/**
+ * add_random_kstack_offset_irqsoff - Increase stack utilization by a random offset.
+ *
+ * This should be used in the syscall entry path after user registers have been
+ * stored to the stack. Interrupts must be still disabled.
+ */
+#define add_random_kstack_offset_irqsoff()					\
+do {										\
+	lockdep_assert_irqs_disabled();						\
+	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
+				&randomize_kstack_offset)) {			\
+		u32 offset = prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
+		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
+		/* Keep allocation even after "ptr" loses scope. */		\
+		asm volatile("" :: "r"(ptr) : "memory");			\
+	}									\
+} while (0)
+
 #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 #define add_random_kstack_offset()		do { } while (0)
+#define add_random_kstack_offset_irqsoff()	do { } while (0)
 #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 
 #endif



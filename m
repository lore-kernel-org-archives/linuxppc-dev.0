Return-Path: <linuxppc-dev+bounces-13315-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CF5CCF9EB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Oct 2025 08:44:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cw6Vj4d2Xz3dBZ;
	Mon, 27 Oct 2025 19:43:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761554637;
	cv=none; b=EzXYOs6B6g4Zn0/4etK3xxFU32iVlhSXENb8ICxwcQBn90APIGxMn0/WVq4WAqaCLFqNnqRkVQl0DDpn19yLZ3K3Z8vIXqiPQsyIrhHYMnedtdehoiV85i29rT5hCf8MHGzhVpcmYg+a9Zz0OlFtM6YGW+2wh85156UX3KgtSP8fuDY+zbvc0AQPL3nuA9bwHMnaPtxslslAUgFav9V75CD3ZPN2X7Pgh8p+uzwpuZ9MB9mSvvGi7Ca7gv3DLRnQlJ1uHCZwfBpcbukULN3wrJ8nXzZ2mZwxqGVToMU53zQ1JAcBhGItHZmhLg6o1MZ2488T4V6xnnhnCOKT9h+5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761554637; c=relaxed/relaxed;
	bh=Q6hUKo07m0tisXGEHl1vXx2So4mSCWEC1HB29LLd09o=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=aQ/ujeUZc02EV4qS5aWoIBFWykL5sSATbYI/c/UmS405M9CsXxllRhRRy7Ogcs8A4VgcKyiN4MD605eIRIQkpHGp9qp4I7uMZanLFD5yUX0b/hbBX4CWVpDz99OmUjKGRt0KRiiTf/N5fe6hHrwS9yr1qgOFKHw0CQWJS7c7LV5UUAIAxhMYXrInzIECTgRmjZb3iZ/qkHjM5L6B3aw9uMI/lmSBp9H8hQVCBF6t0WEgFtdftKdnaRHEV/BWRSSXfebIyv2joaszcG047xNwnwQG/sGnCZL8GBOl3q14Kfbr3I3rnJjTVAQqnetHakfiS5m7xrUPi+qGtFE53ddcJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gejG86uG; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cWp0c/Y7; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gejG86uG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cWp0c/Y7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cw6Vh2YPjz2yrl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2025 19:43:56 +1100 (AEDT)
Message-ID: <20251027083745.419351819@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q6hUKo07m0tisXGEHl1vXx2So4mSCWEC1HB29LLd09o=;
	b=gejG86uGYkBt6kWWKbtkkSyMBhIL8DMix1IJdC1Rv4n2zeeBoyu48PVGhZVUSHn02j0zdT
	nmQpQtSmY9gZ7ggvnh67Q8n3mXcoapnf9GCM73OSpXBVD22oPU6VOAqFwbhmorvSAMHnrB
	pFIq7EJ8RfZkfAnKdb0+OxNiUSsRkeQeab4bvpXdk82BQLUdBrERKKZ0uiO5fuB1tEj9ov
	+w1HWnCm3PlTeUxvOwVUNopURrTcD6NNQuNGZT6D/lqReqmCXB0Cy0U6g7lA/wcDI1GoOJ
	eBuFmh33SvtZhYmNWbWopURvy96FHOZ+N/ukhFraVnsT7MXVuVZPaDU37taYEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q6hUKo07m0tisXGEHl1vXx2So4mSCWEC1HB29LLd09o=;
	b=cWp0c/Y7PNgdaZpuBpvFN/3v3mB9pcZY8cVBK4GP/w1IMHXEMiwFHPbdgZAayFLqDnHzUj
	V/9jZrSCHbwq1wBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V5 05/12] riscv/uaccess: Use unsafe wrappers for ASM GOTO
References: <20251027083700.573016505@linutronix.de>
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
Date: Mon, 27 Oct 2025 09:43:50 +0100 (CET)

ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:

bool foo(u32 __user *p, u32 val)
{
	scoped_guard(pagefault)
		unsafe_put_user(val, p, efault);
	return true;
efault:
	return false;
}

It ends up leaking the pagefault disable counter in the fault path. clang
at least fails the build.

Rename unsafe_*_user() to arch_unsafe_*_user() which makes the generic
uaccess header wrap it with a local label that makes both compilers emit
correct code. Same for the kernel_nofault() variants.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/uaccess.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -437,10 +437,10 @@ unsigned long __must_check clear_user(vo
 		__clear_user(untagged_addr(to), n) : n;
 }
 
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define arch_get_kernel_nofault(dst, src, type, err_label)			\
 	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
 
-#define __put_kernel_nofault(dst, src, type, err_label)			\
+#define arch_put_kernel_nofault(dst, src, type, err_label)			\
 	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_label)
 
 static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
@@ -460,10 +460,10 @@ static inline void user_access_restore(u
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_put_user(x, ptr, label)					\
+#define arch_unsafe_put_user(x, ptr, label)				\
 	__put_user_nocheck(x, (ptr), label)
 
-#define unsafe_get_user(x, ptr, label)	do {				\
+#define arch_unsafe_get_user(x, ptr, label)	do {			\
 	__inttype(*(ptr)) __gu_val;					\
 	__get_user_nocheck(__gu_val, (ptr), label);			\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\



Return-Path: <linuxppc-dev+bounces-13159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5FECCD1BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Oct 2025 12:50:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs8B62Cgyz3cbF;
	Wed, 22 Oct 2025 23:49:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761137358;
	cv=none; b=ER+qh5cRnG/Fn+O+MP5+yV05rIK7OY/3XMYuEqjh8ZOQIs8MZVeA0zAaafkIpK5/ch44M/+qRq8YkASsK6CE4yAKVZ1eIsdfxIXST0KokVgP6bUGS0+Ke1xtA3UPJpLh07/gosIpbBogTj4lG3W7Abk+303334jYWwALGSkbMKpBvK98r6I5ws5CqJBBBJxESipN+mYlKmbeK6S9eU2D0IiiROee09XIEpOxbFu4Utrkk+039t7cZpxAj55LdxxOY83/GGOR87bP+GYNDS9/1+5TG4bvIHgF049S8NYQtAW8QIyxNgo39o+9cEYtNwhRyMVZBbdna7fuZ0uuDMXM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761137358; c=relaxed/relaxed;
	bh=MKNcUChSn/NfFd+dS8+uLnvvYuPvhQsaUPbuMoERc+Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mdMZXFcT7sAN90sYIy/G7LKRQJBFs1qYVcRIJKb695yz2ou+cgSFIye4nPYVxRQeceUgUxFL2fUeSo5SlF+QXubKBVGt8UjY5HPA2yIl4H5pM2GIRsT8MCAkdPJ9utVF4gTjOtpR00cuVWmNzgePSaEFSebfbIK8Y3gsYBJVYcqL/eeeuGOneVSBrE6Ma6r9Qw6MQKh+wmREfy75YavSMgOVyYmYB09lMRtkARLWcsFc8IzhqjRKcvnHbN44eXlxnrsfo8F0DmkX4Wd0sdXkvX2vSbqShlSKmn1dohhgwwWibC1OPV5RP/J5LDq+BwKPc2XHkrgU5ZhKcsrL0TBWDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=a+rP69sf; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ad5CWnRP; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=a+rP69sf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ad5CWnRP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs8B473D4z3dTv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2025 23:49:16 +1100 (AEDT)
Message-ID: <20251022103112.232389777@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MKNcUChSn/NfFd+dS8+uLnvvYuPvhQsaUPbuMoERc+Y=;
	b=a+rP69sfJ/Qp9q3znoDwceoCND840rG89ZVmZnuwGf5auP3gibFmiK9GeAwPeKlsQPgjSC
	IEqDkhxWDgRylSHXUcBaufuyU0/+DeBR9LE0wMGuAySTKPrhbWb7NBxN01PMlZG65ZnUdx
	9nQhGFU8gZHZZ5xxFRf2aI6pAPw7iR+PiAlFiq3RxntxNFyLAqDnifIWEG+9PAntrrgwZi
	rDCWm4zogflzWQHer9+U8mqmPmY7BGAZCUtifi/nt78sGYZqEj9Hg7TN86VsDKDu39fTHu
	U3CT83eVCk6lxvVN0wBHfNiXmYcrzkHYw44qZOqKRncTZNgK5wwPA+VEwQz9Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MKNcUChSn/NfFd+dS8+uLnvvYuPvhQsaUPbuMoERc+Y=;
	b=Ad5CWnRPgGiAM9amesSMP3EPFCura86UkqdaB4otezD1D4yBpXZCc6MwYvvX+osIXMIhow
	Gu/Agcs2yZ8ttBDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
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
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
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
Subject: [patch V4 06/12] s390/uaccess: Use unsafe wrappers for ASM GOTO
References: <20251022102427.400699796@linutronix.de>
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
Date: Wed, 22 Oct 2025 14:49:09 +0200 (CEST)

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

S390 is not affected for unsafe_*_user() as it uses it's own local label
already, but __get/put_kernel_nofault() lack that.

Rename them to arch_*_kernel_nofault() which makes the generic uaccess
header wrap it with a local label that makes both compilers emit correct
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/uaccess.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -468,8 +468,8 @@ do {									\
 
 #endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT && CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
 
-#define __get_kernel_nofault __mvc_kernel_nofault
-#define __put_kernel_nofault __mvc_kernel_nofault
+#define arch_get_kernel_nofault __mvc_kernel_nofault
+#define arch_put_kernel_nofault __mvc_kernel_nofault
 
 void __cmpxchg_user_key_called_with_bad_pointer(void);
 



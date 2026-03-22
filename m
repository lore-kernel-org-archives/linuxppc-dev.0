Return-Path: <linuxppc-dev+bounces-18558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC59FC72B1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 09:38:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdrpd3yCcz2ySb;
	Sun, 22 Mar 2026 20:38:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774172329;
	cv=none; b=jAT7Xfg6tHSasG0gPh/+L+SZDaAOwQZNEo1gbHtTmNSP0l7Kke54hTSneLiBBGbfswpDsKk1ELMFuk3EJSsAIIQgEWqmQ9Y7AB5Al/fxxz69l+bNB4QgA1Gs51Zr1GSLqwN9dVDhwZxVEUUZ9oh5GDg9GapGVzMgTUzeNb3hOGvPT//2edpBUtWmb58sBVef7zvP9/30PWf5ovAG0E+tAkuvcaLChIwAGHL4R+1rSH6wks+zSxJI2q1rplCKYpKRTX3MvZmNkLVSdwNGkWdLxK3J0wmadviubH2yO1NjVngS6EOkAIyeshh3VQ+g3CJwXtaZZzveWzHgXcEN0CW5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774172329; c=relaxed/relaxed;
	bh=inRszuGMDPbokdk8WPeFph98AU/mrbzn+QpJHysiQQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8wJCRM48g3X14Sw9b2cT7ON2MvElR8a1Be/T4kDgwg9QsS6y5LGUV0nC4YpufJBWWXsSD7CpJdfq55DoOpr3RMwsccOcvKBw53trumdVvrwiJj/cEoR40c+tebq5iLttGRQ6oMWb5m9katdx5I+hR/OnRDVvrOMCjSqeAxnTLezHs7X8KMSzeVCTt7i/uRadYO6mWsI7t2AIJ0ghm3NwAo0rQ7iINXxh2jmNIYH2gjWEJhyeX3lk6ptGGuqT40tstPcCMElUmnDK3tBgS3FLAlPto+0+fd7qguXIK7yUIUeVc8z/Z2Kf5ERN9W0B91m8CN2hOkHtKmmVd1hObo4Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jYYXgK7v; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jYYXgK7v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdrpc2P7Bz2xlr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 20:38:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D3C5600C4;
	Sun, 22 Mar 2026 09:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FF1C19424;
	Sun, 22 Mar 2026 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774172324;
	bh=h/vVWTE8x4d938A4Cntx8lxyGZoYGLz1O5DdZV6trls=;
	h=From:To:Cc:Subject:Date:From;
	b=jYYXgK7vwCxpx4sKMWxgUAMUf30SMdopJ5BQCl0rzR9pg9K+5/M3tUH4pEvxjvp82
	 Strs4+pEz5SSOJv8MURlAZdJVel52S4BqN6NeWOBGOW5YAPw6ce/HPAu6d+qNzg7mV
	 I+P2cylVQ3zs1gPxy0jvPqmvVc4oYYi8JDx+dWeXbm362BGdkOMJpO2tJhcw7LvSGA
	 B+QPYJLZoPUzJxZafkQpqBG6aDZVYRWADjNLXN81toAM21omjjUXG9UurKEUeZ8fbW
	 8JEfb/KkQsqUv+yUfTE47TzJUpnCZ/Y6woEpe0DHwVfr6JSTCpkR84NgAAPXTO952n
	 vA27GJslz6oRg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: Simplify access_ok()
Date: Sun, 22 Mar 2026 10:38:26 +0100
Message-ID: <6b9f8362e68008061828319a78b82279c02e8417.1774172243.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450; i=chleroy@kernel.org; h=from:subject:message-id; bh=h/vVWTE8x4d938A4Cntx8lxyGZoYGLz1O5DdZV6trls=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTu3zG1RVa70iz2sZGl9DSFe3wHj2wqkyp/+Lx9SWdgl PXyztO3OkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEbE4yMmysib3Svitoz+cn NzlCvdKKz/9e9fvEha0f6y6FGExl5EpnZLjdsGfd9ClHNwhsqb54bHZ4nuKKR6aSCg9ZpWo5a43 lL3MDAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

With the implementation of masked user access, we always have a memory
gap between user memory space and kernel memory space, so use it to
simplify access_ok() by relying on access fault in case of an access
in the gap.

Most of the time the size is known at build time.

On powerpc64, the kernel space starts at 0x8000000000000000 which is
always more than two times TASK_USER_MAX so when the size is known at
build time and lower than TASK_USER_MAX, only the address needs to be
verified. If not, a binary or of address and size must be lower than
TASK_USER_MAX. As TASK_USER_MAX is a power of 2, just check that
there is no bit set outside of TASK_USER_MAX - 1 mask.

On powerpc32, there is a garanteed gap of 128KB so when the size is
known at build time and not greater than 128KB, just check that the
address is below TASK_SIZE. Otherwise use the original formula.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
v2: Fix build failure following untested last minute change :(
---
 arch/powerpc/include/asm/uaccess.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 570b3d91e2e4..cb1e7f6a49d2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -15,8 +15,34 @@
 #define TASK_SIZE_MAX		TASK_SIZE_USER64
 #endif
 
+#define __access_ok __access_ok
+
 #include <asm-generic/access_ok.h>
 
+/*
+ * On powerpc64, TASK_SIZE_MAX is 0x0010000000000000 then even if both ptr and size
+ * are TASK_SIZE_MAX we are still inside the memory gap. So make it simple.
+ */
+static __always_inline int __access_ok(const void __user *ptr, unsigned long size)
+{
+	unsigned long addr = (unsigned long)ptr;
+
+	if (IS_ENABLED(CONFIG_PPC64)) {
+		BUILD_BUG_ON(!is_power_of_2(TASK_SIZE_MAX));
+		BUILD_BUG_ON(TASK_SIZE_MAX > 0x0010000000000000);
+
+		if (__builtin_constant_p(size))
+			return size <= TASK_SIZE_MAX && !(addr & ~(TASK_SIZE_MAX - 1));
+		else
+			return !((size | addr) & ~(TASK_SIZE_MAX - 1));
+	} else {
+		if (__builtin_constant_p(size) && size < SZ_128K)
+			return addr < TASK_SIZE;
+		else
+			return size <= TASK_SIZE && addr <= TASK_SIZE - size;
+	}
+}
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
-- 
2.49.0



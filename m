Return-Path: <linuxppc-dev+bounces-20182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73205FF8868
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 17:19:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g49K20tKQz2yvP;
	Tue, 28 Apr 2026 03:19:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777310342;
	cv=none; b=Y8j5jYtklvAV8vCdGEJC8a3WxIUs9YydXvqBjFCYhy/RCVPffU64sMsDUqrF5bvVZ6eiqgV4telb3CLGy56YpvbCHZD54Qhniega1UA0Rr8B0pHKCUTWMGzakmYNRvdcAGVmyVg7kNJ1CEWX9NbK0maYvRnoiY/S1/Mqyf2+aG6nUhTtM0NPdFTLgSwZAgG3c256jjVkwTfNV1/4+3rS+YV8roTBzU3yPTJo6uYj0MxWFL6Zzp7YwJ/SbMfhv2mFKfXo9yE/myN527m/NLO03w0ZuA8Bz3vVcF8i5yA3pg1DnrKvrWbZQ1NCE8pgddX267+vSStDhJQWaBaDxbLDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777310342; c=relaxed/relaxed;
	bh=mhZ9NMxuum/7eEE1gQi0nXMq4NB/M40iUHyNchfsiT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF8sPt2dxd7F3JmsuT0KjllFH4wE2pW8/4o8Pa7ztVGCWPKD7guQy3jBLQhaqM2io6ZfbixkM7Tz3cbAGhnsN+3B9fjP/mJLs/lRLpUXO3x4ULRabBMrqRxZ8/F03LoCy9t5baSEXtJXxIpNYT1gNW+Xg/KijXrXHbFg/kKJLjr0lRW2RhcTYii+nsOIRkJbycU81WMYb5fkwU3oqUVgmCql+tsxAsfuwJeT5uXQKKa7mBdUgolWcSoptV+al4aCpGK6YVT/6Z8Xkqm/kZT+yg9iWDCC1Zrv6r1UDlonlQYKcMla1UMSJll/73P6bDuluQbe1jJ+Yo+zuy7vnyeLqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kdO2kRaq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kdO2kRaq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g49K12GnXz2yqP;
	Tue, 28 Apr 2026 03:19:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9368940C54;
	Mon, 27 Apr 2026 17:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C90C2BCB4;
	Mon, 27 Apr 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310339;
	bh=VVuQn2YnZFi2JH9uh9hmEqXb1BpygsXabSyFGnhBvmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdO2kRaqrKnrRzE/uOUoSc+QuIvBLF9bEcfUYb9jTJLWJk0AT883/0gLUkpYyvhxW
	 JwKLSaa6O8znPG+ygzo4nQLM8J0f65SbAuU342P7t8CFNHOEuyufyC86uU6TKB6BuB
	 gSew3oyOMPJ8ALphDrpzU/JPmVzf88NlkSTCpSsq0dGpC1oXnkppqU6so9I0ayHunG
	 vmD6szQq9NnauXryTPXCD0GLKF95gnwZ47owOPgIM468cdafyYqaGorVn/T0ZUPF41
	 utCUjd396YBehKkYMEmrRy4GP6QkmxuYFD7L2LBro+x9SzGKxh5BvzwrXlX1jpWNJG
	 /RZq8/R9DjgcA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-x25@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
Date: Mon, 27 Apr 2026 19:13:48 +0200
Message-ID: <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390; i=chleroy@kernel.org; h=from:subject:message-id; bh=VVuQn2YnZFi2JH9uh9hmEqXb1BpygsXabSyFGnhBvmI=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxljeGSBfXj99HCNy2WTVFXXC9z/Hmi+//aE1/MbC +50nw1Q6ChlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQAT2djH8D+e3yYgNP/F6xtd z9QNXjIccVycwR574E38S3tWp2uq95Yy/M9xKJ2hYJCUJV9391rVwmlfl7x6GzD19bqwZeyVdgF fZ3MAAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

At the time being, x86 and arm64 are missing unsafe_copy_from_user().

Add it.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..10c458ffa399 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -598,7 +598,7 @@ _label:									\
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_copy_loop(dst, src, len, type, label)				\
+#define unsafe_put_loop(dst, src, len, type, label)				\
 	while (len >= sizeof(type)) {						\
 		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
 		dst += sizeof(type);						\
@@ -611,10 +611,29 @@ do {									\
 	char __user *__ucu_dst = (_dst);				\
 	const char *__ucu_src = (_src);					\
 	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+} while (0)
+
+#define unsafe_get_loop(dst, src, len, type, label)				\
+	while (len >= sizeof(type)) {						\
+		unsafe_get_user(*(type __user *)(src),(type *)(dst),label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_from_user(_dst,_src,_len,label)			\
+do {									\
+	char *__ucu_dst = (_dst);					\
+	const char __user *__ucu_src = (_src);				\
+	size_t __ucu_len = (_len);					\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
2.49.0



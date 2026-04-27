Return-Path: <linuxppc-dev+bounces-20184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1560DFF886D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 17:19:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g49KW5Lz2z2yfK;
	Tue, 28 Apr 2026 03:19:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777310367;
	cv=none; b=jbHDKRLBPKoJY4qBnj5fqkoHBxsc1QrvgR/Ab1Lbj0u9J3Py4JYgO55bha5+4UR5onieMCKaXsH6DUbqscpP1XhpDX1eXa+Yms72J9bsNBUwHelHeO3juX8SFxY6N2CY72tnv8QFzUdcOZ+Q/nzPRmFMjA0IZFYfA/dlngOO8Jl9p5lL/ITc+hs1GMmygvq2gGUptzcrvugcwHElo+VOgcxb4WpyIaWCQQ2D13shQR703TOcs+TljArrXTZPcBq5mwKA/XJC+uCf3qRoZFJJOuH9OcwEGUvGjJS1zBuSgbbP/VscyZSjRcyYHP6bptSRryNqrhQEdMPFnlb5p6S0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777310367; c=relaxed/relaxed;
	bh=h3Z/nVyoovIhD0EOyurWXqapA3Ve0yAERyRow/fU/M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkn1+Byf/cuH7IDCPXFWu+4KtYWFDdDCcao5OLpbBXcRPiSL6i3wF7CRrCy1Nf4S7knfEp86EaJMXbNGHArBmMSlwy8b+IXCKqVrTYpdj8ZDU4faCyDyRLMogKmaHEeV5OfZgMGLmbucgv7uYcCJ/g4lJVLATR9qfyxkiJblNoxgo7vgkvnjvJJZLr+jggwoIoDq485Z0LKyPJNf1lDkVriRrkwsrTfbnuIc3v1z8QHV9mRXR6Yy6tGOlGGIm2o+UzCHm4FXDDnEUmn1famlI6RvENDep7aeqwZlj7pZXFJB/MdPuOjn1hpZ5nmoiP1l0LsXgzX2i63RpczbRfCHLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k8kV5Zhk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k8kV5Zhk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g49KV6gLzz2yFm;
	Tue, 28 Apr 2026 03:19:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 180046024D;
	Mon, 27 Apr 2026 17:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25EEC2BCB7;
	Mon, 27 Apr 2026 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310364;
	bh=xblTv37x9V4gU3cvmA9ILfz6xXNOv0sNe2zU9C6a5nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8kV5Zhk7HZbxy8X7mxqUL5UgTTJPPuuLtSKHKOe5PwbIiNodL9/7ESxRbcOMv4dB
	 NN/pd897F5mMQZv6MW+RM/3mikWvqmJGQCtupbd6YHiobStaCQu79RRkwt3Bs1rL/A
	 WmXtcy3vIzgejB2MGSu6MrKJ33itreKKdFlemNypyCUExoUHGXA1bHbqFqaNX4ujdd
	 iXZiXWTV/w69yfgs2V8e+zdWAilhhtsvDDxzPIT8CbbievjXPmrPwVloE5aoqLKmYP
	 ca2+sf92YJQm2mLHcpyNlGd6mMQP6QhUed6Hx8vk/CloBjO7tSgz4fayv+CeXka+Fz
	 NwGM6tvALNVmQ==
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
Subject: [RFC PATCH v1 9/9] uaccess: Convert small fixed size copy_{to/from}_user() to scoped user access
Date: Mon, 27 Apr 2026 19:13:50 +0200
Message-ID: <8780eb2ef80575931a339e5225bc80eb13e9be6c.1777306795.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638; i=chleroy@kernel.org; h=from:subject:message-id; bh=xblTv37x9V4gU3cvmA9ILfz6xXNOv0sNe2zU9C6a5nw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxlr/n9yu2DE7uwkCZGbl0uCp6Y1JLvZTPpz+P/PY xNqPMoaOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE9HwZ/ns82Ho9PV2Q+7Pp 5fqvs6O/v3YN+3EgL+Wk4b/co1rlkZ8YGVZxmDl7XFiUcmPSTPW14WGSHT6/1u4pcTY2cjD0U7P bzAkA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

copy_{to/from}_user() is a heavy function optimised for copy of large
blocs of memory between user and kernel space.

When the number of bytes to be copied is known at build time and small,
using scoped user access removes the burden of that optimisation.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 include/linux/uaccess.h | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 33b7d0f5f808..3ac544527af2 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -50,6 +50,8 @@
  #define mask_user_address(src) (src)
 #endif
 
+#define SMALL_COPY_USER		64
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
@@ -191,6 +193,9 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 	return res;
 }
 
+static __always_inline __must_check unsigned long
+_small_copy_from_user(void *to, const void __user *from, unsigned long n);
+
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
 
@@ -207,6 +212,9 @@ _inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return n;
 }
 
+static __always_inline __must_check unsigned long
+_small_copy_to_user(void __user *to, const void *from, unsigned long n);
+
 extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
 
@@ -215,6 +223,8 @@ copy_from_user_common(void *to, const void __user *from, unsigned long n, bool p
 {
 	if (!check_copy_size(to, n, false))
 		return n;
+	if (!partial && __builtin_constant_p(n) && n <= SMALL_COPY_USER)
+		return _small_copy_from_user(to, from, n);
 	if (IS_ENABLED(ARCH_WANTS_NOINLINE_COPY_USER))
 		return _copy_from_user(to, from, n);
 	else
@@ -239,6 +249,8 @@ copy_to_user_common(void __user *to, const void *from, unsigned long n, bool par
 	if (!check_copy_size(from, n, true))
 		return n;
 
+	if (!partial && __builtin_constant_p(n) && n <= SMALL_COPY_USER)
+		return _small_copy_to_user(to, from, n);
 	if (IS_ENABLED(ARCH_WANTS_NOINLINE_COPY_USER))
 		return _copy_to_user(to, from, n);
 	else
@@ -838,6 +850,41 @@ for (bool done = false; !done; done = true)					\
 #define scoped_user_rw_access(uptr, elbl)				\
 	scoped_user_rw_access_size(uptr, sizeof(*(uptr)), elbl)
 
+static __always_inline __must_check unsigned long
+_small_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	might_fault();
+	instrument_copy_from_user_before(to, from, n);
+	scoped_user_read_access_size(from, n, failed) {
+		/*
+		 * Ensure that bad access_ok() speculation will not lead
+		 * to nasty side effects *after* the copy is finished:
+		 */
+		if (!can_do_masked_user_access())
+			barrier_nospec();
+		unsafe_copy_from_user(to, from, n, failed);
+	}
+	instrument_copy_from_user_after(to, from, n, 0);
+	return 0;
+failed:
+	instrument_copy_from_user_after(to, from, n, n);
+	return n;
+}
+
+static __always_inline __must_check unsigned long
+_small_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	scoped_user_write_access_size(to, n, failed)
+		unsafe_copy_to_user(to, from, n, failed);
+	return 0;
+failed:
+	return n;
+}
+
 /**
  * get_user_inline - Read user data inlined
  * @val:	The variable to store the value read from user memory
-- 
2.49.0



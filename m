Return-Path: <linuxppc-dev+bounces-20179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A787BFF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 17:18:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g49JD2sKhz2ySY;
	Tue, 28 Apr 2026 03:18:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777310300;
	cv=none; b=UW3IgkDSqVf1za9aVjeAaHIvvXV5QAqbQCpikKNAZI0dQouk2UgeftE4iL9o+TT7+vn3a8GSPGy6DO8d4pVoWBxhGlNlAiyh1pffrhrmRBviS3DoFfwO/fmNptfoamwuJHLBz7jgzyfX4QJDQtYHeIhkOX6KAbANbSjNG8BbB6553Z7j8AInVjfCix9+J4ct9B4+0Ksix/vgZGq6zoPQ0yknxi8XmEjrerSoULYUEi1iR1OAVKSzRLA+xhw8cIs/opSxd29g7wUck6CznFRaoM/mMLyl8WDvvBTxuagl2WGaBnhTssMaE4g+kigXDFm8K7+Z+2SxdYrRv8rR+IPNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777310300; c=relaxed/relaxed;
	bh=sOGbn9OoG8rBGqzI2kLVy+02fyWRJuxPwbq3dZ0vyfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqOan8ZeaoZd5M4lwoXxVZ2cG+jW/zvZj0uocEOZYhTrieAnBRuSlVUhHLprMDy33DlbegatnW5V5gxvxqNPXv9nR2ZE15pZErAxcYBw9QnjfHwI5V3pvqjP5JsECsG4+YPQxlkLR2GaDIa0IeuNK06aqJazuYXt5kz7w/oqwaGGw+IMLKtLgYlnRUg+FsZ1cvANiUMVBSR5d5A9nBq8918al+Fquqcx2kCBoQPvwQb/u6rJR1BDK2rLGG1sJIwfa9brbsnYLWhO+MOaHYMPFskJtLQyQGsj5TZXH+zcBFV+H46GNE5WhobHf+fPslk3W7fne8T8hMUkDXBf3S3TQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JDwlcHyn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JDwlcHyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g49JC3bnCz2y7r;
	Tue, 28 Apr 2026 03:18:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B93C440C2;
	Mon, 27 Apr 2026 17:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C06C2BCF4;
	Mon, 27 Apr 2026 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310297;
	bh=G/2eQ9TI5TAejE5IgsfdvVcfACCawPpecEdM1VXM32k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDwlcHynPBKJgZEQOCWtilxNz5OJTbEC9ImCjJuQT3RnOoZjD4+90hMORF2q1smV0
	 ZZwStmTz2ZWfCFTglmd/E7DTmKQiqUkyq6DoW4QkOcmP8LtfpYhN9V4ZMaLV1xjKUX
	 qf/gxqJdT3gAPMXuYRhHcRDH0KM3YGUgvPXpdKncm5DePPHjb0VOG6buq4s8MreRM+
	 EZo8pRxSQAzQ5kujjD1AkNCv3dgeUm7ZrfC1oOr8cnbPHFYMiYdejiO8B5iigWhrca
	 1OgKQbcauQ7QAB8qeF6Zf8CM71cpuIXWBUm7GSS+m87r+rFbtJTWOdD0Mn8qIs0Vfn
	 3JDYXNLvVgu3g==
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
Subject: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
Date: Mon, 27 Apr 2026 19:13:45 +0200
Message-ID: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=chleroy@kernel.org; h=from:subject:message-id; bh=G/2eQ9TI5TAejE5IgsfdvVcfACCawPpecEdM1VXM32k=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxmjMKmwhcOl/KmCyQK3t3e2vTXauaOc++38fue5J 1/fnLd3d0cpC4MYF4OsmCLL8f/cu2Z0fUnNn7pLH2YOKxPIEAYuTgGYyD5HRoZnIqUtqi/uzJzx /elrrqTduXsuSM05kFXcMu1CQyFnzPFOhv/RJewtZeu89EsObX+ieXizf2Xo8RNCJwMOumbxCC5 Mr+EBAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Today there are approximately 3000 calls for copy_to_user() and
3000 calls to copy_from_user().

The majority of callers of copy_{to/from}_user() don't care about the
return value, they only check whether it is 0 or not, and when it is
not 0 they handle it as a -EACCES.

In order to allow better optimisation of copy_{to/from}_user() when
the size of the copy is known at build time, create new fonctions
named copy_{to/from}_user_partial() to be used by the few callers
that are interested in partial copies and need to now how many
bytes remain at the end of the copy.

For the time being it is just the same as copy_{to/from}_user().

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index bd1201c81d94..2d37173782b3 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -221,6 +221,8 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 		return _inline_copy_from_user(to, from, n);
 }
 
+#define copy_from_user_partial copy_from_user
+
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
@@ -233,6 +235,8 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 		return _inline_copy_to_user(to, from, n);
 }
 
+#define copy_to_user_partial copy_to_user
+
 #ifndef copy_mc_to_kernel
 /*
  * Without arch opt-in this generic copy_mc_to_kernel() will not handle
-- 
2.49.0



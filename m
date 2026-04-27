Return-Path: <linuxppc-dev+bounces-20181-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88D0FF8869
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 17:18:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g49Jm12Mxz2yv2;
	Tue, 28 Apr 2026 03:18:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777310328;
	cv=none; b=gfd94ULmLUwhObIdotg7TFPY0UiSy0EQdRzpiPd8sn8kkEDsnv8hdofyUYtIZ8eYQrbrezGlrdAVmMknLk9uRq0zV8p6i7I+BmEL4kbR9mD7nsfVN34a7ItsCijLdONalb+4b9gd+Ed+QAvLDwV5x9j2n0Z0+XeCl1Iy1nyJ39nPZyO6iu4BbO0dYcNld73bBO6GtbrZ0DX3Q711IY/snTDuuRjMaSTpNk6EXcnw6Ar4HiFpuqZ8T/+/KfAFMRSCwt6CFqqI3+VwboWb6QoZdfgk9nLLoOQi6NQ9BkEcNS13sU4p1PRVQsydtxZADw6y9hz3zdh4MBiEMBcTe/EdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777310328; c=relaxed/relaxed;
	bh=gXNNHxOKJNxC6UbQGAQkWPTYQLhbBO1PUuIbA1i3jbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdX4TkjJkR9+FxON74kpKIaAOhDYxs/wmBihkfQBN9Qgwy/0Kh6d79OGUuzFP+a2C/N/2v6D1ObSSmo+0dr271w9vD5qeQAi859pq77dpNI7rGmQinUWBgQWh0+03PQVBntDCCTARt9eKPm5OTXmu6Vu3GYuAbAui+lUN0BZ8dQG8W0cmpBD9MksO9cWcRK5Lt+t3ADNAKisSrvXduCq2Ln/90S6NpYqK0yo/eiIAMLphhP+mLWt0HjStJcHjE8wIDuCwFA5lXXm7YTNevU7ydojuOIjSPPB0K+Dyx0Yyu5W56/Cn2RCNe/apUNf/R5YNU2K2cOzXyD3Wdc518SNlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YS9v5ort; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YS9v5ort;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g49Jl317Fz2yqP;
	Tue, 28 Apr 2026 03:18:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E16F243CD6;
	Mon, 27 Apr 2026 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5390FC2BCB4;
	Mon, 27 Apr 2026 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310325;
	bh=x+yz+Ptlr8yUKihbRCrYsj2OzN4+HDHdWj3mTkeeywo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YS9v5orti9jIm2coPKy7cH4iQCLjTYOH2T4kGrmAKw1lk2UpD8UcWDut4XHtMo5CX
	 290KHU3PNOVzMmnTKEL1o/OfzgOnzBVsJnbuGicRbc3HqjVsrjLo1DZ4Ncwz6tafWZ
	 SG8/hG1Ct8pUgSHrDrW4chwaJ34uCldA2tlOQo4bI8M4kMxsW5bP0OLNOAC7BeTwPk
	 Mil/pgBJA2/iCGWwmbEh5WNZZrQ4Md/gtqmnREocwFdhobkWjiqhIB30lRO/GV15k3
	 DZOePxOSt4vdcYmGqKSVWX7R1FegGyxqEmqkjMUEcFWkKzHsBpXNo8/6bbP3EGANbq
	 KZwGUUWEURiLg==
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
Subject: [RFC PATCH v1 6/9] uaccess: Change copy_{to/from}_user to return -EFAULT
Date: Mon, 27 Apr 2026 19:13:47 +0200
Message-ID: <1a55107abe15dd78450888e2b5327c3a56af29b7.1777306795.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416; i=chleroy@kernel.org; h=from:subject:message-id; bh=x+yz+Ptlr8yUKihbRCrYsj2OzN4+HDHdWj3mTkeeywo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxkjryH88LzkjscmK202zhcwuOPhcJTlidTVNdtCP 9vs/VPG2lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAm0nCN4b9/yT75hpDtr4zk 9XPfORmtVO2p/XH+8bFg730PPNfMvn6dkWHDjsJSC09Vr9bDobdrxTgfMm1ckveKR+Rkud3skLM HLXgA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Now that copy_{to/from}_user_partial() are used by callers which expect
partial copy with number of not copied bytes as return value, change
copy_{to/from}_user() to return an int, and return -EFAULT when the
copy is not complete.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 include/linux/uaccess.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 2d37173782b3..33b7d0f5f808 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -211,7 +211,7 @@ extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
 
 static __always_inline unsigned long __must_check
-copy_from_user(void *to, const void __user *from, unsigned long n)
+copy_from_user_common(void *to, const void __user *from, unsigned long n, bool partial)
 {
 	if (!check_copy_size(to, n, false))
 		return n;
@@ -221,10 +221,20 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 		return _inline_copy_from_user(to, from, n);
 }
 
-#define copy_from_user_partial copy_from_user
+static __always_inline unsigned long __must_check
+copy_from_user_partial(void *to, const void __user *from, unsigned long n)
+{
+	return copy_from_user_common(to, from, n, true);
+}
+
+static __always_inline int __must_check
+copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return copy_from_user_common(to, from, n, false) ? -EFAULT : 0;
+}
 
 static __always_inline unsigned long __must_check
-copy_to_user(void __user *to, const void *from, unsigned long n)
+copy_to_user_common(void __user *to, const void *from, unsigned long n, bool partial)
 {
 	if (!check_copy_size(from, n, true))
 		return n;
@@ -235,7 +245,17 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 		return _inline_copy_to_user(to, from, n);
 }
 
-#define copy_to_user_partial copy_to_user
+static __always_inline unsigned long __must_check
+copy_to_user_partial(void __user *to, const void *from, unsigned long n)
+{
+	return copy_to_user_common(to, from, n, true);
+}
+
+static __always_inline int __must_check
+copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return copy_to_user_common(to, from, n, false) ? -EFAULT : 0;
+}
 
 #ifndef copy_mc_to_kernel
 /*
-- 
2.49.0



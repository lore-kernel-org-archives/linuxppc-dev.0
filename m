Return-Path: <linuxppc-dev+bounces-20178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760A6FF8869
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 17:18:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g49Hq15ZHz2yhD;
	Tue, 28 Apr 2026 03:17:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777310279;
	cv=none; b=O6+OAnCXk3+FjAeHH30GtHGBT6toUeuKc7l8NGRL7V3M0w2dBxQ0Dm/3CkqzhOTy79Fia7nAL5/Rwuyg1DNgZk6dUVScuti31COCe2JKq9yIwYxo7PcLkffThTOyY1h1dddI+9XE/uAiA7uLqVZD4871LSwPGgyMGoYmPoiks4z2n4c2SO3o2i1fvRyT62ymHan37qDF7NM6M+Q7oEprv0EaXR/8CZe4YrGsK55h5e2eNG7+qaIGQmv0f67yx7IkiTWbPuhX/gEpGrIRo4ggFCbXaOAgGj4bl0qCLbYOOIYuYkx7ZVJNdKawh9UlH55V2mDWmFa3N/2nhx2IxfmjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777310279; c=relaxed/relaxed;
	bh=aMiFQ9YDeWWeAvKmml+uHoGAC+wRXXMneJLs8f7ea2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVnCEzGcn5rcb1oIRXf5MSx1FJ/uzDzpVvKoyrPUB3mw8yywxOeI/agzif+PcnZLR2noIAhezYHiaBv0KI1VrJgxxPuIh7mwpGWnJDArHN7hXIHKuMvCoy/NddqBOZSiHKEf4RNGuIwy+4meFmoWFD+qaAf6dDRXh9u+N9Knknd2ZKBc9nLUwLtCsVSI+BbD9TMJOamZoUXW1BVcZj3SywvGDiW/LL+DReE6uhuLiCcrta08hck4U3rqTLXuN8vHavwyJNaHgvqww4GwVTqW60r938TF+9G4RgE1J7KzvdtsMkkBC8kzuq+7dyqfIb7E1WK5bk1u0tvR467eC4yU+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dWIdgH61; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dWIdgH61;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g49Hp0wFSz2yN8;
	Tue, 28 Apr 2026 03:17:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D6C426024D;
	Mon, 27 Apr 2026 17:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B91DC2BCB9;
	Mon, 27 Apr 2026 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310275;
	bh=W5kkD2qOaf9p6y+JEmiY6YQ2keZoelr0Bif5djAA9uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWIdgH61f3FZjJK5/4M8qA2Z3PdTv2PxzuZWcauBhk9DdVxbBkauIdrH8T66hguCp
	 RKByLYUodinjcBlbYhttuH2LGK1CACi5Chox46drqrLCValqYMs6iS6hvWfa8xjP86
	 SRX8mzMn7HjzzZ5PMWVnIWvrJFLR/iyEIDn4Oi2BFSrDeboqSnIrX7WfhL6Ub+tY2g
	 I0hH+wNzy6c//f0TkDzcuax+fX8WXY8rTh4FJ51XM25PFd/tzjClOdpIOdXk4NjGqA
	 oBIlgUIOAdKFgg5RvdKRR4Lqk1Q+lbng1I1sXXDqtORIX/zFE6g7Yv8vrz97KbzGDV
	 XrdmpG3tF9W3Q==
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
Subject: [RFC PATCH v1 3/9] x86/umip: Be stricter in fixup_umip_exception()
Date: Mon, 27 Apr 2026 19:13:44 +0200
Message-ID: <9e8e43d4f81d8f8b6f68311f1c6f859d718d36e4.1777306795.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=chleroy@kernel.org; h=from:subject:message-id; bh=W5kkD2qOaf9p6y+JEmiY6YQ2keZoelr0Bif5djAA9uo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxnda1Jdur5TX+RgO1P4hHufdruHR358Lz3BYPORx G8pRRuZOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE9kkxMjTtX+zW2RH44ELN UZ/TjtH3Kj+Uzdh01e2y7qEZTgrchx8y/E9kjcpJ3dj/tNZwXUT0XHGmyS9k3dX75mj427u7JaY VMwMA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

fixup_umip_exception() calls copy_to_user() and checks whether
the returned value is strictly positive.

A subsequent patch will change the return of copy_to_user() to
return -EFAULT in case of error.

Change the test to checking that the result is not 0.

At the time being copy_to_user() return an unsigned value so
'strictly positive' is the same as 'not 0'.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/x86/kernel/umip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 3ce99cbcf187..dfff28ea1dea 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -409,7 +409,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 			return false;
 
 		nr_copied = copy_to_user(uaddr, dummy_data, dummy_data_size);
-		if (nr_copied  > 0) {
+		if (nr_copied) {
 			/*
 			 * If copy fails, send a signal and tell caller that
 			 * fault was fixed up.
-- 
2.49.0



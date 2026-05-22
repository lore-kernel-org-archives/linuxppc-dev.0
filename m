Return-Path: <linuxppc-dev+bounces-21384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9F6CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:57:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLKQ4J7gz2yRF;
	Fri, 22 May 2026 19:56:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443818;
	cv=none; b=nUL19JdondNMI8woYAGF47Pq7dKpNpB9W+9MhVVS81UgkV+u9222JRbAqTx8Qu8sBEC9BdvvqrSrujngpwPa5Wnw3waKhHrgGOge8wmMHKjE0SLrBEtMsOB6In2VwxgYF7nYvrcc5NJslZC1Dw3eW0EEN3DLCQcQD0/1S34DO5JhDhhgLsE7T7GlbF4NewqnAqj+tG47y7/6Lq8FVoOgCGROnSt9vbE4XRqXJMCezsXzzAJNlpFXLpZNipjU2CF3FEgnjfzbZQQBVAbC/L6aDnkF+p7n5FCjWOT2VviUNYg38unZe+qwfRPY6X1MeIz+eTv1BduYQmBtahHf74FLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443818; c=relaxed/relaxed;
	bh=KetQGnpihDD2vxXf7LRusXJw3y8BnoktxOIVo1JkiuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da2D/r90SSnYwqsX3oBVyRI42/YsU7WRTCaC11YcJLoCCGXG8Nxdm9lp9lEt/Uc1PHib2pazNMfPRTFM4ejdIZblT2+bZJjVyxSPCW7MumCjl843YnK0Z81xHdkbdF5FjXaBV2Bl81nD07KWLPe6DIJOgDv7wdxuLjHIR4T2u4XyxBabFu+QLvR82ao726CQw0Z3tth1nbFe4k1xiFztmnD55reO0nsaCZmwvYPhlDpNnDV+vmM+yHUwBPhAcjtR3EmVnJq5dRhr21WafAYdAll/1AsYYYF94ORuJNlOZTqN6qVyWmSRpqHaL1HvXtGeubeUDEaNfjew/8m2J+KlTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPWVhxS6; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPWVhxS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLKQ0dDDz3bwF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:56:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B0F543691;
	Fri, 22 May 2026 09:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0141F000E9;
	Fri, 22 May 2026 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443815;
	bh=KetQGnpihDD2vxXf7LRusXJw3y8BnoktxOIVo1JkiuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FPWVhxS6abEj6Wk6gFOxmmr6UOrr890+s7heZe8/fOUS5UVOBRFX97dsWRpgb7YaK
	 rnMYA0kQylA8upBWX0FZvF1tdr8ONj8sJ+ginfH1TRkAfkmnYc2X4wnlMLpcf07R1f
	 3DTfbM24AXKjQ6FoYLsxFPLlgzyyzgQ1Pt+wJv+CO1agEntrgLhgfHwDouGe/pwk6G
	 /E5S7iUP/VXGkGAE1/4m72Yhps6wh+PYkLpHm6Y6FeLniPes3Zesk0K5OatPEX70Io
	 iZkKfq6ylDva5sT2HLA2em2ubKAOcESOa6S/VeKXS8PhvqWTQF+4F4XGgrOJ1DZwfy
	 uLzHNsBIsiruw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 7/8] powerpc/uaccess: Add unsafe_clear_user()
Date: Fri, 22 May 2026 11:56:07 +0200
Message-ID: <f06ab796cc90a74dbf6458723c080f0c86ac191e.1779441786.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779441786.git.chleroy@kernel.org>
References: <cover.1779441786.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=chleroy@kernel.org; h=from:subject:message-id; bh=XuOAOSYDASIkE8k1DcwiObr6/h55lx5h+RiNNYy8aAY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaNjvkJjaz3Dv4lZeb6npj7TCjacndbLNDT2ltjlL2 8MsYGN7RykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZjIWmZGhjPiVwo4Nm99mie/ o+5Dz9dm27sMs17pzNPbkvIq+/mWviJGhoblz8xW5Zs5Ke1ZOD97ysaP1tob1d7/TulLC+ovrPt hyQ4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Implement unsafe_clear_user() for powerpc.
It's a copy/paste of unsafe_copy_to_user() with value 0 as source.

It may be improved in a later patch by using 'dcbz' instruction
to zeroize full cache lines at once.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index e98c628e3899..ef6711d1278b 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -588,6 +588,26 @@ do {									\
 		unsafe_put_user(*(u8*)(_src + _i), (u8 __user *)(_dst + _i), e); \
 } while (0)
 
+#define unsafe_clear_user(d, l, e)					\
+do {									\
+	u8 __user *_dst = (u8 __user *)(d);				\
+	size_t _len = (l);						\
+	int _i;								\
+									\
+	for (_i = 0; _i < (_len & ~(sizeof(u64) - 1)); _i += sizeof(u64)) \
+		unsafe_put_user(0, (u64 __user *)(_dst + _i), e);	\
+	if (_len & 4) {							\
+		unsafe_put_user(0, (u32 __user *)(_dst + _i), e);	\
+		_i += 4;						\
+	}								\
+	if (_len & 2) {							\
+		unsafe_put_user(0, (u16 __user *)(_dst + _i), e);	\
+		_i += 2;						\
+	}								\
+	if (_len & 1)							\
+		unsafe_put_user(0, (u8 __user *)(_dst + _i), e);	\
+} while (0)
+
 #define arch_get_kernel_nofault(dst, src, type, err_label)		\
 	__get_user_size_goto(*((type *)(dst)),				\
 		(__force type __user *)(src), sizeof(type), err_label)
-- 
2.54.0



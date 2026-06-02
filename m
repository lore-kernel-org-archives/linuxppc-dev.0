Return-Path: <linuxppc-dev+bounces-21863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E06CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4Fn4jlYz3btR;
	Tue, 02 Jun 2026 18:47:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390029;
	cv=none; b=CpyCL29pKrC7i6zEF0GQz8PDfMpB4CvfbRpjZLd0a93Z58Jh89+/WSlQcZcivgUriDn/cygMaHaTGF06b9uYRpJEvfHq0c/LwRJiGLf5W1ibqjR2Gsj3t8JZr0CKgUf7FNkYLNQVzUV263qsZd0udVRKXgZ4PImz+KaUqkqFgrJRWUmm/NCC4HeDZJRBor70kBLa+lg4yjepcMSXnmRzfAJ3348PCGOTqwkAXa0EYfaLoDBBCmpyHmrvUCdBAjonJ6z+q6cjn9YDGiBF78Lv+W5VrJjjKJ1hjqcZoG3uA/FruXbGwUnICnHO61wtMWDErL0yIiMcIPUqigmq0hSfog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390029; c=relaxed/relaxed;
	bh=KetQGnpihDD2vxXf7LRusXJw3y8BnoktxOIVo1JkiuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc1cwHcrn5Ft9Pbm7Q4+6sFj2ZZD6q3e8TPjaUlZnyCFzQnK1uc0SbdnYhNoaNF2qFKcwkE+nixVbgA4t5OZ3A8GoAEFJTraayzynryANu5b/yTKShXXvG3iVMsjxwiQwMTNBm0WNDs/q2DKsB86lsyWcB2v5L1cLJeqFF6wZe9XPlN7FkTE62gjVassJyQMZDaoysEk0A4MQrtKJ9lzdVMTfWLJ/7DwKtv1hLnO3hiOWoUANNhjXn5lSU7fTwCFHbx+BdznfpfzGQlgCck0rMs8guLjmbXvRevU1fH55Ktyri4Tv+8EcoX0D/rYPhESi3Z1VbgcRJZRFNAJhhSP6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuD2k+yR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuD2k+yR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4Fn0Chwz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:47:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EFDEA43A21;
	Tue,  2 Jun 2026 08:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111B71F00893;
	Tue,  2 Jun 2026 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390026;
	bh=KetQGnpihDD2vxXf7LRusXJw3y8BnoktxOIVo1JkiuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LuD2k+yRlJPZt8nXdTJbqG6KC2W+Dke3s/q3g84fgMAsgCHOlv/HHiDB548ujh1xr
	 3rVpsuk0GvyWAWOk1iOYj530GpfzudRL9onsjLw10+vrV9bwuUGx6tFgPETvwm16l6
	 J6LwCmDwQmP377adwJWaHunJr4CJ2NIEODTWTLhi0WyCZJQO4HZdUZs64Ecp0LUZIG
	 X/RhL0fNJLePJuEj+zb46h38tCqD1bdbvgxyKalD3XIm+3nGDPrwGLSr24k4zxMR7z
	 ooxRsfSyqGlhWUg22EusR7oTkymzzs/wjfkXcNziWdi54hYfg7zG/T8U6cHr1+yC5Z
	 WnLksJM5+C+qA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 7/8] powerpc/uaccess: Add unsafe_clear_user()
Date: Tue,  2 Jun 2026 10:46:36 +0200
Message-ID: <1a4f0e7ef4d1c6b794fb95cb88c4ce65c1fd5f6a.1780389863.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780389863.git.chleroy@kernel.org>
References: <cover.1780389863.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=chleroy@kernel.org; h=from:subject:message-id; bh=XuOAOSYDASIkE8k1DcwiObr6/h55lx5h+RiNNYy8aAY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzcgLSU9+9t018cOqeqtNJtpPW3UPbtAzu1qw7Vj9M +kX69pSO0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEYlwYGeac+/MiTS3z7rvz Zf2RareFL1vxLLJyOFLGL7khyNxpbQ0jQ//UIxXxF3vYIjd+ehxR9uDMry93Jt9okBH1Y1hw+2j VFQ4A
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



Return-Path: <linuxppc-dev+bounces-17951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05929F3C27D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:01:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVTsr3FWyz3bjb;
	Tue, 10 Mar 2026 21:01:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773136864;
	cv=none; b=aJC2rnTbtB50jeDVvCfOMeOggGkVv5Jxow57ndgARvopGJjbkP/6ZVI9B2LoLIrHKpz7YB3yKhxCfyHV8t5Eh/toJuLpftUYv127JUDSw+w1Dsu/WLMrNvD9rs74dj3M8y92QX3fkIghQqQQiKmFld+xgKItSzvSo9N0KOdFXJagW1bsMROwQzTRxjozWambcOI34+taXIp8PrsSMu0TwsS8jkLaYILCOyMbeaSt/nEIkfFCcoY001R9/ZnnNkoReNKiPX4lwI7Cnm/ZgZxQ3/ZiEAW5zq1P9dKyl5L/6l9swIk6+CmGXtwknyDp+JQBlqiFGg0ptDYPSdPSk1j85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773136864; c=relaxed/relaxed;
	bh=CzI22R+Pt6ETEcMZzxu4jHUNbeIVL6aiazjHiMF53HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xnf/hQudneoBZeYIFJ0pzqNjsAGHQoC+xaeka3skENU8RGGbHmc+gURIM0NcoN9FJSXlIPqcXZaew057QZfIiEMtquCHaIYihkSOE3JensgCPHxrg/Cvhv2cSe4egNnhtDPhljhNgZJyU2KCj41YrDfKq0rhtYT4sPt2tbvnqLYnPVL8g2e8EAiJ4ReSe7IWaO5TU1gVorKxNb2FcUkZK5iyXx9YXl6VrYGxWG6MlGWDmpUAz2T6+ZT78UDfiqe1svycVK+pBABYnSg9+Bdc6pdCn7iMCYUsw0BcC0C0pAzns2E/lFo47eyNnJmSW1sxyvn1MRvDEYGBFJKN9QU3nA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EznNiFNZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EznNiFNZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTsq4Sg6z2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:01:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8C6864435C;
	Tue, 10 Mar 2026 10:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CE7C19423;
	Tue, 10 Mar 2026 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136861;
	bh=yMp5vTyT2e6ZkOlPwYQ0o7+Oylg3y9LZSAfa9XFNRJg=;
	h=From:To:Cc:Subject:Date:From;
	b=EznNiFNZ4phD4Eqz+YA9FN+hZJOYF4tc/OTkLdk/5OYGZUSdNJ62OIANvWoibC2li
	 0QpyNJ4Wyx9H9WsQ5m6P8JKzmFG+ichxhPtjlktmZ6AKPwSr6IZgjYd30N+zUnv3n/
	 P4UsXpAp1jdh9wTDOaMTbg7pSwjoENfQ7Wu1LN5tvkT/Qyq2MppVs6V674cZzAP7Uw
	 T8ltJSFTJIPXJHL5h0MhyUk1ks3LsDW+XTn79jSQHqdC/y09WLYTKRqU6H+IfWnI6a
	 iWckwNyCCp5r7P+3MKx3eGoGirzW8hQGm4j4+LZWTmhRxBnx4ICSCCXruley1J5UwP
	 B7Rl5bOuZtArg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/ptrace: Convert gpr32_set_common_user() to scoped user access
Date: Tue, 10 Mar 2026 11:00:53 +0100
Message-ID: <2409643daab08b4bc07004c2b88f42085d1ef45a.1773136838.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2875; i=chleroy@kernel.org; h=from:subject:message-id; bh=yMp5vTyT2e6ZkOlPwYQ0o7+Oylg3y9LZSAfa9XFNRJg=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSuf33tv1KUVQmDkP3Xii1XXA6r50hpqnWx/HohJZPHk HpP9+CRjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjARWWGGv6KTfl16Hraz/dOp et9Qtp1W8w2vfWfziThz/YzYao2LX/0Z/qmIvKn97HA++8WnSGdFIc59X7lLSu/lfvp5RKAn6pP rfn4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
provides optimised user access by avoiding the cost of access_ok().

Convert gpr32_set_common_user() to scoped user access to benefit
from masked user access.

Scoped user access also make the code simpler.

Also changes label from Efault to efault to avoid checkpatch
complaining about CamelCase.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
This patch applies on top of v7.0-rc3, it requires commit af4e9ef3d784 ("uaccess: Fix scoped_user_read_access() for 'pointer to const'")
---
 arch/powerpc/kernel/ptrace/ptrace-view.c | 64 ++++++++++++------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-view.c b/arch/powerpc/kernel/ptrace/ptrace-view.c
index 0310f9097e39..eb5f2091bb59 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-view.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
@@ -758,38 +758,37 @@ static int gpr32_set_common_user(struct task_struct *target,
 	const void *kbuf = NULL;
 	compat_ulong_t reg;
 
-	if (!user_read_access_begin(u, count))
-		return -EFAULT;
-
-	pos /= sizeof(reg);
-	count /= sizeof(reg);
-
-	for (; count > 0 && pos < PT_MSR; --count) {
-		unsafe_get_user(reg, u++, Efault);
-		regs[pos++] = reg;
-	}
-
-	if (count > 0 && pos == PT_MSR) {
-		unsafe_get_user(reg, u++, Efault);
-		set_user_msr(target, reg);
-		++pos;
-		--count;
-	}
-
-	for (; count > 0 && pos <= PT_MAX_PUT_REG; --count) {
-		unsafe_get_user(reg, u++, Efault);
-		regs[pos++] = reg;
-	}
-	for (; count > 0 && pos < PT_TRAP; --count, ++pos)
-		unsafe_get_user(reg, u++, Efault);
-
-	if (count > 0 && pos == PT_TRAP) {
-		unsafe_get_user(reg, u++, Efault);
-		set_user_trap(target, reg);
-		++pos;
-		--count;
+	scoped_user_read_access_size(ubuf, count, efault) {
+		u = ubuf;
+		pos /= sizeof(reg);
+		count /= sizeof(reg);
+
+		for (; count > 0 && pos < PT_MSR; --count) {
+			unsafe_get_user(reg, u++, efault);
+			regs[pos++] = reg;
+		}
+
+		if (count > 0 && pos == PT_MSR) {
+			unsafe_get_user(reg, u++, efault);
+			set_user_msr(target, reg);
+			++pos;
+			--count;
+		}
+
+		for (; count > 0 && pos <= PT_MAX_PUT_REG; --count) {
+			unsafe_get_user(reg, u++, efault);
+			regs[pos++] = reg;
+		}
+		for (; count > 0 && pos < PT_TRAP; --count, ++pos)
+			unsafe_get_user(reg, u++, efault);
+
+		if (count > 0 && pos == PT_TRAP) {
+			unsafe_get_user(reg, u++, efault);
+			set_user_trap(target, reg);
+			++pos;
+			--count;
+		}
 	}
-	user_read_access_end();
 
 	ubuf = u;
 	pos *= sizeof(reg);
@@ -798,8 +797,7 @@ static int gpr32_set_common_user(struct task_struct *target,
 				  (PT_TRAP + 1) * sizeof(reg), -1);
 	return 0;
 
-Efault:
-	user_read_access_end();
+efault:
 	return -EFAULT;
 }
 
-- 
2.49.0



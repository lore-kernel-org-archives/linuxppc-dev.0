Return-Path: <linuxppc-dev+bounces-17953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A138EA8550
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:03:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVTx10bb8z3bjb;
	Tue, 10 Mar 2026 21:03:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773137029;
	cv=none; b=gk1Gh5QVfrJ59RgdcRprxA3FdSPE14a6qCJO8VMAYvzHcWpfUXHxz9GMKrQnfDt2dA6Iulu1IMSupeFK4sci2ner7uCwstAoI+ugqr7J9sRax/vF8OwgJzQu3bSzh0P7+2R/dujZYAOIv4C5p7XozgYz+Zgk3eCMO7jVzh0hd4Kvc7mpFlucQTPa2w+C/GpQsYmDvSDOOLy07ZH6HZv4ex9nUQ1HP4C07Xg7OzdT++dWyp7GYMYuf5uRlHVl9xV2d/mYMYLbfImIIZMB1MYXQDQplzw3PCB7jdStlYikzFtRYFuYrw286Wz1ZkS2i0ZXIsFJ+wjT3hKfaQAJMDWYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773137029; c=relaxed/relaxed;
	bh=ubZsL8H0mw2KyWB6gbOED7hWXNwW+Vk1d59RI5B7iRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCgq+uKIDk7bs17S6+sylFrXOVeXBh/1a7BAPj67UPss/Zr4eTwBwkut/iHPvr5GEwspm/HPiRKPowM5Blgou9S4r/Jg8CZPddoTJqg+iOP1MDWOa3QEkY0lznxQVK8ndFXdi9Q6kdVEjmp/S1TN/FIwzjVXUaJrUa5op0xiC1+Z9ry84WNBEPrYEsQ7/qlXjhzij81dYRv/e5cCd8s2S8+Q5YWNKYMGftP1g+w8UtRnmLc7jSQIkdLPZvje7udwWhxFFQjPOCB/FKKu0V6dqtn/DGhyY8M5VV3xY0HtW94XW1jYaqUlygANyLuYB6GMlfse2L96wrMbaXYp8KIimQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GtLReCa3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GtLReCa3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTx02WWYz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:03:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F96A4097D;
	Tue, 10 Mar 2026 10:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9961C2BC9E;
	Tue, 10 Mar 2026 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137026;
	bh=5Jo4rw9rp9F1FaFj6exu2xGJSJZ4VFRZvzDid3Jq5C8=;
	h=From:To:Cc:Subject:Date:From;
	b=GtLReCa3moHvOA00ZRBGgPJtQqbGFKeESZdDI6wZX/bSUzn0HlimvmMyoRzmqDMoJ
	 /MkjUTLOpBGQYUHVUTnZcgaSXyIECabCmust34slWwJj2blJmLrGZckzsCMGuPOpi4
	 qLfryCrVgsA21jDhdV4mc8LDrcltV+AfvLuA4aYCSM1M+0R1YmRkhqIMTkiNqyMJRB
	 ILvwlvZgpMtud0SClfNedaxfOlHWrw3maAIZiJq9C9klNbz5HU2PJPaaIBKuHr4mUp
	 SHpzYiMgd52atZsbkyAp8Dd1HzWF8cKmVZ35XP36j4kv06g9HIH9Yyd/mlIGqhQ5T3
	 uAobkQHr63M8A==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/sstep: Convert to scoped user access
Date: Tue, 10 Mar 2026 11:03:41 +0100
Message-ID: <8f2d85bddacff18046096dc255fd94f6a0f8b230.1773137010.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4625; i=chleroy@kernel.org; h=from:subject:message-id; bh=5Jo4rw9rp9F1FaFj6exu2xGJSJZ4VFRZvzDid3Jq5C8=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSuf1PLYiLoMGedcnhEwZWai+dOpduc6f9wzl730Joyo afZm1XjOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEJp1lZDiTvHrX1Ll3y+T3 bJ3xJNb1Y5/G999Jr20Wc3Y9WXbsbVk2I8OK6knNfYelnBntju9K/rvnw/rSvTrHJh7nvBwiwDZ 5oyInAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
provides optimised user access by avoiding the cost of access_ok().

Convert single step emulation functions to scoped user access to
benefit from masked user access.

Scoped user access also make the code simpler.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/lib/sstep.c | 77 +++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ac3ee19531d8..f0d6aa657c1a 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -329,20 +329,17 @@ __read_mem_aligned(unsigned long *dest, unsigned long ea, int nb, struct pt_regs
 static nokprobe_inline int
 read_mem_aligned(unsigned long *dest, unsigned long ea, int nb, struct pt_regs *regs)
 {
-	int err;
+	void __user *uea = (void __user *)ea;
 
 	if (is_kernel_addr(ea))
 		return __read_mem_aligned(dest, ea, nb, regs);
 
-	if (user_read_access_begin((void __user *)ea, nb)) {
-		err = __read_mem_aligned(dest, ea, nb, regs);
-		user_read_access_end();
-	} else {
-		err = -EFAULT;
-		regs->dar = ea;
-	}
+	scoped_user_read_access_size(uea, nb, efault)
+		return __read_mem_aligned(dest, (unsigned long)uea, nb, regs);
 
-	return err;
+efault:
+	regs->dar = ea;
+	return -EFAULT;
 }
 
 /*
@@ -385,20 +382,17 @@ static __always_inline int __copy_mem_in(u8 *dest, unsigned long ea, int nb, str
 
 static nokprobe_inline int copy_mem_in(u8 *dest, unsigned long ea, int nb, struct pt_regs *regs)
 {
-	int err;
+	void __user *uea = (void __user *)ea;
 
 	if (is_kernel_addr(ea))
 		return __copy_mem_in(dest, ea, nb, regs);
 
-	if (user_read_access_begin((void __user *)ea, nb)) {
-		err = __copy_mem_in(dest, ea, nb, regs);
-		user_read_access_end();
-	} else {
-		err = -EFAULT;
-		regs->dar = ea;
-	}
+	scoped_user_read_access_size(uea, nb, efault)
+		return __copy_mem_in(dest, (unsigned long)uea, nb, regs);
 
-	return err;
+efault:
+	regs->dar = ea;
+	return -EFAULT;
 }
 
 static nokprobe_inline int read_mem_unaligned(unsigned long *dest,
@@ -465,20 +459,17 @@ __write_mem_aligned(unsigned long val, unsigned long ea, int nb, struct pt_regs
 static nokprobe_inline int
 write_mem_aligned(unsigned long val, unsigned long ea, int nb, struct pt_regs *regs)
 {
-	int err;
+	void __user *uea = (void __user *)ea;
 
 	if (is_kernel_addr(ea))
 		return __write_mem_aligned(val, ea, nb, regs);
 
-	if (user_write_access_begin((void __user *)ea, nb)) {
-		err = __write_mem_aligned(val, ea, nb, regs);
-		user_write_access_end();
-	} else {
-		err = -EFAULT;
-		regs->dar = ea;
-	}
+	scoped_user_write_access_size(uea, nb, efault)
+		return __write_mem_aligned(val, (unsigned long)uea, nb, regs);
 
-	return err;
+efault:
+	regs->dar = ea;
+	return -EFAULT;
 }
 
 /*
@@ -521,20 +512,17 @@ static __always_inline int __copy_mem_out(u8 *dest, unsigned long ea, int nb, st
 
 static nokprobe_inline int copy_mem_out(u8 *dest, unsigned long ea, int nb, struct pt_regs *regs)
 {
-	int err;
+	void __user *uea = (void __user *)ea;
 
 	if (is_kernel_addr(ea))
 		return __copy_mem_out(dest, ea, nb, regs);
 
-	if (user_write_access_begin((void __user *)ea, nb)) {
-		err = __copy_mem_out(dest, ea, nb, regs);
-		user_write_access_end();
-	} else {
-		err = -EFAULT;
-		regs->dar = ea;
-	}
+	scoped_user_write_access_size(uea, nb, efault)
+		return __copy_mem_out(dest, (unsigned long)uea, nb, regs);
 
-	return err;
+efault:
+	regs->dar = ea;
+	return -EFAULT;
 }
 
 static nokprobe_inline int write_mem_unaligned(unsigned long val,
@@ -1065,6 +1053,7 @@ static __always_inline int __emulate_dcbz(unsigned long ea)
 
 int emulate_dcbz(unsigned long ea, struct pt_regs *regs)
 {
+	void __user *uea = (void __user *)ea;
 	int err;
 	unsigned long size = l1_dcache_bytes();
 
@@ -1073,20 +1062,20 @@ int emulate_dcbz(unsigned long ea, struct pt_regs *regs)
 	if (!address_ok(regs, ea, size))
 		return -EFAULT;
 
-	if (is_kernel_addr(ea)) {
-		err = __emulate_dcbz(ea);
-	} else if (user_write_access_begin((void __user *)ea, size)) {
+	if (is_kernel_addr(ea))
 		err = __emulate_dcbz(ea);
-		user_write_access_end();
-	} else {
-		err = -EFAULT;
-	}
+	else
+		scoped_user_write_access_size(uea, size, efault)
+			err = __emulate_dcbz((unsigned long)uea);
 
 	if (err)
 		regs->dar = ea;
 
-
 	return err;
+
+efault:
+	regs->dar = ea;
+	return -EFAULT;
 }
 NOKPROBE_SYMBOL(emulate_dcbz);
 
-- 
2.49.0



Return-Path: <linuxppc-dev+bounces-17952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536ABEFCD9F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:01:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVTtX3x47z3bjb;
	Tue, 10 Mar 2026 21:01:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773136900;
	cv=none; b=UlGQgpVHG9TuUAly07iqc0CguOnbrrTOAEBXvq/dXCRM6CLiTzjBhgvHKXpVMF4UHQQa6PaC/u4Xyvt0WwGb7fKVeGxqQeNr32ssaEkYsbW7dxDvQp9q9LhjGqNIADlPfro6DX09s025cmaVMETGAb1ynUeDPLnS5djPvx8cmG0Hakc5zeQTXO8krYsxa57Q0eQKoeMk0cKcGrTfGgNa6XBbeFdhNc2YkigzBjpj/PL8+F8PZ6N/ftb9E+hp6qa2wQoBFjt6AVs12WF4la/TMLPkhV0QaOo6neTY1r+acjjWxER0iKvbZilhL5TOEUfRLjOOsl+6Wu+GrqbjDEtzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773136900; c=relaxed/relaxed;
	bh=yw8MV94IiuvwXUSKF2h6GdsUcAuvpi0KD1TrFJBIDos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvwSoJO9S/mXR6e3efIqcOejwG0LB3wziGKYrrdabXpfB/1kWlHxiCMZ7T0bLCNtHd0TBAfOKHVo0oCxV4n0TvYMWBBBNUNWiEJANEnWRN0gydrVkoV7xz0+3eoXR0pdMmRN8itBJ0a58N/hEVnmGXemMoSizJtXuagiofe0XNjC475r2RDrL0mUWdwHWkvqI7eZpmMKaHdpo0ghLGZhxItPMgYQdSOUwO4qWIWERmUAPbByOs3jSCFI3HwbNbjvnvHi2nDAd/8GLbetzFczty6p8Nojq+ftepKayAyB3ADy+zk1peOC2DD+g1LhP2Mdsmw6JKMjkN61z/OAZclolg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EzB3UDwy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EzB3UDwy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTtW4rXMz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:01:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8228E60097;
	Tue, 10 Mar 2026 10:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DA0C19423;
	Tue, 10 Mar 2026 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136897;
	bh=YV9k7v/oOmBH0LfirOp+fEdnB8gQFUnL7tP1uq5fYJA=;
	h=From:To:Cc:Subject:Date:From;
	b=EzB3UDwyT+fh+jNBwMSleFQSNLfZPccXs9QD/uFG7EuQ2n/d8gQgZwR6fIJKz98Gn
	 Y6ZRHgFGcamYi+iqgsOwSWfnAg9iPt/+hFCnzYUijAsBjtF/UmizKjKzmrQjBTf3K8
	 uy78R0jGF61MtsAkjzLWDdy1blA2IniKrQm75B561CMxkdfOzNRgNlhPvxha37HVth
	 yumg/fMcZtRHNsQaqdlzdZw6HAzNcvZOlwti3wnwQ6I6hWsKQl2tjjcjPK3KQPFFaY
	 XkRVXsrRIePogSupdc/kqR0nGx4eP+7C1kzb7TeBp+J4Ls3STGqSTAU1sGLGPols8t
	 dM+kCZ6nrknow==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/align: Convert emulate_spe() to scoped user access
Date: Tue, 10 Mar 2026 11:01:31 +0100
Message-ID: <4ff83cb240da4e2d0c34e2bce4b8b6ef19a33777.1773136880.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; i=chleroy@kernel.org; h=from:subject:message-id; bh=YV9k7v/oOmBH0LfirOp+fEdnB8gQFUnL7tP1uq5fYJA=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSuf/07Myr3uEvVmW8N0yK/pq3wisr9xua6Q2iJ8PuUK 14SHofUOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEIrwYGVbXP7Y66fxC6Ets WPeiTqtyh+NltTbVoV+Vax5wMd7bU8jwv0C0vuzL9J7+uuqJJ49d0rVMLZz6fOvE23bh39dfzNU 8yg4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
provides optimised user access by avoiding the cost of access_ok().

Convert emulate_spe() to scoped user access to benefit from masked
user access.

Scoped user access also make the code simpler.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/align.c | 75 ++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 3e37ece06739..61409431138f 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -165,25 +165,23 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 		temp.ll = data.ll = 0;
 		p = addr;
 
-		if (!user_read_access_begin(addr, nb))
-			return -EFAULT;
-
-		switch (nb) {
-		case 8:
-			unsafe_get_user(temp.v[0], p++, Efault_read);
-			unsafe_get_user(temp.v[1], p++, Efault_read);
-			unsafe_get_user(temp.v[2], p++, Efault_read);
-			unsafe_get_user(temp.v[3], p++, Efault_read);
-			fallthrough;
-		case 4:
-			unsafe_get_user(temp.v[4], p++, Efault_read);
-			unsafe_get_user(temp.v[5], p++, Efault_read);
-			fallthrough;
-		case 2:
-			unsafe_get_user(temp.v[6], p++, Efault_read);
-			unsafe_get_user(temp.v[7], p++, Efault_read);
+		scoped_user_read_access_size(addr, nb, efault) {
+			switch (nb) {
+			case 8:
+				unsafe_get_user(temp.v[0], p++, efault);
+				unsafe_get_user(temp.v[1], p++, efault);
+				unsafe_get_user(temp.v[2], p++, efault);
+				unsafe_get_user(temp.v[3], p++, efault);
+				fallthrough;
+			case 4:
+				unsafe_get_user(temp.v[4], p++, efault);
+				unsafe_get_user(temp.v[5], p++, efault);
+				fallthrough;
+			case 2:
+				unsafe_get_user(temp.v[6], p++, efault);
+				unsafe_get_user(temp.v[7], p++, efault);
+			}
 		}
-		user_read_access_end();
 
 		switch (instr) {
 		case EVLDD:
@@ -252,25 +250,23 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 	if (flags & ST) {
 		p = addr;
 
-		if (!user_write_access_begin(addr, nb))
-			return -EFAULT;
-
-		switch (nb) {
-		case 8:
-			unsafe_put_user(data.v[0], p++, Efault_write);
-			unsafe_put_user(data.v[1], p++, Efault_write);
-			unsafe_put_user(data.v[2], p++, Efault_write);
-			unsafe_put_user(data.v[3], p++, Efault_write);
-			fallthrough;
-		case 4:
-			unsafe_put_user(data.v[4], p++, Efault_write);
-			unsafe_put_user(data.v[5], p++, Efault_write);
-			fallthrough;
-		case 2:
-			unsafe_put_user(data.v[6], p++, Efault_write);
-			unsafe_put_user(data.v[7], p++, Efault_write);
+		scoped_user_write_access_size(addr, nb, efault) {
+			switch (nb) {
+			case 8:
+				unsafe_put_user(data.v[0], p++, efault);
+				unsafe_put_user(data.v[1], p++, efault);
+				unsafe_put_user(data.v[2], p++, efault);
+				unsafe_put_user(data.v[3], p++, efault);
+				fallthrough;
+			case 4:
+				unsafe_put_user(data.v[4], p++, efault);
+				unsafe_put_user(data.v[5], p++, efault);
+				fallthrough;
+			case 2:
+				unsafe_put_user(data.v[6], p++, efault);
+				unsafe_put_user(data.v[7], p++, efault);
+			}
 		}
-		user_write_access_end();
 	} else {
 		*evr = data.w[0];
 		regs->gpr[reg] = data.w[1];
@@ -278,12 +274,7 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 
 	return 1;
 
-Efault_read:
-	user_read_access_end();
-	return -EFAULT;
-
-Efault_write:
-	user_write_access_end();
+efault:
 	return -EFAULT;
 }
 #endif /* CONFIG_SPE */
-- 
2.49.0



Return-Path: <linuxppc-dev+bounces-25345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59211C5518F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:51:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDnM96fGvz3bwf;
	Tue, 04 Aug 2026 18:51:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785833461;
	cv=none; b=aNfjham33AnyXX4jUfhQW/02H7vGI2LzVDA8fPIKUUQyITiCjJaEOF0udrHIEwb4du4ecpETn1+Y9QWX2bTB80JVX4UdF01e3mOfc6yLmIh0VNVPZQhanHme3QleRvysORDRdr3piJVRZog9WNTFdpRObwdRMXqgre0a1qnW+zsCXo/EIeRi3O41HeI9OJaeNuVqTT36MGEHSscIRG4PolNGQtmDzPBd8QLi6siz0kREjo0mZdAY2GN4qr0mzCEyARSQdR1Sk4QZBDVwc6GDoOuNXYiAo64sx0eSvZUaHsNiCjtruioCm3NJv7LgJld9cWcndkElv0WT+9GpQMKcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785833461; c=relaxed/relaxed;
	bh=QUPFDZZOko92OrJ5ssAYirYo3y+g2yxcS9iwfIOyGas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPBpwT3ERX6SljkdalfhHxpcxItzhMFsJji8pYWeehS08yLm9Cs2KlAmqluh3mOJYuRgDxg1Swt6uCXpotJAheskhFfTCn8PQjUcHjXVw+owjcwgrNZZA7w9WyRva7CdALQN+oJydUku88Xb6Cf2byXPzVFRsawUbYCel/eQAkC/pjzXhdkdAGMXO6T5OeMUGrWV0Jjy699qRhPRu5N+djMHoRsA2eQYi7b2Xo2jzXaqYpvoXFllctOAhaEl1ELeu4D7kl64eib+VXCFCoGUVQN4XjL0QGdOl0CIH/1+Sj9dFX1muDsD1sheliaa6Bdk04yFxUu4BZhaCTN+USrONw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gguxmrpl; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gguxmrpl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDnM85qP6z3brm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:51:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E9A4643F59;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1F8AC2BCFB;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785833454;
	bh=ouoOtFQsDph48bmUIg1nnMKtB6spdEtljACvUOhmbI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gguxmrplHdHMu6GDamNp9kq6vmj2XLV+qreDsyqBBjorxNEEJeHDt6IF3DxgrQ1B2
	 VXEDqWcHu5yc1KWKn/ymtIlS81CVNqHsbbBeCFLaPEOfJXlvZoup7endt3l634HvxU
	 Bmf83urhBrHpq8A+Ls3wrniDsTC8xWDqIihCfkXSs6n8PEyQ5OFeTIHuOk7R4LC5Jb
	 YnmqOgIhT764/v/D15tstznlIOtmcAMaHz4s86mVGT3/1QUnnFL52QjVy6rFIjWtdC
	 8X8n7dNhgyd0sf0NmwqjQcBCrhTpDnXCrCagKSlYfEtwbksCFxh219MhouQ0ky+8dv
	 2fulpVgekhrpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A6FC55172;
	Tue,  4 Aug 2026 08:50:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 04 Aug 2026 16:50:39 +0800
Subject: [PATCH v2 2/5] powerpc/spufs: don't leak kernel stack via spu_run
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-fixes-v2-2-5bfd827297f9@outlook.com>
References: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
In-Reply-To: <20260804-fixes-v2-0-5bfd827297f9@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@ozlabs.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=/mYJIr4Rrbt5tK8GuImhcqAYaBw3DdGgKByxedyucEU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMLlb76tSgqwj18YnOrQtpRllZ+6sNpx9hVr2ztMT
 858m3mM+UhHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATERHieF/mvPSy7E9malK
 PlmZPR+Wzz/ROOVmBp/wilU6jdlqLCuUGBnmLxSLLDwzZcfSuzcrt6xU2XNXM03EWid2SpTa7Hm
 F8pN5AWe+SRo=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

do_spu_run() hands the address of an uninitialized local to
spufs_run_spu() and then copies it out unconditionally:

	u32 npc, status;
	...
	ret = spufs_run_spu(i->i_ctx, &npc, &status);
	...
	if (ustatus && put_user(status, ustatus))
		ret = -EFAULT;

spufs_run_spu() writes through that pointer at exactly one place, the
"out:" label, and two of its exits never reach it: the interruptible
acquisition of ctx->run_mutex returns -ERESTARTSYS directly, and a
failed spu_acquire() jumps to "out_unlock", which sits just after the
assignment.

Initialize status to 0, which is what userspace would have observed had
the assignment been reached anyway: spufs_run_spu() resets
ctx->event_return to 0 on entry, and 0 is the "no events pending" value
for this word.

Fixes: 67207b9664a8 ("[PATCH] spufs: The SPU file system, base")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index ea4ba1b6ce6a..549fcfbbc140 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -37,7 +37,7 @@ static long do_spu_run(struct file *filp,
 {
 	long ret;
 	struct spufs_inode_info *i;
-	u32 npc, status;
+	u32 npc, status = 0;
 
 	ret = -EFAULT;
 	if (get_user(npc, unpc))

-- 
2.51.2




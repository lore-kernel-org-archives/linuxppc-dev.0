Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EBAC05027
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Feb 2023 11:26:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PCF1P0lL7z3fXF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Feb 2023 22:26:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dFLhCZuv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dFLhCZuv;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PCDtj47m6z3fFM
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2023 22:20:29 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2DF5BB8210A;
	Thu,  9 Feb 2023 11:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5749C4339B;
	Thu,  9 Feb 2023 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675941625;
	bh=YuDm4m8K5tva9CfkEqzuuWDJizZqOlzuQFW2rRMjKhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFLhCZuvQ2WvAYiy+GIfq/aFkFe82QjIeW8jcALOHOyWlZf8IROl3K6/Xl0pw1PTi
	 Sh0ykW3K/ViAIb8XL2z9tJ1fRF6mq+W8F1ACobB8QqYvfZObhAwb2+twrCfynN04Ik
	 QtICyXrr2BTzI094mu7EIjlImL0ngafjdMR1XelMrdXoEWJP7rvXPpX0LoFZNlV+RJ
	 7MYLHD8U5O30zKEb+1oirZYBwYwo1Us0DdfSe9Ruxbi4lMlo3bEfsHl3B6FZEkuY1z
	 l1E62N0o45HRw2N3NvXKetrZzBEwyAZz5Pkaq8lfaSuaVZrQ2cL4/lh6UKwtE1UgIr
	 Kx1J98ghJClSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/6] powerpc/kvm: Fix unannotated intra-function call warning
Date: Thu,  9 Feb 2023 06:19:58 -0500
Message-Id: <20230209111959.1893269-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111959.1893269-1-sashal@kernel.org>
References: <20230209111959.1893269-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, kernel test robot <lkp@intel.com>, npiggin@gmail.com, Sathvika Vasireddy <sv@linux.ibm.com>, seanjc@google.com, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Sathvika Vasireddy <sv@linux.ibm.com>

[ Upstream commit fe6de81b610e5d0b9d2231acff2de74a35482e7d ]

objtool throws the following warning:
  arch/powerpc/kvm/booke.o: warning: objtool: kvmppc_fill_pt_regs+0x30:
  unannotated intra-function call

Fix the warning by setting the value of 'nip' using the _THIS_IP_ macro,
without using an assembly bl/mflr sequence to save the instruction
pointer.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20230128124158.1066251-1-sv@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/booke.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index a9ca016da6702..5d8cc8a637e74 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -898,16 +898,15 @@ static int kvmppc_handle_debug(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 static void kvmppc_fill_pt_regs(struct pt_regs *regs)
 {
-	ulong r1, ip, msr, lr;
+	ulong r1, msr, lr;
 
 	asm("mr %0, 1" : "=r"(r1));
 	asm("mflr %0" : "=r"(lr));
 	asm("mfmsr %0" : "=r"(msr));
-	asm("bl 1f; 1: mflr %0" : "=r"(ip));
 
 	memset(regs, 0, sizeof(*regs));
 	regs->gpr[1] = r1;
-	regs->nip = ip;
+	regs->nip = _THIS_IP_;
 	regs->msr = msr;
 	regs->link = lr;
 }
-- 
2.39.0


Return-Path: <SRS0=ex+5=VV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A1C7618B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 05:35:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2690421BF6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 05:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2690421BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kb.kras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tkb86NBwzDqCH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 15:35:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tkY72HlNzDq9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2019 15:34:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kb.kras.ru
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45tkY71kynz8t9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2019 15:34:03 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45tkY71RKgz9s4Y; Wed, 24 Jul 2019 15:34:03 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kb.kras.ru
 (client-ip=62.213.33.10; helo=ispman.iskranet.ru;
 envelope-from=asolokha@kb.kras.ru; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kb.kras.ru
X-Greylist: delayed 517 seconds by postgrey-1.36 at bilbo;
 Wed, 24 Jul 2019 15:34:02 AEST
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45tkY63VMjz9sBF
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jul 2019 15:34:02 +1000 (AEST)
Received: by ispman.iskranet.ru (Postfix, from userid 8)
 id 9252E8217E2; Wed, 24 Jul 2019 12:25:19 +0700 (KRAT)
Received: from KB016249 (unknown [62.213.40.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ispman.iskranet.ru (Postfix) with ESMTPS id E31798217E2;
 Wed, 24 Jul 2019 12:25:18 +0700 (KRAT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: christian@brauner.io
Subject: Re: [PATCH] powerpc: Wire up clone3 syscall
In-Reply-To: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
References: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
Date: Wed, 24 Jul 2019 12:25:14 +0700
Message-ID: <87ftmwknr9.fsf@kb.kras.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

may I also ask to provide ppc_clone3 symbol also for 32-bit powerpc? Otherwise
Michael's patch breaks build for me:

  powerpc-e500v2-linux-gnuspe-ld: arch/powerpc/kernel/systbl.o: in function `sys_call_table':
  (.rodata+0x6cc): undefined reference to `ppc_clone3'
  make: *** [Makefile:1060: vmlinux] Error 1

The patch was tested using Christian's program on a real e500 machine.

--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -597,6 +597,14 @@ ppc_clone:
 	stw	r0,_TRAP(r1)		/* register set saved */
 	b	sys_clone

+	.globl	ppc_clone3
+ppc_clone3:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,_TRAP(r1)		/* register set saved */
+	b	sys_clone3
+
 	.globl	ppc_swapcontext
 ppc_swapcontext:
 	SAVE_NVGPRS(r1)

I don't think this trivial hunk deserves a separate patch submission.

Thanks,
Arseny

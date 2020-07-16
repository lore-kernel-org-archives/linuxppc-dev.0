Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF38C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 14:23:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34570206F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 14:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34570206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6xM26t5wzDqnp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 00:23:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6vQB6RnnzDqYX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 22:56:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4B6vQ31rftz9sVV; Thu, 16 Jul 2020 22:56:10 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200623234139.2262227-1-npiggin@gmail.com>
References: <20200623234139.2262227-1-npiggin@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/64s: restore_math remove TM test
Message-Id: <159490401036.3805857.3437252892376420317.b4-ty@ellerman.id.au>
Date: Thu, 16 Jul 2020 22:56:10 +1000 (AEST)
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
Cc: Anton Blanchard <anton@linux.ibm.com>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 24 Jun 2020 09:41:37 +1000, Nicholas Piggin wrote:
> The TM test in restore_math added by commit dc16b553c949e ("powerpc:
> Always restore FPU/VEC/VSX if hardware transactional memory in use") is
> no longer necessary after commit a8318c13e79ba ("powerpc/tm: Fix
> restoring FP/VMX facility incorrectly on interrupts"), which removed
> the cases where restore_math has to restore if TM is active.

Applied to powerpc/next.

[1/3] powerpc/64s: restore_math remove TM test
      https://git.kernel.org/powerpc/c/891b4fe8fe3d09f20948b391f24c9fc5b7580a2b
[2/3] powerpc/64s: Fix restore_math unnecessarily changing MSR
      https://git.kernel.org/powerpc/c/01eb01877f3386d4bd5de75909abdd0af45a5fa2
[3/3] powerpc: re-initialise lazy FPU/VEC counters on every fault
      https://git.kernel.org/powerpc/c/b2b46304e9360f3dda49c9d8ba4a1478b9eecf1d

cheers

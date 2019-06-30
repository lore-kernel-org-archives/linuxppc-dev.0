Return-Path: <SRS0=xcTM=U5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813FDC5B57E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:54:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3695320449
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3695320449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45c47T52hczDr6Z
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 18:54:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45c3lv2hLLzDqhl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2019 18:37:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45c3lv0rTwz9sND; Sun, 30 Jun 2019 18:37:30 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8d0f1e05ab16c4bd628ddaefd20b94ffb36d799c
X-Patchwork-Hint: ignore
In-Reply-To: <1560806698-26651-1-git-send-email-gromero@linux.vnet.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Fix earlyclobber in tm-vmxcopy
Message-Id: <45c3lv0rTwz9sND@ozlabs.org>
Date: Sun, 30 Jun 2019 18:37:30 +1000 (AEST)
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
Cc: mikey@neuling.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-06-17 at 21:24:58 UTC, Gustavo Romero wrote:
> In some cases, compiler can allocate the same register for operand 'res'
> and 'vecoutptr', resulting in segfault at 'stxvd2x 40,0,%[vecoutptr]'
> because base register will contain 1, yielding a false-positive.
> 
> This is because output 'res' must be marked as an earlyclobber operand so
> it may not overlap an input operand ('vecoutptr').
> 
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8d0f1e05ab16c4bd628ddaefd20b94ffb36d799c

cheers

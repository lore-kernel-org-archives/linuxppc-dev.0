Return-Path: <SRS0=7W7S=U4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D521C4321A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jun 2019 11:39:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E665F214AF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jun 2019 11:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E665F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45bWrL63z6zDqx4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jun 2019 21:39:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45bWpV2V51zDqQR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2019 21:37:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45bWpV1jWCz9s5c; Sat, 29 Jun 2019 21:37:54 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e13e7cd4c0c1cc9984d9b6a8663e10d76b53f2aa
X-Patchwork-Hint: ignore
In-Reply-To: <20190621225554.1913-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s/exception: Fix machine check early corrupting
 AMR
Message-Id: <45bWpV1jWCz9s5c@ozlabs.org>
Date: Sat, 29 Jun 2019 21:37:54 +1000 (AEST)
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-06-21 at 22:55:54 UTC, Nicholas Piggin wrote:
> The early machine check runs in real mode, so locking is unnecessary.
> Worse, the windup does not restore AMR, so this can result in a false
> KUAP fault after a recoverable machine check hits inside a user copy
> operation.
> 
> Fix this similarly to HMI by just avoiding the kuap lock in the
> early machine check handler (it will be set by the late handler that
> runs in virtual mode if that runs). If the virtual mode handler is
> reached, it will lock and restore the AMR.
> 
> Fixes: 890274c2dc4c0 ("powerpc/64s: Implement KUAP for Radix MMU")
> Cc: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e13e7cd4c0c1cc9984d9b6a8663e10d76b53f2aa

cheers

Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE45C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:18:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916DF20659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916DF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dTtw3lXxzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 21:18:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dTm92FRJzDq7X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 21:12:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43dTm86z85z9sDL; Mon, 14 Jan 2019 21:12:08 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 897bc3df8c5aebb54c32d831f917592e873d0559
X-Patchwork-Hint: ignore
In-Reply-To: <1547039805-7979-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
Message-Id: <43dTm86z85z9sDL@ozlabs.org>
Date: Mon, 14 Jan 2019 21:12:08 +1100 (AEDT)
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
Cc: Breno Leitao <leitao@debian.org>, gregkh@linuxfoundation.org,
 mikey@neuling.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-01-09 at 13:16:45 UTC, Breno Leitao wrote:
> Commit e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
> moved a code block around and this block uses a 'msr' variable outside of
> the CONFIG_PPC_TRANSACTIONAL_MEM, however the 'msr' variable is declared
> inside a CONFIG_PPC_TRANSACTIONAL_MEM block, causing a possible error when
> CONFIG_PPC_TRANSACTION_MEM is not defined.
> 
> 	error: 'msr' undeclared (first use in this function)
> 
> This is not causing a compilation error in the mainline kernel, because
> 'msr' is being used as an argument of MSR_TM_ACTIVE(), which is defined as
> the following when CONFIG_PPC_TRANSACTIONAL_MEM is *not* set:
> 
> 	#define MSR_TM_ACTIVE(x) 0
> 
> This patch just fixes this issue avoiding the 'msr' variable usage outside
> the CONFIG_PPC_TRANSACTIONAL_MEM block, avoiding trusting in the
> MSR_TM_ACTIVE() definition.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
> Fixes: e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/897bc3df8c5aebb54c32d831f917592e

cheers

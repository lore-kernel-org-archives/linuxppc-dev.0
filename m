Return-Path: <SRS0=xcTM=U5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0967C5B57E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:56:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E98820449
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E98820449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45c49C5lqlzDqbs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 18:55:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45c3lx05CzzDqLc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2019 18:37:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45c3lw0kZZz9sLt; Sun, 30 Jun 2019 18:37:31 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6ecb78ef56e08d2119d337ae23cb951a640dc52d
X-Patchwork-Hint: ignore
In-Reply-To: <97f32bd4c45ce004550b3853474b3bc7e211ae0d.1560807643.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/32s: fix suspend/resume when IBATs 4-7 are used
Message-Id: <45c3lw0kZZz9sLt@ozlabs.org>
Date: Sun, 30 Jun 2019 18:37:31 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-06-17 at 21:42:14 UTC, Christophe Leroy wrote:
> Previously, only IBAT1 and IBAT2 were used to map kernel linear mem.
> Since commit 63b2bc619565 ("powerpc/mm/32s: Use BATs for
> STRICT_KERNEL_RWX"), we may have all 8 BATs used for mapping
> kernel text. But the suspend/restore functions only save/restore
> BATs 0 to 3, and clears BATs 4 to 7.
> 
> Make suspend and restore functions respectively save and reload
> the 8 BATs on CPUs having MMU_FTR_USE_HIGH_BATS feature.
> 
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6ecb78ef56e08d2119d337ae23cb951a640dc52d

cheers

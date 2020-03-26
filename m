Return-Path: <SRS0=iuvT=5L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C29C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F752070A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F752070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p3xc71HGzDqH1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 23:21:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p3cV1kQZzDqq5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2020 23:06:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 48p3cS2qrzz9sSV; Thu, 26 Mar 2020 23:06:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48p3cS0rLnz9sSY; Thu, 26 Mar 2020 23:06:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d64c7dbb4d98306b794401ca924ad053f84b59f8
In-Reply-To: <20200219110007.31195-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/xmon: Lower limits on nidump and ndump
Message-Id: <48p3cS0rLnz9sSY@ozlabs.org>
Date: Thu, 26 Mar 2020 23:06:31 +1100 (AEDT)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-02-19 at 11:00:07 UTC, Michael Ellerman wrote:
> In xmon we have two variables that are used by the dump commands.
> There's ndump which is the number of bytes to dump using 'd', and
> nidump which is the number of instructions to dump using 'di'.
> 
> ndump starts as 64 and nidump starts as 16, but both can be set by the
> user.
> 
> It's fairly common to be pasting addresses into xmon when trying to
> debug something, and if you inadvertently double paste an address like
> so:
> 
>   0:mon> di c000000002101f6c c000000002101f6c
> 
> The second value is interpreted as the number of instructions to dump.
> 
> Luckily it doesn't dump 13 quintrillion instructions, the value is
> limited to MAX_DUMP (128K). But as each instruction is dumped on a
> single line, that's still a lot of output. If you're on a slow console
> that can take multiple minutes to print. If you were "just popping in
> and out of xmon quickly before the RCU/hardlockup detector fires" you
> are now having a bad day.
> 
> Things are not as bad with 'd' because we print 16 bytes per line, so
> it's fewer lines. But it's still quite a lot.
> 
> So shrink the maximum for 'd' to 64K (one page), which is 4096 lines.
> For 'di' add a new limit which is the above / 4 - because instructions
> are 4 bytes, meaning again we can dump one page.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/d64c7dbb4d98306b794401ca924ad053f84b59f8

cheers

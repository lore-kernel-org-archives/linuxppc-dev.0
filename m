Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E268C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:33:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D77420758
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D77420758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49RrGZ0YdXzDqjc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 21:33:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RqXY3X5pzDqf0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 21:00:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49RqXW2cc8z9sPK; Wed, 20 May 2020 21:00:11 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1588045502.git.sbobroff@linux.ibm.com>
References: <cover.1588045502.git.sbobroff@linux.ibm.com>
Subject: Re: [PATCH v4 0/2] powerpc/eeh: Release EEH device state synchronously
Message-Id: <158997214111.943180.7534452185720129130.b4-ty@ellerman.id.au>
Date: Wed, 20 May 2020 21:00:11 +1000 (AEST)
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 28 Apr 2020 13:45:04 +1000, Sam Bobroff wrote:
> Here are some fixes and cleanups that have come from other work but that I
> think stand on their own.
> 
> Only one patch ("Release EEH device state synchronously", suggested by Oliver
> O'Halloran) is a significant change: it moves the cleanup of some EEH device
> data out of the (possibly asynchronous) device release handler and into the
> (synchronously called) bus notifier. This is useful for future work as it makes
> it easier to reason about the lifetimes of EEH structures.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/eeh: Fix pseries_eeh_configure_bridge()
      https://git.kernel.org/powerpc/c/6fa13640aea7bb0760846981aa2da4245307bd26
[2/2] powerpc/eeh: Release EEH device state synchronously
      https://git.kernel.org/powerpc/c/466381ecdc741b1767d980e10b1ec49f6bde56f3

cheers

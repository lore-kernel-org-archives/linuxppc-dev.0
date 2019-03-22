Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A18C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 21:22:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259DC2190A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 21:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="utfCMduU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259DC2190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QxS76Hr2zDqB7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 08:21:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="utfCMduU"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QxQ70hyczDqQG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 08:20:14 +1100 (AEDT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553289612;
 bh=ayaBnWDYrJhYMUIvFOaEKWFfqVvNlW5uzh1k3LUM9Jc=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=utfCMduU7qkQVuH72X+aCtFXgAfrox9cuh4vu1Ly0miprV9U2SEN2V3aDd0VOGBxB
 Gw7b7am0SvfNpNTjjih41NTJRZz5Z2vPiMY4iBUfmVswWzuzNbH+EiZOcIQdrJ/UxR
 8FRMT4Py5qjojX5nijaYhDLhFPbE/fjpsMNUUFwE=
From: pr-tracker-bot@kernel.org
In-Reply-To: <87h8bvcbhb.fsf@concordia.ellerman.id.au>
References: <87h8bvcbhb.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h8bvcbhb.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-3
X-PR-Tracked-Commit-Id: 92edf8df0ff2ae86cc632eeca0e651fd8431d40d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5ed1e96cafde5ba48638f486bfca0685dc6ddc9
Message-Id: <155328961210.19902.16718865326587161945.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2019 21:20:12 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: malat@debian.org, linuxppc-dev@lists.ozlabs.org,
 mark.cave-ayland@ilande.co.uk, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, ben@decadent.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Fri, 22 Mar 2019 23:58:08 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5ed1e96cafde5ba48638f486bfca0685dc6ddc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

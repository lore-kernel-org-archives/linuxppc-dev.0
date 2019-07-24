Return-Path: <SRS0=ex+5=VV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE95C76191
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 17:12:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E580C21911
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 17:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnNuMHvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E580C21911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45v2315ZmWzDqCY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jul 2019 03:12:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gnNuMHvb"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45v20b75WczDq6q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2019 03:10:23 +1000 (AEST)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563988221;
 bh=8Iv1KNyqx9qxX4tBWmO2qXBdCa/7Mtdy+eUFXutnc2k=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=gnNuMHvb3zY+RHCONcmiUO5vAwOOLzOxxX6bLB0XbQSyScyNRHUvxB6kuv6jDj6Ay
 rpUIDdogUAjCCK31LSRCkFogRUQtdSHXNGLSW2T8bCuzNT+ExYeVDl4hb7SGEpRwgD
 92Y3ay6PmZocijx8K3Jzx4ELhB57zQDrCYvlzy1c=
From: pr-tracker-bot@kernel.org
In-Reply-To: <87o91j5z20.fsf@concordia.ellerman.id.au>
References: <87o91j5z20.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o91j5z20.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.3-2
X-PR-Tracked-Commit-Id: 3a855b7ac7d5021674aa3e1cc9d3bfd6b604e9c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bed38c3e2dca01b358a62b5e73b46e875742fd75
Message-Id: <156398822120.2764.10514051840491932120.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2019 17:10:21 +0000
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
Cc: aarcange@redhat.com, ego@linux.vnet.ibm.com, mikey@neuling.org,
 shawn@anastas.io, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, clg@kaod.org, sjitindarsingh@gmail.com,
 vaibhav@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Wed, 24 Jul 2019 23:42:31 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bed38c3e2dca01b358a62b5e73b46e875742fd75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

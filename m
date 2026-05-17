Return-Path: <linuxppc-dev+bounces-21019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07C0CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 19:28:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJWF21CFbz2xfB;
	Mon, 18 May 2026 05:28:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779046102;
	cv=none; b=aiIgjx3pCTYqwbaVeCxJnBirWVDlzsrW7nJu/UwFdxXfHNvcNfk+JEG9vFTWC9st58pKelk0zJoNgTersvN+MLa2BgK8sXVa9qvhNY7ismgXHFtK1BGG1AoaM1lmjt5Ap2koJEEGeylxaOOqI/m0amde4pMG1kEK7lM9KzUaf+mlOk8wlgqI4wZ9AKlJXwShp+VaOyEPY2Wj84SnRkHaggqyfAihUT3BrzkiDXarXPRRsCEayfhwcVDTEgbQ8g4NWknP0gciNsFessNRBSF7PWYIhhIEalzcYR/naD7jEBtZy4lbzCv2A6oLmd/FCqws3pcG+sL0fnmpFZ2289Nceg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779046102; c=relaxed/relaxed;
	bh=b/j1j6bMerg9rS4H7JiAjNSWhxJbaFnshXFZ2FDWX9g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NyV/5i+WWfYaMPdIlvKS+WhlYW+NMq3dgxLKHUFOmYwuu89BMTJk/adXJPduUU0bHTogsEeNG80sOvRcf+ABEBne8dSIc3YSUX68emWDncIfpoZai3pHuvHmx0YbwDt+TYMG8d4Y9PtWmgeRnh4B7YTO3oAZ2vTPIKzaYUJzxv3jcUN9tNj0xvqJFm1BvQ2iFlxP++Z8LV7aJ6gbMQZpi8yNTgeSOHuDz5DNitBLL4CPumBmfy6qlpXcYJ31xXu+9IGNrEj5tplblTSzKEfaTbflo4J+t+ew7Mo3+COAeRMSh8l10F7haMhinC+g51VfrTK5Ny3iLgt1umbJx8ck4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CTvVzXJZ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CTvVzXJZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJWF121YMz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 05:28:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ADEB8419C7;
	Sun, 17 May 2026 19:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8528BC2BCB0;
	Sun, 17 May 2026 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779046098;
	bh=oOuL2BlV4ooysHN0paEilDeov0fbNb3XEPLXoA1ZMFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CTvVzXJZFSh1T5LUN+En6IgE0iZLIxkWQVDhvdXVRgEIdMBC0ou34W2NgClPv8M2b
	 shaWmMft9EqVkuqRl7VFDVyPN60qkWV1oQ2fIjjjjuNm1ALeSMO/tMjIVfHQCaNfr5
	 deHW6t2bCAsPQGtZ1rgJB4rIZYoXxoQcz6nLMLYU8JaNWsau9fxxKcSE3ibV+KzIjr
	 fbGXaCt5UmenYgT3VExaBtU6z6HzuZH0J389xcHmghFmZqhsyAur3smgK2lMwLrzV7
	 DXTH7lkDd3cPtPQ44uHq6ujpci0sHnDzVsDykhQq1L9uhEUzQn3jur6TdC8z73JweI
	 3xDizCMn5OIBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB73930B89;
	Sun, 17 May 2026 19:28:31 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.1-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <6d0bf34e-af80-4b1e-aae7-9d2dc27fcc25@linux.ibm.com>
References: <6d0bf34e-af80-4b1e-aae7-9d2dc27fcc25@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6d0bf34e-af80-4b1e-aae7-9d2dc27fcc25@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.1-3
X-PR-Tracked-Commit-Id: 31467b23823ffec1f6fff407f8e3ca9af8b7491a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe6f8e913df9319db03fd107671ff02f104ca38c
Message-Id: <177904611035.673362.7437999102593781569.pr-tracker-bot@kernel.org>
Date: Sun, 17 May 2026 19:28:30 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, aboorvad@linux.ibm.com, allyheev@gmail.com, bvanassche@acm.org, christophe.leroy@csgroup.eu, julianbraha@gmail.com, linusw@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, make24@iscas.ac.cn, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, sayalip@linux.ibm.com, sshegde@linux.ibm.com
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

The pull request you sent on Sat, 16 May 2026 11:25:28 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe6f8e913df9319db03fd107671ff02f104ca38c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


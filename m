Return-Path: <linuxppc-dev+bounces-1776-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07822CFB424
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Oct 2024 19:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XMBlz23rFz2y7K;
	Mon,  7 Oct 2024 06:14:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728242047;
	cv=none; b=A8czW0ycLLprU+wKNSrMSaw7t/bOS0A+Kmxh1TxtsYyK+QA5kSGjiK4vgLD4QD3RdZKF8EXN9XxmDrttpAOEhXfdvua18lCPNdeBI62J6VepLViuSG4kevI8Xqxpn2xlmFeVgRSC5W7rfwADv4ihhwSi2n8s3szHWqVHwh9OZdfaVJ4gy1myenn8kRWAt2mKktech9EM+Jr0npzk+5rYBuM48SUp34S7652afps62nzf/qMI9O4AjwiofPgmZDx+ejYt1zdIqffVeAdt1/v+lPDV3aHbc8YMHj/MM1dnhq7W/rQ5fGcAsCV3MlRRytPtWo7uTMtJoQ1Kwyv+Smoupw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728242047; c=relaxed/relaxed;
	bh=tYKHTqJ+/BjgCIePtTKokaTZNxJasovh5l0beK2pdO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LQUHOTiiaX/dobf3PsyXz9Wo8bTLL7lGqf60ZBHFWjRDN73hW2sQhhLBnJ2KUuTcyCRuO/IraRunH8DcPPEntQEJgdVtTSIA4MU7ULaDyKJbzBnV2yhVxDIuhIuQAOf0fV+dHgfludnjoM6bYYdU3otxzrWsKIxhuSxuXL/SM//t4usPMZipQK/EEQp+LfAWOhfN6eW//5dtlbV8DU/xZoyP/ylIAZBVJxFQCvupfquwycgGhH/NQnL8iMYwCV1bEWL/YGaiIEW1cFIUlOnuS+YbVs9Yp32tR6quOM9/opgoA09gr/KECZ5J2GgNX7q062n54SO8BR4FohFPuWuXmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Qjpl90jO; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Qjpl90jO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XMBlx5Qlfz2xBm
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Oct 2024 06:14:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1483DA40E98;
	Sun,  6 Oct 2024 19:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB99C4CEC5;
	Sun,  6 Oct 2024 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728242038;
	bh=QqHODBGAmDsDiewZwnqtkjjxYYRrjU2tBqPeDbGJGMY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qjpl90jOtr69yJY9D7pwkizOhbAy3szzY6rVd9P+bS0p1uokZB15c6i6JAAf2FT87
	 VOsAhinf4FHarbSRLKQSn/86UW4+1T4CbaL9YLrkJlbQqRRO5BdRUvEfmPOBoSUsd6
	 uqhnnQ8gBqx0hDE2lTxyLI7Wb4z12plsRgYih8R43/85rZbcs/gU82uygfA94Gw7jI
	 uQWCo8kIT9tXOeS6LKcrCSETjZMyNDGy6qPZFDFdRp2MNDHYd6/YAy0BvnYffR+kly
	 cudkFw5yob8ljgmUs/FhyjHNdB2A7FLGu3dBnkdHLRTONOJNuv/jzk/Tb5rAi6snV5
	 AqmPSokC1XePA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB63806656;
	Sun,  6 Oct 2024 19:14:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87bjzxlnmx.fsf@mail.lhotse>
References: <87bjzxlnmx.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87bjzxlnmx.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-3
X-PR-Tracked-Commit-Id: 4b058c9f281f5b100efbf665dd5a1a05e1654d6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3ce5c30a0e05ee3600c82925bebaa4dc1b29cfd
Message-Id: <172824204192.3486601.14939940245333023042.pr-tracker-bot@kernel.org>
Date: Sun, 06 Oct 2024 19:14:01 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason@zx2c4.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>

The pull request you sent on Sun, 06 Oct 2024 18:02:46 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3ce5c30a0e05ee3600c82925bebaa4dc1b29cfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


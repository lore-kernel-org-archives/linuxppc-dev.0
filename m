Return-Path: <linuxppc-dev+bounces-18205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EDCF3026D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 18:47:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYnK10wgwz2yYy;
	Mon, 16 Mar 2026 05:47:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773600453;
	cv=none; b=biMXrx20Wo7hDdLD9D0bTd4Lo8XBgFbWRnjBhOjc5BNLCzHEwX5U9JTYF+Y8vsdHy0gDZXaTYKWAj/+nzf7DsOK8XrN8yxwz1As8FHmtP2xEPMKCpOJBCgQTXr7viHdSNy5riHXquypRY+RSpB1nFwdOtZf6kIhiotFlI/zrEBMasXE5o203IUnq0uCp46sJt7sxlca9verazitb0R/VG84fGBFdbqmVMSzKVTPXQkm3WFFsdUJqXl3yONJy0pzykVpZ2StHsDTERZ3ISkG4BpD1vrGnFTWrEFj1wNuUsp3qn4qPiRCJoxGfV1glDeZfWLg116r6Rp3gGy+DKE69Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773600453; c=relaxed/relaxed;
	bh=B7vyUjVNoLyYbuP2rdAgAhtms0QdsKUWsGBi6xgtJ2k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FCx2uZtaMHGuvdzM8tntzk6q8k8ZUNDNbMdKLd+xjCzM2yJPX+ogaqj7/0xhphTZG2avfFPliN6xTOv59NqJ0Bq16wG+CJ9z33mD0Gi6uCLwwt65CsB1VndHlO89rti8Uypl1In7rA3Z4JWV2BIG9U1EjHeqMInlzAZyRt/xyeJCWXaMMZe1fhVsz1/4vpH83s/0785edTE6FO8wTHDCT50vnrl7eSWGxHcpPckrpyEUhowYgBoG4AtfOTLpeQ7dhRGS6NgveAYrd8fu1syNqZaPAxWOZ0QNE6/z70v8Md3p6yMsTZLfLTT77k91AZpkf+HXxxAzR+Uim0expTOMKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TxS8K6j/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TxS8K6j/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYnK02mMqz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 05:47:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1898C4346C;
	Sun, 15 Mar 2026 18:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC61C4CEF7;
	Sun, 15 Mar 2026 18:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773600449;
	bh=8uuuwgii9UA7r2/YrgNPOtaJP9WvFJmBYedVlUluFfE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TxS8K6j/X73fRjqQarpAgCYDa8yDMUDz5nMUB+d2awb9wD2zNVSaMK9TjIsivYmPA
	 5om8SxX2Cf3AGHAQguGjVfHYx7YbEMxC4eFzLfVX+10WdeoYfO1fIKFAmAKwy1wM9H
	 v9JsmBaD9vWzjrDhqepz4Swd0cemKqyqW6YEU1TLpSVqSuC3D2D4XWhSkJ4SrdkA8b
	 eO3MuAK6Sl6miYz8pCGyd1YfOa92B5K1QftnE0pkQ9qTZM4FzyKk3OoVIZJ0vnEckJ
	 GdJTuUnqYs+ytBoW6mY2vQ8WUSWKWb3L38s+RffONmQqFntzufx9K+O0KAKxHFxAMl
	 yJP3NVbySS2BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1883808200;
	Sun, 15 Mar 2026 18:47:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.0-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <a192e75f-10c2-4733-8a19-11ef8600747c@linux.ibm.com>
References: <a192e75f-10c2-4733-8a19-11ef8600747c@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a192e75f-10c2-4733-8a19-11ef8600747c@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.0-3
X-PR-Tracked-Commit-Id: 82f73ef9c41e0623e0a8bdce4fa44a7237709f0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f3df2e5ea69f5717d2721922aff263c31957548
Message-Id: <177360044255.1970460.16838472266162141014.pr-tracker-bot@kernel.org>
Date: Sun, 15 Mar 2026 18:47:22 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, naveen@kernel.org, nilay@linux.ibm.com, npiggin@gmail.com, ritesh.list@gmail.com, sayalip@linux.ibm.com, vmalik@redhat.com
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

The pull request you sent on Sun, 15 Mar 2026 09:13:15 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f3df2e5ea69f5717d2721922aff263c31957548

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


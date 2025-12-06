Return-Path: <linuxppc-dev+bounces-14668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA02D3ABD8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Dec 2025 01:24:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dNVrf74DFz2xrL;
	Sat, 06 Dec 2025 12:24:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764984242;
	cv=none; b=dvzUBHw9jfjdDQDMH5iuYkn+CVDNnxwqKZqNH3l7RHUuc+e5mxPekhX1WpOh9K//tTDREsnqBGrxTYZhKVtA1j+sfC+A/9dOdtoLSAnxxCDYbcxQCk43YXE3c+U0LA9QQIEEjsTGRC2uG9ObU4hBtHd3l799rKJU0qo++M0dBQyq2q5y7Ee4k5CeWORLRRzA9wpR3mUVd1JuApalKJvMSd/cE0uZrCSvUnpnBspLKjoBwFy9PCJevyfilFZdjV0BWuhjYtzU2ie+YgeXZChK0vOdQpEthezas85+tML7ungzY3ImxE7l0GtzXf84B/yeEdZqGpsHR3p3UY2aY1Nk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764984242; c=relaxed/relaxed;
	bh=tDaD17ZvKT0de3x022ZEOe5LlcYfWQMFI+UwTFt6iP4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ikx8+WwVKsyatfYqMirqf1gu3qPqrhsKBdF1TuZ9GNi6fKHOitw2SVXp6GEtPKnM14/WFwxm0ib0G4KBTD0TZKhFe8aj7M6NIsrnmNksYytpa3sqTSyIg5vhANWVr5O0nNm9TsmvZRuII/9GdanYOZ321jSrzLB+lxMVTGPate1JvghLWBZZAYiX5W1w6x0rwqpYCEitOqyTT1YXw8OPQSH+7fTAfcRLGkMWBKwl9jyVrM/+Ecd+24WYNnZEUqnedkCXpeFwUUMEHJDYVTG3fFXFHmCZr67eUmsrVgQJ1Q8WXZHQorn5/5pMxUkBEkk0aUvucMtfXWB0lDpX5++MPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m6pZRzFm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m6pZRzFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dNVrf1MFxz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Dec 2025 12:24:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B368944223;
	Sat,  6 Dec 2025 01:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACA8C4CEF1;
	Sat,  6 Dec 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764984239;
	bh=GNi8raII27p2ilJnsAHZ6tHQYqE9GgBXpfSNiHp5hXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m6pZRzFmlxHSt6JqP2XTkCzmHrYgHI4zN4JWqXQHu501v5TKC729upQO5+CuZuRfm
	 p7kQgcYEaGMoE8ng9WZGlK8t7tn7LczPj8yCqH+4ByluJKHtwXlARW+fT9+dK518Yx
	 V1hFtBDtf2/toWuAf/SzMLTqeB35D83Hjg+udvVXS92/VkOx0hBmT2AnZ75+DKSdug
	 wQXxYzo4uOEJpE3YrpkToEhScScgU2eLHeXjE4B3bvU3zlgDgyPBqXWcIIt3XqX5QT
	 HgIHhUcuCyRxHNN/iKhZNJx5c6EdbGDK+kyGOc4PvCL+mhBFHIbKriIA7v94qHCJ/7
	 dc/c75aEVCN7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B94A3808200;
	Sat,  6 Dec 2025 01:20:58 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.19-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zf7y1o4r.fsf@mpe.ellerman.id.au>
References: <87zf7y1o4r.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zf7y1o4r.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.19-1
X-PR-Tracked-Commit-Id: 9b36c7fc5aa5f2c6e6eeb9f312fdfe61b4291c9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad952db4a865e96ec98d4c5874a4699fe3286d56
Message-Id: <176498405676.1907434.6281833551067920040.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 01:20:56 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, antonio.feijoo@suse.com, bcollins@kernel.org, chentao@kylinos.cn, dave@vasilevsky.ca, donettom@linux.ibm.com, j.ne@posteo.net, leo.lilong@huawei.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, nathan@kernel.org, ritesh.list@gmail.com, sourabhjain@linux.ibm.com, srikar@linux.ibm.com, tzimmermann@suse.de, unixbhaskar@gmail.com
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

The pull request you sent on Thu, 04 Dec 2025 22:29:24 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad952db4a865e96ec98d4c5874a4699fe3286d56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


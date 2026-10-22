Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383A60A2629
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLtJ43zB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9ZW93XkNz2y2J;
	Fri, 23 Oct 2026 05:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792693925;
	cv=none; b=LDcv0aHoCRt9jkqxTEy4Bgpsvcz/kwVAhm0HnHNbdaoYp23swQ9AwNgfu7MdY7JgS5VC/kNz+U/UKXrodWwn6TMaRuHxa2K435loi4AK0CJNf274u/yxG1MfGAYDJfKICqYjL/J0GjUTj70ovne2QSnPoourUmaqQGrvsuyL+snxfdXk6ZN7kJaLaPovsfGC8EcujFaroU0eDr4NMfgeKkHOmd+FVueVFT89urFk70L7spUS8L5YYSlTNik9wDRISf1kMxMdH7rITYuHI7eNqbB/SLqRK5A7YRB+E38c+VTlt+apVTfDGcsI7gjhu1m6AwvunXKSWQCVvLXYX+M8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792693925; c=relaxed/relaxed;
	bh=Ckqaswfo9sEyvIsIurDoe3dyP3Wi6JEgkyS1WVag/Wk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AspbIdsc1hdihmj11OG9SdMpwoX6BNXz5FVOCBu6wkwB/QozhpdVIHEOdUHLotHT0FMN++yncsa4T8BWwmd4EMZNo0xE1hOkuBMrkUR7LSiZPzIlm63SQmujxiKk/SlDWxuoWEtiLKglrMBzgnkhJnnVFM2Io0IkurYGSG3RlZjPfb/QZqPUvQJs4occN0E9aoj1Am8GiVFSANUOgy9nQsvZe36va8SK++PyuibxCBhNlIhrh7b2BBDPyArdqKX0S0wCse0whnnU+weBlLXyhUAGj3fsfxBayeE1Ta88q4soYA29iGY4N7GHds3U9cpLgz0YuBqL7kZ/I5oIJfDmag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLtJ43zB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLtJ43zB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9ZW80cybz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 05:32:03 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D7386602C5;
	Thu, 22 Oct 2026 18:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8C51F031E3;
	Thu, 22 Oct 2026 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693920;
	bh=Ckqaswfo9sEyvIsIurDoe3dyP3Wi6JEgkyS1WVag/Wk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eLtJ43zBithfmjNqhofHIXl8azLl8YYygLgsCLKqQMuL61LrQeOhfQ/WIc1hEsUNR
	 8aIzD9U2D0dCBA5QaP3697g6pnhQbymTZ7J5+2TH1/wJw7Q/tns7XzCep8GGz+6y6I
	 oQOSoNudlYA1yyz+uVllZz80YhEN0tDFTx9NueEsSQBqH/zdHidFbRV5gRzHjPGpYf
	 mRXAIXDGIwJpp9xOhrBFhywKDYoWAN/4V9NbeAitXyJpwAxS0jl++8xG9z0udLgkwp
	 3To19SaA2A8kh781HbGCwtn5c7R/Db5ZalYZVqHv8v62QUcEs7n88rLpGBiVtQAZ61
	 qBUMyvlKh3Guw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 80E7F380822E;
	Thu, 22 Oct 2026 18:32:00 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.4-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
References: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.4-1
X-PR-Tracked-Commit-Id: 129f5d395fd66b6587a5ac156b232cca060d6512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb2235894a8a604c08b3f93f4e1082b9df03265a
Message-Id: <179269391934.87271.7544822800655175224.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:31:59 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, adubey@linux.ibm.com, amachhiw@linux.ibm.com, blum@kernel.org, christophe.leroy@csgroup.eu, dmitry.torokhov@gmail.com, gautam@linux.ibm.com, gbatra@linux.ibm.com, hbathini@linux.ibm.com, kaylovefoss@gmail.com, kmehltretter@gmail.com, linkmauve@linkmauve.fr, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mkchauras@gmail.com, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, shivangu@linux.ibm.com, srikar@linux.ibm.com, sshegde@linux.ibm.com, ssrish@linux.ibm.com, venkat88@linux.ibm.com, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Wed, 21 Oct 2026 10:19:07 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb2235894a8a604c08b3f93f4e1082b9df03265a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


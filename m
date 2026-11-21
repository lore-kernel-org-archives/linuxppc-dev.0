Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE68606A330
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2026 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9Hd9qiR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jX4VH6jtXz2xLq;
	Sun, 22 Nov 2026 08:05:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795295127;
	cv=none; b=abGR0Mg0RajyAiOH6oEZzqd3B7uDu39uMiIveOiWCq+wkUTRfb3I0m9V0MNc906O78XxWo97tueKxiGIy81jw25LLUlaYSfVrl1CnI+VVujr9RTtHlkJO45wssW6jBSN4yrg8b0RqtuKkwGBtWLfXoJ5+LQeICKVAlbUT9BZT8bA1IOiaNJJpVZO2vFdceNHHgJM1k9s+JUdvuIh0xnxQeKDAIjrEJSwzTq0LCoX0b0BLimkfrHmkQe9QSS7c/vtQ4lxFHpxbJsrWkoaut0AEn8bHcgkUQTgkS8/PieDcSJvP69iO8uBeaX10lkuhMWjPl36CoH8YBAT++Mdxge+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795295127; c=relaxed/relaxed;
	bh=kut3RnC+sJhmtjNJCZ9oinVvtWFuAO9/28dyTHZ3+pc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PzwdtZ8QamNZ3M29KIyb2n1xkqyYcNH7KYuWY2b1USZ2rNg7PFhNTmJnvozPVrQDvlTZV9lTeLH1EJQ8iDWs7BTmk8tRauNpptUaICwRzMiknxSFPhIRa+eye5jNXiDjA4GjuP+eC315m08Vn0PnZjeOeSzQUEdC215B0CifPqW3OlVlBnQF0THQS8u5W0oyOXN0g6sqvdWezg5W6YdcX3HSkq/w1yPF6R1BVbNzqPKZlyAu0AP5qpLMMGlMPYN2vvj8e5erudXSYFEb1WctD3z+PlC0LozTOOV1lnCu0FGyhgFXud1jILWK1tpZW9uIQ880qgOpsZFe2x+4UApp4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9Hd9qiR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9Hd9qiR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jX4VH0x7Vz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 08:05:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9765861CF7;
	Sat, 21 Nov 2026 21:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460AE1F000C4;
	Sat, 21 Nov 2026 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295123;
	bh=kut3RnC+sJhmtjNJCZ9oinVvtWFuAO9/28dyTHZ3+pc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=B9Hd9qiRrwP84tw05mnaamPACaa0JzLoTVI9KSQpjLy9j2w3SrL4+WL6wgVPPdNac
	 /tQ23Wk+VF26MG1SWB4YO6/Iqv+vekCHa1QoTrcZIRx7ysGJcxxCqFZeATiD1FQhmG
	 A8XExvxJf2Ff/6pvuQOMFwZJiVgI4pKZbRm9Ho56css7sfumZ6+x20R2+qJsrC2IEO
	 zVknB3PVAhJ7fx9DvCpzp7V8uUT1JS9X1aRONUPdXzpl/vWTtWOjS02rEYPa4bI+b1
	 B0l32y5+GUd8qlzRP0JRlVLih07WnaU3XFBejgD8qQnt8QnF7QUhpoageLWPdosKnB
	 izqj1nLwU/0EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4D2391B072;
	Sat, 21 Nov 2026 21:05:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.4-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <cfa609ff-9ccc-417c-a816-56b364d0bf76@linux.ibm.com>
References: <cfa609ff-9ccc-417c-a816-56b364d0bf76@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cfa609ff-9ccc-417c-a816-56b364d0bf76@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.4-3
X-PR-Tracked-Commit-Id: bd6d2f87c2239d10bf5f37ab52b3968565528417
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b7fe306dd86b5342d3be8a3f1cbf3bb1ebf280f
Message-Id: <179529512179.1171121.18032448255591519626.pr-tracker-bot@kernel.org>
Date: Sat, 21 Nov 2026 21:05:21 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, gautam@linux.ibm.com, haoxiang_li2024@163.com, kmehltretter@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, mpe@ellerman.id.au, nathan@kernel.org, naveen@kernel.org, nnmlinux@linux.ibm.com, npiggin@gmail.com, ritesh.list@gmail.com, sourabhjain@linux.ibm.com, sshegde@linux.ibm.com, yadavgaurav386@gmail.com
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

The pull request you sent on Sat, 21 Nov 2026 16:01:29 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b7fe306dd86b5342d3be8a3f1cbf3bb1ebf280f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


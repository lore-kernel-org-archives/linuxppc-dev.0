Return-Path: <linuxppc-dev+bounces-26822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6491EC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:49:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfVKT4B0bz2y1F;
	Wed, 09 Sep 2026 02:49:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788886189;
	cv=none; b=jJX42bW68GVGz7DcUE8YOYT6jjw2gUrluVkGsYqULLVRdSbSwCkDmsVVRCay1xef6TrtF3bw8sPRO6Zk2zyw/Pe6moQHrrqdUi37tnBzHl0Zqtxca6rHWU2zxCHsRfuqpUFMzfiUorDYDTd97Il7st5XXIP0ysO7zRuBY1THNPEXuz6E2YyM7uwJwTq/2ejzF7Bc8sVt6nGKMnIdT0oVsdr3YCwqYZhfXeBpKNGfPdZFveTUqnKPMvjimS9X1gXSmb/xSuog0XEuXwVqP/Os6dqo/oHuFr0LVY1r8sRpzkoxoPMIy2nHX2oGRhHk6PAt4/IoR6zZVK5q73ISR8gAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788886189; c=relaxed/relaxed;
	bh=WxZ7LbfHACs3pzhWJ4CsjpCYtuYOS4Xcie8f7D0g/lk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ARv/C2NS+/96HDj0Tx9lYPf5vPcHtuJO4rFPT1knD3UCgISsw/yRoxTazDEVCalEatnE59sSy1b9cWlNncgNxNQK65RccFhq9PKtrYG/OeJQ2fTripax44emUgx/XNhz5I0Z1ybjt9kkuHcw7OXN+0ENZqV90Zm/Qgm47ul0YX/L6QlLQ3weGfc85ackNH6fEaNX2MdbcVstuB++QsITZpi80/vizKvi0DQykHkaVsfpx/sgrQxwPWP1hnHQFpnOJLTaEb/twlGqgu3x8eKwQBfc/dYuZQftakSE/lTo3Qb2sm0wY4JJhG1qoFkdz8yoSNoPhqUFbSkySA5ueuZDNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLgL1NBZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLgL1NBZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfVKS3qqxz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 02:49:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F20F601F7;
	Tue,  8 Sep 2026 16:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4598F1F00A3A;
	Tue,  8 Sep 2026 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788886185;
	bh=WxZ7LbfHACs3pzhWJ4CsjpCYtuYOS4Xcie8f7D0g/lk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XLgL1NBZROxtoqQzvxJKsPWibG5oG+VwSqnsTZhsAolZXqXqUPCt6H8diDodCgK0m
	 mUmpEyuppxKREBDbBHNgb8iOLKuoB8p+DoJDewjkbow+SZhTDKMx2HuZJ2fXQCu7o0
	 Z8uBKwohCzF6dnsa/ACLJ6vPYARjLfhl7c4X8Dq83rgjZKzDcjWpa6JQqIatfEwzGw
	 vd19wE5Cc6RKOZKFs9E+dUDeE71Vo4yCAGXy8lncQHASP4onxC5kHo+h4ANt2x0eSi
	 vJjoo2809V5aTPBti7zVk+VYN2HNQsWrbn7p9wwTIQkFREFf341N0a4cG13WKbPVwe
	 uU4r5TcIbmaSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199C039EAFC0;
	Tue,  8 Sep 2026 16:48:45 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <54e891f8-d549-4ab0-91ea-999d6e8dd385@linux.ibm.com>
References: <54e891f8-d549-4ab0-91ea-999d6e8dd385@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <54e891f8-d549-4ab0-91ea-999d6e8dd385@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.3-2
X-PR-Tracked-Commit-Id: 45a5f7285f835adb3b74c9344c09a7bd2c4fb664
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5acbae5f7eb3d5275120abfe698c394b7325dcec
Message-Id: <178888612365.3639424.6482272206920161969.pr-tracker-bot@kernel.org>
Date: Tue, 08 Sep 2026 16:48:43 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, chleroy@kernel.org, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mkchauras@gmail.com, mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com, ritesh.list@gmail.com, sbhat@linux.ibm.com, sshegde@linux.ibm.com, thorsten.blum@linux.dev, yijiangshan@kylinos.cn
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

The pull request you sent on Tue, 8 Sep 2026 12:00:29 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-7.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5acbae5f7eb3d5275120abfe698c394b7325dcec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


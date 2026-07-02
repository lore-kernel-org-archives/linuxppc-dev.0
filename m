Return-Path: <linuxppc-dev+bounces-23375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE0DC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:50:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grVvq5LT8z2xLk;
	Thu, 02 Jul 2026 18:50:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782982231;
	cv=none; b=ZQcOFXRJEsGskRQ+gGs2c90Yz7SweiHYWoAu2rLKmm8eDg9gYPHh0fpmXeiPn8D1Zgk8/VDjzt1sh5GqJg1Rbjl+34B4sTnTk9Tn3Hw5Wxmu4sDqDGfAfz8B32vXa2FUzYhElXENbLdMHO+ZhJfb4/4guQk9YgJ7BroWcUp9OyeOxbXicUgko4emjrjB+JHkuuCzpct+pK2SZ+pm0FKYMVfHf9N8HqEeqT/HgjS1HrU69+y+n4FJV21z/f0q3fPuO56mcWyVv1gxUsOg+VhRgD+JVs3lvqRhCOTYioNca/X9v4z2vEiUEBVxYgdm1z4UextY1xk/QggnU8UsprUWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782982231; c=relaxed/relaxed;
	bh=rhxeF43WyemNyllTwqUsGUcBXIry0Dl0g/EQ590O6Yo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LC/QGIxFfmhyQ2N1BbofGWZcOhEagwKKXyiumITdjSjO7k4mYWOzX95C/4yQre4xcwR6+EVZdFTUNxO6akiVYt57b69xaWnCgrIFGM+MblJdTwcMKax5zHE0qDteYKjiwsa11u5qrBPLhM2zM3kY5sTmf4bXWlHaERrrvcyQ0hZ19AG+LH2OXk07F1RnEpRKmHc5RLzvGaNdP6VIsgKdTx2gOls1DwJfXbXywK4paJbj5rRzTuVjq7SwIXDGaaI4gEY2kTf1Q8uJvYyP47hLPLmMiT11nD+pabQLTXl/5pw/M28o7Kmx3vlzkbQ0xN/6+0/D7kVNOIAQR3MiZvwUVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kThrb5fX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kThrb5fX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grVvn3jtVz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 18:50:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A66E41387;
	Thu,  2 Jul 2026 08:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB481F000E9;
	Thu,  2 Jul 2026 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782982226;
	bh=rhxeF43WyemNyllTwqUsGUcBXIry0Dl0g/EQ590O6Yo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kThrb5fX38chmzb9y35tycR6aL2Y2DuCPVk0G57doPYKL8DR0yrJtOrsovmmttLSy
	 FsA9lr0YZV22HDSbSEy9QiBWHzfOz13P3chp1ohak70bghZ+h8/lY6Uq+rnmZf2xJv
	 98zQhyFsA7lxjjTCgGQqoBcAmHALVBtGP6C6jrw5gXET6a+GkVcMsCkUCdgM+L+RA2
	 0tyBaT6/v4je8EyP3vuU91lc+uz9Zdu3E8MfHQetBzj8Bz+3YpZKKfxZFbZ5NcW+7q
	 4vYADYEZ/4NXOQbnGh92DgVCAjXvxw+SWTKIaLwJxNCeWZ4MqOkJvUYHgnkiucnNPC
	 UMr1csfjyEjeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD23926665;
	Thu,  2 Jul 2026 08:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: remove the orphaned IBM eHEA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298220914.1528507.15309784548994376903.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:50:09 +0000
References: <20260629211343.3712775-1-drc@linux.ibm.com>
In-Reply-To: <20260629211343.3712775-1-drc@linux.ibm.com>
To: David Christensen <drc@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jun 2026 16:13:41 -0500 you wrote:
> The IBM eHEA (Ethernet Host Ethernet Adapter) driver has been orphaned
> since April 2024 with no active maintainer stepping forward. This series
> removes the driver and associated references from the kernel tree.
> 
> The driver was marked as an Orphan on April 18, 2024:
> 
> commit 97ec32b583bb ("MAINTAINERS: eth: mark IBM eHEA as an Orphan")
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ehea: remove the ehea driver
    https://git.kernel.org/netdev/net-next/c/eb56577ae9a5
  - [net-next,2/2] powerpc: remove ehea driver references
    https://git.kernel.org/netdev/net-next/c/4bbb6f594070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




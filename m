Return-Path: <linuxppc-dev+bounces-16288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A800C88E43
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jan 2026 04:22:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dzwNT32wQz2xnl;
	Mon, 26 Jan 2026 15:22:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769401321;
	cv=none; b=GKHLyTpn7ONtQGO7Z6ZaE671tNXuBVzH1sMQKvkBLGz54NJz3zjc2X4iwjwaOmzFt3xyn9XUqCrBVkWe1N+aScZ5/BvxY5V++Jn1FBPTAAiwvv3wYM1dhzWbxGPqDrli54kRWt0xJVmokSgg2JAI7iyPJRF6JMHqiIlFLr6/Wyg/nZyWD8em10RNqCH4wONswe5eflO8dVS/AV/HK97vIkmzmGnXs6/7q6/ZUNFQkvAOFWiw6qX+UOOQGQIu3Oax722poCtuBSeit/Bnsk16pn+YbV+S3CASQf/qkvDVe7T2pINpy/nsA8r0Pxv6a2zaeTseTbv6oQNz8f4YA8MwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769401321; c=relaxed/relaxed;
	bh=sLUqjxXZv7lWAxSUjPYCz/KXL/xFyVEfhNPKReA43tI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kv8r+VST496oEej73nbZ3Ljar+99aOw6Xvt28OZLGo3eqrZEysiYrAV0Ze8IrhYUScsDvSZhCq2Vds85s9hHbNRNKtc+a9ZFw5y/iZt1hYYNcbZU5+ZqmrW47BifNpIt1QO5pCyDjaNow7q2UnPNcYNwPFbYjUgO59zs4cNfoAacII9yMJ1pUoJkKwqy7eZwBi1RUMHa8oDsKaYq3juFiFpsNzv9DKOrBXXqRVJklEQCLXOdh7OHaclKyCHz+9xDLsmKh97t0OjR1OqWtFIVHuo7E6/ESJDV258/0RQ1kkzXAFvguzpslqIGls238rk43NJYTP6KR3QnSpiGYdVtuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mx3khty3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mx3khty3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dzwNS27kgz2xP8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2026 15:22:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 38FED44180;
	Mon, 26 Jan 2026 04:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163A3C116C6;
	Mon, 26 Jan 2026 04:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769401318;
	bh=u2mZjtT2ef63nBRxN806PtRnf8Sp48BSpzrnucxNvLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mx3khty3+dTGClMOSsm4TCGURDjhMxIJ6Hr1bO+Hbm7pIDDMRiqqUI60/PSBokAlS
	 XDKfB/qj+L3xyJ2qvyINgs0wD1pWn95s+Rkn2LpKpDZVb3Qm6E11lRb6+gmxfXX2fp
	 Y0puJp0SfTExJAn/+KhCOy5Bb/Cb4Wib65mAZItqOyzuEp0PMSk2hQ9F8YHBPAhLUl
	 4OkRVSJbQNM9okPoSdnbRH4h5yxkAZi8MRJuUoppDD2ti/3VZX6AQcX0/6q4RJB+hX
	 BoyEqXvgV5dn4f1qXwsNoEWqJw9JT7awjVq+tpfrUMGLV8dNWUCboeRZP7SRPsDOMP
	 iCanGpQICOKlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B303809A22;
	Mon, 26 Jan 2026 04:21:54 +0000 (UTC)
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
Subject: Re: [PATCH v7] mm/hugetlb: ignore hugepage kernel args if hugepages
 are
 unsupported
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176940131284.4057692.12950572087692218599.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 04:21:52 +0000
References: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
In-Reply-To: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, christophe.leroy@csgroup.eu,
 hca@linux.ibm.com, mingo@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 muchun.song@linux.dev, osalvador@suse.de, tglx@linutronix.de,
 gor@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, x86@kernel.org, david@kernel.org,
 ritesh.list@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed, 24 Dec 2025 17:25:24 +0530 you wrote:
> Skip processing hugepage kernel arguments (hugepagesz, hugepages, and
> default_hugepagesz) when hugepages are not supported by the
> architecture.
> 
> Some architectures may need to disable hugepages based on conditions
> discovered during kernel boot. The hugepages_supported() helper allows
> architecture code to advertise whether hugepages are supported.
> 
> [...]

Here is the summary with links:
  - [v7] mm/hugetlb: ignore hugepage kernel args if hugepages are unsupported
    https://git.kernel.org/riscv/c/b02019169284

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




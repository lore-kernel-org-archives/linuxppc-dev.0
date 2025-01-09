Return-Path: <linuxppc-dev+bounces-4921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64511E77197
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jan 2025 15:52:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTTmt5nF7z3c1w;
	Fri, 10 Jan 2025 02:51:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736437918;
	cv=none; b=Z69QQ2RgzHK0E5i8txDKCbttJ89BJwHXTeHOdBKN2esSBH30PvdFKIKUmDwp2PtOP+8fP1mF46184R3pygoW7D3VGOqmbeVJpXThp3jD/ZZ6Mlqy5tk5cL36I7GepRO55zV3i1JMJq6OiiPjI0oVduPkr5K5inTf0X5+K1ENJQgJV9THQObrmgP7ANiLsOGFqO0xhrDeh5Z1KI0z7/yaIzSC9je3odgpYzRXFgydCw8kBQHDMI97OUjyMTJbXBRR0Sf+E6kffItMdBAF19BqVetFrjCvo8rPPKKnV9dnk1Bxa/A+8DvOwITSQbEfh2tenC/rlgH4LkCl+jeDJpTlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736437918; c=relaxed/relaxed;
	bh=aLvwPrq2OgaU0a/cBhR7BasCwOVkoEZA5e8ZFXYAKgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk9FEbMG/EW01Yq/m+oVernnt5c8M5XqLy9y1UOVNXaFvIwWhVf1MZhMOxa7dGUDhJrZBBvpTaSXlNy2DyXbIM75SCfS2R7C/Fo5a5gA7D1n7xmnlVw9eLb6150FDVW6T1KTbYeZ0cqBWFgPC3bnGdR+oiKLm6iSTt+et16sM2LLergI/y+XFKT6PeqGT3nGus7XwDCRqQRhb/sCAfvG7xmCv23uTaQP8iIkuZrzk/Vlm41CG8ACr9eoX4t5j2OhMwB3a10JVh9E08sfjxyEzCm7wyEF6bN+fPrAA5IpacLzUecv2KtAZ8I0pA03zuHGbHEs72T96BQ+ANYkgPvx0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F9BSlQcx; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F9BSlQcx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTTms4dMCz3c03
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2025 02:51:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D378CA420AB;
	Thu,  9 Jan 2025 15:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E5AC4CED2;
	Thu,  9 Jan 2025 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437915;
	bh=4PNW5U1RCpwSI6ed5qCmkDfjxSB39XjXAAnaje7o+L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9BSlQcxUU/kvrDz8ezVoOO+s/YBhBI99DBGbLdRbteRKBcsdBNKhfA6NIrkjDYkC
	 9GtrmQ7VK0dv7qDBCLFFprwhk5flkxmRl+V2FYyKWlDlaQk5dy/y43RuJc1rAObSVE
	 sl7FszvwCJ3ZWmJ3LwoRXHehBmq48TqQ4/nOFcPMPAGWGxlPfP39p5Evt4580Qxykh
	 T6IreW5JxdI40u2aiQRRvDdYRS5jpPoTlnD0T3RTnaN10Mg41YwaqUaSESqRhF+j/w
	 8yWPU7z9RguVCtFoKzz3OeFzncyxzknkL/0P6P7tlQkSO/uCgw6CAfTy6ch0j+etXR
	 6KWhdTwfzx9bw==
Date: Thu, 9 Jan 2025 07:51:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH] treewide: const qualify ctl_tables where applicable
Message-ID: <20250109155154.GP1306365@frogsfrogsfrogs>
References: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>

On Thu, Jan 09, 2025 at 02:16:39PM +0100, Joel Granados wrote:
> Add the const qualifier to all the ctl_tables in the tree except the
> ones in ./net dir. The "net" sysctl code is special as it modifies the
> arrays before passing it on to the registration function.
> 
> Constifying ctl_table structs will prevent the modification of
> proc_handler function pointers as the arrays would reside in .rodata.
> This is made possible after commit 78eb4ea25cd5 ("sysctl: treewide:
> constify the ctl_table argument of proc_handlers") constified all the
> proc_handlers.

Sounds like a good idea,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> # xfs

--D


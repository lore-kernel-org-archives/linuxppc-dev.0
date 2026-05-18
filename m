Return-Path: <linuxppc-dev+bounces-21130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F1ECD4F4A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 20:29:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK8Xh2Xn6z2xpn;
	Tue, 19 May 2026 06:29:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779136148;
	cv=none; b=eTcabuPYlWZwlv0zJubAcGKp/mjSb41OnkvoIlT7GNNgOU1+VoEKWGA/dFy4hm9iHU/Uo+w5dOx/wSbWlR5sB1reDzVbia2LwHwexSoXUtbJK0NWRHI6/sh84hDiP4pRXiueDQHfZMvHZ5jKBhwlUch+qv1yLwqR4Mk9JLRvA/6pfU0mASkhm9mhfdUCJBuDkD/Zy8X2pHY+IjxFvgB0Qjn6Dx4mMHihVAV5Lkw1hdW4ftEu6XvJEbjGGSZjW1L9PU5qL2Tg4nZiCYd6ZSnswTVIEbI2fDsq/h6gFHLqjPAfZvWDBeL1yr7U90R2cOcBSk+IwuGeBpGJkqfcG67SEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779136148; c=relaxed/relaxed;
	bh=8DgudvDSTScZuk1eSiiN9fUkcq2AjoyjHgjy1GVU7SU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I6GtGxqy6iuPljWlpM8wElNtRZ51bicrK9bvzkoSQY1wbZAwi2F0R7P4CbCXn4OfklVxsJyB3AY1+bw62XrGpBGpq2nTf854BiFlkdf8LrMlK30xJ//mqXkwNrefoDsd6PAgkpdck4/XckSIpQQkPDMYB8PqxEiY29E58YPXU5JKr2IkQ4/xR5UMmvzt/2IrN1THKO8DI65b+7BiiyJCgRUQwPz2pFGiQeKN+kMr7XWyrq5Yvs2MXzq3FVD1usb6haM8NhdvQYu89iscQwnV7hdF57UsokFV7HciSaxfkHVoFe72Sshc31/E20BAjV9iq+QvVUHcHaccWgnscS5g0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kolcN3Lw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kolcN3Lw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK8Xg2CpLz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 06:29:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F23C74178E;
	Mon, 18 May 2026 20:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3329C2BCB7;
	Mon, 18 May 2026 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779136144;
	bh=nlJL4FG+FlQ7lEA+xiz8OWHlZxqnOLIRISrvfbYSZCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kolcN3LwzJr9KUU+xnxSqAVFurh3qjlaQPpxSwOdqKSarhihMdZJoIxjAnjhJJRp8
	 RnW6Cztf+B78QeWzyju8byeHD4ZCgCyy7ddKHnY2BGXLBc38A4KK481fsH/gZVMjma
	 p+8NZeLvxQeGxu6/iCnPaxSCSxu5wMII17huH0iC82iYo7/uXQ/koynSsWhpqiN+VS
	 PPPoPrEYZtMO02sSpQ4ZivR8qX+w6drO0FoI65OMGjTgR5k4Of9PNtDsK1mFKkROY2
	 wKRI2Z9EkWfPuFO5YqXGAbFI8oCu3b/i9Tir7/EwdzglaoL5YoWA1DNtApdJoPemvq
	 go5llXJswlDbQ==
Date: Mon, 18 May 2026 15:29:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Murashka <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	corbet@lwn.net, skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <20260518202903.GA641158@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>

[+cc Lukas]

On Mon, May 18, 2026 at 02:23:36PM +0100, Yury Murashka wrote:
> pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
> If a new AER error is subsequently reported, the AER driver calls
> find_source_device() to find the source of the error. It rescans the
> whole bus and picks the first device reporting an AER error. Because the
> previous error was never cleared, the error is attributed to the wrong
> device and AER recovery is started for the wrong device.
> 
> Add a kernel boot parameter pci=aer_clear_on_recovery_failure to clear
> AER error status even when recovery fails, preventing stale errors from
> causing incorrect device identification on subsequent AER events.

Why should we add a kernel parameter for this?  How would a user
decide whether to use the parameter?  Are there cases where we
find the source of the first error, but we *wouldn't* want to clear
it if recovery fails?


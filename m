Return-Path: <linuxppc-dev+bounces-16335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08507D2FEF9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 23:01:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f119823q1z2xQ1;
	Wed, 28 Jan 2026 10:01:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769554860;
	cv=none; b=lmzAqGtaAwZgAuF9jKzblcpGfEagduJ09bVuv8KyVCWeBg42kfwyeQEKVov4PRDP7Gl9DISwuzxFmlS7LZHeOGNgEe4aXtAxNgEMAR5jK2mA+VUlW6SHxJNLkKXEG+zMwYf67CXUTJ+Q3BMCBAIbkM3Fgy313KDdwoIANRdNDda688x6X62plSJsKzgwwLUXsXpqr9zFTB2OfefykXe57o2CD61t3FyefzqN3j7tgSsdXX0sS1BXbOHBAwMsz8MDQOjkF4rLp6vIz4wvDbMXGHTHdk6QXmLa2QHJeOMni9YhVivZdx/uBsYBdTCwD+2S2MLAo63CqBd3g11XeUqm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769554860; c=relaxed/relaxed;
	bh=LfKjW3qU1hLphr+A4hjbd3J1h3CE3cbb97HxJYEwJRA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MGcYcqury849FNRS/kb+okMi+enlbYmn4VTg0gJykNH1pHzjLyDT0WZplereqkqvymcLlAwdShA+p4m6RLXbAIrZMpcnj8ntq/EN01S+N2wMdC8hF7o0XV0oTp7kQsLCp5wpu25oeUJKyuWnI6/4dNrlbJISGlSW24xP2SQIBI+RnjB4eHU8RuunZBDo+06Hk8NTwqzF+S6PdJAwsAtxHYRi5xLLRjc3TD84YWohvGVGO7GNHSSkcdGdZ00UbE+P5vybKfHaYD8GLR4F6R5h6wS7+caS1oXptBcTdgSHeYWmvFXTUjeNDeIra5pXo6Yt/DBt953oZsbPsc9GGopX6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZC/L3hnF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZC/L3hnF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f119748rRz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 10:00:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D5629600B0;
	Tue, 27 Jan 2026 23:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C26FC116C6;
	Tue, 27 Jan 2026 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769554856;
	bh=/H7K35di+y+EhmmFwDD88J5ULIdDHgdZ4IyV+8b6/vA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZC/L3hnFnH6Pq+FFLN5YLdOTWVldlN8s4OleLEYClwK0VLpSM4JBFd3q1WgyMgRet
	 6tyWqd6un7Vmsga8qyv3KhNjBw4jE1qSFt0fztDVQB6QX8XQ7sJ9JB6fj9Glu1lZiQ
	 ya60A94ln/F+mjZWNOG/gZhIQ4haTn7KLrq23wnkFMWqRC+5/eYZk/ZzZXd+Wi/rgd
	 NirnMlV6wKUI0tmPYMhSVSnswjKq1AJ5NPT3cjve85UYR6zcNtoYCQR/IaYQFBRzDC
	 1/nymRAPhGXGtxdQY7rOAuBPYtbDjxaPCiNtMtFQKd+9V9ohA73YLySeG65I4VQqfi
	 hxPUOhXpPsyzg==
Date: Tue, 27 Jan 2026 17:00:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, Shuai Xue <xueshuai@linux.alibaba.com>,
	tianruidong@linux.alibaba.com, Keith Busch <kbusch@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear stale errors on reporting agents upon
 probe
Message-ID: <20260127230055.GA384686@bhelgaas>
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
In-Reply-To: <3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de>

On Sun, Jan 25, 2026 at 10:25:51AM +0100, Lukas Wunner wrote:
> Correctable and Uncorrectable Error Status Registers on reporting agents
> are cleared upon PCI device enumeration in pci_aer_init() to flush past
> events.  They're cleared again when an error is handled by the AER driver.

Do you think pci_aer_init() is the right time to clear the error
status bits?  Most of those bits are sticky, so they're not cleared by
reset.

I'm thinking about the scenario where a PCIe error occurs is captured
in the AER error status registers, but the system reboots before the
AER driver can log the error.  Since the bits are sticky, the new
kernel might have a chance to find and log the error that happened
with the previous kernel.

So I wonder if pci_aer_init() should just find the Capability and
alloc its buffers, and aer_probe() should look for existing errors and
log them before clearing them.

Of course enumeration will cause some errors (probably mostly
Unsupported Requests), and we wouldn't want to log all those.

Bjorn


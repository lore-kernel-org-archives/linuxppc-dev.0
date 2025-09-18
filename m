Return-Path: <linuxppc-dev+bounces-12399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC2CCA1013
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Sep 2025 20:33:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSS5C61qZz2yqh;
	Fri, 19 Sep 2025 06:33:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758227599;
	cv=none; b=TjfAlQNpJue8rd8xhoTA99XYh2M4r3Simw5sug+V56UHISGsfyyV3u89ycCXmrWY8J1YvGsyBqSeqq1CD8tF2tcNeP+NeYXkYT6H4o5DnnBNoN7XPAZfBs9SyiIi6GaD+psVS2XA571wenLXVaodNMMcAzHRh3r+DbM3Ml1qx5mnK9hdX5usQGwfJ+2aLAYxVsF5XP7S4PUSojIZnTMpJVzJz3YKMiCNopSY+iG50Y5rhm7IORGQz7sEv8ZCpmVySEGge/60yayfto+nvVyYG82pFs2tNDhhfs+3crypJalnU5rh2tan770NyXLWCH+bMZhvUkdDZXLrTmoUjwpqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758227599; c=relaxed/relaxed;
	bh=Z0kfvhZYxFLIJhuIR5/Nd2z7/kUbqP2WTpmGSZ6UPTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OXoykaZSfLe0DKIzGLeTCphxacFnxYS+ddvVY4XOi98y2nWktxDltGVzYUX/AUlU4Dbylsz5a6Kqoss7jDGvjrMfwYpZO6FuOdRs9a6Wu4W2y3VOz7jKg8NOGggDXrVbcg2fsTRtS5yCjpPNYPxepp2VPQEDgWION2kFHUWSzEbBpI7QZ+NZBZtgaAx5EIvTwrxV3CX4zH5EatyEv62Ww6xO2oZM41UJIFKWEkQ2CXiw03mwae79YZGNXoQIFUs/eot5EtWXLkTGo97VKyYxfI5X7I8ybPCIUp8yKsjnlJ61OVmHcR32KnRXFQsLg//8acpcYqwO6KGOWiBgZNhzew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jcDzXY7J; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jcDzXY7J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSS5C1fnRz2xgQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2025 06:33:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 79A09406D3;
	Thu, 18 Sep 2025 20:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AFAC4CEE7;
	Thu, 18 Sep 2025 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758227597;
	bh=b17n9gfNGwudyqoVogCZ25zF5jUPs86Xp8NNXdzWfmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jcDzXY7JtAX2Qmrs2oRTx+KHA+oMbI+x0iczcggT04iPXxgl4tymT0b1xtbun0jZJ
	 6V/NCODn1RjsB1kDqDGFMqbZRiE+DbrqynsDrIn2xKaToFSnrwVonZpD67skulBnvw
	 Djns0nbgerx7Q/Know0OIZRd3EYSsYGITCm2iIglEqwBOAUi2rlXvcw8PVhp4pRl+q
	 iKhTWC2TScSNclu6gWyoH8oTdaC+3dYfNtr8xef51l8GqZwwrDS+cHYG0wPQ4LH0LX
	 ECPNqIpeF0BP5uM4ECR7uVnhMYmiseECEzrSsosxlyIuaqv3rPF7AyGSZqvJZZQMlf
	 OcHdP1lOHikyA==
Date: Thu, 18 Sep 2025 15:33:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, mani@kernel.org,
	Jonathan.Cameron@huawei.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <20250918203315.GA1920702@bhelgaas>
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
In-Reply-To: <20250917063352.19429-4-xueshuai@linux.alibaba.com>

On Wed, Sep 17, 2025 at 02:33:52PM +0800, Shuai Xue wrote:
> The AER driver has historically avoided reading the configuration space of
> an endpoint or RCiEP that reported a fatal error, considering the link to
> that device unreliable. Consequently, when a fatal error occurs, the AER
> and DPC drivers do not report specific error types, resulting in logs like:
> 
> 	pcieport 0015:00:00.0: EDR: EDR event received
> 	pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
> 	pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
> 	pcieport 0015:00:00.0: AER: broadcast error_detected message
> 	pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
> 	pcieport 0015:00:00.0: AER: broadcast resume message
> 	pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
> 	pcieport 0015:00:00.0: AER: device recovery successful
> 	pcieport 0015:00:00.0: EDR: DPC port successfully recovered
> 	pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80

When you update this series, can you indent these messages with two
spaces instead of a tab?  That will preserve a little space and also
preserve the formatting when "git log" adds its own indentation.


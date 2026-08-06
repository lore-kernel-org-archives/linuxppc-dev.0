Return-Path: <linuxppc-dev+bounces-25509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4497C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:26:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDjR1yvwz30B0;
	Fri, 07 Aug 2026 03:26:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786037211;
	cv=none; b=HE5q+btUw9YU/8HTRlbG918o35q072eED+kuUrnBNlX2RELprjFDafD2LZQAa4W/+1FUkK9GroHU0VD9tV/frPZ0KotWDdTz1kb7FUfSW+tr8krLSAfa8P0UUkQ+uyLVXwoQooTNadmtXpjmb4LXEiOCB8cPvWYGmsX4yqYlj/MI5E9VIXNGApV96psxpM6Lm7xGfCfDMJEPesQEKiSusohvLS84r4sIVNVN5nmPtDX8Y8jJWyFmyWuoOPdjte0qPoQY+PAGsbv9xGW/MHrzn5+dpd/V3k8biuGAPRdJT4kxM0o9mJUjqCK+CXqhQT44K9WCUxOeaf9W5p7QiLzG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786037211; c=relaxed/relaxed;
	bh=Jci8ZAL9PyOMSQK1X2/Nm9dIvNlLs9xH8yoq61Ao1fo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SCIWX4N46rNPU3EEBArZeZ3ZQ4cse5hudB9Z2/Vt6xKgsbDJ43ipMy1LWCnGOylkDbx2pcZB9YGWEeZmYaAAq8/2iWkpCJndSFuPmjY5pzEISmenb1jwfijSpLHMkKZtAw2pC2Yhd/XWkbueXTN+/vIKIWJ0nSBPuck1A8YxXvuaCV/23DdyROoEoYWhMS8nx3k7Ei2DePA7v43i8f9/xmA+CtSYCJfmk7sz5rs4UyB1HXFmbEgoA2YyXxTzQr1WvarQ4qSpevp2jiZbqn3poIp8UK3lKmjMPdBZ+MQ9bjBsZRNX5wemQwTME9Elumg6fmF5uI4xjRJNBj69DfoEsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAu+e5m3; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAu+e5m3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDjQ3TRbz309w
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:26:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A0AB360AB0;
	Thu,  6 Aug 2026 17:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B6A1F000E9;
	Thu,  6 Aug 2026 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037207;
	bh=Jci8ZAL9PyOMSQK1X2/Nm9dIvNlLs9xH8yoq61Ao1fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mAu+e5m3FLm6/8yBI7k6dVfFIDmhihUusYSQS9clkDK4h5gVbNS2rQeK0vkgTdoRZ
	 ptqe6UgI9ux6HwBW8bW8ntGLTyXo4qkGQKGcqmc7SLsf1pYbgsXeComCaPV8/dBoDn
	 kKomEKOtSrJT/8Ii38fvJMkVYUWfOKnlk8Y6BhkYjOOjP9veIC2cav3rNQv5DJ4t+v
	 Ga8kNKmRQp2trBXbytciThaJY+qcfmoyezbvtfbyU+4kc2TBaXC1dk4Udu2sd5QMfA
	 /nRsWpkoDYAHlzAXd07inDNhBfI0UMSV/NSkiB1ygmoFruTJO/GK4RNcHxarm5dpJL
	 ccfzj9omKeASw==
Date: Thu, 6 Aug 2026 12:26:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Avinash Roy <avinash@linux.ibm.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, bhelgaas@google.com, npiggin@gmail.com,
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: Re: [PATCH] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
Message-ID: <20260806172645.GA2192955@bhelgaas>
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
In-Reply-To: <72ce5fa7-d12b-40e5-a4a2-f2de414088d1@linux.ibm.com>

On Thu, Aug 06, 2026 at 10:20:02PM +0530, Shivaprasad G Bhat wrote:
> On 8/5/26 10:48 PM, Bjorn Helgaas wrote:
> > On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
> > > From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > > 
> > > The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
> > > reset method for reliable EEH recovery on pSeries/ppc64 platforms.
> > > 
> > > FLR alone is insufficient because it does not re-initialize the Spyre
> > > firmware state machine. On ppc64 with EEH enabled,
> > > pcibios_set_pcie_reset_state() is overridden in
> > > arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
> > > EEH PE operations, which is the correct mechanism for full device
> > > recovery after an EEH event.
> > 
> > This makes it sound like this mechanism is needed for EEH recovery for
> > *all* devices, not just Spyre.  If that's the case it sounds like we
> > need more than just a Spyre-specific quirk.
> 
> Now I re-read it, The second statement needs to be re-worded. It does sound
> like its true for all devices. Quirk is only for the Spyre card.

So I guess this is related to some Spyre erratum?  Per spec, FLR is
supposed to "set all Function-specific state machines to their
initialization values" (PCIe r7.0, sec 6.6.2).


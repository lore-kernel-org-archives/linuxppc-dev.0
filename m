Return-Path: <linuxppc-dev+bounces-16707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C8EE6B65
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Feb 2026 05:55:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f7Ktc3M83z2xRv;
	Sat, 07 Feb 2026 16:55:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770443720;
	cv=none; b=g+2iudOoTHpvy6V46atX31uax8/bDMiyWaQ2f2KPGsAk6QvW7eQ2mlz7OS9s9mRnI83EZAqDm/GTb9pZe3t4YJBITlGQiPfrE3F6T6WnrF93qN2KRjqUwfGYji3oEhD2Vb54isQZamezyJW850x6h738b/pjU34KMGC/syHV3g0fApnvWlIWhaotnzqBvq/N5E2XTXoFLDRL5jKktiiMr9EAKGL4xLSL4/NcMIhf2DZdrr7oqoO64upDq5z1/eN3hrVGiGiy/kmzubNbGcdw1OtHX0Efu9nLVE4zUSfFt9i1/JgbZy/EiqeqIg0ikWsn7jc4c+qa8G7F1BQGIxcfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770443720; c=relaxed/relaxed;
	bh=dkDYANJ0vOAcQ80fvWHL7o+zkXTW0Qwm4IsGDjSXZQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcwC5ZQ/whxkpsm/ta2UiqNCPthyx793Y5XH3eEntEP6DtFcjyVgU+b13AvCaaf0NHiUOoD2+M3xDsu/2iHDfwMikFY+3P3YUp2LlfaJVGy9JSLqocBg1LFfkI15h54nsz3V+uHiAP7YuEIeelxg7EnqkiBqU9RqN4ZKEML2zlOvWeUbX04KY2CizqknOjBRzYC7lQqEYAESOOiRaTW3Yu853Apa3WAaLesoZ077xXLNZ2FdDm9eZC95kWE5ahYH6YM9jEqOLO6Ak2uB2YKVVIfz7b4/gFddrjrTE3Nz9z5GfkI3Y1YDF1PQ/w0bR+9jFEdGfMYAxZ4YufHEegrTpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y4qN5NdE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kbusch@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y4qN5NdE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kbusch@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f7Ktb1vfrz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 16:55:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C48DB441B4;
	Sat,  7 Feb 2026 05:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E2C116D0;
	Sat,  7 Feb 2026 05:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770443715;
	bh=8PukKFBx0ZPMJSJYocWLm+117LmZbUdDqx7PaS3ZQhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4qN5NdEJvGU5Obp06Gold/eJ5wAAyowy4yEejppiJvN44Ojl5C36+4e5JdV23tpw
	 Ljm0YwaAhPA4H9UAksqiKW7acrebCd2QZRMOSxnRmzfklW/XTpv1C3KjHzTm9GDmc4
	 NnC9xTffRs9rsUGrzKwnre9WCgF+dC/pi0TBo6bT/YuCPi0XPNJuGgbrkP9tq7XCtE
	 jrMkwx98xIIK1KDETiD3HcOMTeLisGhnTp61JZJuz7VtskM12M0u0ZkQ0TdRQ9n2Av
	 lcQFJfjv6EZQuAZnMEoNkXehFCQH8Y5kReIIXpAkBhFLe15+mXmQF96PzhleXzkI7J
	 1qV2zgf5rHGBg==
Date: Fri, 6 Feb 2026 22:55:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, dcostantino@meta.com, rneu@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYbTwfShdDE4fouM@kbusch-mbp>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
 <20260206185232.GA70936@bhelgaas>
 <aYY_hMZyVp7GZvX2@kbusch-mbp>
 <aYZU09qCN3u-_byj@wunner.de>
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
In-Reply-To: <aYZU09qCN3u-_byj@wunner.de>

On Fri, Feb 06, 2026 at 09:53:39PM +0100, Lukas Wunner wrote:
> On Fri, Feb 06, 2026 at 12:22:44PM -0700, Keith Busch wrote:
> > On Fri, Feb 06, 2026 at 12:52:32PM -0600, Bjorn Helgaas wrote:
> > > Are there any other similar flags you already use that we could
> > > piggy-back on?  E.g., if we raised the level to KERN_WARNING, maybe
> > > the existing "panic_on_warn" would be enough?
> > 
> > There are many KERN_WARNING messages that don't rise to the level of
> > warranting a 'panic' that don't want to enable such an option in
> > production. It looks like the panic_on_warn was introduced for developer
> > debugging.
> 
> panic_on_warn springs into action on WARN() splats, not arbitrary
> messages with KERN_WARNING severity.  Also, sysctl kernel.warn_limit
> may be used to grant a certain number of panic-free WARNs.

Okay, but the warn panic param still isn't an option for production.

> FWIW, the "pcieportdrv.aer_unrecoverable_fatal" parameter introduced
> by this patch feels somewhat oddly named.  Something like
> "pci.panic_on_fatal" might be clearer and more succinct.

Naming is hard; thanks for the suggestion.

> > I agree the curnent INFO level is too low for the generic unrecovered
> > condition, though.
> 
> At least for unbound devices, I think 918b4053184c went way too far.
> I think an unbound device should generally be considered recoverable
> through a reset.

Yes, I agree, especially considering the generic probe saves a
checkpoint of the state that we can restore to that is consistent with
the kernel's view. There's no clear reason to fail recovery when there's
no bound driver, so this changing that behavior s a good idea.

> As for bound devices whose drivers lack pci_error_handlers, it has been
> painful in practice that they're considered unrecoverable wholesale.

Yes, it gets tricky when there is a bound driver; there's no telling
whether or not it may initiate a broken transaction with cascading
consequences for the rest of the system if anything in the chain is not
cooperating with the error recovery orchestration. I don't know if there
is a best default action, so allowing it to be user defined seems okay.

> E.g. GPUs often expose an audio device as well as telemetry devices,
> all arranged below an integrated PCIe switch.  All of these devices
> need drivers with pci_error_handlers in order for the GPU to be
> recoverable.  In some cases, dummy callbacks were added to render
> the whole thing recoverable.

This experience sounds familiar, and it really does appear that a hard
reboot is the best outcome in many cases because orchestrating all the
components to recover is not going to happen. Hence the reboot param.

> So I wouldn't consider 918b4053184c to have been a universally successful
> approach and I fear that this patch goes even further.

If anyone goes through the effort of fixing that, will it be considered?
You told me in Vienna LPC '24 that you'd help resolve the pci hotplug
deadlocks that have been plaguing pci for the last 10 years, but not a
single comment has happened despite multiple complete and validated
solutions offered.


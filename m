Return-Path: <linuxppc-dev+bounces-29325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A75CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 19:17:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3S0h6Hy3z3brM;
	Tue, 13 Oct 2026 06:17:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791832676;
	cv=none; b=idswW121RYKWSUyseMx4hN7KswG8gWh6StOZ7vky07FxKJwXw8JR0JlXiFQI4pwGW+knI74f3TQy2o6epvM1n4rGvxGo3f9iDgzGORarbRBUD2hrvAWnBoTb49JkCd5KH4iBFLphfQWofTJns4YbrnggRrFXHev9t5JajxExme0n9CiRz4oU7fONLJefOx4mefQ7JROfLEvsJ6avoiLQ6Mpp+Z51CSCsS70fbC3SQV9dUBxqrlRIboGrE3UncvMSEW9hi72IUFOSNWVsvqtQ8lR2D/hOC5fm3fS4Uiz9kfSedqMB3TnGNTVYg/Vivr3wdiKgnSgCMaWBcZjlV2974w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791832676; c=relaxed/relaxed;
	bh=vSqcSyzJV7Puoq8f7n+4OrXODd3h60plAKCCLJ54N1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFBz2Oyq0dNlwxtEJSvBjDHPodV6nyV6qkEUyt6G+nqUpd4xhrZVbmIn358SQ8CLfw/yJXGTegxEBQ61wcjG3fnR+MGw4ekn3tgQVShPBQytjduHT6pJYomYLKnBQw0HtWNY44SiMVnDovIc3YyE4lJOP5KqWKlbXr+yBg6ES+7dRTy8LnMJEQ9cMTKDbS/4fUIrDjz8Wa2NdF5jlLaCCEvOqiE5gsTLEpfzqQt8MEQ2O//LUW6JnLyKShN3tERBFfOyMtUbM6IJwg90bllFImSieCuDpOXsYb3WR/XExeKB+OU2cMcfWETyavMnLyRlPeBkqLG2Xj/oPJi1jkySIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3S0g5VJwz3bpH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 06:17:55 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 9854285EA;
	Mon, 12 Oct 2026 21:17:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7611860000B7; Mon, 12 Oct 2026 21:17:49 +0200 (CEST)
Date: Mon, 12 Oct 2026 21:17:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <as0yXccnanni6KZe@wunner.de>
References: <ash0Rn78gwlQ87Fg@wunner.de>
 <20261009150724.GA974326@bhelgaas>
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
In-Reply-To: <20261009150724.GA974326@bhelgaas>

On Fri, Oct 09, 2026 at 10:07:24AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 09, 2026 at 06:57:42AM +0200, Lukas Wunner wrote:
> > Apple products with a T2 Secure Enclave will require a separate patch
> > which avoids enabling Advisory Non-Fatal Errors on this particular device.
> > A quirk, in other words.
> > 
> > I think the firmware on the T2 is upgradable in principle, but Apple isn't
> > going to do us the favor to fix it.  So we don't have any other option
> > than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> > the first device on that blacklist and maybe others to follow.
> 
> OK, it sounds like two separate issues needing two separate patches to
> fix.  So I think I'll ask Linus to pull this fix today and watch for
> the quirk next week.

In case it's not obvious, the quirk necessary for the Apple T2
was submitted by Aditya here:

https://lore.kernel.org/r/20261010172301.12764-1-aditya.garg@linux.dev/

Also, Jason attached a functionally identical patch to this e-mail:

https://lore.kernel.org/r/CABZrw2H+3yt2Y7xiq6OyAWaJM7P9ox-2nJxoQuJMwoJHLgi+YQ@mail.gmail.com/

Either patch is a viable fix for this problem.

Thanks,

Lukas


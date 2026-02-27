Return-Path: <linuxppc-dev+bounces-17374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1176FD530D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:59:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMj1W0ny9z2yFQ;
	Fri, 27 Feb 2026 19:59:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772182751;
	cv=none; b=Eaj1jtcCWMLjjbDn/nyqLu71c0cOE5NjVXXF8+AtzymagO4hpi7uLtfRP0I9J8ZxyNwA06cfBcqLeJESMCWgkVnqWxagArDJ/5VPNXRRGmf/yl7iL0hZM7hhCj1N3vX9T3yujB9t6cavgHKO8r6xrf+w98clpOzVBcf67ZGRSxA4XBdXBDe12JCrufLuwkuwOy3/oQB5/xLEsSAv3eBT5b6qew3HtiBjqLqkm3e9mJ3+gEesZ0+zGsfl2o+o6D3nUrAnbcgvQkSKrgn2BwVdEzfzrkbY6NjOOW3w2AMt8XxwXYh4Q/aWQuEHXICRyshOwq5iYWNTOyx2bf452w4OwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772182751; c=relaxed/relaxed;
	bh=3USc2QfZCgPyXVGMQZO0u6aGgfjPZSd55Ii4xffhPPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUZrK6WsMP4PP4NofhXCPgE0Argdv34hr61L/bzVFZODMsh1nalYq8U9N9EiV6OKmS1r3jMUrGaB6l96eIuvecbedQqCOPon2nhCZUMLiMZsK8MWwEGjjbSA+/pEZD7mzj848h7Zr86I03NVWa0MW7VGu1nB8d7/TDXrKsDKHLVgzWfqKJ/ntszG8TnLUAsExcwY4UtIyfwWpfZovOWbrlMbnkWKfTN1nIKGyax3obJJpZYn7BoGOIszYD4NPmyQemh6znzHEYMWhrodvL+Cg7+/FbmV//EJk6zQ4XEJF0wjJFoBYalGHSNRj7XE1y9ziWumlDZNy5W++Uol3eJMjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JAEhKUUK; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JAEhKUUK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMj1V3gFXz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 19:59:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 177D16013F;
	Fri, 27 Feb 2026 08:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3918C2BCB0;
	Fri, 27 Feb 2026 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772182746;
	bh=VzY/ze97VjQJB6pusfmZwjsA+pOGa2Ehm/PhEEoeuXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAEhKUUK1BXG9J99lnYRvccU7OFWmcACPC8G9rjuzLEiFAB2pFKgNDr54l7D9w7aY
	 xSx557fMzTqXOTN8Kd/9smGEiItjVaMfSsC/FVg+l0Ja7O5Y5AFFDboPmD3blrTLBc
	 qCpF0Whlvi8V/CSgBZSgfiu2Wu+JrwNu+N6eY65JcwI3csJVwuRyHs/glM0nZ0lbRv
	 1WyAUrwiutxoCbarTjTNR2oXy2mPIL5AwjVCagk1Hpn5C+PSAovHSd+tXGxkLdH9ju
	 ePuzH2Ur7TfopAXlAuB1pO5xVPa1dQecHrZr/EP44S+wpOCuPcj249WAdenNAENoJ+
	 vi95mzuN0VLqg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vvtg3-000000001ZV-3EUL;
	Fri, 27 Feb 2026 09:58:27 +0100
Date: Fri, 27 Feb 2026 09:58:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Khalil Blaiech <kblaiech@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aaFcs1miP88QWmtH@hovoldconsulting.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
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
In-Reply-To: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>

On Mon, Feb 23, 2026 at 09:59:29AM +0100, Bartosz Golaszewski wrote:
> It's been another year of discussing the object life-time problems at
> conferences. I2C is one of the offenders and its problems are more
> complex than those of some other subsystems. It seems the revocable[1]
> API may make its way into the kernel this year but even with it in
> place, I2C won't be able to use it as there's currently nothing to
> *revoke*. The struct device is embedded within the i2c_adapter struct
> whose lifetime is tied to the provider device being bound to its driver.
> 
> Fixing this won't be fast and easy but nothing's going to happen if we
> don't start chipping away at it. The ultimate goal in order to be able
> to use an SRCU-based solution (revocable or otherwise) is to convert the
> embedded struct device in struct i2c_adapter into an __rcu pointer that
> can be *revoked*. To that end we need to hide all dereferences of
> adap->dev in drivers.

Again, this is not the way to do this. You don't need to wrap every
access to struct device in random subsystem specific helpers to address
the lifetime issues. You're just creating a big mess here for no good
reason.

I asked you to show where you think you're going with this because none
of this looks right. Same comment applies to your other series.

Wolfram, I noticed you merged these last night. Please think again and
let's discuss the end result here. There's no question that there are
lifetime issues in i2c, but this is not the way to solve it.

Johan


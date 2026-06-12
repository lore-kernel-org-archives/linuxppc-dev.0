Return-Path: <linuxppc-dev+bounces-22578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BCECD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:58:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcPLn4plmz2ykX;
	Sat, 13 Jun 2026 01:58:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781279905;
	cv=none; b=Ebhrr1nqwVw6bmpy8Y9f1bevQLbRcncuZXZDVgzZeQNlbwmOK2TqdvdEiX+v0sekHTxDDvJY5KEvQ8i612CNUVXStjsqT4gNsuqhVIa3q6rTVjb59WQcDCgnqXO4G1G+f4a3oAKWhwdLJv32MKoQZbH+xScQsP/uTcNej3FEsLO70sGeyqe6u+HagUjiNpMkwZMIhG1nFfUq+hkItgNDMINrt1Y2fvCkTJhjWTP8wUH3AP7ruKT51vKuMrYoszhXWdh9BaBuKVYsZyRnZZ3fUY8aUDw8kvzVXmU5x4OxcwjgKs5SZBitREtGOGBFs2LRUP2B+pTG/T15XEuZzLBTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781279905; c=relaxed/relaxed;
	bh=Q7XhtRD5h/PY6BHzqS7jhF0LE/whhQmKprg+09ceZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgCCwSMFKA21ZkoDBp3ueYgrBRxowvVPv8/RKmHgD5GmwHSqSoE9vHJCOGrshWcBPbKs6+gsKEl0Fb5auRuU5nQ8M74uOGNCYjWf0EOKUZTYOawHoVzw998ENsjBo5/E2dMgxUGcFdx7lwzp8KpU+qxSWUWgxU+yMmeTH+U3yCcmc3KKiKq6UTUNXRs8zg0+jgLc5UpOZphjYar+VO72z5/1NxBYmcUTOKMK9PLnRTnreuZD+XXZYvJFYuZT5fzD2FNzLqR3kS3nFzpjXoRzL1WG4AY0vkl/BZRZ018zouUfnl1NM0EqbHRKOluMr8R6fvbbs1kyx9N/pEBTmyhAGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWf5wjhz; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWf5wjhz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcPLm5Sh9z2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 01:58:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5088D600AB;
	Fri, 12 Jun 2026 15:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074641F000E9;
	Fri, 12 Jun 2026 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279902;
	bh=Q7XhtRD5h/PY6BHzqS7jhF0LE/whhQmKprg+09ceZdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SWf5wjhz3RejAvlNBV4Pl25F48oGUm6wO0U75zqphr83qv6KkYCs+/XodS0ywUzlx
	 V3JkiQHxrskZR7+3j0FjFXc/y0akUvI1i/JfgxkLKDXtHaqX3IfK1hi377UgYy7HvX
	 vfPDebqIuCkUHaM5eTd4QyqTWnvDL6uX5Js6XRKEHPKJbex476pt3yB0Ehns+yf1XN
	 BwsGG/RwRcxu3XoLnz/8NaCp0IKHdbGRzWG4y1zv5eTl+kmNHlfvg0h+WEaa9Z+g2M
	 mU4icUTBep5XT+EXGP/HPEBzOf8MugrEVum1PqP9F5kLr7E27ig23rN5UJ/xUgdnCL
	 oZcrBnoRwAmeQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wY4Gx-00000002OWE-3vMT;
	Fri, 12 Jun 2026 17:58:19 +0200
Date: Fri, 12 Jun 2026 17:58:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] powerpc: switch to dynamic root devices
Message-ID: <aiwsm0ogkWPZcy_h@hovoldconsulting.com>
References: <20260424160259.2672722-1-johan@kernel.org>
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
In-Reply-To: <20260424160259.2672722-1-johan@kernel.org>

On Fri, Apr 24, 2026 at 06:02:56PM +0200, Johan Hovold wrote:
> This series replaces static root devices with dynamically allocated
> ones. Included is also a related printk cleanup.

> Changes in v2:
>  - only set ibmebus root pointer on successful registration
>  - add sanity check when registering ibmebus devices to avoid
>    use-after-free if ibmebus_register_driver() is called after the bus
>    failed to register (Sashiko flagged this path which I had missed)
> 
> 
> Johan Hovold (3):
>   powerpc/ps3: switch to dynamic system bus root device
>   powerpc/pseries: switch to dynamic ibmebus root device
>   powerpc/pseries: clean up ibmebus printks

Can these be picked up now?

Johan


Return-Path: <linuxppc-dev+bounces-17988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD062FD88D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 01:18:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVtDW0PGhz30BR;
	Wed, 11 Mar 2026 12:18:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773191914;
	cv=none; b=Z+2XSK3OU18EJFDmelaFlWQwFRRIkKJKiSogR2InymhFy246hY1rBR3GXZZhtUdXF4BKhTNVRBOV9wZZcRJpgBhWQuWXHlfxGCFDF0aHfBWLkZ8gjKo6stUxwp/748rS0Z8aZgazebtPvz6mzB55CQpWj8K7mwGkrzAaokAlQVcW/U0iHyEha9kE9n6K6NDaUUG5lUsZsOJulwCrSJdXhcKhB/jNb7jYEtMOcKS2vMDGYOdz3O0PkSR1zn+9WEhylG3sAPtUzZSghxbTsdMqtsQDnrtKQSJCSdjzNTnx5onAMgeG+rdvOSxvPWbndtl+z+0QvfT0ddmmj3lf8JwCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773191914; c=relaxed/relaxed;
	bh=+2qLqEcWeIdZa+cmBJAhbqSx73yrQKFstQNF28b8wUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuh5mwib6MPgmvpiNPq1BWANf9ZWen4LgtBT3R/hPqcngpijDNr9WGnpcMqt59iOM9rY/ESo4mUzX/JzKMRc/Ch6cFlKaKD64LWkOdcN7D/mnsoQ7VyBREECsshceYnoUspe9qP6Ygrp5fhc05BCHaxk9IphEXXm+3KnBPEiReUXxZDCP3MUjN58weDGiPqI+2uIvyEM/TVcis+t+5VJ4tFwha0bg4OM/ShEfuTTn8BoUr6EUAZ7NLsGw8JQsC5dCjLjON9E7fjHxDxui/cCNfgnh6T+ZICPnUWgTyUG7wYKCcCEejzkFZdyZOQJkSew2FV7LjvhS16XUsQD9IVH9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rNElMcZ/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rNElMcZ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVtDV250yz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 12:18:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C574417A7;
	Wed, 11 Mar 2026 01:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A1C2BC87;
	Wed, 11 Mar 2026 01:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773191911;
	bh=3MN5J7gHtT0iB6q2hgPDZbQjxnI7iGXFyfIUNXZZ6RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNElMcZ/oiqPMT/syzmk66cskejh79Cstrn6kGqi34MlnfQgHH3oXRf/b6pp8t3cr
	 eQZBKlG0YUGoy6qvmNbm9VSkZGe89hTvf9S3KYoOuY87OOonsgjldShGI0h9JswIlT
	 kIOBDzzz/9diVIPAtmu4HqB2KW3ucNm2B01I2HzMecC5r//hLXyMPoEUZgtUpWOt2j
	 KXJZwBeOS1svS+9hOO3uappOtHNYbprQqULxT4smEtsN26/95gWugNwpPQ2af8mWew
	 HQDisRYaMYMTxu22UqX8vhhY8Jz4kxSYTeCzDitiCkuKPat1c3I4xcTuhQyrmL0xyi
	 Kp8gn9th2s7Mg==
Date: Tue, 10 Mar 2026 18:18:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <20260311011828.GB212983@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <fab2af64-e396-45f9-8876-feff4002e04b@suse.com>
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
In-Reply-To: <fab2af64-e396-45f9-8876-feff4002e04b@suse.com>

On Tue, Feb 03, 2026 at 01:19:20PM +0100, Petr Pavlu wrote:
> > +static unsigned int get_pow2(unsigned int val)
> > +{
> > +	return 31 - __builtin_clz(val);
> > +}
> > +
> > +static unsigned int roundup_pow2(unsigned int val)
> > +{
> > +	return 1 << (get_pow2(val - 1) + 1);
> > +}
> > +
> > +static unsigned int log2_roundup(unsigned int val)
> > +{
> > +	return get_pow2(roundup_pow2(val));
> > +}
> 
> In the edge case when the kernel is built with only one module, the code
> calls log2_roundup(1) -> roundup_pow2(1) -> get_pow2(0) ->
> __builtin_clz(0). The return value of __builtin_clz() is undefined if
> the input is zero.

A suggestion:

        static unsigned int log2_roundup(unsigned int val)
        {
                if (val <= 1)
                        return 0;
                return 32 - __builtin_clz(val - 1);
        }

- Eric


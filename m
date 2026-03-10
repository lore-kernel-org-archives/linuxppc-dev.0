Return-Path: <linuxppc-dev+bounces-17983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B8FFD88C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 22:01:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVnsX6c4pz2xZK;
	Wed, 11 Mar 2026 09:01:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773180112;
	cv=none; b=LarrZ9uFkLBx6DWxE7aLC6M/wh6cAnDsCa5ws34eCNQVL7dO2m1POOu2rg+/Bh2rnlKS18awQPwgvYTvNxffWHohZzJ55WAtd8dKbuadCsfaLy8bnwuXyLDRaJhkJXMWicsX8Fany9x8kdueQUKaBXylVN/y04njHZ34v2NxLQ/2aswHsdCR5O48+hcMrbtMPJY4yVuR5D/0Mr3BBzcFu8PuOWpJVeYR46R34M8y2rJ7DSGg4ohhlgrhkkH2kF/GN4UFumHVweLI1qC6zQ1YavVZxhW9zWkDKcCQxmo5s51FlzmMfuPGySl2Fr6uI26ADgl8yXU9ARflp0H3xiRtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773180112; c=relaxed/relaxed;
	bh=8EI7BfvatAlXxxW9GaymxzyV5wprQNfv6GNjElWVhSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2/uG9myvEYUUaraawRn9+YtiLN7j5UpPkUZFhAxGibY30mGAtegzrAzPFhjAyKqY7TJAERKfPDndIeJqN8HaleG/2TTLEC0/bz4z2HSOxnGWAyIJBo0hCCicQUnqOl8koNbKGf98Qd1MrUC8HoVkYvpNmSH26eS75BVuY1hlaPib3mJt9NyTQSgD0BwTU74Fe6SmYR17wYSRP5E+Qlo3H5F8vxYHWszIXB/RF42Gp4kbrKOJYjDPY1lq8sCJWmAW7JLv5v8W+xYROAX8IY2GBs9yCTNSkaOAIkPzi8ug0Dm/W0uWjtIaI57mLUHl8QHIp+/akM5uSnpNUrumsxBMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GGvggPvE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GGvggPvE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVnsX0NbBz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 09:01:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AEB80600B0;
	Tue, 10 Mar 2026 22:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1DCC19423;
	Tue, 10 Mar 2026 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773180109;
	bh=MQ1Kvit/YkYohJNLQgbKJcXEUW5nvFuzEgTtw+akafs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGvggPvEmh8XiT63QPC7GMfLJo3hx6rmMAuG7zISFhuq9WZUmJwKJ6lnHofnDW73M
	 fn4s0miKrWTlQXpk0PkYvqybGd3Jf0YCgESE1zy9MtCrmEiLqmKVCaYucy6TxqYqwB
	 BOB7v2LEpB45L8U9lQleD0cW9W4ubqGsSgWy8nbzzrvG+zSJw8tYKEb/kgLtaRcY+N
	 4hsy8XsNJdw/bEnLdt3hyxs75ovJPGPB7Id6RxfkWivV/tO9xFsAjqy7CE7DfgNWfG
	 8zy17wQsgLHX6Yq3zfYn2MlzN8Hfqpqroo9tU98OnhnV3H/T/ApraCEXGcHecfuK2r
	 uHijp/5FckWHg==
Date: Tue, 10 Mar 2026 15:01:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
Subject: Re: [PATCH v4 09/17] module: Make module loading policy usable
 without MODULE_SIG
Message-ID: <20260310220146.GE120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-9-0b932db9b56b@weissschuh.net>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-9-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:53PM +0100, Thomas Weiﬂschuh wrote:
> The loading policy functionality will also be used by the hash-based
> module validation. Split it out from CONFIG_MODULE_SIG so it is usable
> by both.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  include/linux/module.h  |  8 ++++----
>  kernel/module/Kconfig   |  5 ++++-
>  kernel/module/main.c    | 26 +++++++++++++++++++++++++-
>  kernel/module/signing.c | 21 ---------------------
>  4 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index f288ca5cd95b..f9601cba47cd 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -444,7 +444,7 @@ struct module {
>  	const u32 *gpl_crcs;
>  	bool using_gplonly_symbols;
>  
> -#ifdef CONFIG_MODULE_SIG
> +#ifdef CONFIG_MODULE_SIG_POLICY
>  	/* Signature was verified. */
>  	bool sig_ok;
>  #endif
[...]
> +config MODULE_SIG_POLICY
> +	def_bool MODULE_SIG

Maybe MODULE_AUTH_POLICY?  Hash-based module authentication does not use
signatures.

This issue appears elsewhere in the code too.  There are lots of places
that still refer to module signatures or "sigs", when really module
authentication is meant.

I'm not sure how far you want to go with the renaming, but it's
something to think about.  It's confusing to use the term "signature" to
mean something that is not a signature.

- Eric


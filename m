Return-Path: <linuxppc-dev+bounces-27216-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126BDC88E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 08:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjzPP70Ylz2yjw;
	Mon, 14 Sep 2026 18:50:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789375817;
	cv=none; b=J2mXVpNnHFJUuMZAi0Y+S3Fzt3WLnZvlN0JMwkFSVLtayA8Yi7I9nbAHhVvTfSX9tVUKCWHJTNyRqlTazTrr/VToH5KKnxDEsEvcG5jCmHroZ6GmnWyDFHbwkZ9yFJXZxgMnVXqw+HA41if/tJx+TNgDurP41n5KwsNu2mFJIZyODholx+xYLFBJf7ObdCrSgAWiNQOW4ISeN2im5hYDZH0q9w45JINYSQ+VwlWWVRj3JHgVVS3DzokRRAkceXsi562d1LLlPqnSRTartoiyC0CAbdAQ5syTtp0LNSCxVcjGMWDXXQ43RlvX0Zy4hG6nYihe+kKno1C+0qami1Bgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789375817; c=relaxed/relaxed;
	bh=MoMrHX1ELw+N1CtqJnUoCCISv2Dk43iGQkE8bkJTkbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJXBKOa7GMf3NdTbv6bMKWjXJXgonDqxgppI30qiJ3mcz+mxcq7v/oWWoIzejYb6Y3zPPDNJQAM/FrcHAjhUs7rbe6Au9FmfDeidySXi7IzoGxue3m4FcdZPOsKjVtaRIuk1geLB4fvrLdRTai0bB6WWh1IlxtMv846O+gOB0j/0tvmf0YjZfi4jG6YfKvAQEKeGfcqA2fDmYN0+ymJEqqIBPEg4WGC1fwCkUHDA6K3WpqlLNj1kyUXOfNI4LWmg5ynpq6dEtZuJQL1F/oBE9eDUp5HpTAHSKz6DAKBh1NJqP6cocJts3gao55h3pI0TKYZd+NV7owmIWUr2WFPoFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hoXxCRLz; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hoXxCRLz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjzPN3wVKz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 18:50:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MoMrHX1ELw+N1CtqJnUoCCISv2Dk43iGQkE8bkJTkbg=; b=hoXxCRLz5TQSChrIfuVCJEUcD6
	W2QZPaFTO9CqwmqSPzTt23VdPl0177HYerkj04dAwcKoZNEMxNTWdEbQDyECZgXkjHbxQJSz0YUxU
	euFONNJm20+xs1WvLPoomjUUybFtZCT5OFXxQLsAOtEKwliZ0e0a0kvg9P6UkCbfnn0SaRMzLFpJd
	0vobP7kb5vLRZnwkQjpT76bv4KU0QleXWWNh6bphSRSvXlsIiLgXwt3IwdZ8BAjqGah9vZwVaG0NK
	rqDuK1xKRqnGN9WG8lNfW206Dq6dDyo3yHOY6IY6Zp95+RzBYhBzORWc78r6Kzj3RqpZEcOyph2Ks
	U/iA7/pw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x62Nl-003UtF-2k;
	Mon, 14 Sep 2026 08:49:46 +0000
Date: Mon, 14 Sep 2026 01:49:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Thorsten Blum <blum@kernel.org>
Cc: Nayna Jain <nayna@linux.ibm.com>, 
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc/vmx - clean up includes, metadata, and
 p8_init()
Message-ID: <aqe1F5CttAHH0ORJ@gmail.com>
References: <20260914081500.65737-2-blum@kernel.org>
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
In-Reply-To: <20260914081500.65737-2-blum@kernel.org>
X-Debian-User: leitao

On Mon, Sep 14, 2026 at 10:15:01AM +0200, Thorsten Blum wrote:
> In p8_init(), remove the goto statement and return ret directly.
> 
> Remove any redundant includes, add a missing space in MODULE_AUTHOR(),
> and join the MODULE_DESCRIPTION() strings for better grepability.
> 
> Also remove MODULE_VERSION(). It has never been updated and the kernel
> release better reflects the module version.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>


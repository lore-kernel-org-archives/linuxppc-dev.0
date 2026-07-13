Return-Path: <linuxppc-dev+bounces-24104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAE5C44506
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:02:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzGfK2r31z2xqM;
	Mon, 13 Jul 2026 19:02:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783933337;
	cv=none; b=aZFtP5AMhE+LFk2K3pK76UGpwbUU2LpmufmgBz1flK/L+mqDiEhbJMkNrY/+UxpCjgeGIQRZx+nQSENjEIDauUfT3XV3PZ1RT63uGGPwHe5qNyqiBvI8/rCmMO5QfwnC58+MayhMqzSORgWKLGQOMtlWm6KCcZhH/wPFYOT+PmiD9odqtzHibDxmW6VjO9HMjBiX6RjqjXxAzmmtEjX0gvI9Q8S2G25lZh5K5J6sxXb47SeAU5aIIEAhKMe6rOtPAIXRcbzthNHsfayTAXbb46gufjYrsgr8U5jqvfLlms/P+LGaM4B8yyv9t5V2bAXm+nnuuekJX2Kx5AgjfzSt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783933337; c=relaxed/relaxed;
	bh=BNwiur73z9ZKcEaSTwnm4ubr4IDbGUdhOCGvro4ilfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSY5JnrKzC3uvmTTGnbsPaQSYLkR8Mam7ILvCPM8k4WDqU8GN3aIvB9pqVRHFwDEG6aL0NFXelMvSmmK/kDy81VjApwiDaujpiGFipTJxLwmtKjMVQ+8S6JhVbRcG6Xy1i0X0DgKPqMRN8JYfgf8/UOMqzZReVdB/5ah+kfhxqVoIUArXed4BpRVL6iA91o83BYpvMiExS9yg5inKh2YK4hUQKXpBPFVICqG/1eph7KN/dgfskwkZEZbUuV5jj8vOPkJXNwi8QIjB2xqzfbPe94weREO6WPg1h2sYjZqzLnT8QlHtSQTDUXZ/cK9vmXzifcjT0M0nRngsq9T3mR/dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IH4bU3lK; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IH4bU3lK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzGfH4xCTz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 19:02:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BNwiur73z9ZKcEaSTwnm4ubr4IDbGUdhOCGvro4ilfc=; b=IH4bU3lKTM1jxZaX9RsJ5oLPux
	VI/tfUrEZwRmRC5tVk7HEG19DkT6jjmtNtggiVf8pUC6vzhWBqry4oapulR8lsoo7iBhEUrhxtXSG
	GJCOxDAmNWB7rJqXgE0bP4Igcie7bmEMlOfdJ5JP9V/BAutaWM9gRAGO+urpk0LzrplbuGjG+6UQA
	/8Wg+2pYmI3jIzIcE1707purm0DLOPEHLImlkbseEvuVJswN5pnUEuFN60cKOpISVoikL/XUo7NYi
	oBuoXdFNsmDRZgYL04AGTIWFoPezklWxvG9/+mvjTt460aEhGys4r9/ueY6bcz3EUy5DR7xQ/+J/A
	vWR7R3jQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wjCXk-001O5g-0O;
	Mon, 13 Jul 2026 09:01:40 +0000
Date: Mon, 13 Jul 2026 02:01:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Nayna Jain <nayna@linux.ibm.com>, 
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc/aes - use bool for encryption/decryption
 flag
Message-ID: <alSpYVYCcT_D4V8K@gmail.com>
References: <20260711145216.747128-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260711145216.747128-3-thorsten.blum@linux.dev>
X-Debian-User: leitao

On Sat, Jul 11, 2026 at 04:52:17PM +0200, Thorsten Blum wrote:
> Use bool for the CBC encryption/decryption flag passed through
> p8_aes_cbc_crypt() to aes_p8_cbc_encrypt().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Breno Leitao <leitao@debian.org>


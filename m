Return-Path: <linuxppc-dev+bounces-22123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB30CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 11:42:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX00p3RdCz2yRM;
	Fri, 05 Jun 2026 21:42:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780659754;
	cv=none; b=kYWUMGDNu+3BheYEAL16P31dpmnu7XVW5/SZE0cVeFheTYqm7JYzBrX3Y91qchgWtS3rkd3lWSxjCUYXG5zK0qGYal0KZPQ06jNFQKaHC13gtOvthHlnBIhUtRJ4mRWlu01hFnfJAwe4zxDLnb6H41F3bj7/AZS44/BiKwwF8TkW/+XXs83tkB/4ZqjjeF3+mwXPiWRaFSkn5rdYQTacuOSgv/cxmwU0GRgh/q9LMhu6ZZmrNI/Q4jvR6A7HnXugQTp9ylLGP4qO6PyY/6lOd14fah7kR5soQsTWlVoOerO9NFCJZLavZCzuiU4Be/l/kAFlwEUHsXjrf4WNuYZFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780659754; c=relaxed/relaxed;
	bh=aTy1XNVxRajlUmsekTI74t3WnZ3rR6lcNyVLeXOVEH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BruYCcJizYl0MBzO2kzWPpQUQn7jj5X4Wdd6F8RPDMD31i++00FsxUDTYGB6wx31lF3htCQ9uYzUF9RafS82b/NgQTwKVPh9nXn7qqzZBa0l0+jKjfcdiNoZsgaaD9cVxVoXebCa23ZjJ/S+dD3Z32SVLyKfz2Xv1VrJLJ+4XDb1DiTAp4HTtG12W5dS6WGZReDBB0+PZSd325oabXzmae4NtLiR1bhUEyGz57Pw3IYqUtqfBnn/duQ1TTgyX6rQWuNv7lciHnZWBAOoGeEr0uZy79V/Ca/wiv3DpTXlN42kVJ0K2ndrDesuyJKaYEnIIdnvmFrMdsWWBDHNQcsImw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=IcLmeEJr; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=IcLmeEJr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 83 seconds by postgrey-1.37 at boromir; Fri, 05 Jun 2026 21:42:31 AEST
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX00l6jVJz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 21:42:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=aTy1XNVxRajlUmsekTI74t3WnZ3rR6lcNyVLeXOVEH0=; 
	b=IcLmeEJrshTweKmN4nFZA08XvRAIVIUw003euSC6d/a//5/n4JXuci3hxMDeaWf7LqAjr1nxtgh
	3WUnO/WmQ4Fd217xAUqPkFY76c6VjUaaha7aUAQ4TXHAVl49vCkCegXi1fHE7CBJGCAhiQE3EuaOh
	IRDnVOlrq/QZ4BriRT+ZHsMC5HR4OS0WBq8dzCrTWiegU+sKeZTCZPG1yOjBIQHZPVJs2q59r6gna
	4vWrmDibNJ3h6ddfI5SYAI5REN57y5qhswZ88vqzge7J0PmsXQkUDXoRGExFr1LAaeXx0rvmSkg8k
	wJCQB+CVuESt34YCbrXhz5CNPaFtQkiQFyvw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSwO-002oqK-2s;
	Fri, 05 Jun 2026 19:42:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:42:20 +0800
Date: Fri, 5 Jun 2026 19:42:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc/aes - use min in
 ppc_{ecb,cbc,ctr,xts}_crypt
Message-ID: <aiK2HApEGY_9eam2@gondor.apana.org.au>
References: <20260527141146.1230672-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260527141146.1230672-3-thorsten.blum@linux.dev>

On Wed, May 27, 2026 at 04:11:47PM +0200, Thorsten Blum wrote:
> Replace min_t() with the simpler min() macro since the values are
> unsigned and compatible.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/crypto/aes-spe-glue.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


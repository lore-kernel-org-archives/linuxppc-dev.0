Return-Path: <linuxppc-dev+bounces-18078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03F31125864
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 18:16:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWJpR6SK3z3cCK;
	Thu, 12 Mar 2026 05:15:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773252959;
	cv=none; b=MvuDmmFcPRy7ScSHYeRVkw6UUwtgokpkhDV9deHITCD4cFiInEMlygHoZbuH0qanzfy69pkFOzP9uSGF83tgtmvlocUnNF+L9ep1G7NXPO8yU30ZcGiMCfiFT4DrKe2jlcLACXHNzFKMJaEZezLG7QuhzPkd7MKyjH9DaJXMihJMsuZtVWjyjscz4MfpcG3UojlKSC3GMKELGnQARFoFor3W1zejX2wRmoHU2x7knnusJUBSuhhD+2IHjtkFvyvzb6KdrZ9t10IWkmDetK00u0q1UcRaVyL0uxf1grqUXULQQOycxqVlqse7qkExQOFWSz61KsQqxHaIKkj3ykC8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773252959; c=relaxed/relaxed;
	bh=Jjq49ouwOstajWDDHsipi40+8r2DGwcxFw4hkhofWGU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=N2eITRXXE/xi0SDz2C1iwrFfgFo3ns/GvBIudDd+pYr6jWHKbD7ZvXtJM7qBdkS8JfyihjyzI6lC557NTSaULjUAe6QAxoohRV6uNR9DoF8FAbkcuESHTC9XUwySn8aUFqyDkWQcfD+H+eOmY2+D0OlutAoVm+NVCDIiDQs1nIBna7t/B7ayjQD/AsvjL7PhkDSaQth7m6bwDorwQqnB7QEVN0FKGXw6F8T7sa1wJWS5ni2F5LbPzIxdyrfljnLUOiacqyOyur7YxWy0HsM+ex8LUW+nn+ZFI5lvGSHJ06WrxUjuBIVRltMQ1iuUccCRr2r9W5I57MvBBkGguBXruA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YRmUOewu; dkim-atps=neutral; spf=pass (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YRmUOewu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWJpN6NdCz3cCC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 05:15:55 +1100 (AEDT)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773252935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jjq49ouwOstajWDDHsipi40+8r2DGwcxFw4hkhofWGU=;
	b=YRmUOewu0aO319izp478Y0xTx7rGxwboIxXbrhev80N21WY8O3DvaGE9epGDrrLNs7li+F
	WhBuL59DlXs0ZajuRcVMtcd9oTzASTPmzKWa8Wl8/x1K+qfm/+5yPjHZzKrJ3VxI0ARc7h
	gL4aIP6QSdvrgtldxvJBfntRA77FeRo=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] crypto: nx - fix memory leaks in
 nx842_crypto_{alloc,free}_ctx
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <47dd8932-7347-4744-be8d-79106bc76f4b@app.fastmail.com>
Date: Wed, 11 Mar 2026 19:15:00 +0100
Cc: Haren Myneni <haren@us.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Dan Streetman <ddstreet@ieee.org>,
 stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2169F556-EB9F-449E-AD21-BAB1D34E81B7@linux.dev>
References: <20260311150922.382941-3-thorsten.blum@linux.dev>
 <47dd8932-7347-4744-be8d-79106bc76f4b@app.fastmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 11. Mar 2026, at 16:16, Ard Biesheuvel wrote:
> On Wed, 11 Mar 2026, at 16:09, Thorsten Blum wrote:
>> The bounce buffers are allocated with __get_free_pages() using
>> BOUNCE_BUFFER_ORDER (order 2 =3D 4 pages), but both the allocation =
error
>> path and nx842_crypto_free_ctx() release the buffers with =
free_page().
>> Use free_pages() with the matching order instead.
>>=20
>> Also, since the scomp conversion, nx842_crypto_alloc_ctx() allocates =
the
>> context separately, but nx842_crypto_free_ctx() never releases it. =
Add
>> the missing kfree(ctx) in nx842_crypto_free_ctx(), and reuse
>> nx842_crypto_free_ctx() in the allocation error path.
>>=20
>> Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
>> Fixes: 980b5705f4e7 ("crypto: nx - Migrate to scomp API")
>=20
> Thanks for the fixes.
>=20
> Given that you are fixing two separate issues that were introduced ~10 =
years apart, I think it would be better to split this up.

Yes, good idea. I submitted them separately here:

=
https://lore.kernel.org/lkml/20260311155645.397083-4-thorsten.blum@linux.d=
ev/

Thanks,
Thorsten



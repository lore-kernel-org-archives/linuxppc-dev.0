Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939E606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=igFILxkl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZPQC6K2Zz2xpt;
	Thu, 26 Nov 2026 02:54:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795622099;
	cv=none; b=eZaIjEEM2XRRFqSCANy8Hoc0/PyWdQvMcrsyflGmN8fuP1psKa8qteOceQO4EQzHem+WNYytmjmjn1gL11yse8tJcEoqejJRSWA1k4ADX88fRX9JHBfkyK3El0KGIUI4bYmBUjUQy3JqZHG7bLqBoZzQrqsfKHaBvtZq0WnQfKjx+QJDmSCuDyMvGbLq/nX/ojMH8HOrbl0WACvrbIDq7OIiooxZIL0Iu6oTaDG9T8W8L1aEqemf97gu1Fx+d92oy4pt25L1+NhEH04+TlsRZweSL6zZpyO6Afx72SdI9rJSW7w4O8v0sHX4tOZQXwUcRR8nTrnE5Cp2cfU0CGpnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795622099; c=relaxed/relaxed;
	bh=gnNfB/2l6cEd6lAcyXmI62/QXeIwC4YHb44ZtprEnm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjieSLhlolf7rHmN3SSNnoixJSQ1kMqVbZD/mXsToph3S0vUB/U37BZGEhoyvIkkgWZwYnpoZOyT4VzkzP/CbbSD+XKt9Z8hX0WMvKlOhX0e66FFGCKtVutAJVl0LLrGqOHrnBZ2VBKjFAsaUS17QdEJtkN42UumGOjmazXKSHyqw03U5ptCyuNt/Wp4cudCXrC5x3cDrBynDNv5KKKCm/uhEb4y7kqaCmE81fsEiWMJzKLv68WySJxeCcixxfeHQesKZu1q3rsSJuywTDFT/hHxFbKQxoaKX8KdTduqqaBzBzhD+WM65qKoNEPfnyE4G2mQd+Virkg+y0ioyg3vbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net; dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=igFILxkl; dkim-atps=neutral; spf=pass (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org) smtp.mailfrom=lwn.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=igFILxkl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 381 seconds by postgrey-1.37 at boromir; Thu, 26 Nov 2026 02:54:57 AEDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZPQ95qJZz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 02:54:57 +1100 (AEDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B132A410D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1795621709; bh=gnNfB/2l6cEd6lAcyXmI62/QXeIwC4YHb44ZtprEnm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=igFILxkl8MOYFso3Y51KF/mSgPOLs4Sw+Ox0lHX11z/kcaE2YTo34XaYO+hI+dSYH
	 6t1CI2R9iA1/ho2GtL1fZsg373EIZ4Sq6DC7cemjBvwU3khlBWS8kp+V9a615Bpubh
	 2yZEw8Plf43YVuG647XpYJ2qEAEOOU57mGQyDRd+wQrUAmiGbUPOyFGj7ibR2FqiE4
	 Qoi7jv3PbuSj01pa5+1cM7nlkPUbGUq9culLAOWBLycUewnycEz9z+b5y4rjNbFa42
	 VNM4I/l+rCsMwpc8CjlCnqPR8sUTo4qgXwXBt0KjPgtAUGLLSXFqxxmR+9hiOay5mn
	 rUWLqyJwH96BA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B132A410D3;
	Wed, 25 Nov 2026 15:48:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] docs: kernel-parameters: correct a typo
In-Reply-To: <20261119014957.213349-1-rdunlap@infradead.org>
References: <20261119014957.213349-1-rdunlap@infradead.org>
Date: Wed, 25 Nov 2026 08:48:14 -0700
Message-ID: <87ld6gyksh.fsf@trenco.lwn.net>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Randy Dunlap <rdunlap@infradead.org> writes:

> Mark a kernel parameter as EARLY instead of ENABLE.
>
> I saw this "ENABLE" and didn't make any sense of it, unless
> it's just a typo for "EARLY".
>
> Fixes: 600716592a3a ("doc: Add EARLY flag to early-parsed kernel boot parameters")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
>
>  Documentation/admin-guide/kernel-parameters.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20261118.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20261118/Documentation/admin-guide/kernel-parameters.txt
> @@ -5556,7 +5556,7 @@ Kernel parameters
>  			execution priority.
>  
>  	ppc_strict_facility_enable
> -			[PPC,ENABLE] This option catches any kernel floating point,
> +			[PPC,EARLY] This option catches any kernel floating point,

Applied, thanks.

jon


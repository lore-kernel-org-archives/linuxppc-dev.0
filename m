Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2E606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guNl/U7h
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYyHK6lWzz2xS6;
	Wed, 25 Nov 2026 09:32:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795559549;
	cv=none; b=gCY0lBnZAVLZbn/gLiwme0WOobZ7c6r3CIknbOMK5PscVMRlkB2mOHExsXAKHKjHW5AKtpHBAFxWnFZsXqG3+DQMqCBVhOv1cfrpe81SVa9Xw4LuK9ikKknW1BpudwBAZT9Ev7e1m7LsUDP0bF8vNHLn0FRC2sEJE3fWgbBMiyrdzPJmz9bkaVM0T6qgmrCR3mswp55KECDytaU7Rjd9PmP22eyjT4AuWpkiY30EGS0ln7dQ0Ecmeue9HeCnAxBu1vM4epSow5/A/4oMwD5FSpeJkiA0QEg+r5ln3u595iAuNgXpRFyqFI/DreKGR+rJ3hAH9J8XXpqp6TuEmGWrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795559549; c=relaxed/relaxed;
	bh=a6FoW319qnHewprCWz001RUISL08rpMG4GuNt+xAPlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny1TYI3e0dNaHaSkyPQzMVoQApBskeRd5hP67Tql3DTkiE4rvyHg1efUySTIhyNxpk7C7CqzfXMUIkhO8q57FvuX9+xLRuQdA4xf/XuSdCpOVVKrLgkXzBCjPDHKgyn9KdDxs7v6pa+Fv5sUEWUmTocpxuf/lj/PdlBskDfh194go6kTaTzvp1OP4SA+qrxGl18xtGMcL74YMRyL2ctpVpXfTCvcvmqeIZp3mZDPrdqb/M/mXJMjojM8SBPiWzPnnEgNUkX45lFqyVfIaRh1jQ9hUTFhOk4oTFTV9bpINcu9ccrVlz361t0l0kFQV9FMGNtpKqMj8+zPRXN6oWxCFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guNl/U7h; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guNl/U7h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYyHK0mqlz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 09:32:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5332141ED4;
	Tue, 24 Nov 2026 22:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0711F000CF;
	Tue, 24 Nov 2026 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559545;
	bh=a6FoW319qnHewprCWz001RUISL08rpMG4GuNt+xAPlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=guNl/U7hY2Ntwk2z/oJAhmEAFxZmqxjgx84FopU1z9kmHdbhMDfnhcMLtXUPRG+db
	 BDq5kY1eUk+pOe8gZiqiZozGY8bmARtvuwRZXf0TPVCv7MhI4tFyCoylOdBTCkkXNK
	 TSGoolL+4pDnaBLVzzB3Mg/s0nyf8R2uPJk2JJE0oZWz+3Iri5Te6MkqNAWWri4PpE
	 z+8yqO7gKB6BtWnaWrHDuWrDkKf5JrUEPfjO511nGCDHFnm4B3TS9N0kE5FDoT9b2M
	 CQT7MHB7Ag2Ft2sKT+2vucLgskxpnLftSCDYrOe8F7zI1s5ex5ZWjBRcv422os1e3F
	 Cx7wSwpMFD4Gw==
Date: Tue, 24 Nov 2026 23:32:21 +0100
From: Thorsten Blum <blum@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] macintosh/smu: Fix BCD encoding of the RTC month
Message-ID: <awYQdVRAcrE8JnM8@kernel.org>
References: <20261124132342.235824-2-blum@kernel.org>
 <e77c95c4-a01a-4d61-b137-509d72b8d7ed@kernel.org>
 <5ab4fc02-b15b-4989-a92d-3e053e89ce51@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ab4fc02-b15b-4989-a92d-3e053e89ce51@kernel.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 07:06:39PM +0100, Christophe Leroy (CS GROUP) wrote:
> Le 24/11/2026 à 16:46, Christophe Leroy (CS GROUP) a écrit :
> > Le 24/11/2026 à 14:23, Thorsten Blum a écrit :
> > > The SMU expects a one-based month encoded as BCD, while tm_mon is
> > > zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
> > > October as 0x0a instead of 0x10.
> > > 
> > > Add 1 to tm_mon before converting it to BCD.
> > > 
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> The real origin is commit faa5ee3743ff ("[PATCH] ppc64: Add basic support
> for the SMU chip in iMac G5")
> 
> Found on repository https://github.com/mpe/linux-fullhistory.git

Thanks for the review and for digging this up.

IIRC, we keep the Fixes: tag pointing to the initial git commit rather
than referencing a commit that predates the history, don't we?


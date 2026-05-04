Return-Path: <linuxppc-dev+bounces-20420-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC63CD3430
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 13:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8NW20fn0z2yZ3;
	Mon, 04 May 2026 23:57:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777903038;
	cv=none; b=YjhWrECtpBA4iDeTgaFnxvPlLIGrIXHjW7rrTcfTqWXV72pZZEameBwcsFl5f8fBd78+3m4TKDIeZpx8muKs/1zp59Kfo18y4dL0K1oJeHyAP7elXJlFYV0Vsr3W8at/650uk10H8HhJotaVpN3fYxjG02U9reAEwJRgkgKbU+uCdISslIES1xxg8Myvlf8RIJckYluvCkoHVpWGUnpnqGejCtgdbgiCuSaa3k9Ha+FOS64gYz6X0zldp58/E5ez3GUAvdzpcDKvzz5elv8cCCFf5res/iifGIAoPhAAXn8JD/YL01ry5CR4erSv94H7G0h0WQFf6BTw9uNTqlp/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777903038; c=relaxed/relaxed;
	bh=C+ilZnUq4wzQcFY/QmlLKUsuoycB9KLagi0FNdHMd44=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NUwPXUYc82oBYewSdTV6ZKO+q7eSVA88YCK0fOBaXHVWCuBSTXm9ZRVykRd/tEc5E7y3dXMvC3B8BzjI+1hmeNqCeHxWJXpC1d8PiIH30Vd2+FcjJYCOcwhsi0Kd6NfQuY/FZdJmiMPXvyKbIVyrCFDAGx5ykn5HhRBOKGHuNHeWVqYIatCA1lDkXjQcOYl/CITkutB2HaATqPdmGFamzqGewIAgQ9BYGmjz242mT+OM64w9OYpObyLDJf/beUf0tHCJVeuGETxj43Iu5nrA5j9PGhHxp1jPPrRYOpdUqgAdmbD6LtGqU+FQ+tBI+nv1Y7RycKlZBTmnG8zde9a97g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ox5CY1Pt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ox5CY1Pt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8NW06Vk9z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 23:57:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 485DA60133;
	Mon,  4 May 2026 13:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C575C2BCB8;
	Mon,  4 May 2026 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777903034;
	bh=YWPDXoMAmmrhqB96B1dvHxpf3zUskuMZ18eGdn0GY2w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ox5CY1Ptk7jvc6uGVAK0AEFf4fY/eVuqZ5aA1WcU/xv/MYHnmJUG/G379EQffxJQh
	 mWXF8As/MeRomThcZFaFeJhSAr9ioZ4HyYO2PoAHVaXe7O4VByznZQ70p08sjq0jfy
	 zEpQYPjmeAkIESGY+BxSjxtjkAuLNo9mxcnB6rCCAiX3/h6eLensDOzAdCQuDQJOjg
	 ZGAnlzm9fTZEAEeF6NLa1NjkwKZ/Iaaa7QDMMt/EXo+U3WaNv+1ggusJqQX3RWrlPN
	 tKWGhXqlapVjHmzEQCDpFWWgqTyv1XAqCLxGBGDZ3d3OrORSnhDnflNHoebHfrKVSd
	 V6k/NW6fQfaYA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F3C8F40076;
	Mon,  4 May 2026 09:57:12 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 04 May 2026 09:57:12 -0400
X-ME-Sender: <xms:uKX4aVbphX3bueqjHkPzAnjJsUjan9XSSjyQS3V9aPfIRJlcKabw7w>
    <xme:uKX4aXNxfkwx7RRmuabgb9rsjcSAO-p0sBS6oxizJpTzOjXVLRu28k92kKIwdKtbz
    xwhxpHn8UZgeNdBjLKe-rBHnL0xiwsD6ZhE64AiC0d5X8KBfmtuwFBj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelledtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepvdeuheeitdevtdelkeduudetgffftdelteefteevjeevjeeiheefhfejieej
    fedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedthedttdejledq
    feefvdduieegudehqdgrrhgusgeppehkvghrnhgvlhdrohhrghesfihorhhkohhfrghrug
    drtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgr
    phgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegthhhlvghrohihsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgrugguhieslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigph
    hptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uKX4aX_cimOx7Q9XHUcgFEd8VLiR8vx7N6o9gVSTY3BkmhJWrPe2og>
    <xmx:uKX4aVQ5_L1TE5H6yJohvsN8whHw4sLH7pjUy0xfKntjxtMMbf-9xw>
    <xmx:uKX4aUR34HetQYP-eIxmRSv64rGgH4Ld9LGkkkMGDQ_cf5Com123qA>
    <xmx:uKX4aZ6xaMtnXeCsVfBguusB1Zeu-ghp94nEB2f2jTw-t6rxdgnW-Q>
    <xmx:uKX4aRWiaDaOizpsFO6nXnv69b-g0dtwA4-uwADuwGXeUKsEGB1uKqC2>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DAAE700065; Mon,  4 May 2026 09:57:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
Date: Mon, 04 May 2026 15:56:52 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>
Message-Id: <112bf0af-1551-4d3e-ab15-e5dea3fc2435@app.fastmail.com>
In-Reply-To: <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>
References: <20260504041448.15820-1-ebiggers@kernel.org>
 <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>
Subject: Re: [PATCH] lib/crypto: powerpc/md5: Drop powerpc optimized MD5 code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Christophe,

On Mon, 4 May 2026, at 15:28, Christophe Leroy (CS GROUP) wrote:
...
> I'm really concerned with the optimised MD5 going away now, and I'm also 
> wondering what will be the way to splice a file into the kernel and get 
> it's MD-5 hash from the TALITOS if AF_ALG goes away in medium-term.
>
> What is the way forward ? I'm open to any suggestion as I really can't 
> see where to go for now.
>

AF_ALG was created to give user space access to crypto accelerators that
require privileged execution, for sharing between clients, and for managing
DMA etc.

The fact that kernel crypto code that does not have this requirement was
exposed via AF_ALG too is a historical accident, and this is causing the
pain that Eric describes wrt attack surface etc.

It sounds like you have constructed a vertically integrated system where
the kernel provides the fallback when the Talitos engine is not available
via AF_ALG.

This fallback does not need to live in the kernel, and it would be much
better (as well as more efficient) if user space would implemented MD5
itself if the Talitos cannot be accessed via AF_ALG. In user space, you
can use any implementation you like, generic or asm accelerated. This is
what all other architectures already implement, in OpenSSL etc.

Claiming that your user space software must only implement one code path,
and that punting this to the kernel is therefore required is not a
technical argument: this is just policy on your part that the community
is not bound to.

However, deprecating AF_ALG does not mean that we will ever be able to
remove it entirely. Especially the crypto accelerators that cannot be
accessed by user space in any other way will remain supported as long
as needed for legacy use cases.

But I think we should consider libkcapi as a general purpose crypto
library deprecated too, as well as any other use of AF_ALG in lieu of
user space libraries. It is not the kernel's job to execute user space
code that can easily execute non-privileged as well.

I suppose there will be more discussion soon about AF_ALG deprecation
for software crypto. It is likely that we will need to come up with
an allowlist of algorithms, in order to limit the attack surface to those
algorithms (such as your MD5) that are known to be relied upon by user space,
rather than any random combination of all the buggy template code and
null_ciphers etc.

Do you have any use cases where MD5 is a bottle neck, and the generic
implementation is too slow?




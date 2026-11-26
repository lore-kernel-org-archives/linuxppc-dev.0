Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE818606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=gpDx8hWI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb8FC6fhmz2xLf;
	Fri, 27 Nov 2026 08:04:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795727087;
	cv=none; b=Z11XgQud508pOxMW7CowPZvMlrC1E56s0RN69Ri83y960WOtcjjRi5Dkm6CT7Hxv1h+E3hoe7mGQWWS4WpIcE5wLbsmzHXQ5x5p9DZrFvs6a2IQ0wbJfq+2LiW5PJk7Fr6+V6b55INUFsxP2bEGz/XdSX1ka4TnKML6OUikSX+S7Uyp9KvzzXlnSIbO6XdTXFBqhb/d/Y3NXtTHQFx9+hrvXG8rbAF35iVXQCXuwRuFaqPeVj4AGO4X7bactgzhig9D5m45X28gbrLQrAOZT9zp/dDnRIOdTbtIF5akawOTlZMC9Vgev7RNciegOlWhvhyh6H19GJ+CLP3RJwICihg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795727087; c=relaxed/relaxed;
	bh=w/veAsUiMRUXVkGGKpQ5FmsMu962qM5OgsgjWQ9RJVQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=D+XF5o0i38QAgh2ECYME/bMv64Ku+KlEV5UHbeYpDwg+OzLqqcyC2RG3pWllLWRX1zTkiD7xtg1bX9JCRbJ/KUK7Dgq0Ph1zxIe4PVyKS9UNj1uEgNHn5UCBtWrXaTopaH1BzAmDohtAw3cwnNSrQ97Cn0O2O1AYYqz9g46tRGU9nz9+rY7NKCA2C+94t88QI8UkpYNj9yolFVWp4P/5gxO4Ad44FkRwcvDxSyQ0UOpdcuBlLNB9KDUc5s/c4ff5DMChAvQ0veHd+iWWjCAdj5jZmvnE5rveUxHUnFU7gV1lR2P36wGXqHvCO+5rgq0g5vEuX7rLNYuwbs5F+eH/ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=gpDx8hWI; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=gpDx8hWI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb8F83q9tz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 08:04:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=w/veAsUiMRUXVkGGKpQ5FmsMu962qM5OgsgjWQ9RJVQ=; t=1795727084; x=1796331884; 
	b=gpDx8hWITxGXBuaxPPvC4rUW5fzQMuGLn8Riv9lH/+4cSEwvRATZCHpTBybmY4spZfhKeCvUBK1
	MYI0b+x1YIbsdpzQ/I0amteqSNQSjomKw5yESFHxtF/P9CwqvoKxRoSaCqmvE6N+trcZj+Tk3qNbb
	MmF1rBUq5OIZSmQCxByhpmTP2ngrIjbQ9eKXSIEiOJUUKrkbOD4moN5nUEDtCF3dTmnKw3zOGu1hC
	UpquS8DKgEMAkhF6qmZHPGhZPaiODrtivKAKbwvuWZS4tdCI+Npn3yWfyNf5Z6vlzZSp7bLDjBr8D
	B/iKFqK0XVBgjAFFyHycMFpDFxuYHISX8BKw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xWgdx-00000000JxU-1YLp; Thu, 26 Nov 2026 22:04:37 +0100
Received: from dynamic-078-054-182-224.78.54.pool.telefonica.de ([78.54.182.224] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xWgdx-00000000KcC-0Z5n; Thu, 26 Nov 2026 22:04:37 +0100
Message-ID: <5793bff62d5995d322659d4a1d311bc4c795a829.camel@physik.fu-berlin.de>
Subject: Should the community reconsider their efforts on PowerPC?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: debian-powerpc <debian-powerpc@lists.debian.org>
Cc: gentoo-powerpc <gentoo-powerpc@lists.gentoo.org>, linuxppc-dev
	 <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 26 Nov 2026 22:04:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
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
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

as some of you may know, IBM has been pushing to deprecate any PowerPC
platforms that they aren't earning money with anymore. This includes
mainly POWER platforms before POWER8 and big-endian PowerPC.

Recently, IBM engineers have remove JIT support in OpenJDK after sending
an email for feedback to a non-public, unmonitored Debian email address [1]=
.

Since IBM engineers have also killed off support for big-endian PowerPC
in Golang, V8 and also don't look after LLVM on big-endian PowerPC anymore,
I wonder what is left for the community working on PowerPC.

I personally feel that IBM thinks they own the PowerPC platform in the
open-source world and can single-handedly decide whether a certain project
will support older PowerPC targets or not. And I'm starting to feel that
this will sooner or later also happen to the kernel parts, GCC and binutils=
.

As someone who has invested endless hours of my free time into working
Linux and open-source software on PowerPC, I feel really let down by
how IBM is handling this and currently I feel like it's starting to become
pointless to invest my free time working on PowerPC support in Linux
and open-source projects.

Adrian

> [1] https://bugs.openjdk.org/browse/JDK-8331859

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


Return-Path: <linuxppc-dev+bounces-19261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA1FD730A2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 06:31:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn84r38RKz2yVP;
	Fri, 03 Apr 2026 17:31:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775197884;
	cv=none; b=hrll4aONl3CXWLrplLmtt6Q9HdD8JyK0ULhwc0KQwVK6imOh9h/B3GbBEdtjrgJLRH0BkBeBhqVONqCB3UhadTujRSKOEv9ynQU3rJoDIt0aHXZp2zlHKo0ihFGmktwX094n9lOkX0o3u9Nr28J+Y3lvaH4jrTKzwRLcE1UxqNgoJAXKyuhRhG70vR5kfhItPFIeBvZfz9GsGCh2ENtHOLMmGVelmqs3Pcm4sk6vNwa355cRZKvaBC++KF3RX3yHXOIndlMbRT7TuXl9E4AEwnHYsjbO7fFHKY6OhU+HUVU8gBFE1D/XEK4v/aNJSWtpZFO3EkZqHHlKdllXO8wMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775197884; c=relaxed/relaxed;
	bh=Z+XyFWPQDMhQFEfGTh5lxYJKkJRaIVp5bBIXM3gL4/Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DiXAJpe2p/7d48fF4LOlk88qfQ3eSOetOyXrX1JuWpC5z+ZolBGvq62winAiwPzTDLQbz2gfCJa5CNcyZpgPhK8zY9gT7pC3s+r8lRQnIj5Y/10lR+yQu7LDm3RIzKYbbbdxvl6Nnea47+uKlUzlApkKH26oUSnR+8QkgTxsdU9f2C/aQNGgSiVW91yEL5EasjVK0/43KZ2h30w0CsUqSmZg7dXykNC5Q5kKgPpapOleXLMdrGLhbwY1vKCxIFtDoNTu59plq6vOTdiXRkyDCBeLg/wR/rTy7pgOJ1iDU31CLwSpacnpiRPfhzEFyq5kN2zDan5EDgeoeIQOQrOZrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wNbZTh+h; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wNbZTh+h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn84q3SdKz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 17:31:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 26B5B43F2F;
	Fri,  3 Apr 2026 06:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55355C4CEF7;
	Fri,  3 Apr 2026 06:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775197880;
	bh=z5smXNJSDIZs7k9QwbEBHb9yac6jAucmud+T/8hzBOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wNbZTh+hRi8x6NmTtJ9Tt4BdER0gAGV8bnI1wlICJAzLhthK02O3Ak1qqpppmO6w9
	 ItAmoOlKwr1JFtSe+6AIaOuNsgXneiQAudP0xVDh/lwc/285dhdd9UmXc38A2RPQOU
	 8DQuoRvBiRsIHfOUw0fy82VH7uKPithrZYXkG7pc=
Date: Thu, 2 Apr 2026 23:31:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, Arnaud Lefebvre
 <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Kairui Song <ryncsn@gmail.com>, Pingfan Liu
 <kernelfans@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
 <robh@kernel.org>, Thomas Staudt <tstaudt@de.ibm.com>, Will Deacon
 <will@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Saravana Kannan <saravanak@kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-Id: <20260402233118.08ea88a6836bd10f01031cce@linux-foundation.org>
In-Reply-To: <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
References: <20260225060347.718905-1-coxu@redhat.com>
	<20260225060347.718905-4-coxu@redhat.com>
	<51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Apr 2026 16:24:14 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> =
wrote:

> But while reading crash_load_dm_crypt_keys() I noticed a possibility of a
> double free at the address pointed by `keys_header`:
>=20
> In crash_load_dm_crypt_keys()/crash_dump_dm_crypt.c
>  =A0 =A0 snip...
>=20
>  =A0 =A0 kbuf.buffer =3D keys_header;
>=20
>  =A0 =A0 snip....
>=20
>  =A0 =A0 r =3D kexec_add_buffer(&kbuf);
>  =A0 =A0 if (r) {
>  =A0 =A0 =A0 =A0 pr_err("Failed to call kexec_add_buffer, ret=3D%d\n", r);
>  =A0 =A0 =A0 =A0 kvfree((void *)kbuf.buffer); =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 <---=20
> First Free
>  =A0 =A0 =A0 =A0 return r;
>  =A0 =A0 }
>=20
> Since `keys_header` is not reset, the next call to=A0build_keys_header()
> will cause a double free at `keys_header`.
>=20
> static int build_keys_header(void)
> {
>=20
>  =A0 =A0 snip...
>=20
>  =A0 =A0 if (keys_header !=3D NULL)
>  =A0 =A0 =A0 =A0 kvfree(keys_header);
>=20
>  =A0 =A0 snip...
> }
>=20
> What do you think?

It looks that way to me.


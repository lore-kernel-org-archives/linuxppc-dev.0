Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603F606A325
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kd5v5C4O
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV23k5v9nz2xdX;
	Thu, 19 Nov 2026 00:08:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795007330;
	cv=none; b=GBLAgr9fQPfhtfFPqSB7FzVXPCvkQ7y0P18tiuKRXONr4Au6X4J2XBzKhQmL63qVWt3AEEdaD/gLZQR9VNb/rpqcnUw/e/sBv4R0TJo1dBgCA/XyIAbPRaSdD+dUe9zf4FDO1PcHnhaaBcpJw5vHQ7ZAhC+zswTLI22k60r/bEjg4ksr/iJ+qSAxFdhqttMfrYRx9K1Vm2G9BXcn7pgloPiy7qqotPq24SvK5ESH9MNtGUncXxmeS54JwC1KfUck0oWfJ20iJzaFfkoJl0G71b2zfB4BxSvWz4wvxVVbdt/NHlnKCKio3W3kNDn9+VPE8JpTiW9yg+8Ub8RkDszrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795007330; c=relaxed/relaxed;
	bh=tKDarfxiWOcLoTCSjE7AeoaPEMMkfbEBqcBYvqId7kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6dWdvPA6ZcabBOxC5gX40jVa62ZvkQwGAlhTqzuJZEvNfJ6Nd+sx9Uq1rnfdcoAcBemlLYQelgCbEe4dA2JUIQ3HG4Q5mVq9dc4RUEwvf/UMAxpSnKd6GflcteHD7pOT8dTcGHFlRnLOCL1dhLqmoqMnwxojQ1NqZLv/b/M/eUVRGU21efi3CJ48OgafC0m4jKl72mvuv3lOBWayPlTh5uHMviGJhfP4ttjsjjRMrpytaxJylcppsGzklGZuNpG4x/xC/emC7eNEW3Lk5SCg78BjilT3Ei7lRLGyNYxF9lOzlLHDH+tYKoPM9txB6iJIQ+I5JHw1ZUFMaYnef2z5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kd5v5C4O; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kd5v5C4O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV23j3ckvz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 00:08:49 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FDCF4601C
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 13:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185F51F000C5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007327;
	bh=tKDarfxiWOcLoTCSjE7AeoaPEMMkfbEBqcBYvqId7kA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Kd5v5C4O0ad97PKFyM23v0ah51NrP1LwAeOglVZu0sHc3THPBxEJ3v1Rf5KuPAmrF
	 yktZ9In2WOEcBZMG+Vt9Un7fMU7mHcBwfbO3f8fe/IINVw9UAa11BJe0Kl/ksIZT5d
	 PEmc4JCpBMgLWmXBZY1NsxAZXmyFSkPBwVbJ1UMitwYk9aqcY6ktvPC3TTGTrf2vXQ
	 hKm0v1n5KAfkV2z0mLNLJQVnbU/SH2lm2ERbH15kdLUwAfeCFV8RRv85k+cJY8TdM9
	 peQpO5zgXC32Dm3UZU7bUpktx638zdZvpfLACoaWbgvVyQ6qoecQIp8o24JqPhufoQ
	 XBukB1wXNjJmQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c126fa1e3aso574750e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 05:08:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEmHnn/dPb5SPfO8RtD1XiPQ6ls10L4vTeYCNLbEgRPxlcMUjNCPwfNn5t3qLD5HmxLhsLftcQyYPlWOLs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/lWBVx1EgoBbYlLP1dqZXG6XKHH5KJIloGePEkie6WvFuerK2w
	bLLhGLOUZcpiLocpe0fKANuQMPgj7nnEOQXFGFawxaUFrX3bIZEhAFcA0dNuZ9cpH1prt+hWjZL
	lZtzEAwwsm9HdSjU6cLHdQXzQivzWtf4=
X-Received: by 2002:a05:6512:3192:b0:5c1:5a83:4285 with SMTP id
 2adb3069b0e04-5c1aa2b16ddmr1030883e87.60.1795007325480; Wed, 18 Nov 2026
 05:08:45 -0800 (PST)
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
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-2-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-2-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 14:08:31 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Ugp2MH1nvBr=+_o6a9UZ4VCU04KY7Z22pzEnGwHAWTg@mail.gmail.com>
X-Gm-Features: Aa3M54rGSDqneypUHMmdmL7dJMYPaYSAWAq3AteQhJuMu5nbQzZhIjBnrf8_3UI
Message-ID: <CAD++jL=Ugp2MH1nvBr=+_o6a9UZ4VCU04KY7Z22pzEnGwHAWTg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] ARM: remove support for highmem on VIVT
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Malin Jonsson <malin.jonsson@est.tech>, 
	Matthew Wilcox <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Nishanth Menon <nm@ti.com>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 1:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> As Jason Gunthorpe noticed, supporting VIVT caches adds some complication=
s
> to highmem that can be avoided these days:
>
> While all ARMv4 and ARMv5 CPUs use virtually indexed caches, they no
> longer really need highmem because we have practically discontinued
> support for large-memory configurations already.  The only machines I
> could find anywhere for memory on ARMv5 are:
>
>  - The Intel IOP platform was used on relatively large memory
>    configurations but we dropped kernel support in 2019 and 2022,
>    respectively.
>
>  - The Marvell mv78xx0 platform was the initial user of Arm highmem,
>    with the DB-78x00-BP supporting 2GB of memory. The only remaining
>    board file is for Buffalo WLX (Terastation Duo), which has only
>    512MB and is going to be removed soon.
>
>  - The Kirkwood platform supports 2GB, and there are actually boards
>    with that configuration that can still work. However, there are
>    no known users of the OpenBlocks A7, and the Freebox V6 is already
>    using CONFIG_VMSPLIT_2G to avoid enabling highmem.
>
> Remove the Arm specific portions here, making CONFIG_HIGHMEM conditional
> on modern caches. Since the cache type is enforced by Kconfig, no
> boot time check is needed here.
>
> Link: https://lore.kernel.org/all/20251219171412.GG254720@nvidia.com/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Good riddance I'd say. I'd choose VMSPLIT_2G over highmem
any day.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


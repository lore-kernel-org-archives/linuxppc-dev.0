Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BAC606A333
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EP1ghp76;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FDCDyhPL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRTXx0mhsz2ygK;
	Sat, 14 Nov 2026 20:36:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794649009;
	cv=none; b=bdFgYFan3x7Td5cuUP1C5ZUTncm6+VRbQejX4ZQPNHs5hXSgseli5lMHbkuJBsv+3xBPCnxlj8l7UebOTvDkNmTqlTKHlFhRzohElc8lk+po2AnpWMfcldB01C5E0z6xSw4uZZQd+A0fYRYN5LDPxQBOmUU287U/UxDPszxp4H+LcVpr32w5cNR9mChtUGJIDCbkJbOa/w+0dW2VHXQH84Xf0pA+eZUZ70HJmeccg0Uez8l7rGNJhbWdJtFGM5qUdrj42piEk1KdcnZ+V1MrQvnpVvtiVTjHhLyVLjmdDvZ0BB0BaRjUW/5rZVUC/9C3NiGeJMpTJasT1rnEg+rY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794649009; c=relaxed/relaxed;
	bh=26oxNda2Jbu3cIX63Z4R9RMnAS+/vo2GCsCa7CBvDvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E42uAom2YTT//p2d2Jry5bYM72Eru93Kf45zVHzojSfVw+8o8NScf6w2p7iNdEL2lPZ1tupIMs5Tc6sn3nbpgW/rGK/DgdJHKv+H34+V9fX1e2Vf+JbFAt92dw/vpTKdVSKIu1U1ZZLYJ9ECkVhPFJs5nGjRE37aJT2YsP6wqKTUpFQOYZH9oqcKyq2VbqfJsEvOrn4WT0yGYSQlKo7HOCUE7TZShJ+/ex4GDXJFczb/1sBifC8PxLVWvScsjPvn9C6fP5GvxRenO9eW6+rVOmVacjYUpqOFRxgHodEgnX/+Uhm3INN79OB6jgHm2W9MrBIkr5R/+4Z5/wMihycv9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EP1ghp76; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FDCDyhPL; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EP1ghp76;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FDCDyhPL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRTXv5yM2z2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 20:36:47 +1100 (AEDT)
Date: Sat, 14 Nov 2026 10:36:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794648998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26oxNda2Jbu3cIX63Z4R9RMnAS+/vo2GCsCa7CBvDvE=;
	b=EP1ghp76E7fkW7ZcMG/KnkpNGMrAXuNWemC6+/fjBeEOPtkBBpbC/RsqgCYyD3m5+E0p0B
	0HCIdgjMzCu04LnAnNlPli7q1Ah0LvU7J/ATYLdTQ1O/mfo8zu6V3m0OnG2pHzboIU0iqR
	bu00CUKO0qkgcrhKy/cnEYRw8zNDljEkyOBjA6rHIiibLQqJvDxIFR8brCnn8GgXu3jId3
	QNAZlYZhBSmcxqef8YxYbx2DeI2Blq04hhKqq4zIB3C8ASKgeew7kmCnX/rMCqvDIxsY0q
	oJOL8TqH2l8M2TufzbNq+WMk7W5O0/HBU4zOOQRmQ5JaWmsmQusBlHp5L1fkxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794648998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26oxNda2Jbu3cIX63Z4R9RMnAS+/vo2GCsCa7CBvDvE=;
	b=FDCDyhPL8YiXrkcibEM2ZGGZh0iOW1G4ezZonzYCx5ldQpmUFBsxOZqa7dyMF5/pzOkxG3
	o10umt1MWPiNC2Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Kees Cook <kees+treewide@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] powerpc/smp: parse_thread_groups() return error on
 missing property
Message-ID: <20261114093636.mDmlSOhU@linutronix.de>
References: <87mrrbrhf2.fsf@jogness.linutronix.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87mrrbrhf2.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ Kees, Vlastimil

On 2026-11-14 08:44:57 [+0106], John Ogness wrote:
> parse_thread_groups() is supposed to return -EINVAL if the property
> does not exist and -ENODATA if property does not have a value.
> However, it is currently assuming it exists and blindly calling
> kzalloc_objs() with whatever of_property_count_u32_elems() returns.
>=20
> Since of_property_count_u32_elems() returns exactly these same error
> values in those cases, simply return with the returned error value.
>=20
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 0af298e62e5cf ("treewide: refresh kmalloc_obj() conversions")

But=E2=80=A6 The difference in the commit was:

|-       thread_group_array =3D kcalloc(count, sizeof(u32), GFP_KERNEL);
|+       thread_group_array =3D kzalloc_objs(u32, count);
|        if (!thread_group_array)
|                return -ENOMEM;

kcalloc() returned NULL on an overflow and did not continue with the
allocation. So the check below worked.

kzalloc_objs() on the other hand returns for the overflow SIZE_MAX and
passes this down to the allocator. We still get a NULL pointer but with
a warning (from ___kmalloc_large_node()).

Is the warning on purpose now?

Sebastian


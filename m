Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A78606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPHU4bh1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZy672QTXz2xlq;
	Fri, 27 Nov 2026 00:27:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795699679;
	cv=none; b=d08VQ6M0YaMsPDodsH52zOUvMyAha/v9qk+qO15V09Q9IBue3oIRme3rAUtfNba5J/z7O9Ng4QUoiB5ZvRSRsOIYGo0a9Jeavn/IX8b6cCWEsCfPoYg6xKCOZuwT8A2fqWdvQABKg3hkNggOOq7sI/26CxsFmxM0qSXwA0Yifa6xa9Eo4AxoUBrTmLzFv3rkuskvsiBSbyQV+uiOjEN0HsVWLSFgJVmgdET3y2aWjY0FYkbOtvaKnpbSxAv0I82xY2SjpnZAAzykU0CRsYfemd5rNR6YG9gAg+TpDdbWROsEmZX5WRvyt/yKrQggE7BLZcZfyxhFOsQ69ojVk2Vs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795699679; c=relaxed/relaxed;
	bh=0SuygBFJgQJDPEHL8vg5eLv9glUvVL4TbpwchKTOKc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oG7LLp1FlH+d7s0d3SKjRjkdlX2cnnpbG7cPa3ZDJbhPC6BAy1p+EvRAGxoCFGDNwDCIdnN4bhFD0WHsRlAEbdqvRVbbi26VCjTfXrGQ7zjmmbnnWnafNVpDDnTQRIaAb5S8uorkZClQJLrokm8Qio/HkUSl4F31axJX8J3qsx7YRNPDXDBUp889Sv3Ee24GQNktVFcCSghp1V5hQuDgD4GwRjMhYGQVfZAP5+rtpt/Zg6G86Ed+vT4ltXEfmwgHqiGpTeC/0AtO8Z2wqrMYf05w5yzVDMLIimwKFjvqBzNmchMXF9kztsu50pgGX2CPHm+SF6bRUpk3IqS4bLWIow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPHU4bh1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPHU4bh1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZy662qL2z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:27:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE29146474
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988D31F01561
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699676;
	bh=0SuygBFJgQJDPEHL8vg5eLv9glUvVL4TbpwchKTOKc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EPHU4bh1rQUynF67I/BLiAYnpMItWNnTQ9AParYyhIyJ+y6H3njJ4HyIE0s6Jx202
	 xCNzY4EbdFEUvhIGV7u89sr9xvmTk/hzD3usLMoUVQo7zRS1mVOEOGXKaU7srd0lqN
	 QJ8zgMkZSbzwDG6k/Q8gKHxK2xOwoNZh0rfmPcgTWzKzVzQoVxEJRXus9AvWUL1U2G
	 poRlMVnD4ZVArgDu1nm8eFgis+FkVYb/7yrTihelucyhtlDiutnGbPYYQd1IeXPRF1
	 uMR3MT3fEDrUV6O3qWBar39ZOF0tAC8l88Y7GgJIURjBmPo17gy3FHsqx2yCKI3NPh
	 QpwxgY4N6hLRw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so419283e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:27:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFtCzqLW++BLmd79qVOfHCkXxrDdBlZWQo0omDDFbZGJLUKRLA1suE7ye5mH9ZPKddwweWLifjRzPw2ewQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/G0GVHYEp8g0anh0TMNV5blERVnnyM6N5lZtyXcv0fR1rwAlIV
	ckhdtXHWSGIQmZuo210uPgjzBV+p2VZ324IvSGZ6/loZcgyT4HCoPGFzumQvOaP0e7dWACZCCTA
	XQTE+k2P42WOIYKWU3dQV8mPOsdO0USU=
X-Received: by 2002:a05:6512:36d9:b0:5c1:5976:1d30 with SMTP id
 2adb3069b0e04-5c1bc8206cdmr4300123e87.57.1795699675392; Thu, 26 Nov 2026
 05:27:55 -0800 (PST)
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
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-6-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-6-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:27:42 +0100
X-Gmail-Original-Message-ID: <CAD++jL=ZyHZcJRUTpVghs3xYH0OGOKauKVWTF8tiPpHPjuad+g@mail.gmail.com>
X-Gm-Features: Aa3M54pIH7xhTLEiVGxFItiuCxGTTC1f9B6RJQ9R1KEb9x9xI611Qqdum1NmRD8
Message-ID: <CAD++jL=ZyHZcJRUTpVghs3xYH0OGOKauKVWTF8tiPpHPjuad+g@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] ARM: add CONFIG_VMSPLIT_2G_OPT option
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

On Mon, Nov 16, 2026 at 1:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
> of lowmem on Arm. Since 2GiB is still a relatively common configuration
> on embedded systems, it makes sense to allow this to be used in
> non-highmem builds.
>
> Add the Kconfig option and make this the default for non-LPAE builds
> with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
> the vmsplit to be on a gigabyte boundary, so this is only available for
> classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.
> Keep ARCH_MMAP_RND_BITS_MAX at 15 for this.
>
> Tested in qemu -M virt, both with and without HIGHMEM enabled.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E64606A32F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn81L3WM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnz22gBhz30Lw;
	Tue, 17 Nov 2026 00:00:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794834030;
	cv=none; b=Se+RIpfLFBJvQpiV1uYUqpzhlsnYE7WRC4qH3RLm5eRwsaJned8rapFRa/MhNRsuvvjZGUto/0GGlm9apOG8t1gaigiJqCmKKXJCZ0WzqIl/HTWtWud/DA3VcZcGU6VFgY/zchqluMXftVXqBCMRUgGPgTCLrDfjTRAcZIMIJfpyGU+AXflRFU/ux9Lf4z6/dV9x9LHY58UgJoUE93BUqpYsVUtCRVOKuZfCOcgoxR5/EVBh+cFF+YmeXbKNmVvIsdAFt9/nLEziGowNgRCEC3VYT+dDpOdOUVrhOW5qZYzr+wCljdx611CCdg+eeGRcxWrMqQUk75jeYn4xyo6B2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794834030; c=relaxed/relaxed;
	bh=y5R7blodr4KyIr57H0lgE0jfeLfnu8xOhBhiMifpgVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDpYT5p0pWvePwfSmJyEEf1P7wDulVWNEavmT3soB0N6DlwgrWXObt9bicMGMTQ5SSUUZlWbld8ULo8g6lr25TEkeDjrY3cBgmzqTDqjm9nSKM24QOT/4gfE2vp+DmoRMoOOtsZqjPowZxNfpSSeQ/LJfmtKKtXB8b9sl7fzno9eVXLrbuGIH0d7x1P0AHAh9Wcw+gxiaQL8hHuaX5c0g3ORFiv3beVKyrIVD4UBFq4qd4gyZDG1o8+/cX6z0cwzHxNGgigpJY2o21zD9n9AnheLXofkG7Ta+UvzjzYf7DcprrgN4PCERuapUwmeycmbz/7CakhuifeQeWLXnx/6gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn81L3WM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn81L3WM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnz11fK5z30VM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:00:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB592625A7;
	Mon, 16 Nov 2026 13:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373501F000C4;
	Mon, 16 Nov 2026 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794834026;
	bh=y5R7blodr4KyIr57H0lgE0jfeLfnu8xOhBhiMifpgVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tn81L3WMTmVSVrFkStoUKS1eJlHCrwqf92DxGJzeE2QnNqJMBbbVy0Xjxt/pr1NlT
	 CC8inPJD0LToR+NrQVsp4zf7dInOG6i2QM2boXgjJrRapJHocK3+y96JvGlfrph2/w
	 VXKZJNkxdWHXEYeGBcIoe7vawFNBAvw9sSR3HQWmuqHqve768kdXbPrsGZA0puqQ/U
	 yuS8sDgebbsOqC3RdflJEQf0pctSVBEO2uDerS+IZULL8JNTLEPvROidufB+eCHmzL
	 yMXMkEn0k8odvkMvxrOrO/2iUiNR4AFj1hQ8PmnBp98gNt5wQCNSqKvRpPec6xzXUA
	 Lqp/ok8GxpgoA==
Date: Mon, 16 Nov 2026 15:00:14 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Nicholas Piggin <npiggin@gmail.com>, Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 10/10] mm: print pte in __print_bad_page_map_pgtable()
Message-ID: <avr-Xjdqrb8Ja1E1@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
 <20261116124832.662455-11-arnd@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116124832.662455-11-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 01:48:32PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> HIGHPTE support is gone now, so it's easy enough to print the
> PTE here along with the upper level entries.
> 
> Acked-by: "David Hildenbrand (Arm)" <david@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memory.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

-- 
Sincerely yours,
Mike.


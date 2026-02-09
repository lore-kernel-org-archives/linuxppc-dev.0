Return-Path: <linuxppc-dev+bounces-16751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89419E81BD6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 15:08:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8p4K5h70z2yFm;
	Tue, 10 Feb 2026 02:08:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770649729;
	cv=none; b=bPoLqn79iI7ayCiyp7wT2vpJwbxb+nUYxS/LmHwubMgIqAJIGgSwIaILSw/q6ukO+IN+GeGBvdXwdX2CbwxWL80J0AVqz/06Aw5bXQIkPb+jGEKAFQopGH+t4eWcZDGGkZfdcz3qVths6ABO0zsVfZuQxysguxEztaU3jTYm9jonYhGfcLn7VtYkZMymrT27x7bFMibnW00ci8uwkJ51Sw8+WBTM2fOO0ZIwv8NZc974elYz0U/p/5Lhy97XdiAvpnv00UxqkCwgY6zCEpeVmG8US8i8cmt3pVmENge+H371Eiq/3j366vbGiKvzQ8QDLjArGdlzVNbRUILtqaRXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770649729; c=relaxed/relaxed;
	bh=kPUqV2G4Ach91Ih94Oec+zKCJRL1csnjCWzGDZaM6fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMY23iFZMolR2DgA0A0yEB/WVye9lqH4kmlkCOhnbjzaA7Azeuz7ZT+A2uff1vZnbOv7mQXaTqqEuy/qJbXj/c57UvaHWKh7qpNG4sc23LNdLQE+koCT/MYpsIGvR6FlfNoAe6i3gcvSJI4g+WgI7eQ6rZCYrwzShdNgHIZGY6Io0iU84/cDdrgcb3w80P5RVQaP4dcCHhk7OPe+d6HG1nUpiPdjH83HXm6w4abvIm+hUrquNrNQQ7PfsaTdrg3NLjrOtnmsBgzovg5WdXhMUht6j096K66p/mC/EhbcgDJi825UAE6GgIIyMcY29PozCS5eGP8rHkEc+9eX8AtP+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hHysNRIg; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hHysNRIg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8p4K00cvz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2026 02:08:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 95B326011E;
	Mon,  9 Feb 2026 15:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E07C116C6;
	Mon,  9 Feb 2026 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770649726;
	bh=74hxAhJyO+2eTcl7giR1QDsEixnocOOTI/KCVXUN3oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hHysNRIgE1EgualKU6aPczQKYfw+TDjGY4OatYFD3fS7TYkGD7WEmgWx3geZeHrfv
	 F1zDDpuaU0nwUv7Ae8xi1oXRUWF9pjvFzqRkh1G83qeRNbE6qwS1sk3FHaw39jYn+r
	 Nk+PQE+5SnWvARHfBa8QAWdgNoL3wy2mlksHsr/SXlqVp8ketneSvd/HphO2nVp9tE
	 BCsZzIL9BLqAHeIK57meLHZ0odqx+OpNBfkHnj8PRzutvNrHUWbq5+TlKgLRN2HHQv
	 huO+HUqNPVA5lqDphasR6vnb5IXL4MN7aVd4+kWDg4t8O5NV52bIkpeW9MtEreTJuG
	 K04aIwqR6xaWg==
Message-ID: <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>
Date: Mon, 9 Feb 2026 16:08:32 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: rename my_zero_pfn() to zero_pfn()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20260209144058.2092871-1-rppt@kernel.org>
 <20260209144058.2092871-3-rppt@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260209144058.2092871-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/02/2026 à 15:40, Mike Rapoport a écrit :
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> my_zero_pfn() is a silly name.
> 
> Rename zero_pfn variable to zero_page_pfn and my_zero_pfn() function to
> zero_pfn().
> 
> While on it, move extern declarations of zero_page_pfn outside the
> functions that use it and add a comment about what ZERO_PAGE is.

I guess the idea of the extern declaration being inside its only 
external users was to ensure nobody would start using it directly, hence 
bypassing the overloadable helpers.

Should we at least call the variable __zero_page_pfn instead in order to 
warn people that using it directly requires care ?

Christophe



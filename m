Return-Path: <linuxppc-dev+bounces-19001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FB6FF4932
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 09:00:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fklbF0FBCz2xpt;
	Mon, 30 Mar 2026 20:00:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774861256;
	cv=none; b=ZAaNkvWlmoL6pnRyEFT0ghX3H6Knw1p1vD4pWThsrueanb7mrsUugc9KPdnND0GTpoWhZUyO485QsJwkDzStMMjb9ClXDTVTfMwzBJ+w+SF6DZplvc0dPGPj3JHP9WuYPYNIvRbQ+G/M21zOpmbSPXvfbKLE4WqkmWoP1HmzQgYcEW9O0z4zLM1F+C01KFRL7fOFUsMu6oPTP67Z6MnMe49+dcuxwlyFpSY1cvMoUQkjAnJOJH3Hb9nU7LE1XL3y5flRzw4t86sHbozHaFYU9RIAXrm9zz9Fy0a7p8nMkDQuoQAArDBSrKwf5dx9lj5chflFShHUZ1O9XfV1KJsXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774861256; c=relaxed/relaxed;
	bh=tNRac5Q0bdyEoztagZPdambBGiK73kwsfN5Tdvc35C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiPgAfomn9RccDMMAo7PF1VB79aMQN33XcXlfeRJ7TqetKk654TNMj3J1VXBl1DIe89l4HpGLtizL34CTRmz6EGB/gHPUbo2MCuszEUwQmM91CM6xVbokimWJv1QVul0MwoPvd3lxrwv/hC5o9cb5RTz2PAc4y4rT+XoVNAQ95m9N7ApAcae2EfFnWj0l4y7F4KarFZZB1yQr01Ht9ijXcpyKgrRR+zcANI9NxegPOHXtB4v65ss2NB4oVZHutPp9Eo8AmYPV1M1g0DMNc+7SjVjFI0OvTVHDuanYI3kVl0NMngv3Whm8zS0TTswkAhTmArkr4xPQmANXpif8AudYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WyVV6yho; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WyVV6yho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fklb766vYz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 20:00:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 42169600AC;
	Mon, 30 Mar 2026 09:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BC8C4CEF7;
	Mon, 30 Mar 2026 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774861247;
	bh=kryiSL0c5gWoP5Xn33RlQGuB1fDy2r29C8AZwGGNizM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WyVV6yhoGLHl2DGlMtLNk2PLvv1LoFNZHT4upzyLknoqI3XroAjHB9I1ha+vU4mPX
	 jqLByu7cdkfcSBvwjAbgeSA7t1FnsQjdZlrHnf9SNnPEyV8aXCVfzuhI/9ayog85j2
	 ZCfecMUhBhB9NayIQbTF+29vTra1H0L8yHpOy9Fwzj1WruGul10WlXsrznGUH8EUO4
	 yAVoSQA1pK/w43OyYruiDlv+uPCsaxYtmh6p3C7asR9EeKI1wjuzkpsIcL4izJJluW
	 H7vlwohlhoQLLz7U0ZJ9f5WNsHXklzmi3Z/jx+6T/BWbr7v0B1OnwuC2GYBfZcweMT
	 Fa1JpYbf/eG2w==
Message-ID: <b1c93301-c12a-46a6-ba92-53e8f9a28022@kernel.org>
Date: Mon, 30 Mar 2026 11:00:37 +0200
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
Subject: Re: [PATCH v2 4/9] mm: move free_reserved_area() to mm/memblock.c
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andreas Larsson <andreas@gaisler.com>, Ard Biesheuvel <ardb@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Brauner <brauner@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Saravana Kannan <saravanak@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Will Deacon <will@kernel.org>, Zi Yan <ziy@nvidia.com>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20260323074836.3653702-1-rppt@kernel.org>
 <20260323074836.3653702-5-rppt@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <20260323074836.3653702-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 08:48, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> free_reserved_area() is related to memblock as it frees reserved memory
> back to the buddy allocator, similar to what memblock_free_late() does.
> 
> Move free_reserved_area() to mm/memblock.c to prepare for further
> consolidation of the functions that free reserved memory.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>



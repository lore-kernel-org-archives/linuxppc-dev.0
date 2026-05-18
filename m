Return-Path: <linuxppc-dev+bounces-21088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FA6CD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:24:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrSC6JGnz3cBH;
	Mon, 18 May 2026 18:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092651;
	cv=none; b=U3a9dUVssVpZCIhadadfLT6ZFhB+vc83YN8T7Frc/fuOSmoAN5txfgHcSJrrb0nFMU5U8og/TZBqQWxlQiMA4XKz+beZ/J1AEqNDHIidYOaCEtjV1weSMh9QqrFCbVZDhxaLSe2RqtM/oe9ItPL+AJIJqad8WfdbtpgST2RTQLjZCfb26R0yNrXXV0uj4BDXmkUrgPh0tBmw5dGvmd5cF2XqyGJoXQPjErxwcYZg0P6kXo1VD9GCmCBHZZ7/MnhBgMczZFM9VhQ7XPBT7sY8O0jaCNSDDTWkga3x3bK187+YCfT/4tVLiY4oUlAA3KmXCphgGWGfwb7NihTGslKOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092651; c=relaxed/relaxed;
	bh=nDIhMV1nHjwLsCIXlCezYHSNmQyf4UWuYbLZvlWovDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KM1vgmxRZthqEwndTsJd9azTPrMVRxMp/lRO+gGMiRtxJMgVUvneTHzNKJcnHt2jTxFZDpYfOYTA8qTqvZ/PSmUTP3N7Lxyfs6DyEuqZXc/sqA1dCSnIl63ETSSYROri+yp89YsG7CcETtYhQkb85XrSUpcZ9cthQCAuAxsdZaypbQ+JMKmQIjoOtL9nvQdiqXNEka7sCBahvf7x/1ZzlPNNdSV1HuW40IuyVwjFKmDzXL+Awb1zGo14MarD9FDEfXOF1ni9ZgJsTB1RpDVFCQ+STLEl1MKVhhDrB8k+oaybHKsJZoH3MUe+I4BZhCX3tf1TQE2ssL/rNu4GGjyzcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NWifYtBE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NWifYtBE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrSC2DDjz3bv8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:24:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B6E5441B5;
	Mon, 18 May 2026 08:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1D1C2BCB7;
	Mon, 18 May 2026 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092649;
	bh=nDIhMV1nHjwLsCIXlCezYHSNmQyf4UWuYbLZvlWovDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NWifYtBE4iioUAj3misRX6WwJ0qFse49SAbzHE90dFtNp8FN6knm3Yiph8G/VuQHI
	 mk5mZdPQEKJC66muMH1yh9b6HwWB0JlBDq+5eBGodIOS/8D1pPmfLOHdZOjeKWK88i
	 N/8w1A1QCWLgXVg9FtWIO/NYcHS1lK/vrQsa5fOdwGgM9OSoaJW4SZC9Hjn7WPYBcw
	 GeKO0qiVF65IovoAz/Xum8DtfjdWmTxiZ2CqAnKB3ZuqDWK9CLQYjpJrhBZDofIX5j
	 V9HjO3QpHnZq4b337FQLstpxcEkP7IBe0Bd8u8pcKxo9RJ8TS2P+8sg+7Whz3yPWao
	 yp6TgriAHH+hg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 00/13] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <agldl4XQLKAtyLty@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <agldl4XQLKAtyLty@FV6GYCPJ69>
Date: Mon, 18 May 2026 13:53:58 +0530
Message-ID: <yq5amrxxxh0h.fsf@kernel.org>
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
Content-Type: text/plain

Jiri Pirko <jiri@resnulli.us> writes:

> Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>are handled consistently.
>>
>>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>shared/decrypted buffer handling. This series consolidates the
>>force_dma_unencrypted() checks in the top-level functions and ensures
>>that the remaining DMA interfaces use DMA attributes to make the correct
>>decisions.
>
> FWIW, the patchset in general looks good to me. I tested this with my
> system_cc_shared dmabuf flow, works flawlessly.
>
> Thanks!
>
Thanks, Can I add

Tested-by: Jiri Pirko <jiri@resnulli.us>

-aneesh


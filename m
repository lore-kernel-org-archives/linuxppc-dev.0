Return-Path: <linuxppc-dev+bounces-26411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B792C624D5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 17:24:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZCQh1xKnz2xns;
	Wed, 02 Sep 2026 03:24:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788283468;
	cv=none; b=fJ7MlXve3HERga5ZYh+ZqGDGVL0dPFqeqc6oBsMsibuJwFrjkoummpWP1fsZUxFrrpFYy6QO2ihdCsQ1oUvzaIteikaKlcCAygKM9vBe7efbQCgYSTVfBapO6AgVABIf4VG4Hlk7BAUhjJYHzimbjjT1kUCv3PXTRv9gTIyW3fZMsr69hPAssxzKZCCB+RAj+2OEC5ZkXwGK38nzvz85H53KpHXQ0iYZlr1mb+57o4yTXhDJ91xG+OiL0kwB0An5JL5yfD5nUkd7t+nnV116BuaC3rCIanV9tOPCcODoOF5lWUb/oOkjt7t2n9yJaS64hAlneZ35ubBOzqX8o3EfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788283468; c=relaxed/relaxed;
	bh=FNtqw+4cMw2tiBTTuj3vqzwte2JlYbPEDqcQmayzdB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKr1T+5o1VnPgBrfPSntG44RIyIKyd3KzH5HAsBzbNZ1180iJ/H7MlaDDiraIETR5eiYSRRBRPcm7iE4M+aFgKCQCuP6itYRsbkX6GMzV2xF0ibRPuS+MG48Rt8SPxjYz5MphkQkuKqMVrgpnhY4HVai5DrnEDiC4LcrMkJvKQ8WPPzEkEwUmfba1z3Tlf7t4OjQ0m/HMz7oOb4ggkYLgMVVbrmodL3e4zw6A6FOCoiUw/ELlERJ62bDE8iTQpLVf5mapqOSg51n+szIahLrCUGS0GJOeT/bZmi7ED6ZJ5vgZtIUcZOfho3DYAhZSjoMEoD+sLIctBNe+sKhDMaLCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LA5VUHH3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LA5VUHH3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZCQg4Fy7z2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 03:24:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0ECAB4351C;
	Tue,  1 Sep 2026 17:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B451F000E9;
	Tue,  1 Sep 2026 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283464;
	bh=FNtqw+4cMw2tiBTTuj3vqzwte2JlYbPEDqcQmayzdB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LA5VUHH3CQRbq6TtG7uAOUnltv/nWwvN8V4834MNvXbYRxwSmTotOmWteii8UiQS5
	 QR4fRDprMmPj5OuZI0MppUEPQ57nQvrdsdqpstxXyjI1E00zLmnpLMN9UloL/ZT3FO
	 0XmliimdrLwMGlqsl+hZIsTW4GKZKZZ9EEBZc2x2c4GzLI/e4yKx5tOAffPk/J5ASP
	 x2ZLdYf9X9nf1oK3mVaEG8OLndn+E+5n+OfO8fLsoGCF3JHWDts5Pv/MKpgYoy/yPr
	 NZso7dD+ZtKvquJLdY3TsryJ/fkqf89H3HUSu6B8WDndLzqUjSBpq32qmt4O6UVQE/
	 43dW7Sls5S4Yw==
Date: Tue, 1 Sep 2026 20:24:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <apcKQBRCFeF-usK7@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <apVmYXlqsVr_p4Oc@kernel.org>
 <7adfefaa-91c5-4bf4-ff98-5dfbba0eac96@outbound.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7adfefaa-91c5-4bf4-ff98-5dfbba0eac96@outbound.gmail.com>

On Tue, Sep 01, 2026 at 10:42:47AM +0200, Eli Billauer wrote:
> On 31/08/2026 13:32, Mike Rapoport wrote:
> > For large sizes kmalloc falls back to page allocator anyway.
> > 
> > And the doc is out of date unfortunately.
> 
> I think it would be a good idea to update the doc first, and by doing so
> officially change the API. After getting this change approved, it's indeed
> safe to rely on kmalloc() even for larger memory allocations.

The documentation always lags behind the code and "official" API is what
include/linux/slab.h says :)

When I wrote that document, SLAB and SLOB were still around and had
different properties than SLUB for larger allocations.

Still, the documentation update is on it's way upstream:
https://lore.kernel.org/linux-mm/20260831-docs-memalloc-guide-v1-0-547718c274c1@kernel.org/
 
> Regards,
>    Eli

-- 
Sincerely yours,
Mike.


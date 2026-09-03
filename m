Return-Path: <linuxppc-dev+bounces-26496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B9C624D6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbN3Q31JQz2y2R;
	Fri, 04 Sep 2026 00:56:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788447410;
	cv=none; b=FjwHRBw5awcSsnNtBhJDtd3pLKl/xXQz/P03ungzVJ9rBtt2169QtsOXro1DjrroZ2+e6/poZwt7rfHnBw4mjbqkE4qDonAzI9a6s3/bYqERtTnWwL8V9qeYEovhc+TIejZBuCCZDV/TCuNRF10+F2ntppTko+P48woYISpBnxZnDGfLNyCOsAjYT9CDBWZ5LzcUeKK+buULjWAounbk4JIYm/7zp+G1w6f1YfTNC8YvyjOg+6gSTV3YAeT+LKYexnSBZtYZgTt5K26mT6mmP0/F2CyNrrT7DDcl37wLVsiMDnorqFT8N4DjPJAyqXGEh/wVOfn0vHR5lf26D7Osow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788447410; c=relaxed/relaxed;
	bh=sewVvVo8Dy/uyKZY77qoojOHF5+/0ZDpHv96nZFd0J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwwyfDSNCO7PJ4mm2ZDKvffRFXhzj5HEEkyAcuskoin1z3H2OntIYzjBLOTIh2jON7oUrXPu78Fcw0D58F1FfeOXzwVIXzl2Ugq2VE6LTOeuSmpBcvZvjvllwjJ2ZExzEEs7NLjZ2BT6SGcL5Q+GJ1EGsYU5S2CysIM+lTtXhDuPthceVkglYqxIDNntPkxFGi2CDLgwMialocp23zaoqwn2fqC+EVBo2SvTzVxSjkQ9aLs3cVXKmM4cT1uwHIQUHkJq4JF0mw7sdQ0Biw04Z4JKyIeoryNtvOyMkpy8ypcXdGorRnxRdGRLR52TvVj0WS2glXjYpHp1O+MohLpXQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8uYt53u; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8uYt53u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbN3P2rjLz2xWR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 00:56:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 65F406057A;
	Thu,  3 Sep 2026 14:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9631F000E9;
	Thu,  3 Sep 2026 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447406;
	bh=sewVvVo8Dy/uyKZY77qoojOHF5+/0ZDpHv96nZFd0J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L8uYt53unxDNYKZf7Y4vZciAiITXax9htmtSv1B4ko/+NkYHyUbMm0k5xmYw1ZYdH
	 YqkRH5UIFvAgYNQoEP4uPERhPI/U51PDU9guJRPq6Kca952s44iw+urk585F4CRKBo
	 aZ7nZStIdXiRi5G9bl6AwbzLR22FTBeEjeBZJM6YNgQLammNOWmM//TBTENdgWHJDC
	 81Lei3albKFQ0oz7bl33i9TnaalK+oIcrFpkNzY1k32Tr3D7NZDzOLIIbhyHB56StK
	 BI+s8Eoew/r1tq2WdAiNb1ViXqj+17CuoPbXi+h/w4a2jm9NqX/h8M2AeheHRwwkU9
	 pAUbkqAm/AY4g==
Date: Thu, 3 Sep 2026 17:56:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Eli Billauer <eli.billauer@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <apmKpl60eHuVFRjt@kernel.org>
References: <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin>
 <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
 <apcPg_y-HsMki7we@kernel.org>
 <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
 <apgSCyj-h2xVc2ss@kernel.org>
 <1d7f8806-f4a0-fda0-a361-a011460ef308@outbound.gmail.com>
 <3c19c24f-5036-4bbe-b3af-e5eae102f34a@kernel.org>
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
In-Reply-To: <3c19c24f-5036-4bbe-b3af-e5eae102f34a@kernel.org>

On Thu, Sep 03, 2026 at 04:28:48PM +0200, Vlastimil Babka (SUSE) wrote:
> On 9/3/26 14:30, Eli Billauer wrote:
> > On 02/09/2026 14:09, Mike Rapoport wrote:
> 
> > in this case. So we actually want __get_free_pages(), but call kmalloc() 

Just to add to what Vlastimil said, if you want a buffer you want kmalloc().

-- 
Sincerely yours,
Mike.


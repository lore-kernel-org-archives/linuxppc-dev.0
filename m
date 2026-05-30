Return-Path: <linuxppc-dev+bounces-21759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8940CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2026 16:19:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSQRX1npVz2yS6;
	Sun, 31 May 2026 02:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780157992;
	cv=none; b=kX//cN1wzRe+C8qgY90prHEyhKIWPx0ebAD14+rjxyla4Mopx0X8CJp08v+/IsjwRqByy30XnMn90twt905tOc4CPDTPGaqhfF7r25nvjibgze178uI3XNmLV+OWc/9mNxZdiWtMdLGXbac7gyBGZa64m3xSJ6aeEIe5z0F5uNB/wavs9LVV32Dq3hZNMWf8W9Vyd0tPV8A+5DHT1HAzCSmTdLYuSckdpaxjBxIndpjlRNEpLUshqLjn5eeK2hxYnzCvEaTuVhiZCiBimu5XP+VyLX0gk80tgN94c3PQbAKs6fiFt82FS+bg7siWHEDjkqEASfwVN4lhlEdONHbtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780157992; c=relaxed/relaxed;
	bh=WxYmQxwwBxgWs6asR9XSCI+irQfqn2faBEqKE1hn53E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opV8i1yz8GBjS69Gys8aADF9rf3Z/WajZaG2z81b/lIhaIK2tP0K8DDXCRp1wZ/wh2Pt7mkEuIPloQ/eOXQRIW11kGRELvFC6Ff7zeRr2ghqh1ToRvdSgUt/hPNNRODFHBgDa5MiBgw5oc8UYy3NK3D7VE/+auh92qhGDJoRY0gtdUX+ppYcrkm0i6qqMrIpPKC6vtEEvsML7mBGCPkSjHqrzJLMgZ3BX8BuoIVcU3dz17Y4LNxmZKPiw+xDAVZDEbtk9z5TDpGNHGgDkVqQOE2MEnkehaC93o5P3mg8wmW1/Lbj8jOXVBLhgRnDbxWuwLo2byRdgqWRLWlQFAoSSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZl0+4I9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZl0+4I9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSQRW3QwMz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 02:19:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18ACC600BB;
	Sat, 30 May 2026 16:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD33E1F00893;
	Sat, 30 May 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157987;
	bh=WxYmQxwwBxgWs6asR9XSCI+irQfqn2faBEqKE1hn53E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZl0+4I9eq0OPPyxyDBdqCGRR+y0CoJpx7P9J1ZNHafWZGZX1fuK9HT7HOCSp1FVU
	 9ddWJ9lDITFjq9eKGfZ8XgcPI1Gceue8QxkZpOu0JwKjN75XEWJg4tA2a8UNAkWZvu
	 d2ASsHkW3EY1IZ3rOpPzq31XPfEMQM756K5+/fSW612wkX78yv2eAZ66ejeZV4LlfY
	 gAu+RNJYW42KKsssq+PHsl1z2ZSd/eOK+QZCgtAc5FgOD8sjUj3miMaJcP2gtaD17q
	 8U+HAlTtH77+9KCSbzDnS36KQEJCJesVoZVR5wfQkL3btqSLgCjvtjIMAmDS1I+rUb
	 wf48OWQ3Lcqyg==
Date: Sat, 30 May 2026 19:19:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v7 12/15] sh: Drop cache flush of the zero page at boot
Message-ID: <ahsOGMc7ys3H_oAt@kernel.org>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-29-ardb+git@google.com>
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
In-Reply-To: <20260529150150.1670604-29-ardb+git@google.com>

On Fri, May 29, 2026 at 05:02:03PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> SuperH performs cache maintenance on the zero page during boot,
> presumably because before commit
> 
>   6215d9f4470f ("arch, mm: consolidate empty_zero_page")
> 
> the zero page did double duty as a boot params region, and was cleared
> separately, as it was not part of BSS. The memset() in question was
> dropped by that commit, but the __flush_wback_region() call remained.
> 
> As empty_zero_page[] has been moved to BSS, it can be treated as any
> other BSS memory, and so the cache flush can be dropped.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/sh/mm/init.c | 3 ---
>  1 file changed, 3 deletions(-)

-- 
Sincerely yours,
Mike.


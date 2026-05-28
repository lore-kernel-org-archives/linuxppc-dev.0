Return-Path: <linuxppc-dev+bounces-21617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525CBCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 06:15:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQx6q5mT2z2xpt;
	Thu, 28 May 2026 16:15:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779948915;
	cv=none; b=JslAQsLqmUL6VyzB43OtO02ircSyUZDshU2WsMkU5BNiZ+3FNqkUtsYmXsGGo5ZkJGOHrlVE9tDoWZ46eHS3Ng1YyhkHg0PQO3Cz1OIWGgvzUgC8YQofI0e9gtXQdht1Wj+jMEzzwj6D+7XXu24Xgk4VwYAqYsoobg0K9m/girbz3OTQZ2Q+bNdgUaIC20rzgayE65G9D6exB1H5Vuft3PV0n5gYu6OSCkMIMBzWQavVLD5jb5xdbhvqs+WFgMBHlCByl2doiUz9oO8UDtDdgO/WuqBbp/T1BhxwThfzM9jsMidnY/nB8HQ/bw7xolZWOxvajvSKWhAliaq7BqzYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779948915; c=relaxed/relaxed;
	bh=sRKrhgIJK76DvhKc8lDcKP3ib2MuR8el2Ira7SHuRmM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PcPMD18BdriCEzt3Ubnl1nyCloDrGgQR3XwlNi6853+NVcaga5FctUoOBWG2tArHnQKucIgefzOpWbE2WWwFOfZrzc/szJfkxPzX0eVYEhwyw5bZCiY2kB1cR9FwcQ5RbQRuJv1wHhLHY3rIIJGmJBWrDW3BgoVx98UxpEVd9+61M3Tjeaxh9AizUYgKDdy4jYErrIJAGH5zwHLt7fUL5aQLNwfNcj9HLYpQ+ZB5U+fXz8hkjPj9IhcWn033Mc124U1Vf7+rcqFLGLuJWCp+bCB2oxz+sZzN61Xg4hTrAMPwHC3rbVjLwPSvooLlvq8YAtG+i0mSzD2qE1Oi32Dv5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1PiQ5PN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1PiQ5PN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQx6p5RPnz2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 16:15:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 05408401F5;
	Thu, 28 May 2026 06:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A541F000E9;
	Thu, 28 May 2026 06:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779948912;
	bh=sRKrhgIJK76DvhKc8lDcKP3ib2MuR8el2Ira7SHuRmM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=a1PiQ5PNbkQnWnC30lpTKTrwQYadp2w2p0U8B2MzUZ5lWlCEg0QyM8AMQpzycZygv
	 FvaONnp6/lnAoptcCj+C4fhPqVxWAHoPwlT2PsIAhUY7XxdXfxfB7r0gxJ/EkklHqh
	 U5ndV9vAuvynZvJxFqWjKIjjunTWrj5iQNfFfCbCVeDwjPS+jZvG6up2mqiawURVp1
	 10h8wkyHeYvVGogUukL9e+Tvhycvo9j0HJvcM0FO4shNmUGfNCdJHV4IA//H0sJ6Ur
	 z6ppWdUCbsjcN346iIBfcyHHa989xSLwor4KttyXLXjlad1+MJkD93DFKd1s+u05h5
	 GEt+TdRSegiSA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 16194F40079;
	Thu, 28 May 2026 02:15:11 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 02:15:11 -0400
X-ME-Sender: <xms:bt0XajrytHanjxs_yj4VHOwSDlHzRL5SxpDAUSIT9g1uf-cLrEA6lw>
    <xme:bt0XaocSspHV73k8Rh0IljsG_YTbMQa0gYuD9E_9_B8B1jrErRuGPwms96rNTuWq8
    _f0Da94NGpalCFrHr12MT4ht7GSnQ07fFTPsZ4uPU-sNIzBCSjiEK4>
X-ME-Proxy-Cause: dmFkZTFYpebslvMFokJoFBZEvhS0RRgsf2rUv7/D81FLAhtEAxXQxJWExaQNrYQvlunXOY
    BzXZlDOzIwICfsvp+wnolkeo3xWaLn/+d/N1LoUHlWUfIIXpugElRdYZZhTKKZLx2NpaJJ
    PyWtUJneOFaEFjJXOZDovXcM+hcpCMkINXksgmiCh7FrU123DTD0mHWjBUvKOYhD8/JeTN
    TgPCJc7dtiYEtEx5zWv39oFWvBCiqMAXb7+6RwUz8fhWr3X8lIaHUIuBBnsPFiQvXo+j77
    IGXF3FavQsXan91HQUIjAEhEyd81hdiEOEQ6SWdmeeaV3xzlrbmsV5pyW87rxFO1TjRYav
    e5AhKyOc6w3NP2RJAbo6/Tvbd2Rovf/EbsfYc68imA924zqCOVWKi2MaPL5udgbalieRsA
    M/2Nqck6HrqAjYKDfE8dPO+thC/pusJd1m1kFl1hUMvXnbBzG6J0BR34+LSR0y1Tvrl2+B
    uxLxG3/KyN+eD08+3YAizm1p6ZaI8JM/3kES/5hVqTZUNaQnVyEpq1aF8mkaWJh0yN0R+O
    gF5o6cRko4vpi2DVE4lbi6sZ7pZSVT/Uil+xYbx06cpSUDfB9YPcSHustlMlrkIsF06PpB
    /0BqrViHB5NhSI7arFBkuGzWRFGbbY6KrbjEkCFwH78CDaDP+qSFu/R6R54g
X-ME-Proxy: <xmx:b90Xajr8S2ObbLDSohOd1_NPqRrPN5O1PNGuPqEpeC6IyTrIIQBCew>
    <xmx:b90Xaih0v199Mz6FRRhghaPgNUlTmWrXGttHjyt7rYw7bBsx7Hd0sg>
    <xmx:b90Xatx17OOg_OzLbvS1_aiB5T4_yiHY60aHTVCuxr28PCooE6xK3g>
    <xmx:b90Xao-mBPm8n5JsUbMvYRNM9JTvpVNBmiqte0PcOEG4yaJ8VeEiJw>
    <xmx:b90XaiC-u174RWXUQ5rTVkL4hh4sjD_5HdRLN_Xj-bbWaR1FoLJbAAXi>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E26E4182007A; Thu, 28 May 2026 02:15:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
Date: Thu, 28 May 2026 08:14:50 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mike Rapoport" <rppt@kernel.org>, "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Will Deacon" <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Jann Horn" <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Message-Id: <87fbe311-5657-4e36-8a33-7404980a9df6@app.fastmail.com>
In-Reply-To: <ahfWnLIwZXJvbvNg@kernel.org>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-30-ardb+git@google.com> <ahfWnLIwZXJvbvNg@kernel.org>
Subject: Re: [PATCH v6 13/15] sh: cast away constness from the zero page when flushing
 it from the cache
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Mike,

On Thu, 28 May 2026, at 07:46, Mike Rapoport wrote:
> On Tue, May 26, 2026 at 07:59:00PM +0200, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>> 
>> SH performs cache maintenance on the zero page during boot, presumably
>> to ensure that any clearing of BSS that has occurred at startup is
>> visible to other CPUs and DMA devices.
>
> It flushes the cache there because before 6215d9f4470f ("arch, mm:
> consolidate empty_zero_page") empty_zero_page used was for boot parameters
> at the very early boot.
>
> I removed memset(empty_zero_page, 0, PAGE_SIZE) that was a line above but
> missed the cache flush. 
>
> This whole "clear zero-page" can be removed IMO.
> 

Good point.


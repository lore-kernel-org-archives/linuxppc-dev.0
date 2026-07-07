Return-Path: <linuxppc-dev+bounces-23673-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9FC44500
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 06:17:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvWGr4SZ8z3brc;
	Tue, 07 Jul 2026 16:17:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783405044;
	cv=none; b=K22zEscxQXDVQ+Iaqv3rrXfJI4LhPj3XRJoC4cAHy79U6FLbxo/hbaAm9nG61nLnxKLy7kxSgwKtt8yF+Xu8IK+SB7j5tumBXQEBn2uzOfnav5Ac068SbpWlAhYlm0qHoIhvAQwqaIqEZR3H4QOMdcpmDs2VxYEhZ41j9nQGhbE/SnAwTE6PAt/kTc/c0ulkD5yxyFLBUDXH6pO0UmUZK44GAiMg0oBIJ6FOB/+cleyre27d+mxiwNQRNOUkl5SfTR+NGsEmxRb6tEEmKdn0X6Iua1THM4fjyZ2ek7cd2xwm5rhQ5UpKH0tot2g9ueP9aZh4og1UVBO7IGWbJf78CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783405044; c=relaxed/relaxed;
	bh=836SAMNcgYGznpPv4pDFhhl2VYFtwB3MUE7NXhRTR44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLGWxQX7EqlzsL8gTvAAzaX4MFbDj4Rk0HCslM/Lhcz0uJuIhj7BK7FryPU0QQTuChBMZ9Tokhwrd/JnEF6T8qa7YgyEZ/PMcKISYx3FDzxNCTFIBCpyvK9bA+UuDWnHg0kDJOl79gGL6O1ma7sZupM/yVW9xGR3avrhcN3B1tGAZhcOnJIxGtDeypa/ffHM2T9N/Fs1Wd6hUSDif4Xj1mNpjvIHFifD89z5lvQqob6U49wWuEjEF0qDJq4t+67ltH5eNTUXBjugUa1OTgHpKf0lUgcHlYWHTS0Ehwz2lhJOd6ryeSc1/PqCeTW4zBiYTw48XXBaT2xl3bQqHl1nyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9LZ68VX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9LZ68VX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvWGq5W7Vz3brN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 16:17:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E027D43C2F;
	Tue,  7 Jul 2026 06:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0651F000E9;
	Tue,  7 Jul 2026 06:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783405039;
	bh=836SAMNcgYGznpPv4pDFhhl2VYFtwB3MUE7NXhRTR44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l9LZ68VXwiy2wzLo7a6kET2rVY4gxtpjyT5oNRV80EH+ueCCspXQGjjIAlDlLzyeO
	 YFYx6l0N+wz+Yy6oMl2JKy3lr/dXU/sJGiE/Mk3RNnxpzjGu+j5vbStTn4Sbhjgc14
	 aZe8rHO3zg0yr1Yfzs6dPtpo6gK9Hw+qdCT0DXbO8vE8KJ8xBpvmIl7MIxNsP9+Ok4
	 tlnMXmxQ9La5/V8b47TJbYkAWoQQODk2Hx1nTtTghnvdeQPJLOaNeS7bpTJcdHx+vX
	 lejiXTi4/7NIktdzxwyfeeL4MkfFWX0K2bNuHqFaSu9rbXvb1YZT2M+vVWfQe5DPsX
	 vROavjbjpHKiA==
Date: Tue, 7 Jul 2026 09:17:08 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mm@kvack.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v2 0/5] treewide: remove unreachable memblock_reserve()
 return value checks in early boot
Message-ID: <akyZ5DhIV_Grn1Kc@kernel.org>
References: <20260706163753.193875-1-ekffu200098@gmail.com>
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
In-Reply-To: <20260706163753.193875-1-ekffu200098@gmail.com>

Hi Sang-Heon,

On Tue, Jul 07, 2026 at 01:37:48AM +0900, Sang-Heon Jeon wrote:
> memblock_reserve() can only return an error after memblock_allow_resize()
> has been called. Before that it either succeeds or panics, never returning
> an error.
> 
> Before memblock_allow_resize() is called, the return value checks of
> memblock_reserve() are unreachable and can be removed.

I'd rather keep these checks.

Removing them relies on internal details of memblock_reserve() implementation
and the existing event sequence. If the code would move around relying on
panic in memblock_reserve() may not be correct.

And the few bytes and cycles the change saves do not worth the churn.

-- 
Sincerely yours,
Mike.


Return-Path: <linuxppc-dev+bounces-22311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB060CD8CAE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 06:31:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZJwX2qHZz2xR4;
	Tue, 09 Jun 2026 16:31:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780986716;
	cv=none; b=bTR46Xr2ELgI7poOqVXEasZ/Xd+t1u+Fl0QzH6L+LaQQ4YN6DWu2HiS/vtZByHeLVQ/iwrqSME0w7u6OlEKkNu3WYFY/7QpCJjrKV8+Rve+7fTIW32GmaBNl2WKbhKVULIHWFZ9cNcNpQwYjSlWF7D2cyPsbg3KWBA5kRyVjUCZothF87zDiI1yTKwBmJ2C/rYfWdhj/CI1iJKkXTUiC83qh52Du+/BiwWYsxPry7rSpjpiYWBvijgyh554brnCge36iLtw/4nXVV/aa8JAtnTlCFG3AqzplrEu4TnEryL0RlL4kOg4fkc18j/tlLypjYdAnPqpLjzzBU7mFqWjcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780986716; c=relaxed/relaxed;
	bh=9cVW14CxuHH6XMS02s4qPCeAXwNI63im2JshZ0C4ctU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iSnySZSOXb8CRUThwz4MDAMTtndgi1RczzqEm0gSjpb6hdZuevJlNKDMSzK8BOWrN8fbuBwD5ceVs0FnsOYF14uasZyGPJA+8msgM4T29lyqCg0Z4/zs0CX87HOAF7HctkkZE/eeuvwv3xjcCtUTF2tHx1saVLCTdfWTSX6PuyMV0F1k/Becof5vTBxZkL2JGKiE40q2tf16peTSGaO+QtaiEjTa1UaOaifsdHfHdVhMFdulVV9oeBkYcmTux4U9Zm1dEI2kica21ggwOG8fKjvd7yK2jf5G6dp2IGVxjT63NVdUxeNqc0MKgUdes9wuzfwgqBNVYVpC8nXAKv5jFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I36rCwiz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I36rCwiz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZJwW39nXz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 16:31:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 275F44422F;
	Tue,  9 Jun 2026 06:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C2D1F00899;
	Tue,  9 Jun 2026 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986713;
	bh=9cVW14CxuHH6XMS02s4qPCeAXwNI63im2JshZ0C4ctU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=I36rCwizpJSZyKVIsZkBmdlWaFimb33Sof3TGcXA9WlVvdRP6gToOWZdvXukJ9jL+
	 5SVEMKWrYVmGTxMjBMMczCYBVlQlb0ljjMetAnAaBddkldG5g1DeFiTNvt/h+apXMG
	 yeBE+dfYKQMSqRajbRyU/vDR9Dypo2rTY7QIlHedCvqph5jJnbHD8LoLdC0QM0IHja
	 4/xfhdmId/CoFv4tmlFVaaFRcF1ObRKOA9VPciyAhsYEUi7RcPgz9JlUfuA32+hg5x
	 bIz1OGlgeHzDU3z+ZzoMR9AQkpypPfB6pBougvko2H3eBSCSH37l4EWGY7GrqDAWN+
	 acs82JagAzwaQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 35BCEF40075;
	Tue,  9 Jun 2026 02:31:51 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 02:31:51 -0400
X-ME-Sender: <xms:V7MnapoRZE115mv3OE1zemucjsva6zjZtD5d3LsnPgo655T0S1_hOw>
    <xme:V7Mnameu8nxCzvSST9MMvGJscv5vZhpBAdbcMmboEfheSYhr55P0vRBiJ0xjWN4Wb
    SxlxanxBk8mUaIbIG7n7TYC69uxcjn-LY5Jbu_tl1eHxWiSk2V7yw>
X-ME-Proxy-Cause: dmFkZTFT0QeOWg6z5S4Eyrduc7ntI2XZ8ybouC2z/7kLY4pY3mTLgtkacitZwNL0VP8Z+4
    i4UPqGOWioNbD8PElNjGgAiflyJ41PIsAAy+dD3ap/EH+TIAFzLxd+eA15lYonXwFjoOXm
    AKsU7Rq+u5U3jQ88y9qztBhSwCBkMRpJPnBR1JdzCnxPqezwVJAo/ivpK09iFH3/nF6WJo
    YO4ZqSmOgzUBstd3L/zqENBtA9r9ayIfL0J65bWVdVShBuwriyuFMEK/DNuMYYCR4QHL0P
    69x8Jv4sWE89NJ6Y2jLFRTyobPkf+u9dagvkxQrWTh7cFlpWSLv+eOEi7AbetLf87SYZaQ
    wEdjX5HLugz4TrS6h5hEFzg3wvewAiBqfJB1VhgirTBJK7Z5+mi4t/WhE42TBtP1+u3Ft9
    BEGoJTCVdWezAbERphPOMzN7Xs6Ww/JJqfJ2iG4yB2ymnmk6z5cXgyCU/l8ZmXDejy1iux
    nxIGX8vKp8sx5VhXOhGykeqMiho9sWDJe5REpSnNTRAAVVWR6IFKTbYhEozF1pJqJh6KXa
    uRhNRa0XsAfrFUH1snAI+NgurLh9E85q0b0eeeluRqIMM1dRoLf5asDBnpVwciTtgxGueD
    sp0lAJe9rKMlnCbk1Z4+Ym9JonWancXM30q7gcQtuJoJnqqguwszhcyU5F2Q
X-ME-Proxy: <xmx:V7Mnarble0pwjkE_7YhgAahliXMbQH-zJV-FMhh0Vo225d_uaGzbaQ>
    <xmx:V7MnavbvD-WJixjTpRNbVUmFMt3WUdWknFu_5_hMnuncD3ThvB-dnQ>
    <xmx:V7Mnau32lH_vp-FfGhx90w1SaqphVHzCJxm3a0ywDm83jsotvCPYEw>
    <xmx:V7MnanZUgCXHNAw5zTNMLkS1bpPFe_ckgiLJju_yL5znmAF7kWdFCA>
    <xmx:V7MnajlRhooJNXLU6ZdPb7qf28Zq9usC6xacsV83k3tEqjwUaKa6cEjU>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E00F182007E; Tue,  9 Jun 2026 02:31:51 -0400 (EDT)
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
Date: Tue, 09 Jun 2026 08:31:30 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>, "Liz Prucka" <lizprucka@google.com>,
 "Seth Jenkins" <sethjenkins@google.com>, "Kees Cook" <kees@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Jann Horn" <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <12e57bd2-5eb3-4de0-bec7-b46b58935977@app.fastmail.com>
In-Reply-To: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com>
 <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
 <CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>
 <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from the linear
 map
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, 9 Jun 2026, at 08:28, Marek Szyprowski wrote:
> On 09.06.2026 08:22, Marek Szyprowski wrote:
>> On 29.05.2026 17:02, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The linear aliases of the kernel text and rodata are also mapped
>>> read-only in the linear map. Given that the contents of these regions
>>> are mostly identical to the version in the loadable image, mapping t=
hem
>>> read-only and leaving their contents visible is a reasonable hardeni=
ng
>>> measure.
>>>
>>> Data and bss, however, are now also mapped read-only but the content=
s of
>>> these regions are more likely to contain data that we'd rather not l=
eak.
>>> So let's unmap these entirely in the linear map when the kernel is
>>> running normally.
>>>
>>> When going into hibernation or waking up from it, these regions need=
 to
>>> be mapped, so map the region initially, and toggle the valid bit so
>>> map/unmap the region as needed.
>>>
>>> Doing so is required because pages covering the kernel image are mar=
ked
>>> as PageReserved, and therefore disregarded for snapshotting by the
>>> hibernate logic unless they are mapped.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> This commit landed in yesterday's linux-next as commit 63e0b6a5b693
>> ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
>> In my tests I found that it breaks booting of RaspberryPi3 and
>> RaspberryPi4 boards with the following kernel panic:
> One more comment - reverting=C2=A063e0b6a5b693 and 53205d56212c (depen=
dent
> change) on top of next-20260608 fixes this issue.
>

Thanks for the report, and for the confirmation that those reverts fix
the issue - this was reported here as well:

https://lore.kernel.org/all/aicVyebkEMs6w6UV@sirena.co.uk/



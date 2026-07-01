Return-Path: <linuxppc-dev+bounces-23283-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ED2C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:40:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtkv3SsFz2xPb;
	Wed, 01 Jul 2026 18:40:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895239;
	cv=none; b=ldUMUPspcMxmjPRoKbXQx1lfn2bFX9hDH/StOM8WY2k+mQy+C00VJeeEwCMjl5KTld4w4dUINfEVd4nR718jeQiEUT93pAXycgtwEH9mlu+9xgM4Qzfr/ZqYV3GHvHxJPpbonF4Y673pttsdXgKrIzkGKQg3SoU/zG50iIiyl5VW/xc+r6zlMpq7ECeRxOrYYpr3rXRnFmnTwZbERXR0WR8U/bnZyk5ff0zY3KtCZ8q6fGqG6BK0lJMe/PY9P0DY1boxR1e1LiXVDUyXGsppl18ZBw7FHyWuT31qXCa/LDjchFQI/sKo5UNxLz9u4ERa6nflnveRTa9cPxo21NLvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895239; c=relaxed/relaxed;
	bh=dzaTPoH0/Jbz15YM7OdwlqoyPsJkrqrtqSoCOmHvtKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vbqlby4ZEnAU5WtqqfFwtd/ImxeBHJllTq8xces5N+pH9wdHoWDQ4UZIytFMmzTCgSKLXOGNX/vhnyuV7099qEbIzre2Zu8x6bXSDnBons7bJtkPcDrgZKnBMb3bFbyFQiswwuOItTXNvw0Oahn9hrtfWI88AnS7QhIVUPtbmpcZdi4IWcPKal1CoHygHYhWeJglVvI2FRixtgX+OH3aVtPLDWu7Zf5Y1JzzDQ6nyZb2UwDWmoYaQ5tAI18driv2RMAi6O6lJr+iN1WvFpLDvRTKUa437r3WhTauIjChco7NmcrjPgck3hs6Kd3Zq6dei9C4y/ZRh4RuWTzP+PwDJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=shJRu5vD; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=g0vhUs9W; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=shJRu5vD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=g0vhUs9W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtks4crrz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:40:37 +1000 (AEST)
Date: Wed, 1 Jul 2026 10:40:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782895232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzaTPoH0/Jbz15YM7OdwlqoyPsJkrqrtqSoCOmHvtKA=;
	b=shJRu5vDUP7ZDKQSHsK+hm5YzMgosdS81oqGJoO7WyU/KYkL+sjeEnqx02Vf7vGu0x43Ry
	uv6fAueFoRpJ4Xm9fSuHL9YZ7rkYM4cHiFQyvecXnQY0kyodiLeLDYy0hJhNzEafujjp1V
	4VPvIVU8ENW3zH8WQmLPMJWXGjv3azZz4S7EcH9XIzvV8SgR9veRJvvUkBalD1CoSrGzoV
	LUCKXOnXTb6ujHmRmax4+2WJA6Xfad6AmRnq70bALY+fNfyXQpi6N0l1bc4wGICwqzsR7f
	4PF/coqct+vO1K0YDcsduOPh91BO43A+uz4vYcgsqDb3FgEpWf9orTC78wUw0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782895232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzaTPoH0/Jbz15YM7OdwlqoyPsJkrqrtqSoCOmHvtKA=;
	b=g0vhUs9WNGqHZUgF7RfmzHiuDSnx9FCObdSlzDF54pp2Ic5gy6Dobr2Cf6z2yhnU/uvjVU
	UB1UH3naQir8cmAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	linux-api@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 1/9] time: Respect COMPAT_32BIT_TIME for old time type
 functions
Message-ID: <20260701102912-ea8f3291-7bba-407b-9a7d-7c367a4c9398@linutronix.de>
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
 <0cda7366-2eb9-4ecb-b76a-b3b68ee10043@app.fastmail.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cda7366-2eb9-4ecb-b76a-b3b68ee10043@app.fastmail.com>

On Tue, Jun 30, 2026 at 03:00:37PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 30, 2026, at 09:38, Thomas Weißschuh wrote:
> > The "old" time types use 32-bit seconds which are not y2038-safe.
> > Respect COMPAT_32BIT_TIME for functions using those types.
> > time(), stime() and gettimeofday() are disabled completely.
> 
> Looks good, yes

Sashiko found an issue [0], which I think is valid. I'll change that for v3.

> > settimeofday() is kept as it is required to do the initial timewarping
> > after boot. However the 'tv' argument will be rejected.
> 
> Not sure about this part, did we already discuss this last time?

This is my interpretation of [1].

> I can see how keeping the timewarping functionality is the easy way
> out, but completely disabling the settimeofday syscall the same
> way we do on new architectures seems so much more consistent.

Shouldn't we then do this completely? Irrespective of COMPAT_32BIT_TIME?
And then remove all of the timewarping and kernel timezone bits.

It would be nice however if this series, and my other ones blocked behind it,
are not blocked on that larger rework.

(...)

[0] https://sashiko.dev/#/patchset/20260630-vdso-compat_32bit_time-v2-0-520d194640dd%40linutronix.de?part=1
[1] https://lore.kernel.org/all/e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com/


Thomas


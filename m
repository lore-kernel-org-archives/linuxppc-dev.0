Return-Path: <linuxppc-dev+bounces-27920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF33DC982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq3gD5qXZz2ygK;
	Wed, 23 Sep 2026 01:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790090392;
	cv=none; b=lK2Lj2Cs2QIu3G2AG7lgAYgP0WUXyxbK2uedjQAt3C6nbnCRHHTi+GoDWRrWWM/Bo4frvL1IjaIFOyVVvMiwHfXzrJSd+mt9dKKM7F9W9Hvs/UbDc5jYAwPo7M+ltMgC8DZeWfyLRK6FYKBdaJrit9unVJC3wJlWcOggl4m2/Kp5r+7bRllikdHudAhB7zDNaXeZ1b0kGO+lZaINAu+nIkYZyElOK83ZLCtuyrNWi4ZH80vIb3Lkqc8NgpRFfQYNVLVTZBWa0KxTGq6frOPtuqDeRohISiNNlKvcn7ilgAJdarzQgVy7LzH8YtBwHp7yPoB6OxrvmCIWwLdnuYpTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790090392; c=relaxed/relaxed;
	bh=LfxzX4JHzFulWpF+0ZFgBW81jq4MJTYU5BqKr5Ioe8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIDZG3tmilv4Wk+N20wv8KqwA+lTyC+DiKJw4+RE6uHonXyYA2GerPyvxA2pEeKydUUSqJWCc3tSRevGTXKw+29tq2cqgeCrZ389wWMCMnjerPsNXkgNoysv/rjydRtN35933NIEGBKmZX+2yEhoTHfFCKZFf0mgfK+sK4u8zocVL1PILMWQx/JShuLg1xlq8clj2rF3P/kWKgR9rkx+S5slZ3prR3lfDxMwDE65vy3jGCU3ulyZ6u0my0ovpID8xbsM1AISbX5iEghkLDurKkDiiD4kRKrmG2iJd8gzDDFpIeZYrVYZx9OrotVtVHYF8jsX4U+N7Kv0zdfW0/OEfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MeyGxw5+; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GAEv4sYv; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MeyGxw5+;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GAEv4sYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 795 seconds by postgrey-1.37 at boromir; Wed, 23 Sep 2026 01:19:51 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq3gC5J5Bz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 01:19:51 +1000 (AEST)
Date: Tue, 22 Sep 2026 17:19:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790090387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfxzX4JHzFulWpF+0ZFgBW81jq4MJTYU5BqKr5Ioe8k=;
	b=MeyGxw5+QOd6Ytm1Rxfi/c9rWq3sVKMDftW/1PjXqFkFtKK5foI39kBiTpu3g+pORHG5/o
	Y3Th+qS/UNuEACZcreRg12WuaGSMZQGOJnOhguAj5lIXV0I/k+c4KxRxiRQBxw+lBvE85V
	u/jKVgzfm0Y8CCkvXoiX7iHg7Cq4wMWTO+RQdDGuKQf1gqTOUzZ/Og+uLlOah148q7KBbj
	MEAk7BF4eg5l8yAo8FfiXJPM6ZUNLe9HFzOfBTwxfMlQ055zFt37fEtqHoJJYHF8XoUUzL
	fqthcclw7+szi3uhjlbc6o/PBLHF6aT+9EeMoTujT6TVsen8nXGM4BTUISIP1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790090387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfxzX4JHzFulWpF+0ZFgBW81jq4MJTYU5BqKr5Ioe8k=;
	b=GAEv4sYvCqIEHhO/n7ovx1RpZjloL/zOdFYtCdSBz8lHaxtNg/U5TKBehRebMyrLPp0MXk
	vzTsnrotTENgcPAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: 7.3.0-rc4: DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
Message-ID: <20260922151946.4eUhMiz7@linutronix.de>
References: <20260922150619.lwWqj1AO@linutronix.de>
 <d8d9ee29-e871-4657-9951-36a3b2b2ea56@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d8d9ee29-e871-4657-9951-36a3b2b2ea56@linux.ibm.com>

On 2026-09-22 20:43:14 [+0530], Shrikanth Hegde wrote:
> Hi Sebastian.
Hi Shrikanth,

> What do you mean nothing on recent one? You don't see the lockdep warning?

I do as seen below. I wasn't sure if this new that nobody triggered or
the same thing in different shape (and a new report isn't needed).

=E2=80=A6
> IIRC, it is tricky to fix since softreplay is a unique thing on its own
> and tracking right context gets tricky.
>=20
> Mukesh had spent some time on it. Lets wait to hear from him.
>=20
> Plus we had some more lockdep warnings too. There is effort ongoing to fix
> them. Hopefully soon.

I see. In that case I lay low. Thanks.

Sebastian


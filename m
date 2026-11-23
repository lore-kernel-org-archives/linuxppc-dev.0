Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A46606A688
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3VkflIru;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kAAiYpzk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1jW6571z2xyj;
	Mon, 23 Nov 2026 21:03:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795428207;
	cv=none; b=jUUnRDoZTVDa78NUvlGkEJp7wtIBry6yB0sHv+pvO070k743BTq0UCY31NlL7YPMFG/mzxO7GDN9EPSzmx6SMzwIwrU5vXmbvxmBp9ZCSXMPqReFH+ubs9uiAba5GmTyJBCkCQTXX+ePSYO85xCc29QVHAQl7CkVmjtDexgCmkxfLN4Ysv3fGhOJZtO94nTMPmQvhrX/vGDEVvmP7A1Dyi3O/tAIBHAQIbMmjNarRh+BVINqBbYm7+hS6P+w51Iz+MQC6kSRSHFCt1qJTurhhKEtClpalel4xcg2SCIshCSn5oJtTUFEqLzQhZPSEop86wlVAO0mstYPSL1jaSESrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795428207; c=relaxed/relaxed;
	bh=CD4ic9Gltp6sjM8mfIwiECFvv0TUSDYXBdZI3py6+Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmtxYXwOZU5Z2ytj23+1BP0NuTh6YF+SBNudD5z3PK7bRwT9LYzChIXPmFdnRyiH1+esxvP8j8jgXU7b1sI1+uM5pBG9TGcsQEDWIPO2Xnwj/jVXBc/+HVPqrchYEMG8vBKuKLxoZEMPYcbbPIscL8csmqsZb6o9dAgiJMSqhswQNfFwQ/s1OJ1nkOBmQO8IDWNE15GitXkUNfaLngzKID+VuBz+JgLO7qt/CI3CdlxWleLMcj3SIPVpy0r+EyQ3nu42Haj530hDZn3ZbWnAEkowZbcs3+E86loaqwdhegxgOgUUNUU2AEI0sDkU7xQVBj6cuF51rWov03KfiOs+ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3VkflIru; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kAAiYpzk; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3VkflIru;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kAAiYpzk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1jV723fz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:03:26 +1100 (AEDT)
Date: Mon, 23 Nov 2026 11:03:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795428203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD4ic9Gltp6sjM8mfIwiECFvv0TUSDYXBdZI3py6+Hs=;
	b=3VkflIruKARozyrkLHlX2mQ95+oFUmmPQ9g7O4L3WFJ+V/4YkuEfXhftFZgsdG9N+ReUrC
	3ECXYSLczZ5sfXJmW/dp9rUJNM/FMjQfywHZgZtQzuHb0kSoe7hHEhJUgFIKC0qG05v5/W
	deQUhf+pARzVbGBEEIbo6yBX9OA7AK30MKgGM9nFf9PO5zjwkdkfGkZM9cxjaj34VKvOsw
	myOUpmdrBt4nOPgZIRTrtBBjy4he4UJ8IukvSGDbAO08UnI4M4oCeuCrk04sAimvWyNpHh
	OeIZxe3E8yO3AcaESf76ss7nR72GuxDw2HX74Yv5N4Yb5IVJ8j/g7DgcR1hCiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795428203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD4ic9Gltp6sjM8mfIwiECFvv0TUSDYXBdZI3py6+Hs=;
	b=kAAiYpzkfztPq6MYwun6e1Y8Vy2mVk9Secfye9usXniusBTfN7Fozg38iBhnOT33Y8lwOo
	+hHvYlvL/ixDdMDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH v3 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Message-ID: <20261123110111-6431e85f-39a4-427e-b545-2e7a590a6c19@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
 <ec5359c1-c16e-4177-8dfa-2ae5ab8a874f@app.fastmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec5359c1-c16e-4177-8dfa-2ae5ab8a874f@app.fastmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 10:44:40AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 23, 2026, at 10:37, Thomas Weiﬂschuh wrote:
> > There is nothing userspace can do with this value. In the kernel is
> > always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> > userspace and also changes from time to time.
> >
> > Move the symbol to kernel-internal headers.
> >
> > Meant to be applied through the asm-generic or execve tree.
> > The default recipient list was huge. I trimmed it to only the
> > architecture lists.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Hi Thomas,
> 
> I'm happy to take this through the asm-generic tree. I've already
> made sure it all applies and the patches look good to me. I'd
> wait a few more days for additional Ack or any other replies,
> let me know once you think I should apply this version.

This v3 is functionally identical to v1 and v2 which have been on the
list of a long time. I am not sure how much more feedback will come.
IMO it can already be applied to gain more exposure in -next.


Thomas


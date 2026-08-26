Return-Path: <linuxppc-dev+bounces-26125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFE8C5DF97
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 18:48:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVYZm06vxz2xyk;
	Thu, 27 Aug 2026 04:48:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787770127;
	cv=none; b=B5BjV2x2KNNO+ZWLUQq3t86ARt1r6vWdXwR9qThC+XTXuYpk1mIZpvEpaT0K3CqI0s8A9Uaj4TevI8guDepetihoDyIl5y4O8FsY7qX/D5cqv6lmxelG/b7vqZBS0V9iVJJnxYrnZbnYNfRa/FRkv/illU+dI6hcTkzGZGBFXeBnraWnL9or2u36m/3nTrKv8FOznn3IVQDnNfLuPgzZlFzOtPKGH77rrsu8C5OjkTpmNvRfuNr7d9h6gUaQt8/FK4e0kKal0iXZYCi93YKr+sF0qi5PnyNif9kzokrRffpA0sFocgARQcyqD1en2D5fabFkPcqo/08NWlRXQQ2a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787770127; c=relaxed/relaxed;
	bh=f4zU9c/JNdk5KJC+Sd8nuCSHq/+ymmDGSesrVV8zzl8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iQRKxtmVHI1G243otcFVVNahv/eVEjn1NkgEGcDmp2STd5qyY/N8Y820oepottPWtHmc85a0iU2o+W6LYSbGl89/evVScF5SNAP3Erus5ZKL5S87vMJpkFJr4Kx4YtJmVj3x3jZlUrUtwCksfhcMGog9RCkoSvUS2+CZk9kf7Qnrvx7BL9iXfcPUfTsXKE/h9RsBxsJeb4ZwpU590sZg8ExIIDbV8ZBxiMfCSe/G33Zd3XVwHfS+RXRGZh+bB3gK8QY+nAd8Ki6MHghE+qhOqXTXax9E1ssIh+6eBlx5zR6qcDS1FDAhbCYu2QPlNdWUrjNdhKUv1ntDm2I24FwPYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=IhVrX5yT; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hRmcu/I7; dkim-atps=neutral; spf=pass (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=IhVrX5yT;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hRmcu/I7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVYZg1Gqjz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 04:48:41 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D8CCEC0201;
	Wed, 26 Aug 2026 14:48:32 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 26 Aug 2026 14:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787770111;
	 x=1787856511; bh=f4zU9c/JNdk5KJC+Sd8nuCSHq/+ymmDGSesrVV8zzl8=; b=
	IhVrX5yTPt8Xnhzy/yUIwFjv+jVH4XuIrxY9SfvWNmpw1wW9FEt8cwMlEznP/f1d
	xxOcnqxcTRWu8VQSXNeRDIjJobmvJQG068Lnyn7Qrazy/1ui5/4Qb8obE6lv0/09
	k+AxjIPqhHjpqqZkKOkR93McV3gonWbbmV80D6S1zheqTht+/o3ic9BjkuTZZOPq
	dGBcunqrKVBsbBS5vFicSnOh0Z8knC5u/X5rqvFbnOop7VhDe+v+idG3ns68Dj6W
	RJDSK3YSLJeT1jNyALPDM87VOmuBZRMfihtmmpmOQ/XcaUevF6mo6LmDsFD3XZjs
	P5irH8Ki/PIEoImd5ZKJ2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787770111; x=
	1787856511; bh=f4zU9c/JNdk5KJC+Sd8nuCSHq/+ymmDGSesrVV8zzl8=; b=h
	Rmcu/I7pLUKE/vxGJDdCqzNcwYS5BrWQ3XaYWeuGxJTvo/7ZE9wKNDfmofR5+oRz
	WNBHv7zl4qU0LI+ypEYVRxmZQ7Da7fopLHmEMQ0C8RkDaBnKEGiODxsqB2/gKLQ3
	1mq+8IOYQH/n/FUNZ5litlyjumTCYKtOlsbpz2VWFcArklef20fGp0xCtHK5By+j
	7YDrTvO6gWXgfFV+qNrHyRRvEdGdYI59z9dzXp40WsUvEJEiXVEcVS5/RVQRhlAN
	Dfzk5f2aR74xhlvKig5hPY675SOhW2787Jbf3e3vACy00f2FBQWPXBZlUI0oU8fU
	JdUzRQu7Yz65mwxTsBZow==
X-ME-Sender: <xms:9zSPajgupCG8BY4ZyIMGUe_bkjrCt5qybhm0IqtRiFptc1StepAveQ>
    <xme:9zSPaq3RnNtNDc2dr_2ZCNjAqqjHIhTHJP5Pni7KDB8vRUJFOkHbKf4XdSwCGbDFe
    irtWZ_FO9wsngl6dbmqzDBU-T4yO7LP2RePW6coMqtU1rX3lPKoKT0>
X-ME-Proxy-Cause: dmFkZTEpJFbkILkdbnjJPhhmIqMU7frV80/nt9hFZsQu4PZ9qgJjoHJyPUWOrwrcASJLCi
    abBYNRANM9ymUYLu4eDv6nLUvz3u+yuAbvEC800+m2hdGgGEDc9Q5Kn4vPfteqbrTFlH9u
    IiI2rNBGoS4iM8Up8wSEqKfxSF60yTHji+aKM680VRZkwna5Sd7/qZXalPIoE2NrQDP9g5
    azVWcv5jzsjf0M/3+Mq361J+OOHmuHQB0kx0ps2KHxXXbhAPlPQyZEO+PuqUmWE4P1ZmY3
    9Pl93zfQ5JvJpAxAU73uHu4r7yTAwEMig1jH0pqBZIX9BUGFqPrfJjXgFnk9+yofRnGWJ4
    a7Kp7JQCrM8mNfMODBVDAvhmfX4nMrhdnbRlpL7bKUc3eHzFP6/PWYVzwAKBsRJlL0zeM6
    3dkKSs0EAISwGAqfeV11ajXrj6JxloHFs6bXR9qcpJ5Fk8yxWBFhSZg0KdZ/950y+ZsnlM
    snrhuXa2E7YR4/XqwcZTUXqNXo4ILdyKyj1vccPJvzA6BVQ3k15S/GSgUwQxJEPVnI0yo7
    yEbG5nhte6DRa+U5nufffKmXyP5iEWJuP6dOk2gAxHMZ0eJcd7aJMCRhf928g6k4ut+CXn
    0GCtyN2e8TdoHrVjTsB7TpS02zk4ojw1CbCLQBXhGFqpl+uJOMFFa3fvHt/g
X-ME-Proxy: <xmx:-jSPavw-Z6GFgrl-O215TTEgOmon29324qhtnwq77LVYoVcOXt3y6w>
    <xmx:-jSPahpOEZvHqHBsoM0u1LaUtCrTwLSMUL9sCVsRgX4ytDqKGpBiLg>
    <xmx:-jSPavc8SMvZagtYUGWzdqX3SqRBKgVL3bg3GOLmG5p5kHHLeHEAPw>
    <xmx:-jSPakoDo_Xe_EHu5zD7CYC-Y5PtxRT9GOeN9eDvdYyxsECDUxgePw>
    <xmx:_zSPakqSMyvGK_Wf9cZPt0W3GU45cUc1tUt6hb7oLSuolHLWWxHELk4u>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E2A3E32A007C; Wed, 26 Aug 2026 14:48:22 -0400 (EDT)
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
X-ThreadId: A-UguAUR6dUN
Date: Wed, 26 Aug 2026 20:47:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Christophe Leroy" <chleroy@kernel.org>, "Kees Cook" <kees@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Geoff Levand" <geoff@infradead.org>
Message-Id: <8ddf7d95-05b1-4758-9b5b-9360db77f904@app.fastmail.com>
In-Reply-To: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
References: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
Subject: Re: [PATCH 0/2] powerpc: remove spufs coredump support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 26, 2026, at 18:06, Christian Brauner wrote:
> Note that the IBM Cell blades that shipped the Cell processor were
> removed in commit 05bf59fbeef3 ("powerpc/cell: Remove support for IBM
> Cell Blades"). The PlayStation 3 is the only platform left and nothing
> there produces or reads these notes.

I don't see how you concluded the PS3 does not produce these
notes: as far as I can tell, spufs on PS3 should still be able to do
this if a process using an SPU crashes, and old gdb binaries should
still be able to read them.

Whether anyone is still developing SPU programs on new kernels and
would benefit from the information in the dump I don't know.

> So remove it.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

With clarifications in the changelog:

Acked-by: Arnd Bergmann <arnd@arndb.de>

I have no objection to removing the spufs coredump. If anyone still
cares, Geoff Levand would know, so I've added him to Cc.

       Arnd


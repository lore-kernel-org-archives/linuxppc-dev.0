Return-Path: <linuxppc-dev+bounces-21126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656DDCD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 15:25:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK1nn4qFkz2xlt;
	Tue, 19 May 2026 01:25:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779117901;
	cv=none; b=Gd/61f37t5TGr2TlgQ0TT2yATCHpbLWISGYHo3hzJE9plrr4SebSXN3NlmgGSE+ZK731MGkeGsw98+624GTEjZnsnEPsEZxl4rbgcoctYK53JYxC9rtv2lGvMJHybF+YpIiJIE6rSLEyOFDSr0vpKzoKau9pIHQjoN6eHTiqvVOcwv8zq8igFlYjyjhvR1fkRTm4FkRAHebsH65BNQgxcfSQZknfSiA1v78ORT3DKxf2qkWETp4FH1ySjQt+NPZFcCCe8+td2IvwvdBmVIZkEnb/FaET+P9WQdvrVo2xSYcLCKMqBuIx9R2rPbY6/GvBWtlB3sx9oesmdIKrccXcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779117901; c=relaxed/relaxed;
	bh=j/AVztdEnoY6zvg7Qrqh6W0cwGIyomUrRR3N62SXiDU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SnxWYvV9N27iOwKaSQKQF20BPPhVZsecdEbnmPZWYd6/7D5y/VVgQpxzQ7XvUst2cGkk92woLE2jy3o/+WadBnvZQ80qe5rfPpd/+8SLikIgXHfpmJcXXvpZHsmCDKTP6s/caA25NWjqeVFpY6cjAHRjnFaiJgUxzG15BL5vV3/CsfIdgLdwNt4qvfu4f/3gLFi0kyejZ/VfVnGcBIhyhpqoQoWMBfxJKygERVXDE8ciA6NJbK04uUb63mfhg7B+hgVdLd8+UZNY1hKvJjMOP00kwsoEsXv1s4EEe/o82gjDKvXlLmi1HqPEQ+FGeDeo5865KxvlB4cYiIbZRfpMfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IUhgtdeV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IUhgtdeV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK1nm5zpWz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 01:25:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 449CA60120
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59C6C2BCB7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779117898;
	bh=d1owoRKS9PjeHSHPQ+ZzJFllSUtve+KK+vjX2wSN8ZA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IUhgtdeVD3rYbgffuIS+Gx/ZbcrXbC9RnqvEGIUAifq3ZZPQ+FIvc8KPxKFenYQJy
	 QsffajzXy6VXND8xtmZlbdRBoqkQL9gi1awYMwzr9+HycIVE4/qq3YeefMf0bys5gy
	 NSHMGJq7dFYgIy54zLpxGq6fNsUsU/dPDEb6tPj9NZDCAFbGYTI6eQ+XRofoIGMJCQ
	 5rmI2Jeb3D63y6xNowkR2r1Pwcn6RgkTpJcrvvPiacY/N49OCXz6BeYca+KWclXHai
	 SH8YAIn0KfbL9Fi+x/HMIncSnz8CUxBucmmfJdgFDzy6RcGGbjLUR5cXd0xABKMP9Q
	 1SfuQGYQIoqcQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0EFDAF40073;
	Mon, 18 May 2026 11:24:57 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 11:24:57 -0400
X-ME-Sender: <xms:SC8LaiqGn5nJi99q0CMFkxEwseiXUGEPUeoJMan3eYxSQb1jVL0YHg>
    <xme:SC8LarevvLGyaAyHHJoIXR2RhTNL8053PggRNDztCcG6RhAcSKIUC_lItAvZcP1jk
    Z_o-5A9bVWOik4RQaNnjqWw2R18m9YAkDW15SfasCHuSw45uiiUdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgr
    shgthhgrrdgsihhstghhohhffhesrghrmhdrtghomhdprhgtphhtthhopegthhhlvghroh
    ihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrgiisehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprh
    gtphhtthhopehiohgrnhgrrdgtihhorhhnvghisehngihprdgtohhmpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SS8LapblXf3E9TsgE9wk3UDee37gx8mBAXI0Xyqmf4K9GW_SPsq13w>
    <xmx:SS8Lai9lOyq6hqCKUUAQoAl4SR6mCJCZG-GHrAQ4Z87_LwPIL0NjFw>
    <xmx:SS8LavkjpOjCNO3HTR7M9o4AqXGJDqgiRP_rrsXIqEP_BGGZAlF8pw>
    <xmx:SS8Lany8TauTPoYOIALV6aqzfAKM8vXTJHVNmSxnxP-RJWSdVY2_dw>
    <xmx:SS8Lap7YQJOe9gTfbdBKYIX_pSy7PQkeZ0RqeXXn0pJSHaJnYPo6b9kx>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E198A182007A; Mon, 18 May 2026 11:24:56 -0400 (EDT)
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
X-ThreadId: AnGEpGJWe5kg
Date: Mon, 18 May 2026 17:24:36 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Marc Zyngier" <maz@kernel.org>, "Christophe Leroy" <chleroy@kernel.org>
Cc: "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Sascha Bischoff" <sascha.bischoff@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <fae1a8f5-b00f-42b0-9ea0-1b2c05229a27@app.fastmail.com>
In-Reply-To: <86zf1wx0b4.wl-maz@kernel.org>
References: <20260224100936.3752303-1-maz@kernel.org>
 <177209938125.547814.7154250802402503122.b4-ty@kernel.org>
 <87v7cva080.wl-maz@kernel.org>
 <4f34dc22-8dd7-42fb-8c16-4e359faf60d6@kernel.org>
 <86zf1wx0b4.wl-maz@kernel.org>
Subject: Re: [PATCH v2 0/6] fsl-mc: Move over to device MSI infrastructure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 18, 2026, at 16:24, Marc Zyngier wrote:
> On Mon, 18 May 2026 14:51:48 +0100,
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
>>
>> > > Do I need to respin it?
>> 
>> No, I'd like to avoid having to rebase again. If you have changes to
>> the series please send followup patches.

Sorry this got held up even longer now. I meant to reply
earlier but dropped the ball on that while sending the merge
window contents.

This was indeed bad timing as the original pull request reached
me only after 7.0 was already out.

> No follow-up patches for that particular series, I just wanted to find
> out whether I could start posting additional changes that do not
> directly involve fsl-mc, but that are prevented by the current state
> of the code (such as trying to move the ITS initialisation much later
> in the boot process).
>
> I'll postpone my changes to 7.3, and keep my fingers crossed for this
> to hit 7.2.

I've merged the soc_fsl-7.1-2 tag into the soc/drivers branch
for 7.2 now. You should be able to base your other changes on top
of f0a2eac6a597 ("platform-msi: Remove stale comment") as a shared
branch.

    Arnd


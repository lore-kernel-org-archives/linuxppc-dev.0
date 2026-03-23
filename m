Return-Path: <linuxppc-dev+bounces-18610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F18EC01A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:00:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQb56Jy2z2xd6;
	Mon, 23 Mar 2026 19:00:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252849;
	cv=none; b=ltsAD39phMnfOHoJ+CTH5Djc3F0M65zA6sUUeN8c9A+K7gCUPiVHrx8zU6Ps+AGSsqhYBvauLqdzOCsZOCR/J5r32st1au61aK14ELKd3iRZMTWHUSUzPjref/fSiZiWSmqAGwuXE39KxBKnUdGpqg7LKJP4EBe2XNcxyoKriLxaEWg1MjWSy+W2cAqn1HyVNLJ/cIYwejUtJmFX+LSttJOPZaiO9HfHizhc8JEdjOGGfsIFKP8e8YqeNqA8X1bh+GUFg12z2KSoCNuS9Yx6pPjyie4Iy/zZlDyeDY1cm8yry8BjBsnWrvNXJksL7Pwz1X4NWrZQ4oGb89dvWu884g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252849; c=relaxed/relaxed;
	bh=ahNZBT3UKtkfPRUQ0dmTVXR+3jFla3v2yy/o2ErGnb8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T9LS7D3BAw6ZNU4sIYJVYDvV06T8dkKlleHQqC/piO2MrDGVfqgutNXMkQ2S85WRcC2AFuDeX/3meMdow0gHZqLP4PmKQPgQthF1qUxcX/S1mmxfs6X+ylv/Pee+2ByzcbW/4vzls9o2VELaf2OP6kBkM3RC1EiWipxDtbdknbJx1v0Nu65nsg1so1TRKq5CaQRv3/y+lj1Y0vtUMGJGDo4KN3oOw4dpJ6Vj8QQ6Tcytu94ew2gMX8oQDihb+Z+31RhtvlaI7vMCigDvu7JVIHUSCqQt9EPF12GOITc7UT4ITkFuRDqJwwj5SxK9z8J77ptOsBldp5by3pspiCfMnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=Q4v0qSqV; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=QKI8n+1y; dkim-atps=neutral; spf=pass (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=Q4v0qSqV;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=QKI8n+1y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQb15kpsz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 19:00:45 +1100 (AEDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B55C9EC01C3;
	Mon, 23 Mar 2026 04:00:41 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-03.internal (MEProxy); Mon, 23 Mar 2026 04:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774252841;
	 x=1774339241; bh=ahNZBT3UKtkfPRUQ0dmTVXR+3jFla3v2yy/o2ErGnb8=; b=
	Q4v0qSqVG/xHcEo6j1AUr1Uv4BgKmbCafCWBE0PPCHwn6FqXrM7oCY3FCEoUwWu3
	Pl4VI3ViaokTfmGFQEhDHkr6K4GRrFw4nJBtjTV1vXDlscE5mhbjeky23Mhv1X36
	37PZLtjE+Z9x52+PydsqrXhSXB4cKeYLXNNVmvyPaF7noMzPam///5vYiD8qyCSq
	V1Y/OZh8ayCpEgtpxPoV3PeQMxwGOmmBcGhvi1sUavOEoMa73VlgK6PMnPe2/C7C
	Y7zq0XU1g7MgYspfgmDEVqYtJWdi2B2H6UPtRl4QeepmvgbYOnJQFd/A5k7Kcwb/
	lP0LvmIgMcqyZ2rlFZYS4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774252841; x=
	1774339241; bh=ahNZBT3UKtkfPRUQ0dmTVXR+3jFla3v2yy/o2ErGnb8=; b=Q
	KI8n+1ybymxT55nAB5/jisKmAXhzqVtMjnGwyqzyHKvgKR7FYDraOlbseakSUo0z
	+ecddqFl9NYcUHItbSANNr/C7SJ/8yvEktuGhCFybNNV/KPyB2aj08KtCGoKghQV
	2QHgplj6VnFrsW2CHEYCWHVPrSxfWHYbTz/yRetX0bOgUv5pur8fLLLq7T+SrPlN
	mIfwcNzfbSgph/LkZqnLhggCRW73XKF1j71hlFhaqPN7JAQ3M+vagFwlLkBPbeLm
	zqIFE2QjH9NG2ChuRQfJppJtii1330RGATpJwjNLWX/UZqp0c3Sm56jD5H7oIGFM
	zYRUn68+xoq+iBXArihXA==
X-ME-Sender: <xms:KfPAacAnW-vORnnpt9Hc58_ZIMgB6dLMymk6zglUDhr0UCDKohS69Q>
    <xme:KfPAaRL2XxTzZTRKqYoHBsbQhtEf8FtMLYPYZWCdoGl00EPLeHAM_b0Ft5l2QJ5Zq
    cVZPEQUfWF7erOdMTaLmNow0JRUT5iFYLuOaoJls3-SCwxHZm5DCsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehrihhtvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehpvghtvghr
    iiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmrghsrghhihhrohihsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhhstgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthgrmhhirhgusehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:KfPAaT_PO7zgxGZ-RrlfLdU5ZDHembkSUV-ynJwpMrnOl_21h9tnUA>
    <xmx:KfPAaeXqz_xfe441Kf_Sh9phSjcAUg2JZZg5Am6dY9lMKsLPk8sYvQ>
    <xmx:KfPAaVTORtP1FUFHLjHenjQSVCYker-ooAD5jSKm5eGzgCOYb7TdUg>
    <xmx:KfPAae2ydQ0W-XbUaHOhwbXIUnFMuShwFYXmDIEnDA2n3josOQYKDw>
    <xmx:KfPAaZufEv8dsEWXf4nEl-atNr5D1XC1_1rAf0xu2LJXSV98ocO8xdrE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F1A37700065; Mon, 23 Mar 2026 04:00:40 -0400 (EDT)
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
X-ThreadId: Auc-q4hEjBcJ
Date: Mon, 23 Mar 2026 08:59:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Venkat Rao Bagalkote" <venkat88@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, tamird@kernel.org,
 "Steven Rostedt" <rostedt@goodmis.org>, ihor.solodrai@linux.dev,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Message-Id: <eb864f61-9fa7-4366-bda0-eee586a8e0ad@app.fastmail.com>
In-Reply-To: <2026032350-stardust-unselfish-ad61@gregkh>
References: <20260323072422.25730-1-venkat88@linux.ibm.com>
 <2026032350-stardust-unselfish-ad61@gregkh>
Subject: Re: [PATCH] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable
 warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 23, 2026, at 08:36, Greg KH wrote:
> On Mon, Mar 23, 2026 at 12:54:22PM +0530, Venkat Rao Bagalkote wrote:
>> drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
>> used. This results in a compiler warning on linux-next builds:
>> 
>>   warning: 'nvram_mutex' defined but not used [-Wunused-variable]
>> 
>> Remove the unused definition to avoid the warning.
>> 
>> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> ---
>>  drivers/char/nvram.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
>> index 9eff426a9286..2ce3307663ed 100644
>> --- a/drivers/char/nvram.c
>> +++ b/drivers/char/nvram.c
>> @@ -53,7 +53,7 @@
>>  #include <asm/nvram.h>
>>  #endif
>>  
>> -static DEFINE_MUTEX(nvram_mutex);
>> +static __maybe_unused DEFINE_MUTEX(nvram_mutex);
>
> If it is never used, why not actually delete it?  This just papers over
> the real issue :(

It's used on ppc32, atari and x86, but not ppc64.

However, I see that all the implementations that have the
mutex in their code path also have an inner spinlock that
does the same thing, while the mutex is a renmant from my
613655fa39ff ("drivers: autoconvert trivial BKL users to
private mutex").

I'm fairly sure we can actually remove it.

      Arnd


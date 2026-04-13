Return-Path: <linuxppc-dev+bounces-19708-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0B8F34C64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 15:51:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvX2v4dgTz2yvB;
	Tue, 14 Apr 2026 01:51:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776095511;
	cv=none; b=RR30zT1mtcabpbTsbOjFlPFamFaUcVKdXN7qHjP4tzXsHe9P5UXlpxL7ab2Z/uhZCCnj0ikYULuXADhD72tkSxP3QSTLUy56nDmQigE4YW0bnGWr9i5jLufGCZsPE1Ve4bTIsIAapinInf4UudP+Y6h8X3/LkGvdNM92xp3e0bpSC5I5021JrtvJ5a2dyn1YQT0A8JXNjmIj3okzxhgfudz/RFyw/dpV91gS5QzDSVuwH8DeJdLlChEsAXyfH4R/iGPt2MMWMBgOYb7qIi4TLtzME6CA/in43fFih0GowCjLnY98g7Kw0H3FCLXrcHwSgN7CgQfqklaRW4E0aqoIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776095511; c=relaxed/relaxed;
	bh=Mi1t5yTJ7BSsNOtqiw5PO/Gvmm+5EbskAhnRecllWew=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZLOzYs/PZkfonJFi3xKG/CHvogBGhueiTT8NxO04Hz2RSO1SMJmQABHwwO1bIVGrpV/jp5408KHn0EJkrzH0Zb8TLh6V7yPogWvUTNBbhPaxYeaD+8o0HV0Zfxy1DkZCMnIP09YO1kUgDsL5WnftgiQF+8xesSRxrddpCjFgRTZRXRdmJOuUKg7BEoLY27Ych6swFrr/u3BJXepiayQ5CXCFmNHsC7lQyQ3E2MAK2ZhpfXO/UUDzCAHgOdHlRcRq31fT4ymrGA4nbNAFdMj8y6BRyCiKLIM1Wi9tKtsqKna6BW+P8UxR4M02KESM9xmDuj4ZHACHvHOgPmIXPgqGlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=CTGl5Ana; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fab+xdUH; dkim-atps=neutral; spf=pass (client-ip=202.12.124.146; helo=fout-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=CTGl5Ana;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fab+xdUH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.146; helo=fout-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvX2r1B27z2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 01:51:47 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D0651D00168;
	Mon, 13 Apr 2026 11:51:44 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 11:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776095504;
	 x=1776181904; bh=Mi1t5yTJ7BSsNOtqiw5PO/Gvmm+5EbskAhnRecllWew=; b=
	CTGl5AnaNsPhlrIqsen0iiQcVJseNBgvfWI00At3ST102r0Uhf0o67h1a1g7B5Bz
	Diaw8VbTx69vW1k3zsph6B8qeXBmCJOpgJ2htWQ+0zq/cE4hGRVGzD5zLwb2xlMD
	Zo/nme0Oc723rGwFHVXn3XlRjK6wSQMr2EsIwgoH1J4LALRzGRi37R5pJkLee/51
	yZHgByazW2Ws1zfvZCh5lQn/MoWqhmldujZOXNJpbi5WqiohFfKo1owkWsxPAVHv
	TWxsOJ342FPPTNfeIyv0PDp/Oqq/MHdkLMclE6QEzwcFvZaM47fqqUxC9AVZQYD0
	N12Y50C59YORmqUgUcsP8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776095504; x=
	1776181904; bh=Mi1t5yTJ7BSsNOtqiw5PO/Gvmm+5EbskAhnRecllWew=; b=f
	ab+xdUHXtn8qe+soKJoxxEksK6YpF19w8XLcxmu5DAFsMgITWQn4LkAFiABHwrWc
	pQivcpTbbE8r9BI0Mjq3gydIkwXhcv+U6Dx5ucgpfNYG1qLh/7LDIivvzRGYuGGy
	CCjcZcWzoAi6GbpN8NqtZmTLMY9q8Ob39nZ4e4/eYeBPNYlsnKg9hHckB6xBc26T
	yt7nXHtQhBo/jMj8fHVtIR+K33ZwK5CaeHDddcWKnCyUtJL1KJLZbcTnLv62omCb
	TX1hqrcd42FdT8b02mGfGiEgdZEpR1kjY8anCrNPPNGpiXWkGCuYe0rTxz7CCshQ
	ABhQDT1Ya0q9Ec8OBTeDg==
X-ME-Sender: <xms:DxHdaaic1MhpoOffJVqS-EEnJQNlqt58euKvGJbtLtyigA0W87QS8g>
    <xme:DxHdaV13tH0GYG0lwsRmwYifZELqjsrLMYJjSsC176p1K1EQx2cKt6Wod0lvoe2MW
    SCZ86JptRD5IrE_TD5Vx_JIAe6QSBrUN4uXVe05uBW-osyRsrta-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrihhtvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhlhgvrhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrugguhieslhhi
    nhhugidrihgsmhdrtghomhdprhgtphhtthhopehvvghnkhgrthekkeeslhhinhhugidrih
    gsmhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohii
    lhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgsuhhilhgusehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DxHdaTglPYtYdHMyXTUIuwsDeqflRHGCzizIlsKhDfslAUHTtr7UTA>
    <xmx:DxHdacAm0fjplbrcVt6c2Uai-D01m_as4jOhJs7D95tD6JqscYxESg>
    <xmx:DxHdaVRQoZXQ0Ge7PZJBP-ybE3S13bU-E7ttfrJD-trk27WYAfMQdg>
    <xmx:DxHdaRWM_rvKnRgD6Ek60Sak1MxfKiBkX0D8Q83owc9Va65g7NqERA>
    <xmx:EBHdaYzKVBAfRKqc43g40qw9CdCtayuAMM8mpgtktC1UNDguKt-phLDj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9227D700065; Mon, 13 Apr 2026 11:51:43 -0400 (EDT)
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
X-ThreadId: Ab6DPzpUApkg
Date: Mon, 13 Apr 2026 17:51:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Venkat Rao Bagalkote" <venkat88@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>
Message-Id: <929a3612-5d0f-4298-bb0f-b6cb0c215e85@app.fastmail.com>
In-Reply-To: <E92E66BE-165B-4289-99B1-3F4E6B84CAAD@linux.ibm.com>
References: <20260330103530.6873-1-venkat88@linux.ibm.com>
 <68e9ca6a-c53b-4f15-85b3-7ae9639f9528@linux.ibm.com>
 <6c00b695-9e84-4dd8-abbb-306fd67d6f97@linux.ibm.com>
 <E92E66BE-165B-4289-99B1-3F4E6B84CAAD@linux.ibm.com>
Subject: Re: [PATCH v4] char/nvram: Remove redundant nvram_mutex
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026, at 11:02, Venkat wrote:
>> On 7 Apr 2026, at 12:11=E2=80=AFPM, Tellakula Yeswanth Krishna <yeswa=
nth@linux.ibm.com> wrote:
>>=20
>> Tested-by: yeswanth <yeswanth@linux.ibm.com>
>>=20
>> On 02/04/26 9:33 pm, Tellakula Yeswanth Krishna wrote:
>>>=20
>>> On 30/03/26 4:05 pm, Venkat Rao Bagalkote wrote:
>>>> The global nvram_mutex in drivers/char/nvram.c is redundant and unu=
sed,
>>>> and this triggers compiler warnings on some configurations.
>>>>=20
>>>> All platform-specific nvram operations already provide their own in=
ternal
>>>> synchronization, meaning the wrapper-level mutex does not provide a=
ny
>>>> additional safety.
>>>>=20
>>>> Remove the nvram_mutex definition along with all remaining lock/unl=
ock
>>>> users across PPC32, x86, and m68k code paths, and rely entirely on =
the
>>>> per-architecture nvram implementations for locking.
>>>>=20
>>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> Thanks for the earlier review and suggestion on this change.
>
> I=E2=80=99m not entirely sure which tree would be the best home for th=
is patch,=20
> given that the change touches common NVRAM code used across multiple=20
> architectures (PPC32, x86, and m68k).=20
>
> If there are no further comments or objections from others, would you=20
> be able to pick this up through your tree?
>
> Please let me know if this should instead go via some other tree or ma=
intainer.

Greg manages the char-misc.git tree, while I mainly do reviews. Please
resend the patch once 7.1-rc1 is out, with Greg as the recipient,
and keeping the rest of the Cc list.

       Arnd


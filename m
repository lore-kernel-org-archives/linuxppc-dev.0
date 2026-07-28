Return-Path: <linuxppc-dev+bounces-24921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D18C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 06:56:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8R803nX5z2yRl;
	Tue, 28 Jul 2026 16:56:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785221776;
	cv=none; b=A4e0OZJmP3L5IHvCT5w8FdNRhZnIdkcvwyA19/oYtIsRXEphsbG5SCT4pB+XvteAe7oYYFeSB4nEbwUtGDDyCV6AHwL0NMdNTBeH1TBAALv67sWHKcLmp/lORGJ8peuNvA81ATG745gM3GwE4leK1rVPbSvf2dvSCMtnYtKcDC4bBTGjek8OjcsYhWcesprCjl5lM5bkclwbcVgyOmJmOgFvr+MCOrjc+IDb1mg7huetBHn/ZJ9iT5bgjCj8itLPg9RS/u6U7K/wct3nKUUZf2v1JFUCekolep/T6LO786ITZWDjAEfsfh92y2mU6dFS/Nylpwy6FsDg2lplN+qb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785221776; c=relaxed/relaxed;
	bh=k3Noxwtoqxkng8GAqve+RUwbYTdWZgL7Q+mnBbrP3gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhS7LmiJtdkuhJ5/U38XjKQ5NGlHidKxRiUeUivXxB7zfHda5FIjnkaTjz5JI+woOEbzrtrHFG8zGSnUIwhrZarPQjphN4b6Hhva8QEvjD/L1TaABMM/HIMfefyggYSHLOayBjwiaV7wOxqc9ouIo8JvaB+nfhubwjWkGikCdIJXGtHg1nLKZYaf/oWwniIvUMzhNxIXdEyjt78ODMZJpzUXat8KRHhzBk8xymmKhB6/nf9QY6bT13ulTx6AH698Gw6rPdnsCoS3MipIO0TAcjyruD8ORoMq1GxumHAtiS9Ox6I8vB6W1u81T6CxZKa4aZsIhSfyulSNcBEEJqfemg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=FCBvWUcP; dkim-atps=neutral; spf=pass (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=FCBvWUcP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8R7x279Yz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 16:56:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785221757; x=1785826557; i=markus.elfring@web.de;
	bh=k3Noxwtoqxkng8GAqve+RUwbYTdWZgL7Q+mnBbrP3gk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FCBvWUcP/t6FHjvPK3+cv+gtbIc+W/5eZP0We688w49ivQEjVShzFM6TjH7QcbEx
	 +jexpVohwjHe+rQjrE9ZBe0R1lUWk5aU2U6oKdUDyhT1V5KJTxFrT9MpucmMMl8jJ
	 TfXOQwrSWho5K09ng5N4r6Rp9hbLS5CKWXrAZ3ZJNTOVk+zQPZt9l/6X20lCkdnQe
	 mwjFLQVAfeI+DzXS3ZmU8mTn5Ed1s3qDvNvi7pf9KY2JYOKOWi3kyv3a8mEKYTdDs
	 YF5bn/+JfZx9HIlb/cZQ4brxCk2xGHLy+v3lggG38oS8aJ6wzX2w6KLtVQTj5O+15
	 vGqjCje8cvbbqWpjWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOQy-1wZg8d1EXi-00TRfz; Tue, 28
 Jul 2026 08:55:57 +0200
Message-ID: <3588f06e-7d11-4e94-b141-008e676bb28b@web.de>
Date: Tue, 28 Jul 2026 08:55:38 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_store_create()
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <chleroy@kernel.org>, Dan Carpenter <error27@gmail.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Peter Zijlstra <peterz@infradead.org>, Roy Pledge <Roy.Pledge@nxp.com>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>
 <y2h44um2grcbecnpkck44cvudugha6df2itq2uy5y46whxjouh@yy2kebig3ia5>
 <802ea627-4bae-4267-b1fa-7da2499f2ab6@web.de>
 <55dkpjlibtfurmrrzxzznq6e3dhxvo76rsrjnokkaquwktl74r@omft73n4kp52>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <55dkpjlibtfurmrrzxzznq6e3dhxvo76rsrjnokkaquwktl74r@omft73n4kp52>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RcEm3ThcfXZcFVh2VqUXaVzT6lOTLeDk3uogky2XV0++Kgk2WGy
 JE2Gg6XAbsA///f7//qsxffJD8bTg2zWn6dIkpviRvO2jCq20+lRqczbSdOxcpf64VpDRq5
 Z8FPXxXXijQLL3U9H18ZLucMQ2rAQS6A9FCKMUn1lYIFVj/05icazt7a+Qv16teFqN8RKeu
 I9ziOu4h4QFOPmmKorIew==
UI-OutboundReport: notjunk:1;M01:P0:/vBlfxoy13s=;B3CnGqk0KH27MY3QcYIcA6iXcHW
 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
 vDYBSqAtrvkA

>> https://elixir.bootlin.com/linux/v7.2-rc4/source/include/linux/cleanup.=
h#L142-L146
>=20
> The context for the recommendation linked by you is (also from
> cleanup.h):
>=20
> 	 * "When multiple variables in the same scope have cleanup attributes,
> 	 * at exit from the scope their associated cleanup functions are run in
> 	 * reverse order of definition (last defined, first cleanup)."
> 	 *
> 	 * When the unwind order matters it requires that variables be defined
> 	 * mid-function scope rather than at the top of the file.  Take the
> 	 * following example and notice the bug highlighted by "!!"::
>=20
> Which is not the case of these simple functions which only need a kfree.
How will development concerns evolve further also according to previous cl=
arification attempts?

Clarifying confusion of our variable placement rules caused by cleanup.h
https://lore.kernel.org/ksummit/CAHk-=3DwhPZoi03ZwphxiW6cuWPtC3nyKYS8_BThg=
ztCdgPWP1WA@mail.gmail.com/
https://lkml.org/lkml/2025/11/18/1766

Regards,
Markus


Return-Path: <linuxppc-dev+bounces-24934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF46EC531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 11:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8Xvk1CkHz2xyk;
	Tue, 28 Jul 2026 21:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785237362;
	cv=none; b=MCRks09aUyXsmZ2HzlZRCSEMsEGkXOpOrVrOLZICmUuG17NqTgLAv1eSfdru4enJhYjqLZ+f5Obo7TCaVqyvg7S+oR0p0LuUDH/9ouaSyqSsvvfjJ9EVSoknSI6pzyM4n2zGRuMpYYDZu8buJEcb572P38crTusKESYA+Y1OkWeIIjjpbBTjKu0OSa3I+73wh/YSbWvxBxi15NPxNjomkFh0XHiAwrDNlU5UuD/eUYbkjDrppk2M1vnkm4SobeQ8DQuxi5xLoxBrNYP2ut/4p8q7zjoTevbKXtVIhBieAoG0ZFaas6VDW9+msYzWZWkDnoYz/FBfgcm4lxGOhltnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785237362; c=relaxed/relaxed;
	bh=kdGvc5zVFTVg5hEMq4ScSQ8q5bqHIRstMjtbKuPq0HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyJiLp/SSbAM/e193LE6e6s6EJZwambsshXX6KaWfSLABYmxrQrDjF0GloUsSbF1PYrBjRKdQmO9E1vjJ979Ymye2TGNv0tl2gWyA4BqDfreMEC/XWvz3WVMXl9ohfRa6Y/4ff1nq3HUyYih9Wf0QOeDazbYzRKfehRy7pTRXp/vBX9L1Wp0ieuxzl8C0AtHaD1WI+fTd96oMc/H1pYI88Brubujy58RUxJqprhdc7smPRwp1BBdWx/0VeDzuEhRksoSS4E22GG1nt4UInjcp1qo6+KlYgTEf/KIBpk/sugeAjQMXGuux8zWJ96gXir681ElYjEUu/7PGYDE6SWZFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Mg/Nu7qA; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Mg/Nu7qA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8Xvf6Nt3z2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 21:15:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785237323; x=1785842123; i=markus.elfring@web.de;
	bh=kdGvc5zVFTVg5hEMq4ScSQ8q5bqHIRstMjtbKuPq0HA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mg/Nu7qAOyD/Fd2Ib1tHGx+URjl0/PQDpgaZrRtZHERJBuYZlkKu8XVE19v/6xB4
	 i1s8bWKuG+zZA8Wr/+TdL585lA1bAk3TwkYjvZNYU5r7HdyTsWkaPDkFKYnfXnh+t
	 450SaOs/SPfaXFI8VklnO2DlyRdw7E4DR6ias0tv59jS5tW6XL6CS2Fi1xgUln9Rh
	 d/mklIRM1kJwJLGEeRM3xZt3nHKF7bEoo+gT/TU/YIVYUrqE0AGDufGgMp24Z8tm1
	 qV+hhclHUYyTkZPdvcVQP/Ib3znORgYJS+VnQHZtbtzHZSxx/UJmxKVjYrgIfFLJq
	 nsWWR4eQzSwv+FqR5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1wifFA3phS-001aHv; Tue, 28
 Jul 2026 13:15:22 +0200
Message-ID: <1bf1506a-e689-4a5a-b087-acf99e7fb1a0@web.de>
Date: Tue, 28 Jul 2026 13:15:16 +0200
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
 James Bottomley <James.Bottomley@hansenpartnership.com>,
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
 <3588f06e-7d11-4e94-b141-008e676bb28b@web.de>
 <6woig227u5snmdsrjfuw7gfcf3vk5iwaap4yf7ow6b6s3pba7z@yg4vmdoaak3h>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6woig227u5snmdsrjfuw7gfcf3vk5iwaap4yf7ow6b6s3pba7z@yg4vmdoaak3h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NXDMpQeusq0/3h0ArwYU9Ve76RPVkb0Vnr7BmOOh5yQxh9HWKac
 /7R23POzVILDEYp4UXoZBr5RSiDrhUa7V0Y2gvQfKOExLk+FKaKnaNFuVYhcEfT3/JzypX9
 0Oka71ouE7dreDBeyNxjE0/0Jr/Ndp8XUS7UWtnfRO2t9WfGGjK4yA1xtXZiEIA1UVJBOpO
 F67UYHnYBWJgyRBsIS6uw==
UI-OutboundReport: notjunk:1;M01:P0:sFrYP3dnSpw=;lhf37Z68Ai7yNKJr1b4EWI0e57W
 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

>> How will development concerns evolve further also according to previous=
 clarification attempts?
>>
>> Clarifying confusion of our variable placement rules caused by cleanup.=
h
>> https://lore.kernel.org/ksummit/CAHk-=3DwhPZoi03ZwphxiW6cuWPtC3nyKYS8_B=
ThgztCdgPWP1WA@mail.gmail.com/
>> https://lkml.org/lkml/2025/11/18/1766
>=20
> My preference still stands and I do not think they contradict the views
> expressed in the above links:

It seems that more time and guidance adjustments would be needed
to adapt development habits into further directions.


> - Variables which do not have anything to do with cleanup.h should still
>   be defined at the start of the function. This is the case of the
>   qman_256_cycles_per_ns which you moved in 2/2 without any motive.
> - In the case of a variable used with __free, if it can be done, I
>   prefer to see the definition and initialization done at the start of
>   the function.

The discussed function implementations contain also input parameter valida=
tion.
Thus I imagine that it would occasionally be nicer to avoid extra data pro=
cessing accordingly.

Regards,
Markus


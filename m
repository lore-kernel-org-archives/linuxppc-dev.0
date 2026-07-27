Return-Path: <linuxppc-dev+bounces-24896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3653EC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:15:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7zbm4Glnz2yhD;
	Mon, 27 Jul 2026 23:15:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785158116;
	cv=none; b=QBQEuJ3xSzkmBkxckM0hjZ+H/3YflxKxaV6tSar0W3A9UAC2P6tbXseFD4ZOJWrzmvKtZu3Y5R8XEbdaHt+YjVLS/3/ajpldNHPJWL7g95z1Lg8Cabw7tb1HGnBFmZ9dN9uIh3al5LZ8C2T0eGcbF+MK0in14H6/DbhPXMnGRx8/zGx716MuLebRacIK+15nAbs/m8aT4WEadUuFtr1Zh2qgUlBIhTQLsOFycHH+mPzasxe1C0fthy0Iuk5/CRAGManJPXX/ujG/HzIiHamGXHbx9zGBWBx99TinQLbnAknNxi7SyyAG0+dhLXcgV9iN4hIWpv4gailR+YvHmI4ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785158116; c=relaxed/relaxed;
	bh=ZKC1MYGSThNxif0BlOrKo5RA0BPCL+cEOOC0M54acGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzz8loUgVtOtPh+VgOikWh3+8YdbCQ1Hmd5Rph1rlNyPR2je9SOhdOg5HRknT+t8v6oN9ALV0iO0G93CFBiYGLABwaXebJr63EvZIyGm5+hdArPqo0WqMI9cLeqGNV0FCgEpBXsQUMbDV41Y+/hz7MyVzrg7XNAXUrIRmI0j23he5Yu8wo+cdMWukQqK7tGOLISfDSQ5lelS8dQndvLnPysGkVClE9eXI3hRcGHp1FgmGlIvWZ+VBLyZtAAkNEKdWcLFXnA25o4jdCVE/CaUjjvOjEZte7h2ae8e5/eSsrMHsIvqqXYgVyu99xC/MZzBj6nr9pUAG3mwEH6eQEzwTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Rf3MCGZU; dkim-atps=neutral; spf=pass (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Rf3MCGZU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7zbj53Fjz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 23:15:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785158097; x=1785762897; i=markus.elfring@web.de;
	bh=ZKC1MYGSThNxif0BlOrKo5RA0BPCL+cEOOC0M54acGU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rf3MCGZUetyeptkb18OxcZhvsc80/9BSLi/ftT5YAgmr9i0oe7ebMTcaB3m3QNOL
	 gx8Q+x73IE+qVjd5DFl0qkLug5sYvaoTlX6kiS/FD/EtLWCW9KNSvHYCmvZHj3b16
	 9i/0uISZEvMqDmw8PkhAP2J0k3D2s4EscRduRnkLCX3D6BNj/Eswa9u9khYyibfUx
	 0Cl5Fvcsci4sjOn3qvs0MM8u+zOdaF+F4enY+nn+7gHQbXN/CiRZn2g+7312cu/6K
	 JvHs0S+OeCyGF3ZMmk2eEyISnJlzECRRZCrZ23z3Li3j1An613AR1ohLVSzt/mlyQ
	 sv5UEdyjdrYf7TThVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidDH-1xQ8co26VD-00kJNf; Mon, 27
 Jul 2026 15:14:57 +0200
Message-ID: <c0cb0888-f37e-4c22-8763-39928385396c@web.de>
Date: Mon, 27 Jul 2026 15:14:54 +0200
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
Subject: Re: [v2 2/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_create()
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <chleroy@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Roy Pledge <Roy.Pledge@nxp.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <f47abd6e-9337-404c-a24f-39a9dd7454d2@web.de>
 <lzwhee46xmnhgr2vjwzuoe2ysmlqavhpyod5kn67avwockpzin@dq2pbhluryme>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <lzwhee46xmnhgr2vjwzuoe2ysmlqavhpyod5kn67avwockpzin@dq2pbhluryme>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1ToG06Bx2U+5Utpt2Fj9nVNfu8T2a5p2by4HCz1kOv40XMSJhcX
 OIPzcD2aR59m5kM6wuIF0KlXOVkkzxnHMuuIvFk7k3QAbbhcfB+X2jKchVGIQ2EvLE06WLa
 evujxedxqombvEULtMXtCrlMqQBWyJlAZha7fxcrd5hY3o4+EXaoi3bg7vmnOb5m3hJIot/
 hRp1ndHrTN715iOMuaOeQ==
UI-OutboundReport: notjunk:1;M01:P0:tvm3urC13A8=;JEn0HK+2v546oobUd6IxS1iHP4q
 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
 3GkkxrjY4=

>> Scope-based resource management became supported for some
>> programming interfaces by contributions of Peter Zijlstra on 2023-05-26=
.
>> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
>> Introduce __cleanup() based infrastructure").
>>
>> * Thus use the attribute =E2=80=9C__free(kfree)=E2=80=9D.
>>
>> * Omit two kfree() calls accordingly.
>>
>> * Reduce the scopes for the local variables =E2=80=9Cobj=E2=80=9D
>>   and =E2=80=9Cqman_256_cycles_per_ns=E2=80=9D.
>=20
> Remove these changes. All variables should be defined at the start of
> the function, especially since there is no strong reason not to.
Can such a feedback be also interpreted in the way that you have got still=
 difficulties
with complete support of scope-based resource management?

Regards,
Markus


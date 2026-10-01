Return-Path: <linuxppc-dev+bounces-28702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018CECA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 22:56:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwnNM0wMbz2y2T;
	Fri, 02 Oct 2026 08:56:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790895411;
	cv=none; b=mr3nAJH+A41kK0/hP9j92zZdbAI5fdHAaBxefNzn3myou9Eg4Uz6nr0SRI5ZjngcfWXORfBawa35fcMqTtQunRJyws35YI8KmWoD7InMFXkJ0wv3Fg+WrUI2cAzmpGasVRNJvoxWfefU0PbO8LV5FJRGZRkAckihoQKDrEb+ms4Kzojk6YQYkEircMxGoHfJH3WlchqClm3n/qqdWpDSiZCTK4UqSGz3S/y2Bv9dqspmw8KvSBZ+v/APCejOTrnafp6i1CDNershzdfXi0H89ckuZp40vBENsDugVRL+R74/eYzwgTQuB1nmIUcXoQssMpznULYzh2Y+UoVgoBW7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790895411; c=relaxed/relaxed;
	bh=H8NFaTMuZbQ4YKm+CogUMym7Z14eCXyyMrAw+sva1Es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OE50C1oKwBvbX5f5gHaqLHzpFjuSnoVPTxHkauVVXXJXAg0uJgGz/QTldpaj+QepcQIYQGbs9mGATO84vOJw8AlOO0Wdi70xHLO3Dcm77L527fluRbuD7RTrFXLyvEzuhytEMt56izdaD0KLnz5h8q2f8w1zdm4huuDOHfq3eDle+udhir5ShSlsjLlUVT/GKUdbdLE9n+6j5cJpei7zmiKwnfCTxPFhZuJV03nH0yhbdgryIZgdOXLSvAWAirMZE+iSQk7/qUHoXDwsY7Fs0QgfhIXQ8vPGCVPAiMB2qFEtmdCROyuLbxSOP5w6B/3+CNmlzIaXUnOvnPBvtDDNtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnE+3Z6G; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnE+3Z6G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwnNL1wsPz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 08:56:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BA14641224;
	Thu,  1 Oct 2026 22:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8951F000FF;
	Thu,  1 Oct 2026 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790895407;
	bh=H8NFaTMuZbQ4YKm+CogUMym7Z14eCXyyMrAw+sva1Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JnE+3Z6GNVm4dkQp3Ky/Wr4oZb5HPnSFOFhIClfGdM9SlKUX5c2p1Q0cpIZVd3rub
	 1c0tvtQ8tuWFksgkmAWABr9k9yZ7gBu9uaXgFFiF0mzpDDE83FzLcVce6z7alwCy6M
	 7Efmo8o1IjdqOme2j5gu5TUFRKJUgxgq9ucVim0VA9kaVebusUxmSs9qpeDM7bnn++
	 V/9k1F7tSaJaaCX/QNwNcO5JEVN02lz8Qtun9/idy+OilA8fyG2zTLmU2Ze9Hm23F7
	 ESxrF0h1t6jVDzrxCIKx17MLH/pSzBAKOZlR55NCdsmmWjno4sLotxQunMnlVVB+0T
	 kg/4L13IM75Dg==
Date: Thu, 1 Oct 2026 15:56:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mingming cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com, ricklind@linux.ibm.com,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v7 00/15] ibmveth: Add multi-queue RX support
Message-ID: <20261001155646.5957a373@kernel.org>
In-Reply-To: <966a8145-421e-4be1-8d46-2cf8e4f9fa2a@linux.ibm.com>
References: <cover.1790319558.git.mmc@linux.ibm.com>
	<966a8145-421e-4be1-8d46-2cf8e4f9fa2a@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Sep 2026 10:40:56 -0700 mingming cao wrote:
> Hi Jacub,

There's no c in my name, sir. I wonder why people do that.

> I noticed this v7 series is flagged red on patchwork. The apply failure=20
> is due to a dependency on my own [PATCH net 0/2] (Message-ID:=20
> cover.1790357373.git.mmc@linux.ibm.com) sent the same day =E2=80=94 kept=
=20
> separate per your earlier feedback to peel fixes out of feature series.=20
> Both touch ibmveth_open() in the same region, and the net pair is not=20
> yet in net-next.
>=20
> The v7 MQ series is based on net-next 161ea2d4f2a7 (2026-09-24). The=20
> fixes are already subsumed by MQ patches 3 and 6.
>=20
> Shall I wait and rebase MQ once the net pair lands in net-next, or send=20
> a v8 now with the net pair folded in? Happy to do either.

Sorry for the delay, hint: please put just me in the To: if you want me
to spot the email sooner. We get 400+ messages to the list every day,
I'm only reading the list as I review :(

To answer your question - please hold off with reposting until the fixes
are in net-next. We won't merge the patches if they conflict with fixes.


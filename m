Return-Path: <linuxppc-dev+bounces-21517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82B4CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 12:39:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPsl56ptPz2y8t;
	Tue, 26 May 2026 22:39:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779799169;
	cv=none; b=l/VhE668CK43USp3flYl+qIawlbQFVkJaISqu4c3VYKl3NHYG8fuQFFPfNeHkiQHYXg2E/ZmVXBZjEEZIGGIvLQeXtI55moj0epg9eLjSJ9QM0eS49n17G+hRMO8N96lpXf2aitVHJbyj58cMPKLiZM9DYeha/CnxdB0VU9pjDSRWs2eA5gogTwAWUZiRmwxs2WRAX41UwZc0+GhgpyQjo4ADLV2Smz/dAtVFT31+0M+JssVmTbX1fYrjUveuPb4x/nVHbFkgS7oqmm04ylGJ1P0lGD82u3FYtv+aQMBnX3mSsOPrtQX9VfzAvPpAS4bWctODmqsWV6RWwGTaKV6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779799169; c=relaxed/relaxed;
	bh=2DdhusNN+vFuzB0PmOPfndHbDWMKZxSYmfD1KK2/m2E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wr2VwME+iJ+qhGzZWWREiGgB82LuJVomYJZ41HmOhKWy9Kzce+wbPJ58UrXSfIuPsyzvCf7aMr8jdjQeIwnmqFzXL8J5OQkZIOHc2Bop1sHQysd0ZCmWPZtRf1XWoiR3+WE9LvoGsUtb2filL0xvKWzUX8uTdPZ62fN7gIwIjzDDWfDVJKQX04V+h38dRLAMT1MYkun1jD5UIwqAb0795raAFtwHeyLPvvvchjaA7OsKCACW1KTMCR8B6A7YGaB2qN3+58c1KWM6x1HCd0wmh8sBb5HyPkQdpPXXu4zSSH081Ma5kOF73os/IyYKjzURJ6Mga7MToYeeyD1m4MfPZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=Zl5C97iH; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WfRF8GIY; dkim-atps=neutral; spf=pass (client-ip=202.12.124.151; helo=fout-c8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=Zl5C97iH;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WfRF8GIY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.151; helo=fout-c8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-c8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPsl24Vx5z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:39:25 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C6CC1D000FB;
	Tue, 26 May 2026 08:39:22 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 08:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779799162;
	 x=1779885562; bh=2DdhusNN+vFuzB0PmOPfndHbDWMKZxSYmfD1KK2/m2E=; b=
	Zl5C97iHWwzX+s65iHmz4A7cBN0fMHPEaOtqEkDv/450rxtnCqAzaF40910/sCx4
	XsRkbYxxcRcJTVoVS+Rj3CPRkoTR9FAbkbgVlrTgwnH+fLNR3yKvTxYz6ozFJzD9
	5yuPXhM+YyiHfrD1U1I94zpXS0nRa7zJJbPfxDZB83OlxXFH7Sx7iMdObzT4nZ/9
	QyTXQ3GmYNukhtaTlyjn9nLG+6lJtoSVkxHPKo73M27e6ePO6zH7IWFSBDvwofzZ
	JEKmEpOKHioFh4cFGmWvg9g1WoRdoeyJvLE+MfZMXBSlr8H3FjsSj/lZTUDr3DAI
	5ctlqw67K0myRrIqnqoL/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779799162; x=
	1779885562; bh=2DdhusNN+vFuzB0PmOPfndHbDWMKZxSYmfD1KK2/m2E=; b=W
	fRF8GIYRCMPR3lZ7dpGkTUoJuGKwURAj+8OZAfKcst2nL0NeRhZT3yRPm2KmRbOP
	Pg2f9wF6MPHE03aMTf0a4d/Ez2Et0VujQWssWiz1GQy00aCIhYmFBFo/oj4IWcRZ
	6fZuNjhGAfqa9tybpKAplceAM02TwxPiB2CUU2zcHQ4X/GkAemgOG9eEalZRme3e
	KNlZieVVgZrtaN0Tw1PBc2OeZKKNGjtL5+BnrwDBK0IoDhIqItOe3DQ/MU7GUM8c
	iBcnhtkmLvQ6JqQcXaqxQcTUzi1RBhT1HCSq2Oxf2OZJbw9rhxJE7ok8jECbXBaz
	iME8iqB/zw59FnQTo+h7g==
X-ME-Sender: <xms:eZQVanw1i65sp2LVimLDuabU3-yASNQPQj7As5LwwpnV27NmqNloJQ>
    <xme:eZQVaqEBMhWCcmZ-9c-O9nLEdjSvBHkK3jdYjOZX7s3T0_F0CZ8OQyrNy5dRMKv94
    iSaWwPDo1IurVvRVrTjAMWSxL1NCj1cwauc77ehoF1T9q1m6kpjqEg>
X-ME-Proxy-Cause: dmFkZTEywkXow3xdYkQ2bDUtuiNbW7HPTteV8VzeERFNC0X3krSq4Ztmxvfvo6lBC3mfHk
    nIOsh5OPxI5m9OkJYF5SpKXCL0JPa1nAwM4dHAgWRKmM5SD1y0YU3ZEds98AJZO2aNgC8j
    zzzgjv6EQVgcIXDfju67LcVJpmmJa1u5qE2m+i8WyxOoLatK9rZaqTmq+Chxph1tcZy6Rl
    gTzCoeLg4agwUggTSBIMIuJWS9zV2ihi7fFBfzxQBNcZLHVyYWYmrgQVAarNy80TcBgYrM
    I5F11ACojSxd2njeimht6MiOouBM0c7tWRJlPYuirsqeO1C1G2wz8aGh7V0B9KYOs+fuf0
    QWibBSswoX2aPbe5RpZ/T5/5VyXZ6ici5TcgaxQRbckIofh1dZ3vi2LHFvxvVf/zw1grSy
    TiFbYmEapVu+EvbVggQzeocyApFx0GmICq1JbLoPZtt68MV/RHZYiHjz082yl3d4xSRIe3
    7q3Tn3RFm9uDbM+GhABvyKx2DcAodSaFPYbYOTYSg1zpgNzA8elKSiy+uaifiZX3GNtC/x
    AsDSiCan2W+1fKFlBxfg2RjxvJVGiNVr5S/0feP5fMpdG4S09OQObqy87wJ/x/QEUA7guh
    WSBRWIsFhVA0TbqVIC33cj+SAHLUdeRWMUKNoj7e2Uj6A1+McumjsS9Oz1fw
X-ME-Proxy: <xmx:eZQVah4bs_xWeiDDQibLl1aBwgYGX1cCRJ38kh4WBqDH10_9gDDYfw>
    <xmx:eZQVav39f8LPj7xgJP3MvokKe5igghtVltfyKfZezSrQvzrup_8Fiw>
    <xmx:eZQVaox4mTj8r5t8eDA1jZs5joqKPISo1WMYqZGbZsYhT5UMPMhqTQ>
    <xmx:eZQVaonlNzLHp4EPnefWPUG_OJkRaPdx-UyE3T94ThcfHiWSuoKH_w>
    <xmx:epQVakkNsMABvUsRVbAnepaf_1q-zRd7bKVxZUmYdvNcFqijiIjGZK2h>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 89ED7182007A; Tue, 26 May 2026 08:39:21 -0400 (EDT)
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
X-ThreadId: AuWQEIBBqPC7
Date: Tue, 26 May 2026 14:39:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Wei Fang" <wei.fang@nxp.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Claudiu Manoil" <claudiu.manoil@nxp.com>,
 "Clark Wang" <xiaoning.wang@nxp.com>, "Christophe Leroy" <chleroy@kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Vladimir Oltean" <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-Id: <ef1435b1-0cce-4f15-9e4c-0e9d50a9e1ea@app.fastmail.com>
In-Reply-To: 
 <DBBPR04MB7500D92831D793CDD1D562E2880B2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260526102708.2837129-1-arnd@kernel.org>
 <DBBPR04MB7500D92831D793CDD1D562E2880B2@DBBPR04MB7500.eurprd04.prod.outlook.com>
Subject: Re: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 26, 2026, at 13:03, Wei Fang wrote:
>
> Thanks for fix this issue, I have sent a patch last Sunday.
> Link: https://lore.kernel.org/netdev/20260524070310.2429819-1-wei.fang@nxp.com/
>
> I think the solution should simply be to add
> "depends on NET_VENDOR_FREESCALE", right? The changes in
> enetc_mdio.h seem more like improvements to me.

Yes, the added dependency is sufficient. I removed the other
change only because that was intended as a workaround
for the same problem but was incorrect.

      Arnd


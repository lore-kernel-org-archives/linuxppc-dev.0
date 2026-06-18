Return-Path: <linuxppc-dev+bounces-22751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC4ACD98ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 00:56:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggj2w5nNsz2xSb;
	Thu, 18 Jun 2026 10:56:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781744168;
	cv=none; b=A9c7SSd11/p4d0OQrLoLdkFNrGD3ob/tlomeK03dNJzZRd0U58SYN4l7AqkLyZ0wXQqdwG9y9V9Haj9uOPqpUh8NgR9XzK3rzbX+tP9znVoVdlKsjGs1F6DjQ4uoVi+MyGSXckSFIwBU8S1Id53lydtxkfgBqTEB6TH7O4Jc4CHkOQp1O/Vt9nymHjuR70uT5uNZHLmPKufJa/uZq4LPmdtvLiaPMEzSxZxhQAH+ltXAXbv/eUx91+mp3+gHpUZ0bWUnXtcs+tTMGOHk48JL319qhJtH9I3eELykEnZle5eN6WwXCltrjJZCU66gqzs3eeUAbu+/IGiO0UeplDgX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781744168; c=relaxed/relaxed;
	bh=oRkffw0hyh/GuxJCIVfKgEWNAymvT88Y3XYpx2BDW/k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WMWe3ytZPt8cTMAhDXFmp9+Fdxq1KwgY4rnk0kVnhUbnX5icdhf7bsCnqe4guHYSRlKTvwd1S0MBeO0ymkw8GvPV9LndQvmCQ0YpqU7UOGp0szESjYBNvsjJeyA16G4vMfo+qu3Nb2SsCtuYZQfHLtngFTw72l8ojyd2iqnmM4Xyno9kYCaDfDiEW2xlK1PqrSbnqTINLUTL418RyO8ytM0iXMaieOaq5aBJq1JCq6fbNscRwLX8/OSxFsofyQWiKDFy1OngerCjybnMK6mRCjUwrjQpcIDyLFpOPNHngT2yG2hm8feLuHz/SDVlIfIVhnUY7AF2RXqcpEad/7bgCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=eERmQ0ay; dkim-atps=neutral; spf=pass (client-ip=103.168.172.145; helo=fout-a2-smtp.messagingengine.com; envelope-from=fthain@linux-m68k.org; receiver=lists.ozlabs.org) smtp.helo=fout-a2-smtp.messagingengine.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=eERmQ0ay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=fout-a2-smtp.messagingengine.com (client-ip=103.168.172.145; helo=fout-a2-smtp.messagingengine.com; envelope-from=fthain@linux-m68k.org; receiver=lists.ozlabs.org)
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggj2t3VyYz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 10:56:03 +1000 (AEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3738DEC05E7;
	Wed, 17 Jun 2026 20:56:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 17 Jun 2026 20:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781744161; x=1781830561; bh=oRkffw0hyh/GuxJCIVfKgEWNAymvT88Y3XY
	px2BDW/k=; b=eERmQ0ayn9m8wVNhOnqGRZkMB6lds2D6/ZBX5aKImkIIXfgOTbi
	bBSDJcR8oILGjvE3+26/CCmg1rMxDZhplAMhmLr74EdkgR03Fzo3Pr33uMyYzruw
	fLWbiYpqvFnIKO1OkdZ/lTWnLN9ZqzlKZ+Pmae7qKjlBGAAT5assyNo9DU2CLm2n
	hcYgUn9Dcuv0J6tYCTvW0YPaOY9hT4bfB/Ypusbfl/uBe5yp+sMGPTWW3FfNlwXf
	yG8FsMyCEJ6CCpuqkbMQFgtW5XCsF/M919yTmBgRSXTDhPvZxrrcNhKur7CAJ3xw
	F55/rzSyXReRpHb7PsV+qL0k/H92V0c4Itw==
X-ME-Sender: <xms:H0IzarJoPpga0EVjkyYtDAKpuylNksfat_NvfCUhWSOCtjwCzF_f-g>
    <xme:H0IzamHdndkLe1JzQqFpQuE1xFHz02NY7tkG3dJxEwoiSQfMF57TOdJOmPEwKtHzY
    KcN0CeNNl1_j8Yp4J3GkmQjc6ElL7AejiJQZOjTqnxH4p3h_WesQA>
X-ME-Received: <xmr:H0Izaoy6d2LWswGUSgdxEZiGOOIp7F1GAzeKRKpSJyrH0AcCv47p3z-pU9ecUiICg3vu-MH_bhj3VeOXZCQlmtdBfz8XK8kBIME>
X-ME-Proxy-Cause: dmFkZTEfsd2sy6rGCX9gKFtzw6P16veTBgEOvotvsGqzQMeY4e0byjs4rXjd0jR1EGh9lH
    Yq1ys3Ja4IDwXPS3v8h80XGdeqX22kwtwfnwKbBWzdXMbQ3K21J/sdYHJ69m1M3WmEMdIu
    u1nMszQRk8K9LYU0Q7Q7bmIKdExPNa6BOQgw7kl30YHXVdwKmJf3E0sJPtu/GsirOjXIP1
    OMohMujEERuDNRRVoYibAAjRUfzIntuPTXU4ZMzzhV1KO9u+QyuBjvQZWPFHNeoyfVgbrS
    xKlIz72VPlV0PJCNH8exmh65DDQ4fM9o2UBLSyaOZeAPSCtscvI5N+qb7q9WWVzoyMW0KJ
    OK/PhdNbZwjAicc4o1XuhSDvlAX5cy+FtEEvV2F6GwZhMa+lPcgdxqF8OBb/lmLupQ5tEs
    eheTqaLv4Nsg7nu414U6XqgJZzeXjEHoQKyhhj/PW+xu5f6FM80JRxgBdtwG9jllgL7YcC
    yqXxG7Cj/sJGT3xVSMUgNWvoLGL7Kb6t1s9H5aAAQMPyEY0Lgd7FGNcJuDBha9e0gs/fps
    iOWIrG6DUpVNDUVADq/vCJwf9Ebi7fmT8Ljiah57AZUCaHj9g2RUI1FwTR5wI2qitIaKqu
    uLTAsCEPC2PcldxNQjt5opO4jHMZ5Rs2C0Zvi0g1/JJ5wDCgBUftZn/Xom5g
X-ME-Proxy: <xmx:H0IzarhtWgRuIMlu2p5-tLhgH2FkJtO7O_M4iRkuEoFf70ad5bOd_A>
    <xmx:H0IzatL7Euk8fVpAZfJJAWzsTcu0W72nRDeXBvUtVs0R9OUKs0mo6Q>
    <xmx:H0IzauC7vQlbiuSjd4tSULVmpAMAV6fSiI9w8wwt0RrhGN4Z63PPVg>
    <xmx:H0IzauSGYEJXZzWQrOlUMtDDUANieswg55yx3NL-E1fVReVzaCOU8A>
    <xmx:IUIzavmfDbaASv4X0vfqP16GYSQdU_zCwOTdK2L0zg5ukH_f6P9Pfp7h>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 20:55:57 -0400 (EDT)
Date: Thu, 18 Jun 2026 10:55:54 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Carsten Strotmann <carsten@strotmann.de>
cc: Jakub Kicinski <kuba@kernel.org>, Carsten Strotmann <cas@strotmann.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
    pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
    geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com, 
    mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
In-Reply-To: <1781694488854.956546368.818588236@strotmann.de>
Message-ID: <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org>
References: <20260616084901.3319d82e@kernel.org> <1781694488854.956546368.818588236@strotmann.de>
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
Content-Type: text/plain; charset=us-ascii


On Wed, 17 Jun 2026, Carsten Strotmann wrote:

> > _Someone_ has to handle the reports and patches. And since nobody is 
> > doing that the code is going to GitHub, where it can continue to "just 
> > be left" or whatever, without racking up CVEs for the Linux kernel and 
> > leading to maintainer burn out :/
> > 
> 
> That's a good point. The large influx of reports is a problem, and burn 
> out of maintainers is a too high cost.
> 

Carsten, if, as a maintainer, you want to avoid burnout then

1) don't promise what you can't deliver (that is, decline sponsorship)

2) delegate (that is, leverage AI as an ally not as a lame excuse)

So the question remains: what is it which _can_ be delivered by and for 
the "community" (by which I mean, that group of people which includes 
actual end users -- not merely paying customers and sponsored developers).

This question has precious little to do with burnout, but it's the 
question we need to address.


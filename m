Return-Path: <linuxppc-dev+bounces-25269-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5D2C55179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 14:19:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDJh80mJ7z30F0;
	Tue, 04 Aug 2026 00:19:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785766744;
	cv=none; b=CBnTmspKSlt/wRNaCLI8ZaKm+pT5NOdpXjfLKLtYktqrsR3B8ZX7X4wKcsroq8qOQKUm0cGGU28xNoYhrhCgXYgAMoQSCmEtdUxBzlInISAsZDkcot3u91yQsMl9SfqSKZvOyj9DiW+S7PFc46w2RdpTr/FkLH1KPSc1UgPcc2LAmrdgeemrbwf4YXGw5397Yn9RxmBTs+6SUMuSXFb/oFV7FbT+CYjFt52OGSojtlMZIED42STCJUEOeuBHP2c9Fe3u65Vt/In4a2W6oS71NbxWl9LOhCzA2qE0ZmrkYfXSi2oJKqEr1bqbHtG66oQ0ZER8kFgqlrbJDzSemUf3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785766744; c=relaxed/relaxed;
	bh=3CLc1MsJX3Lsgw3cqMX2Uw6ELDbd/XqWG95uUZWwPUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeXrEn8d8PtddKT1JSD6/beNFr253x/L4zjz95a3tpPITqlZM0Md0ZOwvMrcfYBs0fftOZxDBv0zrYyidKwuw6pvofCRNF08/PZb8X8JWs2Pi4yRnYLdtrjnmAcrrb7NP7YjrK1gp9y14sjXv5pwwCCkIza+6XBnMCn6Ww//A8eSO93wFzS1Sur6oODE121esE/S7LnJ4G/IADj29TMVxjSpLZy0ZhdoDe5hRmojH/E3VfCLCuqhWtEj9w5hsKWpbJYbIIgVrJeJIvWem6FlxI13BNbdOazgW5iMvYnL4jX47s3uVL6ka8qFwGDmJ+EeNG2DlU3yX2IIqiDk59w8MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb2TRENc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb2TRENc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDJh70Dqrz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 00:19:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 09B8A435DE;
	Mon,  3 Aug 2026 14:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241881F00A3A;
	Mon,  3 Aug 2026 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766739;
	bh=3CLc1MsJX3Lsgw3cqMX2Uw6ELDbd/XqWG95uUZWwPUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Rb2TRENc96jhuEQ8lZxsyZZex9onDfrJnhwNAHZGmTRM1pU2na0+0u81YVBNMlTiq
	 75Xe54TuemtQdnU1HnPD5dbQKKDFeYdd0/kzZ70b7+9mmb5QREUPFBPcY1rs5HqGyY
	 4zubGc7k63IMVqYxUNp4WcppOdSQ58VOM1tRHNdfT2GSQZ0AqZOxsiE8CcDxlMf5gX
	 zOQfGB5iB4AtABj9ihZpRco1EH6ElpVgvQCK1vtqRtpZp/NknJmcx22vc86m+mH+/Q
	 zZQNUrBmsrvI9saX1E8el6dbhMLMQEZHaqoKUT/VKN3BIfI/2+UW7P+fEKxgp0dA/8
	 ZSWAzgUpDz9Jw==
Message-ID: <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
Date: Mon, 3 Aug 2026 16:18:56 +0200
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
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC
 PRAM
To: Matevz Langus <matevz.langus@borea.si>, Zhao Qiang <qiang.zhao@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/08/2026 à 14:58, Matevz Langus a écrit :
> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> More MURAM needs to be allocated than just sizeof(struct ucc_hdlc_param).
> We have noticed MURAM corruption outside of struct ucc_hdlc_param. It was
> caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
> 14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
> Even looking into QE UCC HDLC microcode source code reveals it actually
> stores data beyond 0x6c.
> 
> Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode on kernel 6.12.
> 
> Signed-off-by: Matevz Langus <matevz.langus@borea.si>

Same in MPC8323 reference manual, it is marked "reserved" until offset 0x100

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   drivers/net/wan/fsl_ucc_hdlc.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
> index 71d5ad0a7b98..e170d3ac9116 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.h
> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
> @@ -60,6 +60,7 @@ struct ucc_hdlc_param {
>    __be16 haddr4;
>    __be16 ts_tmp;
>    __be16 tmp_mb;
> + __u8 reserved[148];
>   };
>     struct ucc_hdlc_private {
> --  2.34.1
> 
> 



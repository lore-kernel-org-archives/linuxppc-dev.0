Return-Path: <linuxppc-dev+bounces-18087-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE14FED2EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 08:24:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWgdr38ksz3cFm;
	Thu, 12 Mar 2026 19:24:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773303888;
	cv=none; b=XNuRTICUmKushE6C7U7OMHnAcgZ0OBbT2oWrgo/WTSwf5CfM8R7tzyHIy+9MqG5f98xDiR4CG3piSRyPmpguzD4HMNa0XQfVeY0E38eh4RYpXEUUMd4zs9X8yeS12ynwqrJVKstBcS5p23+/LJTHhfZjI05FrGNuoZyp0fv8sTKGhOqMa+9/t/DFVMXuSUwhylrrNc8Hzs0ej+VIe/yQ9+2MqQEx6MThZJHDT+7Gm+0WBhFxUJ7aKjHsUqjax/DDUY3AdCM7lzd7WhdO8D/ntSK2XJCmz37N8rYM6KkKkj7+lZVP2CnDRBgsY4p2ULU0vlBCbyfOE5wIhppLgjOQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773303888; c=relaxed/relaxed;
	bh=UDHLykqInM0Hn8iQ/Q8qKGceUTdwXGpRS1s5V5ugxeA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i8CPFG2BG6nyB5/gDXJIXd66rMfqgmuzG2apQvYHjYXQePa2OV3x2PmRSkqwJuf71aALEcHDkVY4ei13mroNIq14E5rjupQpvUNHTQQ3MwVpl9mi2Nk5tp756INjLuSttQ0pGzQTmvvP34mujSJnnc138UwGD5/33efgfp715Eoezlahz85AQbNbc5O9fyN3lfUOpq0ivJ1FzVC3T3Kf3/U19zbpn2ReRmCsIJWwLOd62hyaiNcVAvNh4Z2kqd74MIijqLDZM75YfiPRbp3lrH2OB8mVeWdfV+Xd3imqj6UFNy1fTs6To6SLk4UDpq3EvmCVKmaAG6EXCpFl1fMD8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aIep8L8P; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aIep8L8P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWgdq0J4lz3cFN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 19:24:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3973B4342A;
	Thu, 12 Mar 2026 08:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB5CC19424;
	Thu, 12 Mar 2026 08:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773303884;
	bh=ReRqdJ2O2suhdN1AGySEIcJYpF4NU5DTlplHwxXGvig=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aIep8L8PvTO9QsEOnFmjPGV1O4Jal/EKmLHSs2cN+FmpfGMtiseckKRvu8EZ12/Mz
	 cLKuvPtKEbp/DhqlmnLbAX+MgpOUu1ZjXCQCIBi9I+qYytFDrMBGLz/lHhgXvYnBNi
	 WehsJSODNz3TX0p3WqFRh2N7F420E928gQmqtt4ZkWjABRGlq/D/V451vkhOo/fIMu
	 k56eM5TfSBFiKh9aiFSx9gtj9vOm5yrX5u6eMxFERAPWzFkIdqN/HAZQddUHoH/qQf
	 B7Qfkz2RBsNDAX6PfxVFoVdZkgof/IiUnB7qGCUU4glZegm/FbE8yvEiDMDvAi2Arv
	 h+W/AbU8946gA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4817F40068;
	Thu, 12 Mar 2026 04:24:42 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 04:24:42 -0400
X-ME-Sender: <xms:SniyaVPO8MH2B3baW4sm6V2BE2TgvExpbekmugxzcsJKpT8neVJKfA>
    <xme:SniyaSw_-fZxUQz7NniiBX5nZI9Hq_BBeKuFKtynSyX9KyrK7uqU9776PLqhVUSqa
    DjP4LsxgYybXbQsNxe5qXuyBh1xWiq6RMg7N9e5Pzw3vzZYJpSABc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmphgvse
    gvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorh
    hgrdgruhdprhgtphhtthhopegthhhlvghrohihsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehthhhorhhsthgvnhdrsghluhhmsehlihhnuhigrdguvghvpdhrtghpthhtohepmh
    grugguhieslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdq
    uggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtohephhgrrhgvnhesuh
    hsrdhisghmrdgtohhm
X-ME-Proxy: <xmx:SniyaQcnQrOrKvFl4vVFb_DO1WEHvLtndEh8NY_hteV88ZRdjql_TA>
    <xmx:Sniyaelnjw9DL9AYYcDJpXCULGRnVJhewuOzEqt9p49RuOm3A60TRw>
    <xmx:SniyaV8l8pI7Xm9nryC45L3LmDBaI01r5sLWmwhmMxmGoDAoVN1Yxw>
    <xmx:SniyaUFYdnu5XMmNclHK8dXVk-1rpWL-vdqUYesCntOKGG4_SX101w>
    <xmx:SniyaZKZYEu_JhKFyFb-aL2upc_8LJpmJCkabG4487PfZ59MIlcXZo-H>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ABA34700065; Thu, 12 Mar 2026 04:24:42 -0400 (EDT)
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
X-ThreadId: AUCAS038dxvZ
Date: Thu, 12 Mar 2026 09:24:22 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Haren Myneni" <haren@us.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8b29d93a-2437-4e77-8348-83dce77501a6@app.fastmail.com>
In-Reply-To: <20260311155645.397083-6-thorsten.blum@linux.dev>
References: <20260311155645.397083-4-thorsten.blum@linux.dev>
 <20260311155645.397083-6-thorsten.blum@linux.dev>
Subject: Re: [PATCH 2/2] crypto: nx - fix context leak in nx842_crypto_free_ctx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, 11 Mar 2026, at 16:56, Thorsten Blum wrote:
> Since the scomp conversion, nx842_crypto_alloc_ctx() allocates the
> context separately, but nx842_crypto_free_ctx() never releases it. Add
> the missing kfree(ctx) to nx842_crypto_free_ctx(), and reuse
> nx842_crypto_free_ctx() in the allocation error path.
>
> Fixes: 980b5705f4e7 ("crypto: nx - Migrate to scomp API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/nx/nx-842.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
> index 661568ce47f0..a61208cbcd27 100644
> --- a/drivers/crypto/nx/nx-842.c
> +++ b/drivers/crypto/nx/nx-842.c
> @@ -115,10 +115,7 @@ void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
>  	ctx->sbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
>  	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
>  	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
> -		kfree(ctx->wmem);
> -		free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
> -		free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
> -		kfree(ctx);
> +		nx842_crypto_free_ctx(ctx);
>  		return ERR_PTR(-ENOMEM);
>  	}
> 
> @@ -133,6 +130,7 @@ void nx842_crypto_free_ctx(void *p)
>  	kfree(ctx->wmem);
>  	free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
>  	free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
> +	kfree(ctx);
>  }
>  EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);


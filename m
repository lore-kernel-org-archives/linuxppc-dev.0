Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97DC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:12:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08BF20880
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRrgCGu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08BF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dg4w3RSJzDqHS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 18:12:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRrgCGu/"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dg2D3nbWzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 18:10:12 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id f36so4452319plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=aMIYh/4ybm2LqL8pZmCo+L5n2fsr8ubTpxl5Y0mlWyY=;
 b=lRrgCGu/CYYR8STjBaCdM+YXxRJK2NLcrQEyBmZyO/+1UJhAa5Q4SK33wjmMVRskzY
 heiGrmBNfuc7Uk245mCVhB8TW6gFDF1oJ/Q8BT6xrdDRcitcanHnZfxxAAopGKSC9QVZ
 ++T1F42cLlHDlNPbAOoESOSNdKvn1gbIayNFYirDZ6E9D01G3RLJBsLZ8WUg7LcFZ5de
 bOQBlpZTQ6taVDBC1DJd8XmLsoBtIEXId/eId1dwuaOyjTDHFXKZThC6WLo18w+PUs3G
 I0TwxJa+KHvbeJXpKSxHHEgCkxYk1M3tWt90es2OzKNCwHGyjT3WeeR/IS77xBZ9tcuP
 hhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=aMIYh/4ybm2LqL8pZmCo+L5n2fsr8ubTpxl5Y0mlWyY=;
 b=KHEpGqiYa+8dgDkdF4THZXywhl1uVictYRpUOmbtYexcy7UsparInDDZ9na1bqzfmT
 cdBLeNW+zUQYTT3neYy7nh+aZx6e5CO6FSnB3yfxGe7dvgFNqbYz+t7wDeIc9VI1mtjV
 PMUzGirgzHr2L5PUmbq1SdvlRbUGFfUVvs7/9FwgrKuP7drrgwuf/daOu3DmTdBjEbB0
 68M+c2wOHNdMrySoquIkSFzSHoqw4KYOU7XKWyj795nuu3b5i9svVURRgfuRXXgnX/9p
 7gHlbvP6RpHG3hb1teviZMF9XfLVqC2XwCZFouSV/LkHRh8d3MqLH7n0PnKXrxTvic8M
 S+/Q==
X-Gm-Message-State: APjAAAUTAcEOwmWXWFZnH1YvXZRfHsLw983kOipp2IFJ8D5m5LsgIADN
 dwvgo8b1QZ58XnjtFMA4X2c=
X-Google-Smtp-Source: APXvYqxu+R2UJtPbU5uCJBHR2hicDa992uRoSEel8Hvl8Znp6n85CNyCREvMnDQSeBlZPNt8fTltwQ==
X-Received: by 2002:a17:902:e9:: with SMTP id
 a96mr15092475pla.176.1554797409135; 
 Tue, 09 Apr 2019 01:10:09 -0700 (PDT)
Received: from localhost ([58.84.79.14])
 by smtp.gmail.com with ESMTPSA id n21sm45304730pfb.42.2019.04.09.01.10.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Apr 2019 01:10:08 -0700 (PDT)
Date: Tue, 09 Apr 2019 18:10:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/mm/radix: Do slb preload only with hash
 translation mode
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org, 
 mpe@ellerman.id.au, paulus@samba.org
References: <20190409040328.6038-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190409040328.6038-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554797372.p2dyr7bihq.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Aneesh Kumar K.V's on April 9, 2019 2:03 pm:
> Add radix_enabled check to avoid slb preload with radix translation.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>=20
> Without this we result in kernel crash as we move hash related variables
> out of mm_context_t
>=20
>  arch/powerpc/kernel/process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index dd9e0d5386ee..f7b2e3b3db28 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1729,7 +1729,8 @@ void start_thread(struct pt_regs *regs, unsigned lo=
ng start, unsigned long sp)
>  	unsigned long load_addr =3D regs->gpr[2];	/* saved by ELF_PLAT_INIT */
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> -	preload_new_slb_context(start, sp);
> +	if (!radix_enabled())
> +		preload_new_slb_context(start, sp);
>  #endif
>  #endif
> =20
> --=20
> 2.20.1
>=20
>=20
=

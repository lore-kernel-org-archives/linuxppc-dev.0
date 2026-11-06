Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D43608362E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnoUALN5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLcYP12CCz2xNC;
	Fri, 06 Nov 2026 22:35:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793964921;
	cv=pass; b=dEQzu4vCnkQ4YKD9zkuE3YcFyOHtIK/IXJKogwiJmH/51gf+CLAvV6WXErA7Hnpc2edYHbiNoc2GzGjd9rlxja02I9EOKMDVAAELQeGQdlDHPqj0RBO7Bzo9iKrkQHC8lcjnVOQ0+4XAPSxejl2zKiI8mSLePAeYphX+4E6lJfSraiaWmoSFKMBmyaQBiSYZYpfNxzfE7C2UvI2wRPEhDhoiK7PTBrvsRMSDnkMN2Z1l16lnXTi5zWrnEfOe9MXFzUtA18tBzCUEzAgQvzVD3n1r8VWbxiQ5FL/AkhnDSD/RD+w92cIfmxMdAOc2S67fa1GKv5jOb4m8C+YR6lvbFA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793964921; c=relaxed/relaxed;
	bh=16NvhSdACMX6i/J+q88CC7Hvp0PVE6O559cAroATpPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEfPTmsX5txFEw3wlc2+AF0B89h7WYiJroB4fvyD1KYSK3J224GGNwx36DS1MxV4USOe7eI8RFXZ+fVtD+K1IJW3drHLZMCyIm5cxuVqtiq793N2T/+NT4K0kkL7NgE92V0I1tC3tHxkJMBcF5BUrTVWqCevtcbk5WgVP0R+DdSsnNu39Hhr3zv4SNbckSiRaoHfUVqAwwgi1e+nJ1mn1Cgy53v8xFst14II+DnXHmrgcW6GloxUFPsNRmeKod5i+/qtRME8RdWvaAiqiafOyE+0lX/4fHHKGjTIKSKIo8Jw3jjVj3sIfk11j+s1klWvkaNSP2W7QXp2y+TQV6bFBw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnoUALN5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnoUALN5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLcYM6sMvz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 22:35:19 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so164083a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 03:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793964917; cv=none;
        d=google.com; s=arc-20260327;
        b=CFV10MK4qVwBqZEe5dWE4fXGtCWHiJVqNu/Ql7k4Ji1sgvb/gP3HDOvMuzP+WW4QIy
         KdTggxtS4VbU/vfvu76WFTQ5RE5sSEOqLqEbKlOaRMzld5WL8bzuLSiz9nit54C1THO2
         uH0yEwkh0Wlf69myR7AIenSY0ejJhCInSyuR2ixpihgZp+9fwnlLvl/BNVq49tUHWtMX
         qLsUtm1sX93Zy4rtynYCplwq+uwb9F7P6U3EQbljkA8eEGEMDVAj/5hPhPKlb7AwK10F
         4PaJS7ZQfOkQ27INpVVwhljEzkWdBI2XO4KxpKAj8QAv7HzoSfv6uDn41K2N1YqjlHRy
         +aLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=16NvhSdACMX6i/J+q88CC7Hvp0PVE6O559cAroATpPE=;
        fh=ga7dJN2CY2fXDMo+XHVuP6OvgjiPnY1/EGJmMThhmYk=;
        b=sD46/7XHYs/FPN0w8Tq3CtyvLDW2NsKKY/ImwY0DpNhii47c3loY3UKFZ611+cDFtZ
         z5CShTpD9gn7mrV3/YcKNQfbvO69pD6ECwGDnQTsPLhPQkKLzfXlZuoMHrbk8btbq8cQ
         5Fc7a8lPwyOGzQPR96Vf5eivVIJo10EWDtFnjosys6NH5nG4UAZ0+5SeTn2DrA+N31wS
         a3yOE/d2yYl4plU8Ao/bDw1gpKhKsQ2MLqXJBTLvaMleJYyfByl/QYYjHoHBIhGljxC6
         t+Tj+zQ7rnNLTDHRzhiXHJahoE2DFKlNDXprxE5BvMxKSJEEM0Z0AB4cNBxX0dQ8FIFn
         wvNw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964917; x=1794569717; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16NvhSdACMX6i/J+q88CC7Hvp0PVE6O559cAroATpPE=;
        b=hnoUALN5UvX/iWQAFcm8VRj8WfS66PEbixG1NdccobIpZxt5TPtV/BwKNfTst1DsZ2
         wC53ipdf+VPmy5pks6+zVP7gM9ihDIQYMIeyJB05lIW3X0FzMWGS3Vnzuxpkt7QTsQIr
         R5sqMgmtCiLhe4OdDyT5/Q5pvsaWS7ke+isB09+7vYVTZYnSNp8VGT5DHbZoaqGNKobe
         mqqOooeujNancBL6v4BqfAOCFx0mkoeGD5J5YOuH1f4lixr1jgdoeYskd2pA98VOQ3DC
         c9cCqiMsxtG7Lvvn7xXGu9xC7Mh8X3t/tYFN8x6c9wupb5JR85WZqdcCb1keMrxw3yVK
         YuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964917; x=1794569717;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=16NvhSdACMX6i/J+q88CC7Hvp0PVE6O559cAroATpPE=;
        b=bYUTr6dsJAzggF9ZzAn6lhIoGstoiEaT+IwvDpo82ZXl0MoVyD4XuxQB9LLS6JefpO
         nLsaJxeMZSxIkLmRi/1nVTneXvU4IRmV6tXh9V6zEQbCB6Vfex6v3h0PgneW6rF7ejU/
         7yzgfnrG4vs2SJXm3MDLIhtLMf0NWpHxfw0wyC5kAIeV5NBLvPTI6b1gWxU7fCY6Pja3
         HEQbcV6tQtE0HzYs8Z/zrUKkMahOYIsGwSWi9m8BB9U0CAaT5nFK/G0ffoOzpCXQ3Xkr
         B/TfkU3YXHQtrY1r5hl/l46gvTjG2qpB7hy/8cbWMKbTrxfu2xPVq+z3aKUQpF1PAmqa
         OODw==
X-Forwarded-Encrypted: i=1; AL+hErFlZ3o0W8xexX9v37zZzrGxu5r3JWwU0oJZyDXqmuFpi2UCgyJqRwZ21Ir06Y+9gOica3aaw197ENbd37s=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9oCmZEuVpA+SwGT+7AXi0gUQ3nJuzJZpktnQeGJEFLxxVF3aRN
	c1aJ/MGntgm2zbquFiNGZ3VPjvUpeeqnOEOoLTQcMCek4O3fzW62Th6mfUC9m3YAJX2pcLRzAeS
	p5JX1ITp5NQGNuvpfeccBY06rOpBgkrQ=
X-Gm-Gg: AYBFou0a1oQiuxhhSK/xuPszQI0J7SD18pOLn4jBY8WktPrN1CeGzzRa52TTl13jJHM
	ZlGjH+np+O5kbMgnwR6mI90XlTwPOb5nMe14WtkTZrRhqOn5YmgCBcvMY5BYpQAppK4ikppPX3T
	xvDqDg3S2cuFF4l6vkKtY4NH5UhZz0VN1NgUEA1CRYnZbcMbjkds38u1wgAPqMxwcbLq2gePmgo
	nRiJzZeBTdN/kAF9TdAAXD8JS0/WpYz1uIcZTX35n+h4RWeE7Wj6qqHFlB3C70ZzzuLfPaxw0dq
	rczckgRHtWzm73Tkc+h+hCxp351tQ7jmSM7rR8XecJcLGWnIofg9z7M/UUOlLISpztvWAnBx3Vz
	V5f6lllxtb+uhL7q5nTDNaQQA0Ild1NYza6JuaVPb141Z/RE2K73r0tGoG1vhZfZ/F3dkkFV0YX
	O1uuNsm032rZ/a/qzRsOA159I/9aWNcOYkn33PNJDRmv30nh6r
X-Received: by 2002:a17:90b:270e:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3b0db6d79f6mr1962737a91.14.1793964917143; Fri, 06 Nov 2026
 03:35:17 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105104237.38542-1-phucduc.bui@gmail.com> <CAA+D8APoQt1uSk9R+O6Xg0zUKc4TaGbB7DJX1QvyZ6wzjDwHYw@mail.gmail.com>
In-Reply-To: <CAA+D8APoQt1uSk9R+O6Xg0zUKc4TaGbB7DJX1QvyZ6wzjDwHYw@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 6 Nov 2026 18:35:06 +0700
X-Gm-Features: AclHuK9vZj_WvyDhYxVjJQKavp5g7gEsFZLIBCX-BuGPepr8Uo7-FSCeNAnboFE
Message-ID: <CAABR9nG5bVowBxTXtHZC4S3wnLNwzHMu+8upjOR9Gai+M_Rh+w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ASoC: fsl_sai: Address several issues in the driver
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shengjiu Wang

>
> The series looks good to me.
>
> Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>
>

Thanks for reviewing the series!

I'll continue looking into other parts of the FSL audio drivers,
such as ASRC, PDM, and SPDIF, next week.

Best regards,
Phuc


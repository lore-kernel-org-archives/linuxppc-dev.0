Return-Path: <linuxppc-dev+bounces-24118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382ACC44507
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 14:05:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzPN54v9Jz2y1F;
	Tue, 14 Jul 2026 00:05:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783951525;
	cv=none; b=EWdOp3VVp4xBAjA2SEfZpqBNtQAsF17RIZBFLMraW+VOpg+T7R0/osPNJoJDFBeX18w+R6F5gwysoCJ/1WCWHRbo394rZmBNGD4benKcx+++ZloHVVDcYR7RRddEqg1BKzMBTTUSnt8B11l3gTrBrrgSq2Xjc0k6RR09Da0Nmux+Uj1VA1hLmRPp0fSmQ+Kd27n+6vXaGQxOMjN9UnfEhw0YY0qhPBl7mVzubqM4DpJR0p+pr8nlDVbOMQR78aGGhv9p+Q5tp3VDFpKqFj180q4uJV9qZ4Z/aIi7Y9oCX37tS29v4WqRGtRG0oK+bPi7EbJC5rVZpPsOPr/QyC64gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783951525; c=relaxed/relaxed;
	bh=Bz1QzqXfBrAcxVGMO+lYD/NQtR2+3hmHUYT+Uqk91ks=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=m2uS7EGrIqR+wUPt4Vpucg9GihGMeor/qWz7+HbTAmVBgWahTGK6u2CufYoPGnI57l2VNiFYR05OQYSfqUmHMrh76SuzSKGoHxLp2sFbNY5fdl8aRJgaoGpre3tXD7A3g++QK7D7hC6rPxL8Ark9P9DMrn2IaniFrUfMMDvMnJUpceS3iyiM1VAH+EyWfKAbHnyxEV8wfqrDBbqD3D9kSfVbUJJx2yEFB02/BD3QcGObIRqDoMLus22+UrSxQi1TLNNDSpy+YWZ6u6wVcyBSmp7aYuJRTy7SqHI6apOZGwCIdrtuVXjnGHuAMuFGHf7I3AkGEgZbnjTyq9ar6thKfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ThxmlSMy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ThxmlSMy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzPN4528Zz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 00:05:23 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3811e59df58so2103626a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951521; x=1784556321; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Bz1QzqXfBrAcxVGMO+lYD/NQtR2+3hmHUYT+Uqk91ks=;
        b=ThxmlSMyBBk73lGWlj9bNQKhTRK0dylWfw0PfC+LTRK3vFgWUAoCf8Kdfn1Zb9QMPm
         /zm68bTb98R9bNB0k5AQj312Ut5AKEgUF3w1aMuRr9ZcffjjA0iICmAgHg/vwht/XNUV
         nelAjiSRsGd+likrpe9IOOd12e+vNaN1F0eGqpFjIahax93YoX9mkZXqQmSogK/WijpV
         gf/IajDv3MJ5bG2hayf5zLWxGzSaPAUR+Nukx2wW9cXqv6X9ZfQfDVxD3GdJdoRi6qu6
         kf7JvPTMDfvl1xhdeCKkA+ldvxNAbRYNQtVWBjSEHYF6bk+RIPLZsuGOBJ07PWiMK9aw
         KRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951521; x=1784556321;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bz1QzqXfBrAcxVGMO+lYD/NQtR2+3hmHUYT+Uqk91ks=;
        b=PA/WzHSgJPsLFfoushZaBsRle8hU9Bp0egZ2bmsCr3iemhEV1L6uwhmZnNAUk3ySXv
         Ya3azTuQFPFuslm0l6B/Wt96t4d9omW3uMJAPte6MHkF4UYGm3JOn40P0/MwJceYXS+Q
         F0hVH3IAf7zr41z7GT8xdcyhk6oVuVEchqgTsrc/JcMItNYC3xpCT1zzR4ocQXkYzFWw
         atF+cTZdCVVCBjYNQHkKMGm+iel2EfMBm+OBWw9j4Y5OyFjpYOcAzJsOVo9YWK9JeW8M
         1jtza25oZkfJSfbmoFUe8OeoKCbxz30J49F0HkxXYweGjMOlS1e1GJWoWWXiFd8cHiG7
         mapg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2cFB8IOcoJUUVut5PZYIsqb2YAAARl1JmeGzLMHw8RyB9/6rXuZsKmwDqmg4VDtKaMKnIfLnWac+7mBk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAuhyYt0wjzGTK1LXRZG+AIsgVx0KNt5+MW2LMiTX2XSrgHDnl
	ZCEJnN+fATFfIkZeAPKqeYWXa1LxmPrfmyO3P/fzT3p02TYQ6pMFANYQHUpdig==
X-Gm-Gg: AfdE7cmJnnHlnIfrXXERRwizumuqeUs2T/4yVCqokAmhdMsf0lJ+gi64dNIHUkbld9R
	yajsl4xLeBcQHxHoOCuPL7wA21cB2U/j1qdgP11GDamrHMHY4N8PwjA7Xqpew/7PGPOMQKtRXqz
	2XIXXHbS7giO7jfI3MDudRCDFll684wO04k/+PBHfEiTL/UWLkU6LKI4RrYpKh+rMDVL3gCyeut
	mfb2QwL++ylcNbNWkJep5p6BDpfySbP8YWetyG3/JlRrctiO64ObgCHkv9PYs3HPEOODV0jMFPx
	EKOHYUCfRUb/loLI4Fm8emqVkridY6S7cP+h8IA6qpCssGBGHt0AhuBwSeliSh1cHL8MEZIA95Z
	eB2sswGbWezcwEE3phvlFBqnWwwyNhX+LzEKpXNQCrptgzHaEhx8CNY47Er+3OKI7OXrqYKRHH5
	9WAp8NQCdZYUwOK3QgKmPoXXYyH78E8Ni8
X-Received: by 2002:a17:90b:2f46:b0:381:22d6:f7a3 with SMTP id 98e67ed59e1d1-38dc7a41bd4mr8502347a91.18.1783951521381;
        Mon, 13 Jul 2026 07:05:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31198cb2b99sm47152260eec.26.2026.07.13.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Thorsten Blum <thorsten.blum@linux.dev>, Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/ps3: Remove unused struct table in setup_areas()
In-Reply-To: <20260713091731.97212-3-thorsten.blum@linux.dev>
Date: Mon, 13 Jul 2026 19:33:10 +0530
Message-ID: <fr1nugv5.ritesh.list@gmail.com>
References: <20260713091731.97212-3-thorsten.blum@linux.dev>
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

Thorsten Blum <thorsten.blum@linux.dev> writes:

> The local table structure is not used - remove it.
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

LGTM.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


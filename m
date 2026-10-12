Return-Path: <linuxppc-dev+bounces-29279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CBBCA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:02:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3QKs090fz2xwN;
	Tue, 13 Oct 2026 05:02:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::231" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791828160;
	cv=pass; b=IPaSCsSbw2ANAaMOMqFvaUMVT4NAfS0Fs5sCvcB3i4mGy5ALakNM9Ffb6NDqBWpsTcvB6SvhALKkq4iui1exmzIxfn3A+/1F5svmyFYi2SSi5ZiminNhrw4PY3nwC0Un04gBGVT63UtKEGGDThaaOGJEwaihQzDxgTtydmXQiHi63NIVFoUANL/7IvnNVTo2hw9UCc0VsrUtmFcDO2e0iHUftRXATDhKSnraBsb8m7UrylmV7wUeIWAUifRRUoWp4LYr/Kz6+ydWWr/EHsfVVUE5mxa9MkVeJXRtYd+MPIshvZAyOAeQMks2haPGjjLNcxX+Wk3qWwWEQUC0rR7QgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791828160; c=relaxed/relaxed;
	bh=f9aoCkFfSDX2/6XxSiLf6H4ohGMtImVLYKMUBsJfeiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQh0j+Vc/GgPikkUCJS3IkpsR1wpEGJv03O+iEz7eMYIhghq8H+ETYWELluDbw2dmg9iJ0rzF2udy5eo2CDHadtWIKThwPSzCzwfbg2MLN/9wLwocA1gxsM3AYCEulTuWrLzAzAPn8cgegzqHIoprQbttPAO1nT930UTN9nt8BCNQ1GEPVpMvPVlDGcY1mZxcBDoldiRR34lacIFX7qZU8bspC1ufiscFAAdBvYxw76Ezb9H9i6PhprPZd+fwH5VSeke1b90W/QTRUJdkKoqSIz3/hFShmC8hdmKWptmuNh3JgN2ihLr20qPNI2rTbtWfdPF2OjPn6G4FdcMJvTCFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EYkIa7BE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EYkIa7BE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3QKq567Wz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:02:39 +1100 (AEDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-3a9e87ba7f2so7212701fa.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791828154; cv=none;
        d=google.com; s=arc-20260327;
        b=b640whcWDYWz9ethiQLvjs5Z1IFHMpPcRzqvVVW4B9UhUgPusni2r0ahaiONQn7BKq
         fXxaRprYU/j0k0YKE6kcWaVRiDzVX1HKkhj9bEPeWCgGLqJQyDm4Wh0ynVspz4cnKA13
         v635WLODykrZVtg/8q1vMbrSQ9Z7fzZdQmc5h9l/5aL+50s2o3gEo7EXhC6EwmN2nvwB
         TxGsTGRjiVa4Fx4YeEwJbkh28mlnmXzHfsSHVYzFL+lir5GTvnbzqyxaEiwuUTD81tuB
         9jW2yg2x7wJqy13FNvn3AOdI95oOaJP9fRVqmouMVRlDgWQls7iiDVAAHmPVNFqBrI/0
         xe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f9aoCkFfSDX2/6XxSiLf6H4ohGMtImVLYKMUBsJfeiU=;
        fh=kVZi0g1oZ1ZcNdCWIz2rChyoFFAm0JLiRxGjL18wJlM=;
        b=TM+8GvBBTboaGS2efKsyUIg1al1lDdRmugP1C3Fogh0gmKOJ6WJIRtP+LjdjDE1OnO
         3/FCosvB58CikHY/d/0c6I+qz7v5kZZddgPJbwnpWt6UBbSOSTTpsHB3qIYEPSNUntcg
         HB0ErBAT/Wbn83G6JhMmhZy8aP6Y46N4kD3Z7IajXofE35R+Wytu+RX/+pgGLrnqTcsn
         YHyC5WpStg4X5j8FUQUhfb/DtKxrwcblWp1Ck7QTY5zFDZR2gfOsck7o4oDjoSkjrZ9j
         vVRoiBOFVaIo1gvTx+yVv3RGd9yKJPEwTq+XeRU0ItBJPZHEGw0ZNIm0oih4Q2yascui
         lfNA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791828154; x=1792432954; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9aoCkFfSDX2/6XxSiLf6H4ohGMtImVLYKMUBsJfeiU=;
        b=EYkIa7BETWmvP6cbtJ8NaLOZWkxILUu34D71wjOpR5iyqWL1TjFBj9V6YvNRgb70bb
         IPucuhWH1FhVV7/fYKDjIQqB7rwYzMEoRShonub97eoEI1oWOSlAGpJGFxBY1vCi0ljM
         EWB1cQbhLLzKvn0Hi2Y3OXL9lAt1oqy1hSlLzGIUcfP1VamytzIKk3KZuxbjZMjluu8Q
         q5f0kGt0azn1P9fqJM6kuuOjr4laCrkkH7kdYc4f3F7SXaQvUtrWR1+BQmVPgfn+pPHj
         JswqZvsL0ASiv2ziVlnTUe4Joe98mmZKwFi7Hm+xVi+lbeNlFJ77GAWBSnbn+QmE1qdV
         ZfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828154; x=1792432954;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f9aoCkFfSDX2/6XxSiLf6H4ohGMtImVLYKMUBsJfeiU=;
        b=20EbHn5/Xsi1Gw6OX796EIh+eYLOrcw3eY/2AgdFD+kfnpQtGDuxIhzyJXBuOaSckJ
         bCTjQBMl5IkySacBr8Sj/7zFj93FtcBi5KBmGvbSEPYvEIDYMqWPdV3ybZW5Wf2FRHbB
         R5QfO0voNXQWQKtSfva2GKyfAA35lgEAQUfHgzBCNatkZS/KQWJ65ojt0bsV0/BgHcJT
         73uzJNHZPxVXWgY0bKwOdGgUDqFSqfX19v1Yaf+dXkf1lCXDpa+MOaxelIVQYmubyEzF
         K9y9JyzXRzlHYCRJrzSVRX9dVLCdkdieUB3zfKnPa02d03uAImMMd/sG3KRWCWuhVyNY
         jmhg==
X-Forwarded-Encrypted: i=1; AKwUvBxz4bEGilzjcAmI7I27Vu6Mb58FsZgSyeehcpScozTYAaOTQZN+WwJYhbyggJdBMaK3m4KZH9uSoM35G9A=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK9geNynLD8nh0pKqn7WMfyjpCRrXmpEfXRiPWPREDrwN8p3hw2
	lZ5de1rbyvwwawAmEXwxLQfzTasnYAlx4iCDJLvqHPHJgI8kNHdEues75UXjJz2iyovVHVUhHgM
	0T5ictJHOGdkKGUAsrdkmYsEhfDKzIDQ=
X-Gm-Gg: AYBFou3SZWrbydDVbTICXLHeTWiXIjx36VWhC2C9b3mJ3SxRbFEx1AjEfYoWZ9ocM/G
	uhhgG00TnQpHbjnLUxUupf46i8sLlzlkmRy9Z+3JQ+uGpDfX/df+xJBsPTkxsYrLLANpg1HP63b
	g8D4N27sseELx8Z2nRtxy1ECCsdo8mHyyEPX1funQYE7GWNR6F/LWwS/wB2l1QNt0+tkKlQN0Ri
	OsTo1cyJ785HD6k0h8o4mZIj1TJLK5EitU03aY5+6CGHsGfKX3dfHadd7bfJr42uL5gFvBGBugX
	K/ggDxmWAHPQ4k6XMyLElVdTxvWU06hbXXxLjQr7XUJiiuFp3zMStCw=
X-Received: by 2002:a05:651c:144c:b0:3a9:d377:f5e4 with SMTP id
 38308e7fff4ca-3a9d377fd51mr18447101fa.20.1791828154266; Mon, 12 Oct 2026
 11:02:34 -0700 (PDT)
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
References: <20261002090947.869220-1-jiangwen6@xiaomi.com> <20261002090947.869220-6-jiangwen6@xiaomi.com>
 <astarANeoldvqBxc@milan> <4f812ef0-ab14-48c5-908b-b7d82ce418b3@arm.com>
In-Reply-To: <4f812ef0-ab14-48c5-908b-b7d82ce418b3@arm.com>
From: Uladzislau Rezki <urezki@gmail.com>
Date: Mon, 12 Oct 2026 20:02:20 +0200
X-Gm-Features: AclHuK_uSuO89Qhd1bXs6ll2oIbh2EHyO8-k6OSdE2Rwub_69M_koNK3b1_sl9g
Message-ID: <CA+KHdyVjjk3B0gsfsx+NPeuNH+ZyN7HbiP=S0F9kspRO9ZAXAg@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] arm64/vmalloc: allow arch_vmap_pte_range_map_size()
 to batch multiple CONT_PTE
To: Dev Jain <dev.jain@arm.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, catalin.marinas@arm.com, 
	linux-mm@kvack.org, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org, 
	chleroy@kernel.org, david@kernel.org, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

> >>
> > This is arch/arm64 code. Can you, Jain or Ryan from ARM folk review this change?
> >
> > Thank you!
> >
>
> I will come to this soon.
>
Thank you!

-- 
Uladzislau Rezki


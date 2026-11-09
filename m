Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8260606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhvQrH5a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNDG94Br2z2xfK;
	Mon, 09 Nov 2026 13:27:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794191265;
	cv=pass; b=aa3mxdA1Vxir3nzWqfPj0p2EAhzc63LvPy4y+eI5qvnBTnxR/7db0EIUt02OnXJA6Q6/Eql/9u/Cc5CDwGLyPgF1txxRcEKgp2wMbgSb099eHIHTkCMUsDJpIVHXZIbAqPMwrEvz/vB13NuW1F8byeboyVGTzTZb0YViVCUnXz5frUIx8LiysiAEbdoHZu/S71l4OfPkeQEPcJxGEmrYPECluNL+e6qKk1GDPSMmiJKQDUcmCDcRdQ16aVtM9IZgXzOsXEbb6+CnQVx3N3cjwR9XjpuVhaYa4hlPhdMiVnlDW7ODMqCG+jkdxAPljRojYoZ9Q8JiDObs7wpf7FLR8Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794191265; c=relaxed/relaxed;
	bh=yPQur+hqQu2q0njQUmv4lZWgo9lpsQ1I9fKlomCvuSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPFO8fDpJPFqIxLO1+GxmHXoXL8JxIrAqVbBIzHX2IXUPO0qlJkrZ9xmzP+BL2rzgqNuAsN0VBKo3s6iHjlcxFJOV1X222QDMxSxZVEM4PF9QN6Jr2T3FJamf55y0bHEurmdxBC8ZICRWfeYWnmChWmXY6K1NTlgiMu9NlstgYMwStrbJ3vH6fEht9bp92TDiFtinrpL82pJjsnWd3dIew1fYFc1WRrXiWbHUyqtsIOfX/f+DA/mQOANKz3Z7sa/XPzKdezN5YPtCshj7/z+V/RGkN8hvuXbaaVjDAKU/DJLoJ0KTxZBzuFZHGzMKtddAdOop1HcgRUaD+R8x1AZVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhvQrH5a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhvQrH5a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNDG864hTz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 13:27:44 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so189890a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 18:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794191261; cv=none;
        d=google.com; s=arc-20260327;
        b=ocntIcC+F0lDnWyrMsE22ufJPKp18MTw6UwXTicVspv7Df8O2RhbjJEt7MNjhE3o3k
         LR9BqOdheN9wu8gxp1A6ZPsKhx29b0JBTXi/0K80nofLWhovR81gVpXOgGen0VdEVzJg
         Q4ytnuxtDoG6upYvbY7sIF1InftiaJ7WrdGuQd/zGYD81Cs7CnCNc2JqDFKlMUHdezcO
         x6sRrmaQJSxqL9v0VZG9fuLsYhvFF1fJW8BeZkbUHKvA9Aw1r8bpuwSvCUjPs8R/9SQ+
         hZB0ICzeLdiZgsCEg4JUXLUIiVhRf5lbI+XOBJD1h9O0xJbEp0Nv+6LRHgi69/Br6jy0
         gCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yPQur+hqQu2q0njQUmv4lZWgo9lpsQ1I9fKlomCvuSc=;
        fh=jN9Vpri0fyPKsJSm4k2+a/uhfSlhs5/+wxd05cHsgBQ=;
        b=KPRhxRbCubOj7tZnfnlMNyAbPc3qZUdgOShoq6KmMkUX4ug12YtBHQ18I7FSdsk0q5
         xp+LZhOQ26yM46mV6EKcSzOXoPjOx3QSDivWdHl0lLpUPRoVSmMNRl8nqCzCU0VcdedW
         zsIUllaOWnl9foL4SoRWQUB5jWvZuSBg1H2mLZQUPFknMR2YdEseCQSbADysB6QXFCEy
         ITTNdTmRQE9ViEd4WabscN0xGlNyOPkstYRrBhzN23hXxU61uB8T8WpjVcNb1GQiO/Qg
         0dRrVv+6MeINtAdlhs08An1f4BsFBAoPkk2QRgKwN8dzAZ4dJZdvrj1LYiApgohw3zZG
         FTLg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794191261; x=1794796061; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPQur+hqQu2q0njQUmv4lZWgo9lpsQ1I9fKlomCvuSc=;
        b=fhvQrH5aWOhNN2AaQxacVEapBp1LGIcqJ9xoNkR+DGkABvoRjmjD4PNFlTpTwhZd5l
         iRmAocMuv86dedJ86MKhCDw0NpJ3ioKMIe/QeCT6qmLjUXxNAvKBUQadRiIq/Qi8MeFW
         uTbF8pHU+UtPZjSjfj4w5AHWqP+PiOhWmKLIU/vPsHCpM5WGRZTPna0CVrGhZvZT52pH
         J44uNdwA/jkSX5Nre1PQfMyXR0nSfMjEmMwq8eiuWeoAaEtKf00aQY5Dsbox+kgWGGi7
         vbTqhVoMU6cOKjq+e6Gr3V8ZyDNBtQf2jCBRm0dkZl+PMmdml5a4D6edQj0SJNkzFet5
         K9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794191261; x=1794796061;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yPQur+hqQu2q0njQUmv4lZWgo9lpsQ1I9fKlomCvuSc=;
        b=XSNJNWQTzLwiVV8eVaVIsJLg4W8W97P8aJx8BAzRG8Mgmq8xVUwaBLIbpd9XFsUdr2
         eNUfGiUeIfOwGtEA7ojWpg/VzbqnWY33+ZQyujPVoiowpJgNB3tZQtmfXBwF5kio98/o
         VVZTl3nGkv6fvK/70iUx+bPo1/+TPrzc3PU3YmwSDY9UumoCjwMBXDLaa0xztkfYb5Bw
         6qMGoBGjMfd9dkkscXj2r5kspnn+wWJaXqc6ZCrBywJkLtN+6jqGgnwD+9fOrFCNtiJ8
         qPMEAB9/15fe7y0rkaR2Ek9553wctEJphzGmNww/lN9EXtN2Qih28bWYH1yAJc3/geXO
         nlBg==
X-Forwarded-Encrypted: i=1; AL+hErHS0d4pSMS6IFv5uKreJrjbC2Dx2l5xjmqCsXHDFteEIsYtitMR26klJ4LLV546Z+hJefGGzEixm/iSm6Q=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Ri9eQ2fKN2nErT+1u+ZSJu9stSGmu/Gc2PZiSUIJHWjx1J6lN
	xbBBUuxz6snA9iO7lkWiV04QhCb/6cFsjNNoE7kwtPjTcNOxP0DTwwGy6XKQwhup6iMPCiYxkJJ
	yF7DDQqfgAoqe4szjtSgXmBTnYHRsRfw=
X-Gm-Gg: AYBFou0JegyfqkjHDTdmwtVQi5LPgEy0JgHP0umZ6OAUv2LJ3HOy853BzC1/q5hMo4/
	11gVLaVnr13WNIC3Ya1ysFyTIsqKDjOU+9Xabfy4tm14gNAvk1kUr/kdYUaYlWqk3OQYEhGk5eE
	volf/m33gCR4nlqLVKDhPGSjbiG+RvlcVe+uSES/aGU7HivHJJEv1g0pt6ZHkuQcgBMstQny1BV
	v7ydeYPe+IvXiTAr0GRRhXtPub1yBCI6+cGY74RItfLlCp6mnH1I6pSRNHPnoMx6T3RwFTxvFdu
	W5UFwJumsY0hlhuKsbjb9EJ19YSig6O2etPNCeaARKwECE+hDvSXuuL7NV+9WnLp1sFWKXldbPt
	ipejjG4n4qrCqWC0YYhT73lxoSl4b+9txZQXL9kKphUJEW9RcQkXe5FajAAb1YT2YM547BeKc6B
	TNs7cqx4Ow3Nhi4Zym2CCYJBXmtaFEMEvzLywohdf4Qsomv1I8xv27qRV7sGNQBGE3ZqGRjnw=
X-Received: by 2002:a17:90b:224e:b0:3b0:e2a9:3466 with SMTP id
 98e67ed59e1d1-3b12d2d9c58mr2213613a91.16.1794191261575; Sun, 08 Nov 2026
 18:27:41 -0800 (PST)
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
References: <20261105104237.38542-1-phucduc.bui@gmail.com> <20261105104237.38542-7-phucduc.bui@gmail.com>
 <179397468198.3073895.13432289481715460817.b4-review@b4>
In-Reply-To: <179397468198.3073895.13432289481715460817.b4-review@b4>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 9 Nov 2026 09:27:30 +0700
X-Gm-Features: AclHuK8qWYxsmthTljZlA9XrWRKIopm0BhFLBCTL3jBC3OtGTCQg-V_91oKsLvQ
Message-ID: <CAABR9nG9_aDfphSQ3LuYCjQxKe77woHM4Jp92MLsVx=PYDYmbg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ASoC: fsl_sai: Warn if TE/RE does not clear on disable
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mark,

Thank you for your reviews.

> > +     if (ret == -ETIMEDOUT)
> > +             dev_warn(&sai->pdev->dev, "%cx not disabled at frame end\n",
>
> There wasn't a warning before...
>
> > +     else if (ret)
> > +             dev_err(&sai->pdev->dev, "failed to read %cSCR : %d\n",
>

That's correct. Since this function returns void, previous failures and
abnormal hardware conditions were silently ignored. I added a warning
for timeouts and an error message for regmap read failures to make
these issues visible and easier to diagnose.

Best regards,
Phuc


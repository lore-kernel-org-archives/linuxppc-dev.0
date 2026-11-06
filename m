Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4A606EE97
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMX3LJgG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLYs34gwfz2xKx;
	Fri, 06 Nov 2026 20:33:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793957623;
	cv=pass; b=K5+L8Yb1X5nYCdDxbTCV8F6qwhUy84Ja68RdSQFmX3jzXbjzhkC+/YlKejEnANnf7RFOYpX4zYg598aw/7oRTSIWZvH6Gs738MkFWk57f+DLEd2J878Lkz/IS97PuF+6hRKqB37XWT8UgBuTBAG6l9S/MmQdMWXjAFtY6omsXnIN91NdBHCKE25/nWCpsiGtqO/th63/2r4Cm05Qbs7Hi9DcGRJ0eUqPez8ElxDiwy2ulC+r1OOMuCuHiDPHfQeooHeTEBHZSOaEnFPQ9Ut1v19WINU/PmZieLgSvgykcaWophoRT+WIlEmqubPJDXBj0fHPtHDjhhJBrVcY+xQJVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793957623; c=relaxed/relaxed;
	bh=ybV5PJ0tMQr6qthaURptS6hX+OOSLkoiXlq2+ClE4YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKx8scB3i2i+TPqy68quZrvWu8ibmFPrgqav8mfQWFWimrPCM/+Uc0YR8ItxNLZ7wnMvzRzdzjdVPDeb3LcYEBqihUxIlEaCvdaltcLmRGIQgiDm8lGc182JhkHcRKOim90srX52h9dtBFH9xundFG8FQgMOfBZRqv8e0DB0TjEzpLRelrhgRXIufW66843tB2rgdX/zmamer28ZnVKmQ/zSCO3clImV6B2jx8pGedoPWblg8aIF6jBCvOOKsezzBlekTpm463jAGQ5luIlufnQl5kzm0K46fpL2AdpdOXM2Gw+9FHTjKLvZXpVxmuUXWCjdPb4+nfuTKlgWiijg8Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMX3LJgG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMX3LJgG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLYs21j6Bz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 20:33:41 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cd3310348d2so716251a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 01:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793957619; cv=none;
        d=google.com; s=arc-20260327;
        b=FUFxU1CCt/hmMM77kDJKJ9bfbKpGb29CZgZ9fBn+B3lwRn9MbttFlWanGthKL1btHl
         0pEWM2OfRJaWtBX0LavMK8ZqbElHJC6h77WOVpvLZQ7d0DUSmzVwl5fULDYs88Uamzm3
         vfyf9+et7ylzsm+ZK3qd/uLq+W1VCp80lFtKLx6uOP6LNA9EkLFmwiRpfn58S3rsMdWM
         GMOiFmQ8/VBGCymllMd8bPXh82Rq7j4wo/IAO81YQCioSXCXtGCjzblVB/U+cA/L27Q6
         3VygQNmrj75htIwEglSG4O8EJs5Cv4jtQIU5PLi1L4yKBQPbLopOJT6Yd1jpZhF6JrgV
         rqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ybV5PJ0tMQr6qthaURptS6hX+OOSLkoiXlq2+ClE4YI=;
        fh=OWSBu/8DaJynOrQ70IQvF5alhaqQhoe8rLzSakiLwSI=;
        b=HD1A0soS0RECOpPC1CJCFpWMoEhXeIL2arlAVNC4GQVz8/4eLmjLmEoU+diBEfia/h
         Rbng3pFhsQqlstvdee0nv1DnHGIgE4CQxGm7pPSRRD0Au3JnB6a4nqnOIbDlh1MjX1uM
         3PtOFeZ+vmBjuvuouEmKDcB+hB61K2/+XQHSL6hTE/adrFbqbTNOu1FOFRCw0ogAigj0
         L1PkZSQbJFbM4+Y9xFFdsoTHHUrbLWe0HxnjfLdBO6XRDfIGRlTH8ubxsEgTs2Xi3DyN
         Q7wBhXE7vuYiAAIjPdccIGjsAOypftBAcLq1oXbgsookaxW8RzYxrhzc39uleg1lskyz
         C6EQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793957619; x=1794562419; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ybV5PJ0tMQr6qthaURptS6hX+OOSLkoiXlq2+ClE4YI=;
        b=eMX3LJgGkDShq2MjZTkYqPNbB1qk5pSU3p3KPyUGmULO9xp6AMuovv8pxvvtg+dcwt
         gPgRMZBEKauMgAGOcBViDHrnnGyWybfIaCdGRr9Rq46SDxG2ssCO6Vm/4QxE1WZ5gTV+
         /p8Soi3s00q1XFVnD2Y26PodRa9J7aA7cMaFWpMPwvA8rV8trF4wQtgHiXzbx2rpryhd
         a03k3117DDhDBqtDepteXn2Qco8d/C5glO0595/TwEj8MF9o9egaZHtKQefmtqmi6Kkl
         2ikrWKFHgpeL/bC6NOyIV499jOzzskI0rqWlMZ4zMSVvyGKJVUQTEMTdSCPXJmXKS0jJ
         FdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957619; x=1794562419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ybV5PJ0tMQr6qthaURptS6hX+OOSLkoiXlq2+ClE4YI=;
        b=hlFIh7iH+q1Cbx/YNTtiiFB1OpGT5/IUFsDfEHDlY6E1SkevovZNboUi5iq8BmM35z
         lzL0dD2RS1ReIorNSfXwfsYyrWwGYiXcvfv+P0JbZ7fwmejHBdZeJYNF1jh63OnBGseP
         MAVZ9grJv7UcTDLtUIGQWGtbMI4BvTgZ0ppDxzew1YxHiXzPMBQSLqpE8WNCOCdLYvq7
         SHYVL/4yYChvmA+V3JynUkrwUMGFnH/r/WT5KXo1sNcpHyh2EUF6lbbjTL+nv43VcOi/
         hsTEBlNOPYoiJbO0Kshs1s8ccyYZiHHq5DpzqKTOodz6detJPsvgICirCI73jvmv3fQp
         HY0w==
X-Forwarded-Encrypted: i=1; AL+hErFgj7U20ruNsp9vEdouy2j0Ed6mEUSxpLwyc7re6QHFxu0yK53OkJOgxMk1H7utXvd614Dhb/+eOUoUCl0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8AxEqdVakTFwBwABYlAy1N0OEPnJfRXHxcSe0KuEl6CNocoayM
	TripjSEuC9WVjQM6GszIAFofCnCsAFKBgeRP96kFBDkq7kF3Cuymj7NKcJjyPkt4IXpum2pnOT+
	ovjlzPjBt149wzxXz6B/CatHZTJKIIxA=
X-Gm-Gg: AYBFou1Jij+UAHwo3lqAGaeuARurG+l4zebkGNFrktyEdzfJIl8Q38b5DZRTNRf/TM9
	bvB2nhyIc0/zbkxT/s/zhOYrKmTYx99yjfqAA0jGph2fcGyRNtAIQfOHg+V/api92rpu601vcMm
	PMLM33gVaLdwgvRU47xKa7JnnkpAzKaPp+0oQOIhACvx1QnLLtXikbKekxLJa633YgX4MVRk/l7
	QhkNT4xnPIMVB6zKFxgLxVdS+NqOkHCEAJIY5PrlHE3suxCz5vgdOgyYmciGJKnWQfFGvlXgVNZ
	AS1UnKkaPxsE8Zb7WZnhf+ZL4jQIedzv2iwvEaUG3QbFehPO6nIOu6dawLmMdd5B0z06dklp8vy
	YnJpJzPcdVlAO2DzV7h/x+c5P+4p2McYFZLop
X-Received: by 2002:a17:90b:3f4f:b0:3b0:a757:e370 with SMTP id
 98e67ed59e1d1-3b0db70fc26mr1220761a91.42.1793957619397; Fri, 06 Nov 2026
 01:33:39 -0800 (PST)
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
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
In-Reply-To: <20261105104237.38542-1-phucduc.bui@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 6 Nov 2026 17:33:09 +0800
X-Gm-Features: AclHuK9vpWE_SlFYNUyNg7Vdx2dzB0HS2FNB_3vVBzGexP4Y_R3XoG7q6HqdtEU
Message-ID: <CAA+D8APoQt1uSk9R+O6Xg0zUKc4TaGbB7DJX1QvyZ6wzjDwHYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ASoC: fsl_sai: Address several issues in the driver
To: phucduc.bui@gmail.com
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 6:43=E2=80=AFPM <phucduc.bui@gmail.com> wrote:
>
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Hi all,
>
> I've continued reviewing the FSL SAI driver and referred to the
> i.MX RT1180 Reference Manual when looking into its register
> configurations and behavior:
>
> https://www.nxp.com/docs/en/reference-manual/IMXRT1180RM.pdf
>
> Link v1:
> https://lore.kernel.org/all/20261030091404.18757-1-phucduc.bui@gmail.com/
> Change in v2:
>  - Add five patches covering disable handling, documentation,
>    ISR error handling, BCLK ratio validation,
>    and preventing incorrect CHMOD writes to the other direction's xCR4.
>
> Compile-tested only.
>

The series looks good to me.

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang

> Best regards,
> Phuc
>
> bui duc phuc (10):
>   ASoC: fsl_sai: Fix PM QoS cleanup on resume failure
>   ASoC: fsl_sai: Use optional clock getter for MCLKs
>   ASoC: fsl_sai: Remove redundant error messages
>   ASoC: fsl_sai: Propagate device tree property read errors
>   ASoC: fsl_sai: Drop redundant dataline mask AND
>   ASoC: fsl_sai: Warn if TE/RE does not clear on disable
>   ASoC: fsl_sai: Clarify fsl_sai_dir_is_synced() documentation
>   ASoC: fsl_sai: Check regmap_read() return value in ISR
>   ASoC: fsl_sai: Reject bclk ratio smaller than slot width
>   ASoC: fsl_sai: Don't write CHMOD to the other direction's xCR4
>
>  sound/soc/fsl/fsl_sai.c | 89 +++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 40 deletions(-)
>
> --
> 2.43.0
>


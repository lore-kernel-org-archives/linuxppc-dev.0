Return-Path: <SRS0=x5jM=LN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E60FC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 02:55:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA39B60041
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 02:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA39B60041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G6L4z2VJwz3c60
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 12:55:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=PsQpIrSi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PsQpIrSi; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G6L4Q3fnpz302y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jun 2021 12:55:01 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id g4so6818925pjk.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 19:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=Qm/LGU7W75aN0DFRrKWxwUIu8JdECUu7qWute3z2ogk=;
 b=PsQpIrSipbzbf4PZG5+3tHsyeHqXWyaY1X4eAhpgkQTUY7SHWQWBbBqHTOwx0APlIB
 WbLj2enImC8SZMl8W63BkcQWKlgjjGkLiMEnImjoH1O5E5yBclotwWGtyttQvTLsOvkT
 6V9MaeVTg9CpVwX3rzs1RVL4Aw89ID+rLRmFo/Fr6MU6WGpPaNFTOZ8kehaIOw+j7Xnj
 LEWZ1neZKvo8t2zO8EwRwYwIgH1S5mReguDxFmmb2NzhmpMx8o6h0MXTVxt9/ihyW6b0
 zjx31jt6mNiKMMWYvbEpNZ7cJD2zuj0ij+XhSeEk6jlq4w9MMrHQQ/InqpyM78qcloyc
 HW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=Qm/LGU7W75aN0DFRrKWxwUIu8JdECUu7qWute3z2ogk=;
 b=q2HIC8vV13B6FHXvjYLyH/DnwVgO2suBD/XwJ/ph1x8ajvaql6YHev3eeUMAx51fxm
 P+UUxfJexV1TXYuAgMMK8EQhIVK8HAXFCiHGNH/4XJPvFFCWsmtiePIIEW20WxGvcT/g
 gdj9x7i0PyuFmpXIF6w7ZoQo7CgMQGgsbIlnYHj5QULSq21tn7xrm1RVxSfyn8HkHGqm
 NOqY1647QBd0Fiqlle03grkh7kCLl5uOPg34Vrl1jsQd+LNnjztUVVT/cAsDw6NOKsjO
 mbQgyurFV6i7gvZAcbT5Pp9elx8tPmLbSaSZtBCAJTeM7usbc2AiWrh27CzAQ+SdsPr1
 HdrA==
X-Gm-Message-State: AOAM532ELPbA+m/4cG5Jm3t8Pif/hmeRf6reue/GviQlWSGerOd+TvGA
 71sIk0ng8RAP0J0zFHLnUxc=
X-Google-Smtp-Source: ABdhPJyqH7ViLeRB+FzWYOQ3vCq1H+mXD6TGmS95TYmAhoGG8iLkWsaQTJEmu5/Xukv8LchZhr0SNA==
X-Received: by 2002:a17:902:db10:b029:120:9e54:2c09 with SMTP id
 m16-20020a170902db10b02901209e542c09mr7685042plx.0.1624071296335; 
 Fri, 18 Jun 2021 19:54:56 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id f205sm1584766pfa.154.2021.06.18.19.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 19:54:56 -0700 (PDT)
Date: Sat, 19 Jun 2021 12:54:50 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
To: Andrew Morton <akpm@linux-foundation.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210618194455.0d6c278c@canb.auug.org.au>
In-Reply-To: <20210618194455.0d6c278c@canb.auug.org.au>
MIME-Version: 1.0
Message-Id: <1624071243.qkc40fnx8l.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel =?iso-8859-1?q?Mailing=0A?= List
 <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Stephen Rothwell's message of June 18, 2021 7:44 pm:
> Hi all,
>=20
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   arch/powerpc/kernel/smp.c
>=20
> between commit:
>=20
>   86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C")
>=20
> from the powerpc tree and commit:
>=20
>   103e676c91d0 ("lazy tlb: introduce lazy mm refcount helper functions")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is the correct merge.

Thanks,
Nick

>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/powerpc/kernel/smp.c
> index b83a59ce9beb,b289f1d213f8..000000000000
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@@ -1541,11 -1541,7 +1541,11 @@@ void start_secondary(void *unused
>   {
>   	unsigned int cpu =3D raw_smp_processor_id();
>  =20
>  +	/* PPC64 calls setup_kup() in early_setup_secondary() */
>  +	if (IS_ENABLED(CONFIG_PPC32))
>  +		setup_kup();
>  +
> - 	mmgrab(&init_mm);
> + 	mmgrab_lazy_tlb(&init_mm);
>   	current->active_mm =3D &init_mm;
>  =20
>   	smp_store_cpu_info(cpu);
>=20

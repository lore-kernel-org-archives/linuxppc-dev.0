Return-Path: <SRS0=31b2=KF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2ABC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 05:54:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAF1600EF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 05:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAF1600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fdqy51C2fz3bvD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 15:54:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=KH1SwilX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=KH1SwilX; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FdqxZ2vF7z2xYf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2021 15:54:10 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id
 gq14-20020a17090b104eb029015be008ab0fso9409251pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 May 2021 22:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=tR7xbEi9c29/x8eJIiHRmINurN5BHiF2ey4jlgTK/Pk=;
 b=KH1SwilXvtXlZAiLyCwvi+Ot9VVWOawIXsHFy0/0SKIc35/u+sV/z5i4KtW7C9nCon
 OzNs3cI+QKy55PN4dJj1SPdfDo7a7q+z8MR196JHZFp1VoL8XghRwv4FRTOuue2Aufvm
 IwQpblSvXnwB1AoeYBQJ+IAil/6y5XeeFt0Qz5HLVcgoMf3zPUJvoOiCIX5j9xTpS/97
 IMsmfvd+O6GemP7h7tOTLRL0Rboyg2NvnZU54sB7AnWGlGH3Y6GKjYvQMRRgxdQDekXb
 51vilZ5RhE/9e7AYwHvBfN0N33MrEK2PPdOHe0A6hCAHsbMsiEb3UInH/R1ZnGS9uV/3
 xubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=tR7xbEi9c29/x8eJIiHRmINurN5BHiF2ey4jlgTK/Pk=;
 b=nXHASxGr/jg8EtYMrbN2ug7lN+U6/rXKcJ3R7AasM/vtub6nJaMYF8INFWLvWBZ0tt
 zVUN1XuyUt3mroSeCec+qAp61lYDs5AFbqnm0pjqxtcz0VposNnNewnvRxe28YVXz/a0
 ugPXVj1sPu7j3peJQr1uZXQYQbT4f4Uj9qSAVR+HEIgPE0aoz9gndJ+iTyop0ySrfDkb
 0F8dtWWdMKyoeHIsam9nZXMiwe41PYxwT8TAPPISUnWC09lDRbLATqvLeUNV0R36f+SP
 EBiL5thEc5eHV//ytoW2QyPEhKRoivvZVr0ncHP+YNPDEojcIvs6zG4XY8V1F4Wm+Zif
 Y0zA==
X-Gm-Message-State: AOAM531m/Jb8ocBBE8Iikb8YLO7VcseRIusvzwFONALqi1w42fgB9NGw
 /Son+hemRYvCiIkZC7kLth8=
X-Google-Smtp-Source: ABdhPJwC2cknlj0R+/+Nu9uYefhcPSxTHmIleg4vPMSoywZqbkZ+562g4e5nw2cw3Zbeen0dQtG5QQ==
X-Received: by 2002:a17:903:184:b029:ee:c8eb:55b8 with SMTP id
 z4-20020a1709030184b02900eec8eb55b8mr23150347plg.39.1620626047978; 
 Sun, 09 May 2021 22:54:07 -0700 (PDT)
Received: from localhost (60-241-47-46.tpgi.com.au. [60.241.47.46])
 by smtp.gmail.com with ESMTPSA id i8sm73032pjs.54.2021.05.09.22.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 May 2021 22:54:07 -0700 (PDT)
Date: Mon, 10 May 2021 15:54:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [V3 PATCH 07/16] powerpc/vas: Define QoS credit flag to allocate
 window
To: Haren Myneni <haren@linux.ibm.com>, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <a910e5bd3f3398b4bd430b25a856500735b993c3.camel@linux.ibm.com>
 <90328d5aa92016434f3061ec7cadc812ea2c5dbc.camel@linux.ibm.com>
In-Reply-To: <90328d5aa92016434f3061ec7cadc812ea2c5dbc.camel@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1620625758.4u2ddwmbaj.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Haren Myneni's message of April 18, 2021 7:06 am:
>=20
> pHyp introduces two different type of credits: Default and Quality
> of service (QoS).
>=20
> The total number of default credits available on each LPAR depends
> on CPU resources configured. But these credits can be shared or
> over-committed across LPARs in shared mode which can result in
> paste command failure (RMA_busy). To avoid NX HW contention, phyp
> introduces QoS credit type which makes sure guaranteed access to NX
> resources. The system admins can assign QoS credits for each LPAR
> via HMC.
>=20
> Default credit type is used to allocate a VAS window by default as
> on powerVM implementation. But the process can pass VAS_WIN_QOS_CREDITS


There's some interchanging of pHyp and PowerVM in the series.

PowerVM is probably the better term to use, with uppercase P.
Unless you mean PAPR or pseries etc.

I think you can say the PAPR VAS spec has two different types of=20
credits, rather than say a specific hypervisor is introducing them.

> flag with VAS_TX_WIN_OPEN ioctl to open QoS type window.
>=20
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/vas-api.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/vas-api.h b/arch/powerpc/inclu=
de/uapi/asm/vas-api.h
> index ebd4b2424785..eb7c8694174f 100644
> --- a/arch/powerpc/include/uapi/asm/vas-api.h
> +++ b/arch/powerpc/include/uapi/asm/vas-api.h
> @@ -13,11 +13,15 @@
>  #define VAS_MAGIC	'v'
>  #define VAS_TX_WIN_OPEN	_IOW(VAS_MAGIC, 0x20, struct vas_tx_win_open_att=
r)
> =20
> +/* Flags to VAS TX open window ioctl */
> +/* To allocate a window with QoS credit, otherwise default credit is use=
d */
> +#define	VAS_WIN_QOS_CREDITS	0x0000000000000001
> +
>  struct vas_tx_win_open_attr {

Some consistency of naming might help, VAS_TX_WIN_FLAG_QOS_CREDIT.

>  	__u32	version;
>  	__s16	vas_id;	/* specific instance of vas or -1 for default */
>  	__u16	reserved1;
> -	__u64	flags;	/* Future use */
> +	__u64	flags;
>  	__u64	reserved2[6];
>  };
> =20
> --=20
> 2.18.2
>=20
>=20
>=20

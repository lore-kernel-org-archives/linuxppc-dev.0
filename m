Return-Path: <SRS0=fO6x=VZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B8AC433FF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jul 2019 16:03:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4C3206DD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jul 2019 16:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4C3206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=longchamp.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xSKv5144zDqRm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 02:03:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.208.193; helo=mail-lj1-f193.google.com;
 envelope-from=valentin.longchamp@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=longchamp.me
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xSJ50pyVzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 02:02:12 +1000 (AEST)
Received: by mail-lj1-f193.google.com with SMTP id r9so56088085ljg.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jul 2019 09:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=9kWcDYI013Fq24ux+CQJuoXjF2s1gijWRe9buHhJyPg=;
 b=C12+OzS/eiZDFSGjC1fwM1YQ922Ztgex4vzFA/Gxe/ghKpMUSEnbCTbT82Mf1oZHQU
 DMsuGzc0olAHYyUfkoN/jJoAqChlqhYwTbk0jYxwP1pxFr1eora82OqSUoqT+k68uGwY
 jCW+k7TGA/oG/xm1KmNXz3S4S4MTd2TMUAv0I7InNdU1CTXy7GId3sillG5cHvLH6A+3
 gEoyr6ayOt7omEGadi9GnvTg7bcqf+J888mkyE3bAp3NOrYWODAnDEGmKT874dcvc3ZY
 jRleMGRneqOBazMRBxQjlVGtU42BjLH+s7hkUm9eN2ttI9kgl2b2pkKO7xGcm3kJlquU
 rRJg==
X-Gm-Message-State: APjAAAVssNg4Xxv+cCH0z7ttQHiBZpeDoSyhcrO86kL85qKHA6EZCqf2
 pa7IiP19KQxdIc7wGUKQMnD2n4+rn8M=
X-Google-Smtp-Source: APXvYqzG5553/rM8HScBVMWIIIx22xHkNcGLEysw2HYNUiHKrncuWG3K18xQJXbGYJ9Vu6iLabEIzw==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr54538113lji.57.1564329727187; 
 Sun, 28 Jul 2019 09:02:07 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180])
 by smtp.gmail.com with ESMTPSA id w6sm10119430lff.80.2019.07.28.09.02.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 28 Jul 2019 09:02:07 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h10so56104942ljg.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jul 2019 09:02:06 -0700 (PDT)
X-Received: by 2002:a2e:3013:: with SMTP id w19mr55387814ljw.73.1564329726043; 
 Sun, 28 Jul 2019 09:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190714200501.1276-1-valentin@longchamp.me>
In-Reply-To: <20190714200501.1276-1-valentin@longchamp.me>
From: Valentin Longchamp <valentin@longchamp.me>
Date: Sun, 28 Jul 2019 18:01:55 +0200
X-Gmail-Original-Message-ID: <CADYrJDwvwVThmOwHZ4Moqenf=-iqoHC+yJ_uxtrD8sDso33rjg@mail.gmail.com>
Message-ID: <CADYrJDwvwVThmOwHZ4Moqenf=-iqoHC+yJ_uxtrD8sDso33rjg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kmcent2: update the ethernet devices' phy
 properties
To: linuxppc-dev@lists.ozlabs.org, oss@buserror.net, galak@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Scott, Kumar,

Looking at this patch I have realised that I had already submitted it
to the mailing list nearly 2 years ago:
https://patchwork.ozlabs.org/patch/842944/

Could you please make sure that this one gets merged in the next
window, so that I avoid forgetting such a patch a 2nd time ?

Thanks a lot

Le dim. 14 juil. 2019 =C3=A0 22:05, Valentin Longchamp
<valentin@longchamp.me> a =C3=A9crit :
>
> Change all phy-connection-type properties to phy-mode that are better
> supported by the fman driver.
>
> Use the more readable fixed-link node for the 2 sgmii links.
>
> Change the RGMII link to rgmii-id as the clock delays are added by the
> phy.
>
> Signed-off-by: Valentin Longchamp <valentin@longchamp.me>
> ---
>  arch/powerpc/boot/dts/fsl/kmcent2.dts | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dt=
s/fsl/kmcent2.dts
> index 48b7f9797124..c3e0741cafb1 100644
> --- a/arch/powerpc/boot/dts/fsl/kmcent2.dts
> +++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
> @@ -210,13 +210,19 @@
>
>                 fman@400000 {
>                         ethernet@e0000 {
> -                               fixed-link =3D <0 1 1000 0 0>;
> -                               phy-connection-type =3D "sgmii";
> +                               phy-mode =3D "sgmii";
> +                               fixed-link {
> +                                       speed =3D <1000>;
> +                                       full-duplex;
> +                               };
>                         };
>
>                         ethernet@e2000 {
> -                               fixed-link =3D <1 1 1000 0 0>;
> -                               phy-connection-type =3D "sgmii";
> +                               phy-mode =3D "sgmii";
> +                               fixed-link {
> +                                       speed =3D <1000>;
> +                                       full-duplex;
> +                               };
>                         };
>
>                         ethernet@e4000 {
> @@ -229,7 +235,7 @@
>
>                         ethernet@e8000 {
>                                 phy-handle =3D <&front_phy>;
> -                               phy-connection-type =3D "rgmii";
> +                               phy-mode =3D "rgmii-id";
>                         };
>
>                         mdio0: mdio@fc000 {
> --
> 2.17.1
>


--=20
Valentin Longchamp
Rue de la Carri=C3=A8re 30, CH-1700 Fribourg
valentin@longchamp.me
Mobile: +41 79 569 25 75

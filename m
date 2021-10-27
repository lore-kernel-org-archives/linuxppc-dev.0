Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF63C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 14:38:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4683960F56
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 14:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4683960F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfWXH1HRNz3c7X
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 01:38:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.219.42; helo=mail-qv1-f42.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfWWm2l50z2xrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2021 01:38:10 +1100 (AEDT)
Received: by mail-qv1-f42.google.com with SMTP id h11so1845060qvk.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2021 07:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IIc3VM+0QP6tW1izmsIwRCOe4zK0xch73rEnQe2rldc=;
 b=v1xlrvEr8m+cjJ06HjnvzZ8CPpMNiO+3yI8JiHaSRl6ui1RzGpRES1967Q+ny2xkbL
 VShvJZWjym3AEQTUTP3TBka28V1zXN6r0SPrGhv3jRzdEFiYIYDiIvxOCRdMujtK/Rtr
 MsLwBKWElQXvVy3JiSmEv7GwWpqBJDQWiEyA53sx1yWKoAMoSezlTf/lVJbC0dMXjBPh
 9ITvG8M7NQ8KR3ClMr/NKvgSfXDJbJfd+IlnrufwN3i6AK+8JAmIx+faub6pWO2DEKVE
 hZEr/T3lBX5EfO9A4lQEyglrsWEHVFnZ9aqIhNOT0Y+MslCGfq4vS4BxzjJoiri9QdwT
 UZrw==
X-Gm-Message-State: AOAM5333BDt9GjGiZMjUtqGb4OkIGE7hn3vlNqHMkWxA3ZaD4ThOo+SU
 1cIv0IadagFb3Q3o0+IU6IeQiMFFf1k=
X-Google-Smtp-Source: ABdhPJwNqwnw568QNHR/NrxyQsmNWn4QtdCP3W8/a77JMZACsdudATDGzR+d9oyecnx29eNU+sEyVw==
X-Received: by 2002:a05:6214:20e8:: with SMTP id
 8mr29996274qvk.17.1635345486662; 
 Wed, 27 Oct 2021 07:38:06 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com.
 [209.85.219.43])
 by smtp.gmail.com with ESMTPSA id 17sm64804qtw.16.2021.10.27.07.38.05
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 07:38:06 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id a4so1863081qva.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2021 07:38:05 -0700 (PDT)
X-Received: by 2002:a0c:fe8c:: with SMTP id d12mr25332323qvs.19.1635345485575; 
 Wed, 27 Oct 2021 07:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211027080849.3276289-1-geert@linux-m68k.org>
In-Reply-To: <20211027080849.3276289-1-geert@linux-m68k.org>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 27 Oct 2021 09:37:54 -0500
X-Gmail-Original-Message-ID: <CADRPPNQwcTTS-0MkonizSA_XbLBbTS8di4F3NWOMADACp4gD_w@mail.gmail.com>
Message-ID: <CADRPPNQwcTTS-0MkonizSA_XbLBbTS8di4F3NWOMADACp4gD_w@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: Mark USB_FSL_QE broken on 64-bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Cc: Felipe Balbi <balbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 27, 2021 at 5:25 AM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> On 64-bit:
>
>     drivers/usb/gadget/udc/fsl_qe_udc.c: In function =E2=80=98qe_ep0_rx=
=E2=80=99:
>     drivers/usb/gadget/udc/fsl_qe_udc.c:842:13: error: cast from pointer =
to integer of different size [-Werror=3Dpointer-to-int-cast]
>       842 |     vaddr =3D (u32)phys_to_virt(in_be32(&bd->buf));
>           |             ^
>     In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:41:
>     drivers/usb/gadget/udc/fsl_qe_udc.c:843:28: error: cast to pointer fr=
om integer of different size [-Werror=3Dint-to-pointer-cast]
>       843 |     frame_set_data(pframe, (u8 *)vaddr);
>           |                            ^
>
> The driver assumes physical and virtual addresses are 32-bit, hence it
> cannot work on 64-bit platforms.

The device is truly only used in legacy 32-bit PowerPC chips and never
tested with 64-bit.  Thanks.

>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
> One more casualty of CONFIG_WERROR=3Dy.
> http://kisskb.ellerman.id.au/kisskb/buildresult/14652936/
> ---
>  drivers/usb/gadget/udc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kcon=
fig
> index 8c614bb86c665c77..69394dc1cdfb6436 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -330,6 +330,7 @@ config USB_AMD5536UDC
>  config USB_FSL_QE
>         tristate "Freescale QE/CPM USB Device Controller"
>         depends on FSL_SOC && (QUICC_ENGINE || CPM)
> +       depends on !64BIT || BROKEN
>         help
>            Some of Freescale PowerPC processors have a Full Speed
>            QE/CPM2 USB controller, which support device mode with 4
> --
> 2.25.1
>

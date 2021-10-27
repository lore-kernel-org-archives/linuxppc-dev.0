Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9049CC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 10:38:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C884C60F39
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 10:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C884C60F39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfQCh2cmtz3bhx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 21:38:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.130; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfQC86DXdz2xXb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2021 21:38:27 +1100 (AEDT)
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQgtC-1mLPuS20IA-00NeY1 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct
 2021 12:38:22 +0200
Received: by mail-wm1-f53.google.com with SMTP id
 g205-20020a1c20d6000000b0032cc6bbd505so5256040wmg.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2021 03:38:21 -0700 (PDT)
X-Gm-Message-State: AOAM5326YG/0QJgMesvNa44Gnx0qXcF3ZDVfzRErEI9l7V4igHbtBbAE
 ShQ2ylNNj3IYO+rtLqURmglc/2so2JrdWYCpabM=
X-Google-Smtp-Source: ABdhPJzWVmMJRu6Nz/rjaD9BGMlTJTXmWs4kciJksMzsWQT3KiOawx9iTDk2eBtfMChr7uV7l5Br7Iq8uFXkQjkfCiM=
X-Received: by 2002:a05:600c:1548:: with SMTP id
 f8mr4852836wmg.35.1635331101366; 
 Wed, 27 Oct 2021 03:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211027080849.3276289-1-geert@linux-m68k.org>
In-Reply-To: <20211027080849.3276289-1-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Oct 2021 12:38:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2uxL3qGtDOuCg2Np4k_MtYML2VgOj4HVvOZXEFAEEuvg@mail.gmail.com>
Message-ID: <CAK8P3a2uxL3qGtDOuCg2Np4k_MtYML2VgOj4HVvOZXEFAEEuvg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: Mark USB_FSL_QE broken on 64-bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tslZVbKYIyPtZ8eXl2DjNtfCFk5ardkgwb6D+Xtm6RjoUP7Ul5U
 Xa4UlwKrHNzXAOIiE6OXEVLiF9LMcEubNFOVivLoczNTctb6tmI18GVMOCMfoCFQtQhIAsp
 i7E9agFYxEc7fjCkUZ9n2+G4qYZXiM+MT1v797NLyTUvY8Co7OlZR3uox41+BDOebNSkQka
 dUh79af8nqk2WxnTnRITg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ipqW22eF9mY=:gWvYMGc7murHrzOgSphzYu
 AJKnlnodc8SkHqp2PxljZRshDkwPr0RHh2n2SMf10LVOCbMpF+aJibnIWNS9M15givAaok1Ky
 JJat7vtOU49wF4+AbTqJBHIy0D6zBSaDIrBRLoGJWLrMJc+XiuXK6NtW2JedKLh87fEKCwvXM
 WgQeC0kcJysdMsA7HhQn3CqnTErrN0nBOnto9HCy4qGMWuTkygrGMcIiEb5EyP+FrhjCB2uBs
 WleOPd+B5K+l5fpsn6FcR1BaCCigy94z4ImvvKWRzBbtBr4M5oy83xDvdjdNCWlUCD7JBIUbT
 joSjuVi0JnFiXMa4hxs6psi1oe4h4TFYinRTu43B1ljr6zzOYsW+xQsCXlwelTFkryz5tu0z8
 Xb7tdoL+kGKO4gkKqmaodTwh24nCfbNCDfzxXyLk5Bmz9nyd5crOkDsDmE/M2V/l+SfwGlpUR
 kTsCIzJIcpbrqjU2+S5Q8qxkPxyJJTpbsyDvih5Pxo8kEpkFon+AP2qNbgO65WYJtIRQ7Hw1l
 2c5Zys+Dl5bXvHdOtvwc4o/FVEsSPaaP54bOVK7KKzMoLXeU0udRvkAC+pJ8al2MiPiBSXNCS
 ZXZjELKpVMB0F3snKnnzHBBq63JOIdj+9qjnLg+DI0b0o5o+WYstuwaxSQGmjnW50B8gxu68N
 vby2LRLB0mbD6PfTe17xsTxSTgZcQGE5rPG4NR0V+hX29Vy0igA9XashnbjfmxW43fSnkEFPl
 0wOsPEqIuuvHtMPJpfdVc+SszttrrXpZlZELfXwvfc7u6Yk37c3d3MGkYALXfTGaro83WevsH
 Fh/ZC3hxo+oDoQpEPwkzpnPg3gtSynsx5o9+YgYJZjp3sbFvlQ=
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 27, 2021 at 10:08 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
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
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Interesting, I have not seen this one in randconfig builds.

It looks like the driver also assumes that physical addresses are the same =
as
bus addresses, so maybe it should also be marked broken when CONFIG_IOMMU
is enabled? Maybe that takes it too far, as this driver could still be used
on a machine without IOMMU in a kernel that supports IOMMUs on
other machines.

        Arnd

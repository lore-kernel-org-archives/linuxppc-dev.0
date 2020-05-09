Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE3C47255
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 23:01:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A74121473
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 23:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArCp/cIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A74121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49KN4707dLzDqVx
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 09:01:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ArCp/cIA; dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49KN1r477QzDr3y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2020 08:59:41 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id z2so5618859iol.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2020 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Cu5XCMlYmCles9cU1zQwpiIO21jpNUEqhrhXon1DyTk=;
 b=ArCp/cIAUPJ/JCkJdrEDvwlWmGjF3AzFJHP8CbZpYzbO0cs7JN90wOY2+phy5hmj+m
 ZkyZnzfpB1wU4gad/X5Ns25I6G4qI6SUAjPPVdAYzqG4oKV5MzhWyGJTGimk4aEvlgoc
 nDsLQtDt1b+XQb/cPt/0TNgao7ZFig6LbeZCs0umCsKJ4WDOpmksak12b25ipUsQZVHx
 FbnjECmSWwo8hWHmt8qzZs4Qm1C3dbQJIqRvJHqI3oZYirs+r6sskhltk/wFjEMQh9RJ
 Y5Ih8GsXENUzVEKpf/nwdi8Ymsienu1DfFgCSDUmk/fvp5psNL/Cc56PJZ1rpdc5Bd9B
 4o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Cu5XCMlYmCles9cU1zQwpiIO21jpNUEqhrhXon1DyTk=;
 b=AefGVHy6ObNM+58pHyJQALdOCFVk+OgtEiZ5dba2AbzswoUwpfcvHM9lJk4OTo3OYa
 QKSGpq60+de6he+BfLsxCSeYStqJUV8/ST479wyDIXpLuVEpHxzhU9UDK+HZLrSS5ZFU
 SE4EP+ckXtSGDbMi7F/MiKLfNLbuFSSEG9+mrcKM3bSh9bS95zeAkA5twu71DlamV85E
 C0amVoFNQz/Z6jCqbBGsNGbk5r5Xn9Max23rQSTKvHi8UAEEP2zvfVsDMq/fdJJs4Adp
 ofM/lO0hlq4AdESzvm/VU1N6TJNwX5aKHuKrvOXkx06Qp6WMNFJ9eADNAvUqiQ1ZArFA
 CWeQ==
X-Gm-Message-State: AGi0PuaWB22g2ZSqR9qGIvawnJHSu9C77hGzjjDoMKjaNSqnStUmIqF+
 Xvx2SogwiE9YDHlVbEuPZOcx9mnLjhN3vnpE7Aw=
X-Google-Smtp-Source: APiQypJtMK+i9KbHBea1iSvxTMn9QE3F1NEO8HjjwRAUFzoOcJ17K0Cw3CiBAHoqUReKldaUxOrzVyJqSIWwkOJRTiA=
X-Received: by 2002:a02:c8c7:: with SMTP id q7mr877554jao.111.1589065178240;
 Sat, 09 May 2020 15:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
 <229E1896-0C06-418A-B7DE-40AEBFB44F85@lca.pw>
 <a4ae5c50-f317-4224-a5f2-6e1030e62d2b@csgroup.eu>
In-Reply-To: <a4ae5c50-f317-4224-a5f2-6e1030e62d2b@csgroup.eu>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Sun, 10 May 2020 08:59:27 +1000
Message-ID: <CAOSf1CEe85Lev54g+hkEoDmmR1HRsF070oxLu8ok7fEtXUH7NQ@mail.gmail.com>
Subject: Re: ioremap() called early from pnv_pci_init_ioda_phb()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, May 10, 2020 at 1:51 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 08/05/2020 =C3=A0 19:41, Qian Cai a =C3=A9crit :
> >
> >
> >> On May 8, 2020, at 10:39 AM, Qian Cai <cai@lca.pw> wrote:
> >>
> >> Booting POWER9 PowerNV has this message,
> >>
> >> "ioremap() called early from pnv_pci_init_ioda_phb+0x420/0xdfc. Use ea=
rly_ioremap() instead=E2=80=9D
> >>
> >> but use the patch below will result in leaks because it will never cal=
l early_iounmap() anywhere. However, it looks me it was by design that phb-=
>regs mapping would be there forever where it would be used in pnv_ioda_get=
_inval_reg(), so is just that check_early_ioremap_leak() initcall too stron=
g?
> >>
> >> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> @@ -36,6 +36,7 @@
> >> #include <asm/firmware.h>
> >> #include <asm/pnv-pci.h>
> >> #include <asm/mmzone.h>
> >> +#include <asm/early_ioremap.h>
> >>
> >> #include <misc/cxl-base.h>
> >>
> >> @@ -3827,7 +3828,7 @@ static void __init pnv_pci_init_ioda_phb(struct =
device_node *np,
> >>         /* Get registers */
> >>         if (!of_address_to_resource(np, 0, &r)) {
> >>                 phb->regs_phys =3D r.start;
> >> -               phb->regs =3D ioremap(r.start, resource_size(&r));
> >> +               phb->regs =3D early_ioremap(r.start, resource_size(&r)=
);
> >>                 if (phb->regs =3D=3D NULL)
> >>                         pr_err("  Failed to map registers !\n=E2=80=9D=
);
> >
> > This will also trigger a panic with debugfs reads, so isn=E2=80=99t tha=
t this commit bogus at least for powerpc64?
> >
> > d538aadc2718 (=E2=80=9Cpowerpc/ioremap: warn on early use of ioremap()"=
)
>
> No d538aadc2718 is not bogus. That's the point, we want to remove all
> early usages of ioremap() in order to remove the hack with the
> ioremap_bot stuff and all, and stick to the generic ioremap logic.
>
> In order to do so, all early use of ioremap() has to be converted to
> early_ioremap() or to fixmap or anything else that allows to do ioremaps
> before the slab is ready.
>
> early_ioremap() is for temporary mappings necessary at boottime. For
> long lasting mappings, another method is to be used.
>
> Now, the point is that other architectures like for instance x86 don't
> seem to have to use early_ioremap() much. Powerpc is for instance doing
> early mappings for PCI. Seems like x86 initialises PCI once slab is
> ready. Can't powerpc do the same ?

Patches welcome.

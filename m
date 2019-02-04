Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01614C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:05:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382C1218A6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW+lpe13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382C1218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHJL3jstzDqHV
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:05:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OW+lpe13"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHGW008BzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:04:18 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id d11so18599288itf.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Feb 2019 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=etuZIXbwIDk2ykGX6cOVcgiYmDIWwhQSB2Esl7OcoA8=;
 b=OW+lpe13AFyZtM274DNj951LQKuFKYM9/KcZiD3dhDfFj0xXwQJ8H/tRs7RwoMABoS
 XfKDdcAOZQ0WsbScUVKXCA7djujaL5ws0vPAF9/zan/p5TD5x2+6u8XWOLfHjWyn2Pzk
 V3IoqMXAVwynfVJo0+oX2b13WlDvnWlkOX44N/ugLOc/8f36dwl1y4NSCeyYIdv7hTM5
 HTbGyRjKd2p50w2IW6eb6s1fn0oUfZU7a78ZsPiM4SC0OLuG1Zu/MLWG0+DemdPT3qVL
 IczRNBQUThro44mqg56izJ9G/uIKmMpdXwKhVuGM7loysD1OrFy6FvjaQQ86i/URfZI0
 eyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=etuZIXbwIDk2ykGX6cOVcgiYmDIWwhQSB2Esl7OcoA8=;
 b=FZwfLW19nKS4dJSMy76e3kX9tx2BaIJM+yjQBvIBrRbEfEkYF+vTo9zIdEaGNQh5Kd
 8QHyc+C1+lecpLctfup3BuxMq4VcK0cFDVt772QwpAxvMhZQSi1OPYf2FLg+uKxynDDm
 jlG31+GARXyUicCl8r8Rv0jorboZ4u+Hr2t6/UjyvhD7GCvX29YCpjQx6Me80gxdycy+
 MuKg47WaCRgqezJAqlRriqeGJj8vaYBB1AHKfycAgFTWaTzj1UPPCG2tBINS230jdJag
 vf7hcMQVmGIOQ/zUkLBRqv03LdAw2GrIga8onVLLHL/t18n3JharXA0RYoVje48IfKpZ
 1VYg==
X-Gm-Message-State: AHQUAuaUVWX3CI1cP9Z96r4YdoUvKj828GV1vF+goaKR6ps2XOiGUN7b
 F8OlcXeRycL6lIvsqLJkNlEvuJhxas8a46DSmoMd7A==
X-Google-Smtp-Source: AHgI3Ia18w/AMZ0I6i8AGM3ajKdCp9a0KPifyeJFgZUXcEU1beyhvepUg/TCGCNOJF41Hb6CSgTBlDaOEFlrC5t1SCA=
X-Received: by 2002:a24:74c2:: with SMTP id o185mr7899012itc.100.1549260256540; 
 Sun, 03 Feb 2019 22:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20190201004201.6512-1-oohall@gmail.com>
 <0b323d19-c197-aa66-3d0a-344a5af39789@ozlabs.ru>
In-Reply-To: <0b323d19-c197-aa66-3d0a-344a5af39789@ozlabs.ru>
From: Oliver <oohall@gmail.com>
Date: Mon, 4 Feb 2019 17:04:05 +1100
Message-ID: <CAOSf1CFFrnp_fv=Y7S1rR5z8u4ig_rm0GwivZQdiZP6eogHG3Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Escalate reset when IODA reset fails
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 4, 2019 at 3:45 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 01/02/2019 11:42, Oliver O'Halloran wrote:
> > The IODA reset is used to flush out any OS controlled state from the PHB.
> > This reset can fail if a PHB fatal error has occurred in early boot,
> > probably due to a because of a bad device. We already do a fundemental
> > reset of the device in some cases, so this patch just adds a test to force
> > a full reset if firmware reports an error when performing the IODA reset.
> >
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>
> I am pretty sure I already saw this :-/

Uh yeah, looks like I posted it a while ago and forgot I did.

>
> ah, anyway
>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>
>
>
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 1d6406a..53982f8 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -3943,9 +3943,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> >        * shutdown PCI devices correctly. We already got IODA table
> >        * cleaned out. So we have to issue PHB reset to stop all PCI
> >        * transactions from previous kernel. The ppc_pci_reset_phbs
> > -      * kernel parameter will force this reset too.
> > +      * kernel parameter will force this reset too. Additionally,
> > +      * if the IODA reset above failed then use a bigger hammer.
> > +      * This can happen if we get a PHB fatal error in very early
> > +      * boot.
> >        */
> > -     if (is_kdump_kernel() || pci_reset_phbs) {
> > +     if (is_kdump_kernel() || pci_reset_phbs || rc) {
> >               pr_info("  Issue PHB reset ...\n");
> >               pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
> >               pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
> >
>
> --
> Alexey

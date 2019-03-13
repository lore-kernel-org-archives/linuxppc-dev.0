Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF3C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:15:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C6E20693
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C6E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KNPq04qKzDqK3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 07:15:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KNLx1YZszDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 07:13:13 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id b3so2990649otp.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 13:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L6gmyEFlOHG4CkXi67ykOuLwFFs5zi3k3f8mGPiMx1w=;
 b=philtwd6kLl34LwcI5JbOY/lyDat5AeOESyPMfO0qMkRohJKKJotyCtP9YunyzRlgb
 lf7oAqzwlw+RJI3IrsqLVclIvcfbzPDeleNy5mUCQ8W9aqZB8EAUzm/DQ4009J6Jrl4E
 PI84UmtpGySOTn3wIk6btTTBL8a/o5VHra8j/maV/gdzE8Myg+EVP8NGTmanMbpV5t/C
 bOIJmjpWGmyvRvKoHaLk1eQh1weLADLAbbX5WE1cC9tsE1bbdXOpB8kEY6i+EujCkGo6
 V1Tjava8+JxjRBT5Ed8Ppg+aiTi9dcAbK4S9eQSXgeayXmoXH9fSqJOjqqtKkj78FACp
 GaLw==
X-Gm-Message-State: APjAAAWTadcYF0j5fjDd7eUXhSpdeilBwspbCcJeePhEFXks+nkZOYZl
 cO8RWrd56quzOMFo0wu8BXHqbC92JS58xdh5+8E=
X-Google-Smtp-Source: APXvYqwDDarbEXYPAC8J2SutbdlxKHrmfvedVgw51YdaAG3IhupTJ6Kn1B/I/B+Lassa7IUamDVvECvVuYyjFGGA9lU=
X-Received: by 2002:a05:6830:16cc:: with SMTP id
 l12mr29209028otr.58.1552507990675; 
 Wed, 13 Mar 2019 13:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190312203140.31785-1-malat@debian.org>
 <607b412d-e5a2-5d08-7fb9-53a24e6c76d4@c-s.fr>
In-Reply-To: <607b412d-e5a2-5d08-7fb9-53a24e6c76d4@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 13 Mar 2019 21:12:59 +0100
Message-ID: <CA+7wUszPviAFVjyU-=qAJfOpe_NxmimWd2-tc148NLUEc4Oj0w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Make some functions static
To: Christophe Leroy <christophe.leroy@c-s.fr>
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
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 12, 2019 at 10:14 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 12/03/2019 =C3=A0 21:31, Mathieu Malaterre a =C3=A9crit :
> > In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
> > new functions were added. Since these functions can be made static,
> > make it so. While doing so, it turns out that holly_power_off and
> > holly_halt are unused, so remove them.
>
> I would have said 'since these functions are only used in this C file,
> make them static'.
>
> I think this could be split in two patches:
> 1/ Remove unused functions, ie holly_halt() and holly_power_off().
> 2/ Make the other ones static.

Michael do you want two patches ?

> Christophe
>
> >
> > Silence the following warnings triggered using W=3D1:
> >
> >    arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous =
prototype for 'holly_exclude_device' [-Werror=3Dmissing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous=
 prototype for 'holly_show_cpuinfo' [-Werror=3Dmissing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previou=
s prototype for 'holly_restart' [-Werror=3Dmissing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:236:6: error: no previous=
 prototype for 'holly_power_off' [-Werror=3Dmissing-prototypes]
> >    arch/powerpc/platforms/embedded6xx/holly.c:243:6: error: no previous=
 prototype for 'holly_halt' [-Werror=3Dmissing-prototypes]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/platforms/embedded6xx/holly.c | 19 ++++---------------
> >   1 file changed, 4 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/=
platforms/embedded6xx/holly.c
> > index 0409714e8070..829bf3697dc9 100644
> > --- a/arch/powerpc/platforms/embedded6xx/holly.c
> > +++ b/arch/powerpc/platforms/embedded6xx/holly.c
> > @@ -44,7 +44,8 @@
> >
> >   #define HOLLY_PCI_CFG_PHYS 0x7c000000
> >
> > -int holly_exclude_device(struct pci_controller *hose, u_char bus, u_ch=
ar devfn)
> > +static int holly_exclude_device(struct pci_controller *hose, u_char bu=
s,
> > +                             u_char devfn)
> >   {
> >       if (bus =3D=3D 0 && PCI_SLOT(devfn) =3D=3D 0)
> >               return PCIBIOS_DEVICE_NOT_FOUND;
> > @@ -187,13 +188,13 @@ static void __init holly_init_IRQ(void)
> >       tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
> >   }
> >
> > -void holly_show_cpuinfo(struct seq_file *m)
> > +static void holly_show_cpuinfo(struct seq_file *m)
> >   {
> >       seq_printf(m, "vendor\t\t: IBM\n");
> >       seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> >   }
> >
> > -void __noreturn holly_restart(char *cmd)
> > +static void __noreturn holly_restart(char *cmd)
> >   {
> >       __be32 __iomem *ocn_bar1 =3D NULL;
> >       unsigned long bar;
> > @@ -233,18 +234,6 @@ void __noreturn holly_restart(char *cmd)
> >       for (;;) ;
> >   }
> >
> > -void holly_power_off(void)
> > -{
> > -     local_irq_disable();
> > -     /* No way to shut power off with software */
> > -     for (;;) ;
> > -}
> > -
> > -void holly_halt(void)
> > -{
> > -     holly_power_off();
> > -}
> > -
> >   /*
> >    * Called very early, device-tree isn't unflattened
> >    */
> >

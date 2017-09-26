Return-Path: <chunkeey@googlemail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1sXV6NNfzDsPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 06:11:05 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id n64so3097404wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 13:11:05 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: fix compile error on 64K pages on 40x, 44x
Date: Tue, 26 Sep 2017 22:11:01 +0200
Message-ID: <1679187.TCVvfgChXT@debian64>
In-Reply-To: <8d7986f1-bb32-133f-d809-edb7b73106bb@c-s.fr>
References: <20170926190345.2341-1-chunkeey@googlemail.com>
 <8d7986f1-bb32-133f-d809-edb7b73106bb@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, September 26, 2017 9:25:30 PM CEST Christophe LEROY wrote:
>=20
> Le 26/09/2017 =C3=A0 21:03, Christian Lamparter a =C3=A9crit :
> > The mmu context on the 40x, 44x does not define pte_frag
> > entry. This causes gcc abort the compilation due to:
> >=20
> > setup-common.c: In function =E2=80=98setup_arch=E2=80=99:
> > setup-common.c:908: error: =E2=80=98mm_context_t=E2=80=99 has no =E2=80=
=98pte_frag=E2=80=99
> >=20
> > This patch fixes the issue by adding additional guard
> > conditions, that limit the initialization to just
> > platforms that define the pte_frag variable in the
> > mmu context.
> >=20
> > Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> > ---
> >   arch/powerpc/kernel/setup-common.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/s=
etup-common.c
> > index 0ac741fae90e..436d42a7d761 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -904,7 +904,9 @@ void __init setup_arch(char **cmdline_p)
> >   #endif
> >   #endif
> >  =20
> > -#ifdef CONFIG_PPC_64K_PAGES
> > +#if defined(CONFIG_PPC_64K_PAGES) && \
> > +    defined(CONFIG_PPC_BOOK3S_64) && \
> > +    defined(CONFIG_PPC_BOOK3E_MMU)
>=20
> There must be something wrong here.
> BOOK3E_MMU is defined if BOOK3E_64 or FSL_BOOKE
> BOOK3S_64 and BOOK3E_64 are mutually exclusive
> FSL_BOOKE is PPC32 which is mutually exclusive from PPC64.
>=20
> Therefore you can't have both BOOK3S_64 and BOOK3E_MMU at the same time
Oops, yes. I guess it should be:

#if defined(CONFIG_PPC_64K_PAGES) && \
    (defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_BOOK3E_MMU))

right?

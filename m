Return-Path: <chunkeey@gmail.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y43vz213QzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 20:05:35 +1000 (AEST)
Received: by mail-wm0-x231.google.com with SMTP id t69so3135475wmt.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 03:05:34 -0700 (PDT)
From: Christian Lamparter <chunkeey@gmail.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: fix compile error on 64K pages on 40x, 44x
Date: Sat, 30 Sep 2017 12:05:26 +0200
Message-ID: <3274258.FKFWPD0JKs@debian64>
In-Reply-To: <b0281459-f8b7-40e1-d4a6-1e4a122593f7@c-s.fr>
References: <20170928183232.15367-1-chunkeey@googlemail.com>
 <b0281459-f8b7-40e1-d4a6-1e4a122593f7@c-s.fr>
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

On Saturday, September 30, 2017 10:25:45 AM CEST christophe leroy wrote:
>=20
> Le 28/09/2017 =C3=A0 20:32, Christian Lamparter a =C3=A9crit :
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
>=20
> Wouldn't it be better to amend mm_context_t with the following, just=20
> like other platforms, instead of a #ifdef in setup_arch() ?
>
> #ifdef CONFIG_PPC_64K_PAGES
> 	/* for 4K PTE fragment support */
> 	void *pte_frag;
> #endif

This would require to add this dead weight to the mm_context_t of
asm/mmu-40x.h, asm/mmu-44x.h and asm/mmu-8xx.h.=20
asm/mmu-book3e.h already has the pte_frag defined.
But it is not used by any mmu-book3e/mmu-32 code as far as I can tell.

> Otherwise, since init_mm is defined in BSS, is setting pte_frag to NULL=20
> needed at all ?
> I think removing this line would be better.
Yes, in fact it's guaranteed to be NULL by C99.
This is because init_mm is of external linkage and this makes it of "static=
=20
storage class" according to 6.2.4.3:
"An object whose identifier is declared with external or internal linkage,
or with the storage-class specifier static has static storage duration."

And C99 defines in 6.7.8.10 Initialization that: "
If an object that has static storage duration is not initialized explicitly,
then:
=E2=80=94 if it has pointer type, it is initialized to a null pointer;
[...]
"

so yes, init_mm.context.pte_frag =3D NULL; can be dropped.=20

The question is what to do with BOOK3E mmu.h? After all the
pte_frag serves no purpose there.

Regards,
Christian

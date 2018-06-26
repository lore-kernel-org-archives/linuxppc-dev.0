Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FGJS294fzF1H5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 16:25:59 +1000 (AEST)
Received: by mail-ot0-f194.google.com with SMTP id l15-v6so17799431oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 23:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180622192749.24954-1-malat@debian.org>
 <c182ca65-f41e-4a1c-95ee-6cb979a6e76b@c-s.fr>
In-Reply-To: <c182ca65-f41e-4a1c-95ee-6cb979a6e76b@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 26 Jun 2018 08:25:44 +0200
Message-ID: <CA+7wUsy9j8Zfxs1dB-bR-dYrzWjpNRm=BZYqkvEH5c1UzHrZMA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_powerpc=2Fmm=3A_remove_warning_about_=E2=80=98type?=
 =?UTF-8?Q?=E2=80=99_being_set?=
To: a.p.zijlstra@chello.nl
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 23, 2018 at 7:12 PM christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 22/06/2018 =C3=A0 21:27, Mathieu Malaterre a =C3=A9crit :
> > =E2=80=98type=E2=80=99 is only used when CONFIG_DEBUG_HIGHMEM is set. S=
o add a possibly
> > unused tag to variable. Remove warning treated as error with W=3D1:
> >
> >    arch/powerpc/mm/highmem.c:59:6: error: variable =E2=80=98type=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
>
> Is type neeeded at all when CONFIG_DEBUG_HIGHMEM is not set ?
>
> The call        type =3D kmap_atomic_idx();          seems useless when
> CONFIG_DEBUG_HIGHMEM isn't set. Couldn't we just most type definition
> and setting inside the CONFIG_DEBUG_HIGHMEM {} below ?
>
> Alternatively, maybe you could replace the #ifdef CONFIG_DEBUG_HIGHMEM
> by an    if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) ?

I am not familiar with this code. But starring at other arch
implementations (eg. `arch/x86/mm/highmem_32.c`), it feels like
powerpc is skipping `pte_clear(&init_mm, vaddr, kmap_pte-idx);` unless
`CONFIG_DEBUG_HIGHMEM=3Dy`. Could someone please confirm this is the
correct behavior ?

Or else I can rewrite the code a bit like `arch/arm/mm/highmem.c`
which skips `set_fixmap_pte(idx, __pte(0));` unless
`CONFIG_DEBUG_HIGHMEM=3Dy`.

> Christophe
>
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/mm/highmem.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
> > index 668e87d03f9e..82a0e37557a5 100644
> > --- a/arch/powerpc/mm/highmem.c
> > +++ b/arch/powerpc/mm/highmem.c
> > @@ -56,7 +56,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
> >   void __kunmap_atomic(void *kvaddr)
> >   {
> >       unsigned long vaddr =3D (unsigned long) kvaddr & PAGE_MASK;
> > -     int type;
> > +     int type __maybe_unused;
> >
> >       if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
> >               pagefault_enable();
> >
>
> ---
> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
>

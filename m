Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlgWj5C8CzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 09:49:37 +1000 (AEST)
Message-ID: <1460591377.30121.3.camel@neuling.org>
Subject: Re: [PATCH 1/3] powerpc: Complete FSCR context switch
From: Michael Neuling <mikey@neuling.org>
To: Jack Miller <jack@codezen.org>, Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, michael@ozlabs.au.ibm.com
Date: Thu, 14 Apr 2016 09:49:37 +1000
In-Reply-To: <CAGXwabRb-Wc8W8m0qP4kLb-oR+fZED8urYr4Asw0bq9kAc8C1w@mail.gmail.com>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
 <1460401065-10540-2-git-send-email-jack@codezen.org>
 <20160413205112.425444de@kryten>
 <CAGXwabRb-Wc8W8m0qP4kLb-oR+fZED8urYr4Asw0bq9kAc8C1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-13 at 12:52 -0500, Jack Miller wrote:

> Hi Anton.
>=20
> On Wed, Apr 13, 2016 at 5:51 AM, Anton Blanchard <anton@samba.org> wrote:

> > Hi Jack,
> >=20

> > > Previously we just saved the FSCR, but only restored it in some
> > > settings, and never copied it thread to thread. This patch always
> > > restores the FSCR and formalizes new threads inheriting its setting s=
o
> > > that later we can manipulate FSCR bits in start_thread.
> >=20
> > Will this break the existing FSCR_DSCR bit handling?
> >=20
> >          if (cpu_has_feature(CPU_FTR_DSCR)) {
> >                 u64 dscr =3D get_paca()->dscr_default;
> >                 u64 fscr =3D old_thread->fscr & ~FSCR_DSCR;
> >=20
> >                 if (new_thread->dscr_inherit) {
> >                         dscr =3D new_thread->dscr;
> >                         fscr |=3D FSCR_DSCR;
> >                 }
> >=20
> >                 if (old_thread->dscr !=3D dscr)
> >                         mtspr(SPRN_DSCR, dscr);
> >=20
> >                 if (old_thread->fscr !=3D fscr)
> >                         mtspr(SPRN_FSCR, fscr);
> >         }
> >=20
> > If not, we should modify the above so we don't write the FSCR twice.
>=20
> I think this code is just partially redundant. I think it's trying to
> predict the right FSCR value based on this dscr_inherit flag. Now that
> we fully switch it, we could skip setting FSCR here, and just set DSCR
> if FSCR.DSCR is set (similar to what my patches do with FSCR.LM). In
> fact, we might be able to just entirely get rid of the dscr_inherit
> flag, but I'd have to look harder at that.

I'm not sure that works on processes before power8.

There DSCR SPR number 0x11 will always trap and emulate from userspace
(see arch/powerpc/kernel/traps.c:emulate_instruction()).  That is not
controlled by FSCR and should work on POWER7 where FSCR is not
present.  We need to set the inherit bit there too.

DSCR SPR number 0x3 is controlled by fscr, but it's only avaliable on
POWER8.

> Right now the FSCR switch is conditional on FTR_ARCH_207S which is
> more exclusive than FTR_DSCR, but I guess the actual FSCR register is
> universal to PPC64 like the fscr field in the thread struct? If so, I
> can just move the FSCR save/restore out of the 207 conditional.

FSCR was only introduced in power8, so it needs to be 207 conditional

Mikey

>=20
> Anyway, I'll clean this up a bit, add the little asm tweak from
> Segher, and put another spin on the list.
>=20
> - Jack
>=20

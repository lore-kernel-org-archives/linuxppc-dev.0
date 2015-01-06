Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 4B9871A08A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 00:05:25 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 2/2] powerpc/8xx: use _PAGE_RO instead of _PAGE_RW
Date: Tue, 6 Jan 2015 13:05:19 +0000
Message-ID: <1420549519.25047.31.camel@transmode.se>
References: <20141222101450.D7DD11A5E15@localhost.localdomain>
 <1420481520.25047.15.camel@transmode.se> <54AB88C2.7040901@c-s.fr>
In-Reply-To: <54AB88C2.7040901@c-s.fr>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 2015-01-06 at 08:03 +0100, leroy christophe wrote:
> Le 05/01/2015 19:12, Joakim Tjernlund a =E9crit :
> > On Mon, 2014-12-22 at 11:14 +0100, Christophe Leroy wrote:
> > > On powerpc 8xx, in TLB entries, 0x400 bit is set to 1 for read-only p=
ages
> > > and is set to 0 for RW pages. So we should use _PAGE_RO instead of _P=
AGE_RW
> > >=20
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Hi Christophe, been meaning to look over all you recent 8xx MMU/TLB pat=
ches
> > but got so little time :(
> >=20
> > This is very cool (not sure if there will be a performance gain)  but .=
.
> I think every saved cycle is worth it.
> Before I did any modification:
> * ITLBMiss was 28 instructions.
> * DTLBMiss was 32 instructions.
> Now, (No MODULES, no CPU6, no CPU15):
> * ITLBMiss is 15 instructions
> * DTLBMiss is 24 instructions

I only meant this patch, sorry for not being explicit about that.

> > >=20
> > >=20
> > > diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/=
include/asm/pgtable-ppc32.h
> > > index caf094a..b4e0c3b 100644
> > > --- a/arch/powerpc/include/asm/pgtable-ppc32.h
> > > +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
> > > @@ -178,9 +178,10 @@ static inline unsigned long pte_update(pte_t *p,
> > >          andc    %1,%0,%5\n\
> > >          or      %1,%1,%6\n\
> > >          /* 0x200 =3D=3D Extended encoding, bit 22 */ \
> > > -       /* Bit 22 has to be 1 if neither _PAGE_USER nor _PAGE_RW are =
set */ \
> > > +       /* Bit 22 has to be 1 when _PAGE_USER is unset and _PAGE_RO i=
s set */ \
> > >          rlwimi  %1,%1,32-2,0x200\n /* get _PAGE_USER */ \
> > > -       rlwinm  %3,%1,32-1,0x200\n /* get _PAGE_RW */ \
> > > +       rlwinm  %3,%1,32-1,0x200\n /* get _PAGE_RO */ \
> > > +       xori    %3,%3,0x200\n \
> > >          or      %1,%3,%1\n\
> > >          xori    %1,%1,0x200\n"
> > >   "      stwcx.  %1,0,%4\n\
> > ... here I expected to loose the existing xori insn instead of adding o=
ne?
> >=20
> >=20
> Well, I could have xored the PAGE_USER bit instead, but in that case, it
> is not anymore an 'or' but an 'and' that has to be performed between the
> bits, and then all other bits must be set to 1, or the result of the 'and=
' shall be inserted using 'rlwimi'. So it would be more modifications than =
just adding an xori, and not less instructions.
>=20

I see, thanks

 Jocke=

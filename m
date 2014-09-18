Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id B074B1A015D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 04:12:45 +1000 (EST)
In-Reply-To: <541B0B66.8030405@c-s.fr>
References: <20140917163657.7737D1AB032@localhost.localdomain>
 <OF3CC96BF2.DF7CB060-ONC1257D57.00533ED7-C1257D57.0053CADF@transmode.se>
 <541B0B66.8030405@c-s.fr>
To: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH v3 03/21] powerpc/8xx: exception InstructionAccess does not
 exist on MPC8xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFB7DFC74D.65FC1C31-ONC1257D57.00632BC3-C1257D57.00640A0B@transmode.se>
Date: Thu, 18 Sep 2014 20:12:41 +0200
Content-Type: text/plain; charset="ISO-8859-1"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

leroy christophe <christophe.leroy@c-s.fr> wrote on 2014/09/18 18:42:14:

>=20
> Le 18/09/2014 17:15, Joakim Tjernlund a =E9crit :
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/09/17=20
18:36:57:
> >> Exception InstructionAccess does not exist on MPC8xx. No need to=20
branch
> > there from somewhere else.
> >> Handling can be done directly in InstructionTLBError Exception.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>
> >> ---
> >> Changes in v2:
> >> - None
> >>
> >> Changes in v3:
> >> - arch/powerpc/mm/fault.c uses the vector number, so make sure it
> > understand
> >> the new ones.
> >>
> >>   arch/powerpc/kernel/head=5F8xx.S | 17 +++++++----------
> >>   arch/powerpc/mm/fault.c        |  1 +
> >>   2 files changed, 8 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/arch/powerpc/kernel/head=5F8xx.S
> > b/arch/powerpc/kernel/head=5F8xx.S
> >> index 3af6db1..fbe5d10 100644
> >> --- a/arch/powerpc/kernel/head=5F8xx.S
> >> +++ b/arch/powerpc/kernel/head=5F8xx.S
> >> @@ -234,15 +234,9 @@ DataAccess:
> >>      EXC=5FXFER=5FLITE(0x300, handle=5Fpage=5Ffault)
> >>
> >>   /* Instruction access exception.
> >> - * This is "never generated" by the MPC8xx.  We jump to it for other
> >> - * translation errors.
> >> + * This is "never generated" by the MPC8xx.
> >>    */
> >> -   . =3D 0x400
> >> -InstructionAccess:
> >> -   EXCEPTION=5FPROLOG
> >> -   mr   r4,r12
> >> -   mr   r5,r9
> >> -   EXC=5FXFER=5FLITE(0x400, handle=5Fpage=5Ffault)
> >> +   EXCEPTION(0x400, InstructionAccess, unknown=5Fexception,=20
EXC=5FXFER=5FSTD)
> >>
> >>   /* External interrupt */
> >>      EXCEPTION(0x500, HardwareInterrupt, do=5FIRQ, EXC=5FXFER=5FLITE)
> >> @@ -382,7 +376,7 @@ InstructionTLBMiss:
> >>   #endif
> >>      mfspr   r10, SPRN=5FSPRG=5FSCRATCH2
> >>      EXCEPTION=5FEPILOG=5F0
> >> -   b   InstructionAccess
> >> +   b   InstructionTLBError
> >>
> >>      . =3D 0x1200
> >>   DataStoreTLBMiss:
> >> @@ -477,7 +471,10 @@ DataStoreTLBMiss:
> >>    */
> >>      . =3D 0x1300
> >>   InstructionTLBError:
> >> -   b   InstructionAccess
> >> +   EXCEPTION=5FPROLOG
> >> +   mr   r4,r12
> >> +   mr   r5,r9
> >> +   EXC=5FXFER=5FLITE(0x1300, handle=5Fpage=5Ffault)
> > Still don't like that you change the vector number, every other ppc=20
uses
> > the
> > standard number.
> >
> > Can you not just lie here(EXC=5FXFER=5FLITE(0x400, handle=5Fpage=5Ffaul=
t))?
> > Move the code to InstructionAccess too and let TLBError branch there.
> My issue was that if I do EXC=5FXFER=5FLITE(0x400, handle=5Fpage=5Ffault)=
, I=20
> can't leave the
>      EXCEPTION(0x400, InstructionAccess, unknown=5Fexception,=20
> EXC=5FXFER=5FSTD) at address .400
> Otherwise, I get twice the same label.
>=20
> What about the following patch then ? Would this be acceptable ?
>=20
> @@ -234,15 +234,13 @@ DataAccess:
>       EXC=5FXFER=5FLITE(0x300, handle=5Fpage=5Ffault)
>=20
>   /* Instruction access exception.
> - * This is "never generated" by the MPC8xx.  We jump to it for other
> - * translation errors.
> + * This is "never generated" by the MPC8xx.
>    */
>       . =3D 0x400
>   InstructionAccess:
>       EXCEPTION=5FPROLOG
> -    mr    r4,r12
> -    mr    r5,r9
> -    EXC=5FXFER=5FLITE(0x400, handle=5Fpage=5Ffault)
> +    addi    r3,r1,STACK=5FFRAME=5FOVERHEAD
> +    EXC=5FXFER=5FSTD(0x401, unknown=5Fexception)

Since this is never generated I think it is OK. Nedds some more commenst
though, why the 401 etc.


>=20
>   /* External interrupt */
>       EXCEPTION(0x500, HardwareInterrupt, do=5FIRQ, EXC=5FXFER=5FLITE)
> @@ -382,7 +380,7 @@ InstructionTLBMiss:
>   #endif
>       mfspr    r10, SPRN=5FSPRG=5FSCRATCH2
>       EXCEPTION=5FEPILOG=5F0
> -    b    InstructionAccess
> +    b    InstructionTLBError
>=20
>       . =3D 0x1200
>   DataStoreTLBMiss:
> @@ -477,7 +475,11 @@ DataStoreTLBMiss:
>    */
>       . =3D 0x1300
>   InstructionTLBError:
> -    b    InstructionAccess
> +    EXCEPTION=5FPROLOG
> +    mr    r4,r12
> +    mr    r5,r9
> +    /* 0x400 is InstructionAccess exception, needed by bad=5Fpage=5Ffaul=
t()=20
*/
> +    EXC=5FXFER=5FLITE(0x400, handle=5Fpage=5Ffault)

You should have the code in TLBMiss and have the TLBError branch there as
that is the common case.=20

>=20
>   /* This is the data TLB error on the MPC8xx.  This could be due to
>    * many reasons, including a dirty update to a pte.  We can catch that
>=20
>=20
> >
> > If not I think you should keep the old/current way?
> >
> > Same for DataTLB Miss/Error
> >
> >>   /* This is the data TLB error on the MPC8xx.  This could be due to
> >>    * many reasons, including a dirty update to a pte.  We can catch=20
that
> >> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> >> index 51ab9e7..4d63c96 100644
> >> --- a/arch/powerpc/mm/fault.c
> >> +++ b/arch/powerpc/mm/fault.c
> >> @@ -526,6 +526,7 @@ void bad=5Fpage=5Ffault(struct pt=5Fregs *regs,=20
unsigned
> > long address, int sig)
> >>         break;
> >>      case 0x400:
> >>      case 0x480:
> >> +   case 0x1300:
> >>         printk(KERN=5FALERT "Unable to handle kernel paging request fo=
r=20
"
> >>            "instruction fetch\n");
> >>         break;
> >> --=20
> >> 2.1.0
> >>
>=20

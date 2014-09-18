Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id EF9DB1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 06:02:17 +1000 (EST)
In-Reply-To: <541B2E45.5070900@c-s.fr>
References: <20140917163657.7737D1AB032@localhost.localdomain>
 <OF3CC96BF2.DF7CB060-ONC1257D57.00533ED7-C1257D57.0053CADF@transmode.se>
 <541B0B66.8030405@c-s.fr>
 <OFB7DFC74D.65FC1C31-ONC1257D57.00632BC3-C1257D57.00640A0B@transmode.se>
 <541B2E45.5070900@c-s.fr>
To: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH v3 03/21] powerpc/8xx: exception InstructionAccess does not
 exist on MPC8xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFFF48B453.8913C6B0-ONC1257D57.006DED24-C1257D57.006E0FCC@transmode.se>
Date: Thu, 18 Sep 2014 22:02:09 +0200
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

christophe leroy <christophe.leroy@c-s.fr> wrote on 2014/09/18 21:11:01:
>=20
>=20
> Le 18/09/2014 20:12, Joakim Tjernlund a =E9crit :
> > leroy christophe <christophe.leroy@c-s.fr> wrote on 2014/09/18=20
18:42:14:
> >
> >> Le 18/09/2014 17:15, Joakim Tjernlund a =E9crit :
> >>> Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/09/17
> > 18:36:57:
> >>>> Exception InstructionAccess does not exist on MPC8xx. No need to
> > branch
> >>> there from somewhere else.
> >>>> Handling can be done directly in InstructionTLBError Exception.
> >>>>
> >>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>        . =3D 0x1200
> >>    DataStoreTLBMiss:
> >> @@ -477,7 +475,11 @@ DataStoreTLBMiss:
> >>     */
> >>        . =3D 0x1300
> >>    InstructionTLBError:
> >> -    b    InstructionAccess
> >> +    EXCEPTION=5FPROLOG
> >> +    mr    r4,r12
> >> +    mr    r5,r9
> >> +    /* 0x400 is InstructionAccess exception, needed by=20
bad=5Fpage=5Ffault()
> > */
> >> +    EXC=5FXFER=5FLITE(0x400, handle=5Fpage=5Ffault)
> > You should have the code in TLBMiss and have the TLBError branch there =

as
> > that is the common case.
> As far as I remember, I tried it already but we don't have enough space=20
> in TLBmiss for that. We can only have 40 instructions.

Do your other optimizations first, then you might have space :)

 Jocke

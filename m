Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B67E92C012D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 03:55:23 +1100 (EST)
In-Reply-To: <525D6CD4.5090403@c-s.fr>
References: <201310111256.r9BCuepM006243@localhost.localdomain>
 <OFF3401910.4A8AA6D0-ONC1257C01.0052FC82-C1257C01.00539C55@transmode.se>
 <525D6CD4.5090403@c-s.fr>
To: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc 8xx: Fixing memory init issue with CONFIG_PIN_TLB
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF6759CC56.EB344A53-ONC1257C05.005CC383-C1257C05.005CF353@transmode.se>
Date: Tue, 15 Oct 2013 18:55:16 +0200
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

leroy christophe <christophe.leroy@c-s.fr> wrote on 2013/10/15 18:27:00:
>=20
>=20
> Le 11/10/2013 17:13, Joakim Tjernlund a =E9crit :
> > "Linuxppc-dev"
> > <linuxppc-dev-bounces+joakim.tjernlund=3Dtransmode.se@lists.ozlabs.org>
> > wrote on 2013/10/11 14:56:40:
> >> Activating CONFIG=5FPIN=5FTLB allows access to the 24 first Mbytes of =

memory
> > at
> >> bootup instead of 8. It is needed for "big" kernels for instance when
> > activating
> >> CONFIG=5FLOCKDEP=5FSUPPORT. This needs to be taken into account in=20
init=5F32
> > too,
> >> otherwise memory allocation soon fails after startup.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>
> >> diff -ur linux-3.11.org/arch/powerpc/kernel/head=5F8xx.S
> > linux-3.11/arch/powerpc/kernel/head=5F8xx.S
> >> --- linux-3.11.org/arch/powerpc/mm/init=5F32.c   2013-09-02
> > 22:46:10.000000000 +0200
> >> +++ linux-3.11/arch/powerpc/mm/init=5F32.c   2013-09-09=20
11:28:54.000000000
> > +0200
> >> @@ -213,7 +213,12 @@
> >>       */
> >>      BUG=5FON(first=5Fmemblock=5Fbase !=3D 0);
> >>
> >> +#ifdef CONFIG=5FPIN=5FTLB
> >> +   /* 8xx can only access 24MB at the moment */
> >> +   memblock=5Fset=5Fcurrent=5Flimit(min=5Ft(u64, first=5Fmemblock=5Fs=
ize,
> > 0x01800000));
> >> +#else
> >>      /* 8xx can only access 8MB at the moment */
> >>      memblock=5Fset=5Fcurrent=5Flimit(min=5Ft(u64, first=5Fmemblock=5F=
size,
> > 0x00800000));
> >> +#endif
> >>   }
> >>   #endif /* CONFIG=5F8xx */
> > hmm, I think you should always map 24 MB (or less if RAM < 24 MB) and=20
do
> > the same
> > in head=5F8xx.S.
> >
> > Or to keep it simple, just always map at least 16 MB here and in
> > head=5F8xx.S, assuming
> > that 16 MB is min RAM for any 8xx system running 3.x kernels.
> Yes we could do a more elaborated modification in the future. However it =


> also has an impact on the boot loader, so I'm not sure we should make it =


> the default without thinking twice.
>=20
> In the meantime, my patch does take into account the existing situation=20
> where you have 8Mb by default and 24Mb when you activate CONFIG=5FPIN=5FT=
LB.
> I see it as a bug fix and I believe we should include it at least in=20
> order to allow including in the stable releases.
>=20
> Do you see any issue with this approach ?

Not at all, so:
Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

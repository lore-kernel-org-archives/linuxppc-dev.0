Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.185])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E0671A0569
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 20:46:44 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joakim Tjernlund' <Joakim.Tjernlund@transmode.se>, "anton@samba.org"
 <anton@samba.org>
Subject: RE: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
Date: Mon, 12 Jan 2015 09:45:21 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAC5628@AcuExch.aculab.com>
References: <1420768591-6831-1-git-send-email-anton@samba.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CAC418D@AcuExch.aculab.com>
 <20150112115505.15d95434@kryten> <1421045727.3055.101.camel@transmode.se>
In-Reply-To: <1421045727.3055.101.camel@transmode.se>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joakim Tjernlund=20
> On Mon, 2015-01-12 at 11:55 +1100, Anton Blanchard wrote:
> > Hi David,
> >
> > > The unrolled loop (deleted) looks excessive.
> > > On a modern cpu with multiple execution units you can usually
> > > manage to get the loop overhead to execute in parallel to the
> > > actual 'work'.
> > > So I suspect that a much simpler 'word at a time' loop will be almost=
 as fast - especially in the
> case where the code isn't
> > > already in the cache and the compare is relatively short.
> >
> > I'm always keen to keep things as simple as possible, but your loop is =
over 50% slower. Once the
> loop hits a steady state you are going to run into front end issues with =
instruction fetch on POWER8.

Interesting, I'm not an expert on ppc scheduling, but on my old x86 Athon 7=
00 (I think
it was that one) a similar loop ran as fast as 'rep movsw'.

> Out of curiosity, does preincrement make any difference(or can gcc do tha=
t for you nowadays)?

It will only change register pressure slightly, and might allow any executi=
on
delays be filled - but that is very processor dependant.
Actually you probably want to do 'a +=3D 2' somewhere to reduce the instruc=
tion count.
Similarly the end condition needs to compare one of the pointers.

Elsewhere (not ppc) I've used (++p)[-1] instead of *p++ to move the increme=
nt
before the load to get better scheduling.

>          a1 =3D *a;
>          b1 =3D *b;
>          while {
>                  a2 =3D *++a;
>                  b2 =3D *++b;
>                  if (a1 !=3D a2)
     That should have been a1 !=3D b1
>                  	break;
>                  a1 =3D *++a;
>                  b1 =3D *++b;
>          } while (a2 !=3D a1);
     and a2 !=3D b2

	David

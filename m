Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id D52AD1A064E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 17:55:36 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "anton@samba.org" <anton@samba.org>
Subject: Re: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
Date: Mon, 12 Jan 2015 06:55:27 +0000
Message-ID: <1421045727.3055.101.camel@transmode.se>
References: <1420768591-6831-1-git-send-email-anton@samba.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CAC418D@AcuExch.aculab.com>
 <20150112115505.15d95434@kryten>
In-Reply-To: <20150112115505.15d95434@kryten>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
 "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2015-01-12 at 11:55 +1100, Anton Blanchard wrote:
> Hi David,
>=20
> > The unrolled loop (deleted) looks excessive.
> > On a modern cpu with multiple execution units you can usually
> > manage to get the loop overhead to execute in parallel to the
> > actual 'work'.
> > So I suspect that a much simpler 'word at a time' loop will be almost a=
s fast - especially in the case where the code isn't
> > already in the cache and the compare is relatively short.
>=20
> I'm always keen to keep things as simple as possible, but your loop is ov=
er 50% slower. Once the loop hits a steady state you are going to run into =
front end issues with instruction fetch on POWER8.
>=20

Out of curiosity, does preincrement make any difference(or can gcc do that =
for you nowadays)?

         a1 =3D *a;
         b1 =3D *b;
         while {
                 a2 =3D *++a;
                 b2 =3D *++b;
                 if (a1 !=3D a2)
                 break;
                 a1 =3D *++a;
                 b1 =3D *++b;
         } while (a2 !=3D a1);

 Jocke

> Anton
>=20
> > Try something based on:
> >         a1 =3D *a++;
> >         b1 =3D *b++;
> >         while {
> >                 a2 =3D *a++;
> >                 b2 =3D *b++;
> >                 if (a1 !=3D a2)
> >                 break;
> >                 a1 =3D *a++;
> >                 b1 =3D *b++;
> >         } while (a2 !=3D a1);
> >=20
> >         David
> >=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list Linuxppc-dev@lists.ozlabs.org https://lists.ozl=
abs.org/listinfo/linuxppc-dev=

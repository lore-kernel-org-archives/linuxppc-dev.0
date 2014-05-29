Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 1E93B1A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 18:37:17 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 17414-04 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 29 May 2014 09:37:07 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joe Perches' <joe@perches.com>, Cody P Schafer <dev@codyps.com>
Subject: RE: [PATCH 11/16] byteorder: provide a linux/byteorder.h with {be,
 le}_to_cpu() and cpu_to_{be, le}() macros
Date: Thu, 29 May 2014 08:36:11 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1724FA5C@AcuExch.aculab.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
 <1401236684-10579-12-git-send-email-dev@codyps.com>
 <063D6719AE5E284EB5DD2968C1650D6D1724EEAF@AcuExch.aculab.com>
 <CAPoQQ-17OHotfbczJvEoq=vAzu_+6-sV3M1ZAhDaQ45wB3NB4A@mail.gmail.com>
 <CAPoQQ-11vW3Q0=LcS-myNZ6hXeYBeu==_prwHJXHvLfkUSmZHQ@mail.gmail.com>
 <1401318025.19335.15.camel@joe-AO725>
In-Reply-To: <1401318025.19335.15.camel@joe-AO725>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches
> On Wed, 2014-05-28 at 17:11 -0500, Cody P Schafer wrote:
> > On Wed, May 28, 2014 at 5:05 PM, Cody P Schafer <dev@codyps.com> wrote:
> > > On Wed, May 28, 2014 at 3:45 AM, David Laight <David.Laight@aculab.co=
m> wrote:
> > >> From: Cody P Schafer
> > >>> Rather manually specifying the size of the integer to be converted,=
 key
> > >>> off of the type size. Reduces duplicate size info and the occurance=
 of
> > >>> certain types of bugs (using the wrong sized conversion).
> > >> ...
> > >>> +#define be_to_cpu(v) \
> > >>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint8_t) , v, \
> > >>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint16_t), be16=
_to_cpu(v), \
> > >>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint32_t), be32=
_to_cpu(v), \
> > >>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint64_t), be64=
_to_cpu(v), \
> > >>> +             (void)0))))
> > >> ...
> > >>
> > >> I'm not at all sure that using the 'size' of the constant will reduc=
e
> > >> the number of bugs - it just introduces a whole new category of bugs=
.
> > >
> > > Certainly, if you mis-size the argument (and thus have missized one o=
f
> > > the variables containing the be value, probably a bug anyhow), there
> > > will be problems.
> > >
> > > I put this interface together because of an actual bug I wrote into
> > > the initial code of the hv_24x7 driver (resized a struct member
> > > without adjusting the be*_to_cpu() sizing).
> > > Having this "auto sizing" macro means I can avoid encoding the size o=
f
> > > a struct field in multiple places.
> >
> > To clarify, the point I'm making here is that this simply cuts out 1
> > more place we can screw up endianness conversion sizing.
>=20
> It does screw up other types when you do things like:
>=20
> 	u8 foo =3D some_function();
>=20
> 	cpu_to_be(foo + 1);
>=20
> the return value is sizeof(int) not u8

And you'd have to be very, very careful with constants:
#define SOME_CONST xxxxx
	cp_to_be(SOME_CONST)
isn't likely to be the right size.

	David

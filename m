Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id E29542C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 22:18:48 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 29203-02 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Feb 2014 11:18:42 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gabriel Paubert' <paubert@iram.es>, James Yang <James.Yang@freescale.com>
Subject: RE: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
Date: Mon, 10 Feb 2014 11:17:38 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6BBCE9@AcuExch.aculab.com>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
In-Reply-To: <20140210110342.GA15806@visitor2.iram.es>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > However, your other solutions are better.
> >
> >
> > > > >
> > > > > mask =3D (FM & 1);
> > > > > mask |=3D (FM << 3) & 0x10;
> > > > > mask |=3D (FM << 6) & 0x100;
> > > > > mask |=3D (FM << 9) & 0x1000;
> > > > > mask |=3D (FM << 12) & 0x10000;
> > > > > mask |=3D (FM << 15) & 0x100000;
> > > > > mask |=3D (FM << 18) & 0x1000000;
> > > > > mask |=3D (FM << 21) & 0x10000000;
> > > > > mask *=3D 15;
> > > > >
> > > > > should do the job, in less code space and without a single branch=
.
...
> > > > > Another way of optomizing this could be:
> > > > >
> > > > > mask =3D (FM & 0x0f) | ((FM << 12) & 0x000f0000);
> > > > > mask =3D (mask & 0x00030003) | ((mask << 6) & 0x03030303);
> > > > > mask =3D (mask & 0x01010101) | ((mask << 3) & 0x10101010);
> > > > > mask *=3D 15;
...
> Ok, if you have measured that method1 is faster than method2, let us go f=
or it.
> I believe method2 would be faster if you had a large out-of-order executi=
on
> window, because more parallelism can be extracted from it, but this is pr=
obably
> only true for high end cores, which do not need FPU emulation in the firs=
t place.

FWIW the second has a long dependency chain on 'mask', whereas the first ca=
n execute
the shift/and in any order and then merge the results.
So on most superscalar cpu, or one with result delays for arithmetic, the f=
irst
is likely to be faster.

	David

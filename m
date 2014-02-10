Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id E4D762C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 23:33:34 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 09043-06 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Feb 2014 12:33:22 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gabriel Paubert' <paubert@iram.es>
Subject: RE: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
Date: Mon, 10 Feb 2014 12:32:18 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6BBDA6@AcuExch.aculab.com>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
 <063D6719AE5E284EB5DD2968C1650D6D0F6BBCE9@AcuExch.aculab.com>
 <20140210122138.GA30356@visitor2.iram.es>
In-Reply-To: <20140210122138.GA30356@visitor2.iram.es>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: James Yang <James.Yang@freescale.com>, Chris Proctor <cproctor@csc.com.au>,
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

> I disagree, perhaps mostly because the compiler is not clever enough, but=
 right
> now the code for solution 1 is (actually I have rewritten the code
> and it reads:
>=20
> 	mask =3D (FM & 1)
> 			| ((FM << 3) & 0x10)
> 			| ((FM << 6) & 0x100)
> 			| ((FM << 9) & 0x1000)
> 			| ((FM << 12) & 0x10000)
> 			| ((FM << 15) & 0x100000)
> 			| ((FM << 18) & 0x1000000)
> 			| ((FM << 21) & 0x10000000);
> to avoid sequence point in case it hampers the compiler)
>=20
> and the output is:
>=20
>         rlwinm 10,3,3,27,27      # D.11621, FM,,
>         rlwinm 9,3,6,23,23       # D.11621, FM,,
>         or 9,10,9        #, D.11621, D.11621, D.11621
>         rlwinm 10,3,0,31,31      # D.11621, FM,
>         or 9,9,10        #, D.11621, D.11621, D.11621
>         rlwinm 10,3,9,19,19      # D.11621, FM,,
>         or 9,9,10        #, D.11621, D.11621, D.11621
>         rlwinm 10,3,12,15,15     # D.11621, FM,,
>         or 9,9,10        #, D.11621, D.11621, D.11621
>         rlwinm 10,3,15,11,11     # D.11621, FM,,
>         or 9,9,10        #, D.11621, D.11621, D.11621
>         rlwinm 10,3,18,7,7       # D.11621, FM,,
>         or 9,9,10        #, D.11621, D.11621, D.11621
>         rlwinm 3,3,21,3,3        # D.11621, FM,,
>         or 9,9,3         #, mask, D.11621, D.11621
>         mulli 9,9,15     # mask, mask,
>=20
> see that r9 is used 7 times as both input and output operand, plus
> once for rlwinm. This gives a dependency length of 8 at least.
>=20
> In the other case (I've deleted the code) the dependency length
> was significantly shorter. In any case that one is fewer instructions,
> which is good for occasional use.

Hmmm... I hand-counted a dependency length of 8 for the other version.
Maybe there are some ppc instructions that reduce it.

Stupid compiler :-)
Trouble is, I bet that even if you code it as:
 	mask1 =3D (FM & 1) | ((FM << 3) & 0x10);
	mask2 =3D ((FM << 6) & 0x100) | ((FM << 9) & 0x1000);
	mask3 =3D ((FM << 12) & 0x10000) | ((FM << 15) & 0x100000);
	mask4 =3D ((FM << 18) & 0x1000000) | ((FM << 21) & 0x10000000);
	mask1 |=3D mask2;
	mask3 |=3D mask4;
	mask =3D mask1 | mask3;
the compiler will 'optimise' it to the above before code generation.
If it doesn't adding () to pair the | might be enough.
Then a new version of the compiler will change the behaviour again.

	David

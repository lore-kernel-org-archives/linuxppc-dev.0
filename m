Return-Path: <heukelum@fastmail.fm>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by ozlabs.org (Postfix) with ESMTP id F03CCDE090
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 00:19:38 +1000 (EST)
Message-Id: <1208787574.7995.1249020641@webmail.messagingengine.com>
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Gabriel Paubert" <paubert@iram.es>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <20080421191231.41a34aef.sfr@canb.auug.org.au>
	<20080421095102.GB1666@elte.hu>
	<1208776790.4613.1248992953@webmail.messagingengine.com>
	<18444.34002.74202.564600@cargo.ozlabs.ibm.com>
	<1208783233.25773.1249008469@webmail.messagingengine.com>
	<20080421133606.GA27304@iram.es>
Subject: Re: linux-next: x86-latest/powerpc-next merge conflict
In-Reply-To: <20080421133606.GA27304@iram.es>
Date: Mon, 21 Apr 2008 16:19:34 +0200
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Apr 2008 15:36:06 +0200, "Gabriel Paubert" <paubert@iram.es>
said:
> On Mon, Apr 21, 2008 at 03:07:13PM +0200, Alexander van Heukelum wrote:
> > On Mon, 21 Apr 2008 22:13:06 +1000, "Paul Mackerras" <paulus@samba.org>
> > said:
> > > Alexander van Heukelum writes:
> > > > Powerpc would pick up an optimized version via this chain: generic =
fls64
> > > > ->
> > > > powerpc __fls --> __ilog2 --> asm (PPC_CNTLZL "%0,%1" : "=3Dr" (lz)=
 : "r"
> > > > (x)).
> > >=20
> > > Why wouldn't powerpc continue to use the fls64 that I have in there
> > > now?
> >=20
> > In Linus' tree that would be the generic one that uses (the 32-bit)
> > fls():
> >=20
> > static inline int fls64(__u64 x)
> > {
> >         __u32 h =3D x >> 32;
> >         if (h)
> >                 return fls(h) + 32;
> >         return fls(x);
> > }
> >=20
> > > > However, the generic version of fls64 first tests the argument for =
zero.
> > > > From
> > > > your code I derive that the count-leading-zeroes instruction for
> > > > argument zero
> > > > is defined as cntlzl(0) =3D=3D BITS_PER_LONG.
> > >=20
> > > That is correct.  If the argument is 0 then all of the zero bits are
> > > leading zeroes. :)
> >=20
> > So... for 64-bit powerpc it makes sense to have its own implementation
> > and ignore the (improved) generic one and for 32-bit powerpc the generic
> > implementation of fls64 is fine. The current situation in linux-next
> > seems
> > optimal to me.
>=20
>=20
> Not so sure, the optimal version of fls64 for 32 bit PPC seems to be:
>=20
> 	cntlzw	ch,h ; ch =3D fls32(h) where h =3D x>>32
> 	cntlzw	cl,l ; cl =3D fls32(l) where l =3D (__u32)x
> 	srwi	t1,ch,5
> 	neg	t1,t1	; t1 =3D (h=3D=3D0) ? -1 : 0
> 	and	cl,t1,cl ; cl =3D (h=3D=3D0) ? cl : 0
> 	add	result,ch,cl
>=20
> That's only 6 instructions without any branch, although the dependency=20
> chain is 5 instructions long. Good luck getting the compiler to=20
> generate something as compact as this.

I should not have said the magic word optimal, I guess ;). The code
you show would fit nicely as an arch-specific optimized version of
fls64 for 32-bit powerpc in include/arch-powerpc/bitops.h.

Greetings,
    Alexander

(who is not going to write and test a patch with
powerpc inline assembly soon. srwi?)

> Don't worry about the number of cntlzw, it's one clock on all 32 bit=20
> PPC processors I know, some may even be able to perform 2 or 3 cntlzw=20
> per clock.
>=20
> 	Regards,
> 	Gabriel
>=20
--=20
  Alexander van Heukelum
  heukelum@fastmail.fm

--=20
http://www.fastmail.fm - Same, same, but different=85

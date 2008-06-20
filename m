Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC 3/3] powerpc: copy_4K_page tweaked for Cell
Date: Fri, 20 Jun 2008 12:25:02 +1000
References: <200806191754.17289.markn@au1.ibm.com>
	<200806192328.51423.arnd@arndb.de>
In-Reply-To: <200806192328.51423.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806201225.02753.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	cbe-oss-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Jun 2008 07:28:50 am Arnd Bergmann wrote:
> On Thursday 19 June 2008, Mark Nelson wrote:
> > =A0=A0=A0=A0=A0=A0=A0=A0.align =A07
> > _GLOBAL(copy_4K_page)
> > =A0=A0=A0=A0=A0=A0=A0=A0dcbt=A0=A0=A0=A00,r4=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0/* Prefetch ONE SRC cacheline */
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0addi=A0=A0=A0=A0r6,r3,-8=A0=A0=A0=A0=A0=A0=A0=
=A0/* prepare for stdu */
> > =A0=A0=A0=A0=A0=A0=A0=A0addi=A0=A0=A0=A0r4,r4,-8=A0=A0=A0=A0=A0=A0=A0=
=A0/* prepare for ldu */
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0li=A0=A0=A0=A0=A0=A0r10,32=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0/* copy 32 cache lines for a 4K page */
> > =A0=A0=A0=A0=A0=A0=A0=A0li=A0=A0=A0=A0=A0=A0r12,128+8=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0/* prefetch distance*/
>=20
> Since you have a loop here anyway instead of the fully unrolled
> code, why not provide a copy_64K_page function as well, jumping in
> here?

That is a good idea. What effect will that have on how the code
patching will work?

>=20
> The inline 64k copy_page function otherwise just adds code size,
> as well as being a tiny bit slower. It may even be good to
> have an out-of-line copy_64K_page for the regular code, just
> calling copy_4K_page repeatedly.

Doing that sounds like it'll make the code patching easier.

Thanks!

Mark

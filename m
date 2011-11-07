Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id BB5A41007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 02:28:05 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 04266-03 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  7 Nov 2011 15:28:01 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
Date: Mon, 7 Nov 2011 15:26:26 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEAA@saturn3.aculab.com>
In-Reply-To: <1320678819.2750.15.camel@treble>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Josh Poimboeuf" <jpoimboe@linux.vnet.ibm.com>,
 "Suzuki Poulose" <suzuki@in.ibm.com>
Cc: Nathan Miller <nathanm2@us.ibm.com>, Josh Poimboeuf <jpoimboe@us.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> On Fri, 2011-11-04 at 14:06 +0530, Suzuki Poulose wrote:
> > On 11/03/11 05:06, Josh Poimboeuf wrote:
> > > On Tue, 2011-10-25 at 17:23 +0530, Suzuki K. Poulose wrote:
> > > @@ -137,6 +137,9 @@ get_type:
> > >   	lwz	r0, 8(r9)	/* r_addend */
> > >   	add	r0, r0, r3	/* final addend */
> > >   	stwx	r0, r4, r7	/* memory[r4+r7]) =3D (u32)r0 */
> > > +	dcbst	r4,r7		/* flush dcache line to memory */
> > > +	sync			/* wait for flush to complete */
> > > +	icbi	r4,r7		/* invalidate icache line */
> >=20
> > Doing it this way has two drawbacks :
> >=20
> > 1) Placing it here in relocate would do the flushing for=20
> each and every update.
>=20
> I agree.  My kernel had around 80,000 relocations, which means 80,000
> d-cache line flushes (for a 32k d-cache) and 80,000 i-cache line
> invalidates (for a 32k i-cache).  Which is obviously a little=20
> overkill.
> Although I didn't notice a performance hit during boot.

The I-cache invalidates shouldn't be needed, the un-relocated
code can't be in the I-cache (on the grounds that executing
it would crash the system).
A single sync at the end is probably enough as well.
I guess it is possible for the cpu to prefetch/preload
into the i-cache through the jump into the relocated code?
So maybe a full i-cache invalidate right at the end? (or
a jump indirect? - which is probably there anyway)

The d-cache will need some kind of flush, since the modified
lines have to be written out, the only time it generates
additional memeory cycles are if there are two (or more)
reloations in the same d-cache line. Otherwise the early
write-back might help!

	David

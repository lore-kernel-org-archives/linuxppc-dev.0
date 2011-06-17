Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id C58A4B6FA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 19:04:42 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 18266-07 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 10:04:31 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/3] powerpc: POWER7 optimised memcpy using VMX
Date: Fri, 17 Jun 2011 10:02:55 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ADA4@saturn3.aculab.com>
In-Reply-To: <20110617071222.GA6878@iram.es>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Gabriel Paubert" <paubert@iram.es>,
	"Anton Blanchard" <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> On Fri, Jun 17, 2011 at 02:54:00PM +1000, Anton Blanchard wrote:
> > Implement a POWER7 optimised memcpy using VMX. For large aligned
> > copies this new loop is over 10% faster and for large unaligned
> > copies it is over 200% faster.
...

> BTW: do you have any statistics on the size distribution
> of memcpy memcpy_to_from_usr?
>=20
> My gut feeling is that the intermediate case is the most
> important, and the short case the less critical (drowned
> in overhead's noise) but that's the kind of things on which
> I've often been wrong.

My thoughts are certainly that the code is too big, and that
the 'cold cache' version and possibly the effects of increasing
the size of the working set (ie displacing other code) may
be significant in real life.

For memcpy() the 'short' case will happen surprisingly often,
I suspect the fixed costs for the short case may dominate some
real workloads.

I'm not sure the speed of misaligned copies matters enough
to take the hit of the alignment test!

Of course, I don't actually remember doing any instrumentation
of this, but I have changed i386/amd64 memcpy (not linux/glibc)
to avoid the 'rep movsb' used for the trailing bytes (copy
the last 'word' first) - the setup cost for 'rep movsb' is
over 40 clocks on netburst P4!
(It is possible to get amd64 to copy data as fast as the
'rep movd', but the setup times are longer. And very recent
Intel cpus contain hardware acceleration for aligned and
misaligned 'rep movsd' - so trying anything clever isn't good.)
I do realise thise doesn't directly apply to ppc :-)

	David

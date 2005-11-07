Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 36AB568684
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 02:44:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 7 Nov 2005 16:44:32 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5B5@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org,
	Dan Malek <dan@embeddedalley.com>, gtolstolytkin@ru.mvista.com
Subject: RE: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20
> Joakim!
>=20
> On Mon, Nov 07, 2005 at 03:32:52PM +0100, Joakim Tjernlund wrote:
> > Hi Marcelo
> >=20
> > [SNIP]=20
> > > The root of the problem are the changes against the 8xx TLB=20
> > > handlers introduced
> > > during v2.6. What happens is the TLBMiss handlers load the=20
> > > zeroed pte into
> > > the TLB, causing the TLBError handler to be invoked (thats=20
> > > two TLB faults per=20
> > > pagefault), which then jumps to the generic MM code to=20
> setup the pte.
> > >=20
> > > The bug is that the zeroed TLB is not invalidated (the same reason
> > > for the "dcbst" misbehaviour), resulting in infinite=20
> TLBError faults.
> > >=20
> > > Dan, I wonder why we just don't go back to v2.4 behaviour.
> >=20
> > This is one reason why it is the way it is:
> >=20
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html
> > This details are little fuzzy ATM, but I think the reason for the
> > current
> > impl. was only that it was less intrusive to impl.
>=20
> Ah, I see. I wonder if the bug is processor specific: we=20
> don't have such
> changes in our v2.4 tree and never experienced such problem.
>=20
> It should be pretty easy to hit it right? (instruction=20
> pagefaults should
> fail).

No, its pretty hard to trigger it. Read the all mails on the subject to
see why.
The one or two exception approach doesn't matter performancewise(at
least for ITLB exceptions)
I think.

>=20
> Grigori, Tom, can you enlight us about the issue on the URL above. How
> can it be triggered?
>=20
>=20
>=20
>=20

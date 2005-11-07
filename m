Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id E1D8B6867C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 05:14:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 7 Nov 2005 19:14:15 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5C5@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org, Dan Malek <dan@embeddedalley.com>,
	gtolstolytkin@ru.mvista.com
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

> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]=20
> Sent: 07 November 2005 16:52
> To: Marcelo Tosatti
> Cc: Joakim Tjernlund; Pantelis Antoniou; Dan Malek;=20
> linuxppc-embedded@ozlabs.org; gtolstolytkin@ru.mvista.com
> Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
>=20
> On Mon, Nov 07, 2005 at 08:16:18AM -0200, Marcelo Tosatti wrote:
> > Joakim!
> >=20
> > On Mon, Nov 07, 2005 at 03:32:52PM +0100, Joakim Tjernlund wrote:
> > > Hi Marcelo
> > >=20
> > > [SNIP]=20
> > > > The root of the problem are the changes against the 8xx TLB=20
> > > > handlers introduced
> > > > during v2.6. What happens is the TLBMiss handlers load the=20
> > > > zeroed pte into
> > > > the TLB, causing the TLBError handler to be invoked (thats=20
> > > > two TLB faults per=20
> > > > pagefault), which then jumps to the generic MM code to=20
> setup the pte.
> > > >=20
> > > > The bug is that the zeroed TLB is not invalidated (the=20
> same reason
> > > > for the "dcbst" misbehaviour), resulting in infinite=20
> TLBError faults.
> > > >=20
> > > > Dan, I wonder why we just don't go back to v2.4 behaviour.
> > >=20
> > > This is one reason why it is the way it is:
> > >=20
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html
> > > This details are little fuzzy ATM, but I think the reason for the
> > > current
> > > impl. was only that it was less intrusive to impl.
> >=20
> > Ah, I see. I wonder if the bug is processor specific: we=20
> don't have such
> > changes in our v2.4 tree and never experienced such problem.
> >=20
> > It should be pretty easy to hit it right? (instruction=20
> pagefaults should
> > fail).
> >=20
> > Grigori, Tom, can you enlight us about the issue on the URL=20
> above. How
> > can it be triggered?
>=20
> So after looking at the code in 2.6.14 and current git, I think the
> above URL isn't relevant, unless there was a change I missed (which
> could totally be possible) that reverted the patch there and=20
> fixed that
> issue in a different manner.  But since I didn't figure that=20
> out until I
> had finished researching it again:

I wasn't clear enough. What I meant was that the above patch made me
think and
the result was that I came up with a simpler fix, the "two exception"
fix that
is in current kernels. See
http://linux.bkbits.net:8080/linux-2.6/diffs/arch/ppc/kernel/head_8xx.S@
1.19?nav=3Dindex.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/kernel|his=
t
/arch/ppc/kernel/head_8xx.S
It appears this fix has some other issues :(

How do the other ppc arches do? I am guessing that they don't double
fault, but bails
out to do_page_fault from the TLB Miss handler, like 8xx used to do.

>=20
> Switching hats for a minute, this came from a bug a customer of
> MontaVista found, so I can't give out the testcase :(
>=20
> To repeat what Joakim said back then:
> "I think I have figured this out. The first TLB misses that happen at
> app startup is Data TLB misses. These will then hit the NULL L1 entry
> and end up in do_page_fault() which will populate the L1=20
> entry. But when
> you have a very large app that spans more than one L1 entry (16 MB I
> think) it may happen that you will have I-TLB Miss first one of the L1
> entrys which will make the I-TLB handler bail out to=20
> do_page_fault() and
> the app craches(SEGV)."

This still stands I think.

>=20
> Looking at the patch again, what I don't see is why I talk=20
> about fudging
> I-TLB Miss at 0x400 when it's I-TLB Error we fudge at being there, but
> then get hung up that there can be a slight diff between the=20
> two ("This
> is because we check bit 4 of SRR1 in both cases, but in the case of an
> I-TLB Miss, this bit is always set, and it only indicates a protection
> fault on an I-TLB Error.") so instead of 0x1300 jumping to the handler
> at 0x400, we treat it like a regular exception so we know=20
> where we came
> from, and perhaps missed fixing a case somewhere?

Didn't look into this part of your patch, sorry.

 Jocke

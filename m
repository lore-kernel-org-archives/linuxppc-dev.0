Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 73283686A4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 05:37:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 7 Nov 2005 19:37:45 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5C6@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddedalley.com>, gtolstolytkin@ru.mvista.com,
	linuxppc-embedded@ozlabs.org
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

 >=20
> On Mon, Nov 07, 2005 at 07:14:15PM +0100, Joakim Tjernlund wrote:
> > > -----Original Message-----
> > > From: Tom Rini [mailto:trini@kernel.crashing.org]=20
> > > Sent: 07 November 2005 16:52
> > > To: Marcelo Tosatti
> > > Cc: Joakim Tjernlund; Pantelis Antoniou; Dan Malek;=20
> > > linuxppc-embedded@ozlabs.org; gtolstolytkin@ru.mvista.com
> > > Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
> > >=20
> > > On Mon, Nov 07, 2005 at 08:16:18AM -0200, Marcelo Tosatti wrote:
> > > > Joakim!
> > > >=20
> > > > On Mon, Nov 07, 2005 at 03:32:52PM +0100, Joakim=20
> Tjernlund wrote:
> > > > > Hi Marcelo
> > > > >=20
> > > > > [SNIP]=20
> > > > > > The root of the problem are the changes against the 8xx TLB=20
> > > > > > handlers introduced
> > > > > > during v2.6. What happens is the TLBMiss handlers load the=20
> > > > > > zeroed pte into
> > > > > > the TLB, causing the TLBError handler to be invoked (thats=20
> > > > > > two TLB faults per=20
> > > > > > pagefault), which then jumps to the generic MM code to=20
> > > setup the pte.
> > > > > >=20
> > > > > > The bug is that the zeroed TLB is not invalidated (the=20
> > > same reason
> > > > > > for the "dcbst" misbehaviour), resulting in infinite=20
> > > TLBError faults.
> > > > > >=20
> > > > > > Dan, I wonder why we just don't go back to v2.4 behaviour.
> > > > >=20
> > > > > This is one reason why it is the way it is:
> > > > >=20
> > >=20
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html
> > > > > This details are little fuzzy ATM, but I think the=20
> reason for the
> > > > > current
> > > > > impl. was only that it was less intrusive to impl.
> > > >=20
> > > > Ah, I see. I wonder if the bug is processor specific: we=20
> > > don't have such
> > > > changes in our v2.4 tree and never experienced such problem.
> > > >=20
> > > > It should be pretty easy to hit it right? (instruction=20
> > > pagefaults should
> > > > fail).
> > > >=20
> > > > Grigori, Tom, can you enlight us about the issue on the URL=20
> > > above. How
> > > > can it be triggered?
> > >=20
> > > So after looking at the code in 2.6.14 and current git, I=20
> think the
> > > above URL isn't relevant, unless there was a change I=20
> missed (which
> > > could totally be possible) that reverted the patch there and=20
> > > fixed that
> > > issue in a different manner.  But since I didn't figure that=20
> > > out until I
> > > had finished researching it again:
> >=20
> > I wasn't clear enough. What I meant was that the above patch made me
> > think and
> > the result was that I came up with a simpler fix, the "two=20
> exception"
> > fix that
> > is in current kernels. See
> >=20
> http://linux.bkbits.net:8080/linux-2.6/diffs/arch/ppc/kernel/h
> ead_8xx.S@
> >=20
> 1.19?nav=3Dindex.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/k
> ernel|hist
> > /arch/ppc/kernel/head_8xx.S
> > It appears this fix has some other issues :(
> >=20
> > How do the other ppc arches do? I am guessing that they don't double
> > fault, but bails
> > out to do_page_fault from the TLB Miss handler, like 8xx used to do.
>=20
> Assuming Dan doesn't come up with a more simple & better fix, maybe we
> should go back to the original patch I made?

That was what I was thinking too(or some variation of your patch)
I wonder if that would solve the misbehaving dcbst problem Marcelo found
some time ago too?

 Jocke

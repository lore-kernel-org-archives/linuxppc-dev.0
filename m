Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A7E72BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 01:04:08 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Date: Fri, 14 Jan 2005 15:03:52 +0100
Message-ID: <JPEALJAFNGDDLOPNDIEEAECDDAAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050113151646.GZ3391@smtp.west.cox.net>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] Handle I-TLB Error and Miss separately on 8xx
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
> From: Tom Rini [mailto:trini@kernel.crashing.org]
> On Wed, Jan 12, 2005 at 08:15:08AM -0700, Tom Rini wrote:
> > On Wed, Jan 12, 2005 at 03:17:11PM +0100, Joakim Tjernlund wrote:
> > > > On Wed, Jan 12, 2005 at 08:53:17AM +0100, Joakim Tjernlund wrote:
> [snip]
> > > > > Patch looks good to me, but I want to ask when this error
> > > > > can be triggered in practice?
> > > > 
> > > > It is possible to see this in the real world, as we (<hat=mvista>) found
> > > > this with a customers app.
> > > 
> > > hmm, this app must have been doing something pretty special. Any idea what
> > > caused it?
> > 
> > Only vaugely.  I'll poke the folks who did the investigation to see if
> > they recall (the app is quite large) and follow up with details, I hope.
> 
> First, we couldn't get this issue to happen w/ anything but the custom
> app.  It would generate a lot of I-TLB Error exceptions, with bit 1 of
> SRR1 set, and these went fine, the I-TLB got updated, and execution
> continued.  But then at some point, and we aren't sure why exactly, an
> 0x1100 is generated, and we crash.  We don't know what went and caused
> an 0x1100 to be generated instead of an 0x1300 (my wild-ass-guess is the
> code jumped very very far ahead).

To me this looks like you entered the I-TLB Miss handler with a NULL pte which
is something that never happens in my system, don't know why this is so but I am
guessing that the kernel populates all instruction pte's at exec time. On the
other hand I don't understand why there are so many I-TLB errors, is that normal?

Does the app modify its own code or construct a code trampoline which it jumps to? Not
sure how that would be handled by the kernel w.r.t NULL pte's

 Jocke

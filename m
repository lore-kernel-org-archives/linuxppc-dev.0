Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 9D5F32BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 04:47:37 +1100 (EST)
Date: Fri, 14 Jan 2005 10:47:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Message-ID: <20050114174734.GB28724@smtp.west.cox.net>
References: <JPEALJAFNGDDLOPNDIEEAECDDAAA.joakim.tjernlund@lumentis.se>
	<JPEALJAFNGDDLOPNDIEEGECEDAAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <JPEALJAFNGDDLOPNDIEEGECEDAAA.joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jan 14, 2005 at 06:38:35PM +0100, Joakim Tjernlund wrote:
> > > -----Original Message-----
> > > From: Tom Rini [mailto:trini@kernel.crashing.org]
> > > On Wed, Jan 12, 2005 at 08:15:08AM -0700, Tom Rini wrote:
> > > > On Wed, Jan 12, 2005 at 03:17:11PM +0100, Joakim Tjernlund wrote:
> > > > > > On Wed, Jan 12, 2005 at 08:53:17AM +0100, Joakim Tjernlund wrote:
> > > [snip]
> > > > > > > Patch looks good to me, but I want to ask when this error
> > > > > > > can be triggered in practice?
> > > > > > 
> > > > > > It is possible to see this in the real world, as we (<hat=mvista>) found
> > > > > > this with a customers app.
> > > > > 
> > > > > hmm, this app must have been doing something pretty special. Any idea what
> > > > > caused it?
> > > > 
> > > > Only vaugely.  I'll poke the folks who did the investigation to see if
> > > > they recall (the app is quite large) and follow up with details, I hope.
> > > 
> > > First, we couldn't get this issue to happen w/ anything but the custom
> > > app.  It would generate a lot of I-TLB Error exceptions, with bit 1 of
> > > SRR1 set, and these went fine, the I-TLB got updated, and execution
> > > continued.  But then at some point, and we aren't sure why exactly, an
> > > 0x1100 is generated, and we crash.  We don't know what went and caused
> > > an 0x1100 to be generated instead of an 0x1300 (my wild-ass-guess is the
> > > code jumped very very far ahead).
> > 
> > To me this looks like you entered the I-TLB Miss handler with a NULL pte which
> > is something that never happens in my system, don't know why this is so but I am
> > guessing that the kernel populates all instruction pte's at exec time. On the
> > other hand I don't understand why there are so many I-TLB errors, is that normal?
> > 
> > Does the app modify its own code or construct a code trampoline which it jumps to? Not
> > sure how that would be handled by the kernel w.r.t NULL pte's
> > 
> >  Jocke
> 
> I think I have figured this out. The first TLB misses that happen at app startup is Data
> TLB misses. These will then hit the NULL L1 entry and end up in do_page_fault() which
> will populate the L1 entry. But when you have a very large app that spans more than one
> L1 entry (16 MB I think) it may happen that you will have I-TLB Miss first one of the
> L1 entrys which will make the I-TLB handler bail out to do_page_fault() and the app
> craches(SEGV).

Yes, that sounds like it.  Thanks.

> Your patch will fix this. 
> I havn't seen it go in yet, will you submit the patch to Linus/Marcelo?

I was hoping Marcelo would pick this up since I thought he was on the
list.  I'll re-poke him.  For 2.6, the app in question crashes
differently, prior to hitting this bug, but I do want to get it pushed
out.  I've just been swamped lately.

-- 
Tom Rini
http://gate.crashing.org/~trini/

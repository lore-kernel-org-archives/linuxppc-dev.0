Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id B49F42BF16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 02:16:48 +1100 (EST)
Date: Thu, 13 Jan 2005 08:16:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Message-ID: <20050113151646.GZ3391@smtp.west.cox.net>
References: <20050112140630.GP3391@smtp.west.cox.net>
	<JPEALJAFNGDDLOPNDIEEAEADDAAA.joakim.tjernlund@lumentis.se>
	<20050112151508.GS3391@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050112151508.GS3391@smtp.west.cox.net>
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

On Wed, Jan 12, 2005 at 08:15:08AM -0700, Tom Rini wrote:
> On Wed, Jan 12, 2005 at 03:17:11PM +0100, Joakim Tjernlund wrote:
> > > On Wed, Jan 12, 2005 at 08:53:17AM +0100, Joakim Tjernlund wrote:
[snip]
> > > > Patch looks good to me, but I want to ask when this error
> > > > can be triggered in practice?
> > > 
> > > It is possible to see this in the real world, as we (<hat=mvista>) found
> > > this with a customers app.
> > 
> > hmm, this app must have been doing something pretty special. Any idea what
> > caused it?
> 
> Only vaugely.  I'll poke the folks who did the investigation to see if
> they recall (the app is quite large) and follow up with details, I hope.

First, we couldn't get this issue to happen w/ anything but the custom
app.  It would generate a lot of I-TLB Error exceptions, with bit 1 of
SRR1 set, and these went fine, the I-TLB got updated, and execution
continued.  But then at some point, and we aren't sure why exactly, an
0x1100 is generated, and we crash.  We don't know what went and caused
an 0x1100 to be generated instead of an 0x1300 (my wild-ass-guess is the
code jumped very very far ahead).

-- 
Tom Rini
http://gate.crashing.org/~trini/

Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 020472BF23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 02:15:09 +1100 (EST)
Date: Wed, 12 Jan 2005 08:15:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Message-ID: <20050112151508.GS3391@smtp.west.cox.net>
References: <20050112140630.GP3391@smtp.west.cox.net>
	<JPEALJAFNGDDLOPNDIEEAEADDAAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <JPEALJAFNGDDLOPNDIEEAEADDAAA.joakim.tjernlund@lumentis.se>
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

On Wed, Jan 12, 2005 at 03:17:11PM +0100, Joakim Tjernlund wrote:
> > On Wed, Jan 12, 2005 at 08:53:17AM +0100, Joakim Tjernlund wrote:
> > > > As the code stands currently, there is a bug in the 2.4 and 2.6 handling
> > > > of I-TLB Miss and Error exceptions on 8xx.  The problem is that since we
> > > > treat both of them as the same exception when we hit do_page_fault,
> > > > there is a case where we can incorrectly find that a protection fault
> > > > has occured, when it hasn't.  This is because we check bit 4 of SRR1 in
> > > > both cases, but in the case of an I-TLB Miss, this bit is always set,
> > > > and it only indicates a protection fault on an I-TLB Error.
> > > 
> > > Patch looks good to me, but I want to ask when this error
> > > can be triggered in practice?
> > 
> > It is possible to see this in the real world, as we (<hat=mvista>) found
> > this with a customers app.
> 
> hmm, this app must have been doing something pretty special. Any idea what
> caused it?

Only vaugely.  I'll poke the folks who did the investigation to see if
they recall (the app is quite large) and follow up with details, I hope.

-- 
Tom Rini
http://gate.crashing.org/~trini/

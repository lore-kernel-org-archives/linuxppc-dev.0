Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id B72182BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Oct 2004 00:22:11 +1000 (EST)
Date: Fri, 29 Oct 2004 07:22:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20041029142209.GN2097@smtp.west.cox.net>
References: <JPEALJAFNGDDLOPNDIEEEEMOCNAA.joakim.tjernlund@lumentis.se>
	<41823D68.1090100@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41823D68.1090100@intracom.gr>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 29, 2004 at 03:54:00PM +0300, Pantelis Antoniou wrote:
> Joakim Tjernlund wrote:
> 
> >>Joakim Tjernlund wrote:
> >>
> >>
> >>>>On Thu, Oct 14, 2004 at 04:53:49PM +0200, Joakim Tjernlund wrote:
> >>>>
> >>>>  
> >>>>
> >>>>
> >>>>>Is it not time to merge 8xx from linuxppc-2.5 into Linus tree?
> >>>>>
> >>>>>I know the 8xx is not fully functional yet but this isn't done
> >>>>>soon I think it won't happen at all. The 8xx arch can be made to 
> >>>>>depend on BROKEN in Linus tree to make it clear that it isn't
> >>>>>working properly yet.
> >>>>>    
> >>>>>
> >>>>>
> >>>>I've been the hard-ass about holding back on moving 8xx forward.  Once
> >>>>2.6.9 finally comes out (assuming and hoping that Linus really intends
> >>>>to do a release and not -rc5), I'll start moving stuff over and make it
> >>>>depend on BROKEN hopefully in time for 2.6.10-rc1.
> >>>
> >>I'm currently battling to make 2.6.10-rc1 work the same way it used do.
> >>
> >>But something changed in slab management and the kmallocs in request_irq
> >>called by init_IRQ fails.
> >>
> >
> >hmm, I think I saw something about that in the www log for Linus kernel. 
> >It is offline so
> >I can't check now.
> >
> >The www I/F for both Linus tree(http://linux.bitkeeper.com/) and the ppc 
> >tree(http://ppc.bitkeeper.com/)
> >are offline alot. Anyone who knows whats going on?

BitMover has been moving and upgrading the machines of late, I think
this is done now.

> Found the bug.
> 
> IRQ code is now common for all arches, but ppc used a special
> irq_kmalloc routine, since request irq was called very early.
> 
> The generic code just calls straight kmalloc, which obviously craps out 
> when too early.
> 
> Lets see what can I do to fix it...
> 
> BTW I'm curious if any embedded PPC actually works on 2.6.10...

In 2.6.10-rc1 release? No.  In linuxppc-2.5? Now, yes.  The changes came
from Randy Vinson, to make request_irq() / openpic_hookup_cascade()
calls become arch_initcalls() which fixed at least some platforms.  I
would guess 8xx will need something similar.

-- 
Tom Rini
http://gate.crashing.org/~trini/

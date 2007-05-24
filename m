Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 17E25DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 03:10:25 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Detlev Zundel'" <dzu@denx.de>
Subject: RE: Problems in 2.6 memory management on 8xx
Date: Thu, 24 May 2007 19:10:11 +0200
Message-ID: <007601c79e26$639bf6e0$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <m2hcq2b26n.fsf@sowhat.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Detlev Zundel [mailto:dzu@denx.de] 
> Sent: den 24 maj 2007 18:46
> To: joakim.tjernlund@transmode.se
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: Problems in 2.6 memory management on 8xx
> 
> Hi Joakim,
> 
> > On Thu, 2007-05-24 at 17:23 +0200, Joakim Tjernlund wrote:
> >> On Thu, 2007-05-24 at 15:07 +0200, Detlev Zundel wrote:
> >> > Hi,
> >> > 
> >> > working on a 2.6.16 kernel on a 870 CPU, I ran into this strange
> >> > behaviour exemplified by the simple attached demo 
> program.  An icbi
> >> > from userspace on an address that is mapped only lazily 
> gets into an -
> >> > though interruptible - loop. Locking the icbi target in 
> question with
> >> > mlock circumvents this problem.
> >> 
> >> 8xx is buggy w.r.t cache instructions. They do not update the
> >> DAR register in the TLB miss/TLB error handlers.
> >> The TLB miss handler does not use the DAR reg but the TLB error
> >> handler do. Thats why it works when you mlock the memory.
> >> 
> >> This bug isn't documented but Freescale has confirmed it.
> >> You can search the archives some years back for more info.
> >> 
> >>  Jocke
> >
> > BTW, it is possible to workaround this problem in the kernel by
> > tagging DAR with an impossible value and compare DAR against it
> > in the DTLB Error handler. If a match, then do a instruction decode
> > to get the regs involved and calculate the faulting address.
> >
> > I did this several years ago for 2.4 in assembler and posted
> > it, but it was rejected.
> > One should bail out to handle_page_fault and do the
> > calculations there instead(less likely to break that way)
> >
> > Found one version of the patch here:
> > http://patchwork.ozlabs.org/linuxppc/patch?id=1307
> 
> Thanks for shedding some light on this problem.  I already found the
> patch you refer to and also wondered why it was never accepted.  Was
> there a technical reason or did it simply slip everybodys attention?

Can't really rember the details, but I think Dan Malek didn't
like it because it was hard to maintain and usally one can avoid
the problem.
I have been using that patch on our 860/862 boards for years now
and it works fine.

 Jocke

Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id E35B0DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 02:23:56 +1000 (EST)
Subject: Re: Problems in 2.6 memory management on 8xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Detlev Zundel <dzu@denx.de>
In-Reply-To: <1180020200.1468.51.camel@gentoo-jocke.transmode.se>
References: <m2fy5mcqut.fsf@sowhat.denx.de>
	<1180020200.1468.51.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Thu, 24 May 2007 18:23:54 +0200
Message-Id: <1180023834.1468.64.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-24 at 17:23 +0200, Joakim Tjernlund wrote:
> On Thu, 2007-05-24 at 15:07 +0200, Detlev Zundel wrote:
> > Hi,
> > 
> > working on a 2.6.16 kernel on a 870 CPU, I ran into this strange
> > behaviour exemplified by the simple attached demo program.  An icbi
> > from userspace on an address that is mapped only lazily gets into an -
> > though interruptible - loop. Locking the icbi target in question with
> > mlock circumvents this problem.
> 
> 8xx is buggy w.r.t cache instructions. They do not update the
> DAR register in the TLB miss/TLB error handlers.
> The TLB miss handler does not use the DAR reg but the TLB error
> handler do. Thats why it works when you mlock the memory.
> 
> This bug isn't documented but Freescale has confirmed it.
> You can search the archives some years back for more info.
> 
>  Jocke

BTW, it is possible to workaround this problem in the kernel by
tagging DAR with an impossible value and compare DAR against it
in the DTLB Error handler. If a match, then do a instruction decode
to get the regs involved and calculate the faulting address.

I did this several years ago for 2.4 in assembler and posted
it, but it was rejected.
One should bail out to handle_page_fault and do the
calculations there instead(less likely to break that way)

Found one version of the patch here:
http://patchwork.ozlabs.org/linuxppc/patch?id=1307

 Jocke

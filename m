Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 477F2B7BBF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 09:08:05 +1100 (EST)
In-Reply-To: <1254789255.7122.95.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254773824.7122.33.camel@pasglop>	
	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>	
	<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>	
	<OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
	<1254784539.7122.52.camel@pasglop>	
	<OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
	<1254789255.7122.95.camel@pasglop>
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFC64CFB37.E5E17F42-ONC1257647.0068299A-C1257647.00795ECE@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 7 Oct 2009 00:05:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 02:34:15:
>
> On Tue, 2009-10-06 at 01:35 +0200, Joakim Tjernlund wrote:
> >
> > > Well, if the HW has the ability to enforce trap when store with !
> > DIRTY,
> >
> > Yes, provided that the kernel invalidates the TLB too so the next
> > access
> > will provoke a TLB Miss, which will then provoke a TLB error. The TLB
> > error routine checks VALID, RW and USER(if not a kernel access), then
> > sets
> > ACCESSED & DIRTY and writes the TLB(RPN reg).
> >
> > Perhaps the missing invalidate is haunting us here?
>
> No, the kernel will invalidate when clearing dirty or accessed, I don't
> think that's our problem.
>
> This is still all inefficient, we end up basically with two traps.
>
> 8xx provides backup GPRs when doing TLB misses ? What does it cost to
> jump out of a TLB miss back into "normal" context ?
>
> IE. What I do on 440 is I set a mask of required bits, basically
> _PAGE_PRESENT | _PAGE_ACCESSED is the base. The DTLB miss also sticks
> in _PAGE_RW | _PAGE_DIRTY when it's a store fault.

After some more thinking I don't think I do TLB Miss/Error correctly yet.
The problem is ACCESSED. Since I don't know if load or store in TLB Miss
I must choose:
 - Assume load and do what you do above. That will incorrectly
   set ACCESSED on store ops when mapped as RO(plus whatever more I haven't thought about yet)

 - Trap to TLB Error and do the above. That will set ACCESSED correctly
   but won't trap kernel space so these remain what they are.
   Is anything depending on ACCESSED for kernel pages?
   if so, what if we set ACCESSED on all kernel pages when mapping them at boot?
   Will SWAP or some other service(accounting?) not like that?

Finally, why do you need to include DIRTY when a store OP?
Do you need to do COW before dirtying the page?
Seems to work for me to just set DIRTY in TLB Error if RW is set too
and not trap to C.

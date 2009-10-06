Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C0B5B7BBC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 22:06:35 +1100 (EST)
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF5058A03E.5D586A94-ONC1257647.003C25B0-C1257647.003C5220@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091005220420.GA27923@compile2.chatsunix.int.mrv.com>
	<OF9AD6CA21.DCD59A1B-ONC1257646.007AE622-C1257646.007BB767@transmode.se>
	<1254782248.7122.49.camel@pasglop>
	<OF2DE63E1A.21EA8BF0-ONC1257646.0082A7F0-C1257646.0082E281@transmode.se>
	<1254793935.1959.1.camel@pasglop>
	<OFAEE03401.0C51FEE2-ONC1257647.002C29FE-C1257647.002C917A@transmode.se>
	<1254817969.6035.4.camel@pasglop>
	<OF5058A03E.5D586A94-ONC1257647.003C25B0-C1257647.003C5220@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 22:06:26 +1100
Message-Id: <1254827186.6035.11.camel@pasglop>
Mime-Version: 1.0
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

On Tue, 2009-10-06 at 12:58 +0200, Joakim Tjernlund wrote:

> Here I don't care if err. insn will be 0 if it fails and the following
> if will be false

I'd rather you use get_user() so it does access_ok().

Else, you can probably manufacture some code that will make the kernel
access some MMIO register for example, which could be nasty.

At this point, you may as well also check the result even if indeed a
fault isn't going to matter. Just makes the code cleaner and avoids some
random janitor coming up with a patch later on :-)

Cheers,
Ben.

> > >        if (((insn >> (31-5)) & 0x3f) == 31) {
> > >           if (((insn >> 1) & 0x3ff) == 1014) /* dcbz ? 0x3f6 */
> > >              istr = "dcbz";
> > > @@ -171,27 +172,32 @@ int __kprobes do_page_fault(struct pt_regs *regs,
> > unsigned long address,
> > >              dar = regs->gpr[rb];
> > >              if (ra)
> > >                 dar += regs->gpr[ra];
> > > -            if (dar != address && address != 0x00f0 && trap == 0x300)
> > > +            if (dar != address && trap == 0x300)
> > >                 printk(KERN_CRIT "%s: address:%lx, dar:%lx!\n", istr, address, dar);
> > >              if (!strcmp(istr, "dcbst") && is_write) {
> > >                 printk(KERN_CRIT "dcbst R%ld,R%ld = %lx as a store, fixing!\n",
> > >                        ra, rb, dar);
> > >                 is_write = 0;
> > >              }
> > > -
> > > +#if 0
> > >              if (trap == 0x300 && address != dar) {
> > >                 __asm__ ("mtdar %0" : : "r" (dar));
> > >                 return 0;
> > >              }
> > > +#endif
> > >           }
> > >        }
> > >  #endif
> > >        if (address == 0x00f0 && trap == 0x300) {
> > > -         pte_t *ptep;
> > > +         //pte_t *ptep;
> > >
> > >           /* This is from a dcbX or icbi insn gone bad, these
> > >            * insn do not set DAR so we have to do it here instead */
> > > -         insn = *((unsigned long *)regs->nip);
> > > +         if (get_user(insn, (unsigned long __user *)regs->nip)) {
> > > +            printk(KERN_CRIT "get_user failed, NIP:%lx\n",
> > > +                   regs->nip);
> > > +            goto bad_area_nosemaphore;
> > > +         }
> 
> and here I go to bad_area

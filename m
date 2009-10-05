Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1019B7BA5
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 10:53:47 +1100 (EST)
In-Reply-To: <1254782248.7122.49.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<20091005220420.GA27923@compile2.chatsunix.int.mrv.com>
	<OF9AD6CA21.DCD59A1B-ONC1257646.007AE622-C1257646.007BB767@transmode.se>
	<1254782248.7122.49.camel@pasglop>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF2DE63E1A.21EA8BF0-ONC1257646.0082A7F0-C1257646.0082E281@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Oct 2009 01:49:36 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 00:37:28:
>
> On Tue, 2009-10-06 at 00:31 +0200, Joakim Tjernlund wrote:
> >
> > regs or regs->nip is NULL? Either one does not make sense
> > In any case it might be a secondary problem as DAR is NULL already
> > when you
> > enter the page fault.
> > >
> > >                 insn = *((unsigned long *)regs->nip);
> > > c000e110:       80 a9 00 00     lwz     r5,0(r9)
> > >
> > > fails.
> >
> > hmm, I wonder if you managed to invalidate the a kernel TLB?
> > Are you using pinned kernel TLBs?
>
> You should not dereference a user address like that. Use get_user !

So how does this look? Does it change anything?
It should as the previous way was way off :(

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c33c6de..08a392f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -153,7 +153,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 #ifdef DEBUG_DCBX
 		const char *istr = NULL;

-		insn = *((unsigned long *)regs->nip);
+		__get_user(insn, (unsigned long __user *)regs->nip);
 		if (((insn >> (31-5)) & 0x3f) == 31) {
 			if (((insn >> 1) & 0x3ff) == 1014) /* dcbz ? 0x3f6 */
 				istr = "dcbz";
@@ -178,11 +178,12 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 					       ra, rb, dar);
 					is_write = 0;
 				}
-
+#if 0
 				if (trap == 0x300 && address != dar) {
 					__asm__ ("mtdar %0" : : "r" (dar));
 					return 0;
 				}
+#endif
 			}
 		}
 #endif
@@ -191,7 +192,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,

 			/* This is from a dcbX or icbi insn gone bad, these
 			 * insn do not set DAR so we have to do it here instead */
-			insn = *((unsigned long *)regs->nip);
+			__get_user(insn, (unsigned long __user *)regs->nip);

 			ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
 			rb = (insn >> (31-20)) & 0x1f; /* Reg RB */

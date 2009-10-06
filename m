Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87404B7BFE
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 00:22:07 +1100 (EST)
In-Reply-To: <1254827186.6035.11.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<20091005220420.GA27923@compile2.chatsunix.int.mrv.com>
	<OF9AD6CA21.DCD59A1B-ONC1257646.007AE622-C1257646.007BB767@transmode.se>
	<1254782248.7122.49.camel@pasglop>	
	<OF2DE63E1A.21EA8BF0-ONC1257646.0082A7F0-C1257646.0082E281@transmode.se>
	<1254793935.1959.1.camel@pasglop>	
	<OFAEE03401.0C51FEE2-ONC1257647.002C29FE-C1257647.002C917A@transmode.se>
	<1254817969.6035.4.camel@pasglop>	
	<OF5058A03E.5D586A94-ONC1257647.003C25B0-C1257647.003C5220@transmode.se>
	<1254827186.6035.11.camel@pasglop>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFC5E527BE.77D28888-ONC1257647.00489546-C1257647.00491C0F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Oct 2009 15:18:33 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 13:06:26:
>
> On Tue, 2009-10-06 at 12:58 +0200, Joakim Tjernlund wrote:
>
> > Here I don't care if err. insn will be 0 if it fails and the following
> > if will be false
>
> I'd rather you use get_user() so it does access_ok().
>
> Else, you can probably manufacture some code that will make the kernel
> access some MMIO register for example, which could be nasty.
>
> At this point, you may as well also check the result even if indeed a
> fault isn't going to matter. Just makes the code cleaner and avoids some
> random janitor coming up with a patch later on :-)
>
> Cheers,
> Ben.

So my user space access was bust. Try slapping this on top
It might be that my crappy user space handling also tripped the
asm version, would be great if you could try that one again too.

I suspect that you both, Rex and Scott, have dcbX/icbi insn's in user
space that trip DTLB errors, that would explain everything I think.

      Jocke

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c33c6de..d757ec8 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -152,8 +152,16 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 		unsigned long ra, rb, dar, insn;
 #ifdef DEBUG_DCBX
 		const char *istr = NULL;
+		int ret;
+
+		insn = 0;
+		if (user_mode(regs)) {
+			if ((ret = get_user(insn, (unsigned long __user *)regs->nip)))
+				printk(KERN_CRIT "get_user:NIP:0x%08lx, err:%d\n",
+				       regs->nip, ret);
+		} else
+			insn = *((unsigned long *)regs->nip);

-		insn = *((unsigned long *)regs->nip);
 		if (((insn >> (31-5)) & 0x3f) == 31) {
 			if (((insn >> 1) & 0x3ff) == 1014) /* dcbz ? 0x3f6 */
 				istr = "dcbz";
@@ -178,20 +186,27 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
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
 		if (address == 0x00f0 && trap == 0x300) {
-			pte_t *ptep;
-
+			int ret;
 			/* This is from a dcbX or icbi insn gone bad, these
 			 * insn do not set DAR so we have to do it here instead */
-			insn = *((unsigned long *)regs->nip);
+			if (user_mode(regs)) {
+				if ((ret = get_user(insn, (unsigned long __user *)regs->nip))) {
+					printk(KERN_CRIT "get_user:NIP:%lx, err:%d\n",
+					       regs->nip, ret);
+					goto bad_area_nosemaphore;
+				}
+			} else
+				insn = *((unsigned long *)regs->nip);

 			ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
 			rb = (insn >> (31-20)) & 0x1f; /* Reg RB */
@@ -206,18 +221,6 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 			       trap, address, dar, error_code, istr);
 #endif
 			address = dar;
-#if 1
-			if (is_write && get_pteptr(mm, dar, &ptep, NULL)) {
-				pte_t my_pte = *ptep;
-
-				if (pte_present(my_pte) && pte_write(my_pte)) {
-					pte_val(my_pte) |= _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE;
-					set_pte_at(mm, dar, ptep, my_pte);
-				}
-			}
-#else
-			return 0;
-#endif
 		}
 	}
 #endif

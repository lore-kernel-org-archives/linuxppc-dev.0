Date: Thu, 25 Jan 2001 20:03:10 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: jekacur@ca.ibm.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: sigcontext on Linux-ppc in user space]
In-Reply-To: <OF38EA3C4D.2A886AF4-ON852569DF.00530F62@LocalDomain>
Message-ID: <Pine.GSO.4.10.10101251957050.24557-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Could you try the patch below?

bye, Roman

diff -u -r1.1.1.5 signal.c
--- arch/ppc/kernel/signal.c	2000/09/13 17:59:51	1.1.1.5
+++ arch/ppc/kernel/signal.c	2001/01/25 18:59:54
@@ -334,12 +334,12 @@
 	newsp -= __SIGNAL_FRAMESIZE;
 	if (put_user(regs->gpr[1], (unsigned long *)newsp)
 	    || get_user(regs->nip, &rt_sf->uc.uc_mcontext.handler)
-	    || get_user(regs->gpr[3], &rt_sf->uc.uc_mcontext.signal)
-	    || get_user(regs->gpr[4], (unsigned long *)&rt_sf->pinfo)
-	    || get_user(regs->gpr[5], (unsigned long *)&rt_sf->puc))
+	    || get_user(regs->gpr[3], &rt_sf->uc.uc_mcontext.signal))
 		goto badframe;

 	regs->gpr[1] = newsp;
+	regs->gpr[4] = (unsigned long *)&rt_sf->pinfo;
+	regs->gpr[5] = (unsigned long *)&rt_sf->puc;
 	regs->gpr[6] = (unsigned long) rt_sf;
 	regs->link = (unsigned long) frame->tramp;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

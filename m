From: "Ryan Nielsen" <ran@krazynet.com>
Message-ID: <19981205174858.A31582@gondolin>
Date: Sat, 5 Dec 1998 17:48:58 -0800
To: Tom Rini <tmrini@ntplx.net>
Cc: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@persephone.cs.nmt.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>
Subject: Re: ksymoops
References: <19981205164713.A30036@gondolin> <Pine.LNX.4.05.9812051953170.954-100000@pc.wackyland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.9812051953170.954-100000@pc.wackyland.com>; from Tom Rini on Sat, Dec 05, 1998 at 07:53:43PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> On Sat, 5 Dec 1998, Ryan Nielsen wrote:
> 
> > > Hello,
> > >   Has anyone played around with getting ksymoops working on PPC yet?
> > > Would be a rather useful tool (gonna take a stab at it if not).
> > 
> > I assume you mean linux/scripts/ksymoops.cc, a package that does similar
> > and works on PPC can be got from ftp://ftp.ocs.com.au/pub/ksymoops.tar.gz
> 
> Yeah, found that a bit later on.  Ever pass on the patch for more detailed
> oops to Cort/Paul?

(CC'd to Cort and Paul)

its the same Instruction DUMP from the sparc code.
I've found it useful in finding out where modules fsck up.

--- linux/arch/ppc/kernel/process.c	1998/10/11 17:47:23	1.67
+++ linux/arch/ppc/kernel/process.c	1998/11/02 03:11:28
@@ -198,6 +200,19 @@
 	_enable_interrupts(s);
 }
 
+void instruction_dump (unsigned long *pc)
+{
+	int i;
+
+	if((((unsigned long) pc) & 3))
+                return;
+
+	printk("Instruction DUMP:");
+	for(i = -3; i < 6; i++)
+		printk("%c%08lx%c",i?' ':'<',pc[i],i?' ':'>');
+	printk("\n");
+}
+
 void show_regs(struct pt_regs * regs)
 {
 	int i;
--- linux/arch/ppc/kernel/traps.c	1998/05/05 19:18:53	1.21
+++ linux/arch/ppc/kernel/traps.c	1998/11/02 03:11:36
@@ -79,6 +79,7 @@
 		debugger(regs);
 #endif
 		print_backtrace((unsigned long *)regs->gpr[1]);
+		instruction_dump((unsigned long *)regs->nip);
 		panic("Exception in kernel pc %lx signal %d",regs->nip,signr);
 	}
 	force_sig(signr, current);
@@ -126,6 +127,7 @@
 		debugger(regs);
 #endif
 		print_backtrace((unsigned long *)regs->gpr[1]);
+		instruction_dump((unsigned long *)regs->nip);
 		panic("machine check");
 	}
 	_exception(SIGSEGV, regs);	
@@ -219,6 +221,7 @@
 #endif
 	show_regs(regs);
 	print_backtrace((unsigned long *)regs->gpr[1]);
+	instruction_dump((unsigned long *)regs->nip);
 	panic("kernel stack overflow");
 }
 
--- linux/arch/ppc/mm/fault.c	1998/10/06 03:13:19	1.28
+++ linux/arch/ppc/mm/fault.c	1998/11/02 03:11:36
@@ -89,6 +89,7 @@
 			printk("page fault in interrupt handler, addr=%lx\n",
 			       address);
 			show_regs(regs);
+			instruction_dump((unsigned long *)regs->nip);
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 			if (debugger_kernel_faults)
 				debugger(regs);
@@ -174,6 +175,7 @@
 	/* kernel has accessed a bad area */
 	show_regs(regs);
 	print_backtrace( (unsigned long *)regs->gpr[1] );
+	instruction_dump((unsigned long *)regs->nip);
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_kernel_faults)
 		debugger(regs);

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

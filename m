Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18454.42926.213374.977098@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 14:44:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
In-Reply-To: <20080428203322.GD15223@ld0162-tx32.am.freescale.net>
References: <20071023212404.GA30942@loki.buserror.net>
	<Pine.LNX.4.64.0804251454050.6045@axis700.grange>
	<20080428203322.GD15223@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> On Fri, Apr 25, 2008 at 02:57:24PM +0200, Guennadi Liakhovetski wrote:
> > is there any specific reason, why out of these 7 patches only the first 
> > one made it into the mainline? AFAICS, there has been only one comment, 
> > suggesting to replace printk with dev_err on two occasions in one of 
> > the patches...
> 
> A while ago Paul said on IRC he'd prefer to do the TLF_SLEEPING hack more
> like the soft IRQ disabling that 64-bit uses.  I haven't yet had a chance
> to look into it, so the patch collects dust, despite the current
> implementation of TLF_SLEEPING working just fine.

I have taken a closer look at the TLF_SLEEPING patch and crystallized
my thoughts about it a bit:

1. Too many ifdefs - it's only a few instructions extra, so if we're
going to have the TLF_SLEEPING stuff we might as well have it
unconditionally.

2. It seems convoluted to me to go through transfer_to_handler_cont
and ret_from_except when we could just get out directly through
fast_exception_return, given that we are not calling a handler.  The
only thing to watch out for there is that r7 and r8 haven't been
modified (or have been restored if they have).

3. The style in all the assembly code is not to have spaces after
commas separating instruction operands.

The untested patch below is what I was thinking of.  If you'd like to
try it out, I'd be interested to hear how it goes.

Paul.

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 84c8686..162500f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -146,6 +146,7 @@ transfer_to_handler:
 	lwz	r12,TI_LOCAL_FLAGS(r9)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
+	bt-	31-TLF_SLEEPING,7f
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
@@ -163,6 +164,13 @@ transfer_to_handler_cont:
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
 	stw	r12,TI_LOCAL_FLAGS(r9)
 	b	power_save_6xx_restore
+
+7:	rlwinm	r12,r12,0,~TLF_SLEEPING
+	stw	r12,TI_LOCAL_FLAGS(r9)
+	lwz	r9,_MSR(r11)		/* if sleeping, clear MSR.EE */
+	rlwinm	r9,r9,0,~MSR_EE
+	lwz	r12,_LINK(r11)		/* and return to address in LR */
+	b	fast_exception_return
 #endif
 
 /*
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index d030f5c..1cd8c8f 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -147,8 +147,10 @@ static inline struct thread_info *current_thread_info(void)
 /* Bits in local_flags */
 /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
 #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
+#define TLF_SLEEPING		1	/* suspend code enabled SLEEP mode */
 
 #define _TLF_NAPPING		(1 << TLF_NAPPING)
+#define _TLF_SLEEPING		(1 << TLF_SLEEPING)
 
 #endif /* __KERNEL__ */
 

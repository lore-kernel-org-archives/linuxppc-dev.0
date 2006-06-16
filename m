Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EA85A67B64
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 13:25:09 +1000 (EST)
Date: Fri, 16 Jun 2006 13:24:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: Re: [PATCH] powerpc: Use soft irq-disable on all 64-bit machines
Message-Id: <20060616132439.484c2ced.sfr@canb.auug.org.au>
In-Reply-To: <20060614172309.59d7b76e.sfr@canb.auug.org.au>
References: <17551.33574.27019.305680@cargo.ozlabs.ibm.com>
	<20060614170840.3686cbad.sfr@canb.auug.org.au>
	<20060614172309.59d7b76e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Jun 2006 17:23:09 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Wed, 14 Jun 2006 17:08:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Looks good.  A couple of small fixes below.
> 
> Plus we want the below as well ...

And this ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 434461a..c6b0400 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -89,6 +89,8 @@ system_call_common:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+	lbz	r10,PACAPROCENABLED(r13)
+	std	r10,SOFTE(r1)
 #ifdef CONFIG_PPC_ISERIES
 	/* Hack for handling interrupts when soft-enabling on iSeries */
 	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
@@ -96,8 +98,6 @@ #ifdef CONFIG_PPC_ISERIES
 	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
 	beq	hardware_interrupt_entry
 #endif
-	lbz	r10,PACAPROCENABLED(r13)
-	std	r10,SOFTE(r1)
 	mfmsr	r11
 	ori	r11,r11,MSR_EE
 	mtmsrd	r11,1

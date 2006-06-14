Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C5B2F67B6C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 17:09:01 +1000 (EST)
Date: Wed, 14 Jun 2006 17:08:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Use soft irq-disable on all 64-bit machines
Message-Id: <20060614170840.3686cbad.sfr@canb.auug.org.au>
In-Reply-To: <17551.33574.27019.305680@cargo.ozlabs.ibm.com>
References: <17551.33574.27019.305680@cargo.ozlabs.ibm.com>
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

On Wed, 14 Jun 2006 13:31:50 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> This patch extends the soft interrupt-disable strategy used on iSeries
> so that it applies to all 64-bit machines.  Basically, the idea is
> that local_irq_disable() and related functions don't actually change
> the MSR_EE (external interrupt enable) bit in the MSR, they just clear
> a per-cpu "interrupts enabled" flag.  If an interrupt does come along,
> the exception prolog code notices that interrupts are supposed to be
> disabled.  It then clears a per-cpu "interrupts are actually enabled"
> flag, and returns from the interrupt with MSR_EE clear.
> 
> Then, when interrupts later get enabled, we noticed that the
> "interrupts are actually enabled" flag got cleared, and set it and the
> MSR_EE bit in the MSR.
> 
> This should result in improved performance, since setting and clearing
> the MSR_EE bit in the MSR can be much more expensive than setting and
> clearing a per-cpu flag in memory.  This also reduces the
> iSeries-specific differences in the code.

Looks good.  A couple of small fixes below.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 26729e9..44b8cdc 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -370,7 +370,7 @@ #ifndef CONFIG_PPC_ISERIES
 #define DISABLE_INTS				\
 	li	r11,0;				\
 	stb	r11,PACAPROCENABLED(r13);	\
-	stb	r10,PACAHARDIRQEN(r13)
+	stb	r11,PACAHARDIRQEN(r13)
 #else
 #define DISABLE_INTS				\
 	li	r11,0;				\
diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
index f231264..db0ce76 100644
--- a/include/asm-powerpc/hw_irq.h
+++ b/include/asm-powerpc/hw_irq.h
@@ -44,12 +44,6 @@ #else
 #if defined(CONFIG_BOOKE)
 #define SET_MSR_EE(x)	mtmsr(x)
 #define local_irq_restore(flags)	__asm__ __volatile__("wrtee %0" : : "r" (flags) : "memory")
-#elif defined(__powerpc64__)
-#define SET_MSR_EE(x)	__mtmsrd(x, 1)
-#define local_irq_restore(flags) do { \
-	__asm__ __volatile__("": : :"memory"); \
-	__mtmsrd((flags), 1); \
-} while(0)
 #else
 #define SET_MSR_EE(x)	mtmsr(x)
 #define local_irq_restore(flags)	mtmsr(flags)

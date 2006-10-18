Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FDD367B9E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 18:26:15 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1Ga62l-0006uh-QS
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 09:40:51 +0200
Date: Wed, 18 Oct 2006 09:32:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt] powerpc update
Message-ID: <20061018073234.GA31118@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com>
	<20061018072858.GA29576@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061018072858.GA29576@elte.hu>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Ingo Molnar <mingo@elte.hu> wrote:

> really, the ->eoi() op should only be called for true fasteoi cases. 
> What we want here is to turn the fasteoi handler into a handler that 
> does mask+ack and then unmask. Not 'mask+eoi ... unmask' as your patch 
> does.

i.e. like the much simpler patch below. That's what i've applied to the 
soon-to-be-rt6 tree, plus the other bits of your patch. Can you confirm 
this works well on PPC?

	Ingo

Index: linux-rt.q/kernel/irq/chip.c
===================================================================
--- linux-rt.q.orig/kernel/irq/chip.c
+++ linux-rt.q/kernel/irq/chip.c
@@ -386,13 +386,15 @@ handle_fasteoi_irq(unsigned int irq, str
 	}
 
 	desc->status |= IRQ_INPROGRESS;
+
 	/*
-	 * fasteoi should not be used for threaded IRQ handlers!
+	 * In the threaded case we fall back to a mask+ack sequence:
 	 */
 	if (redirect_hardirq(desc)) {
-		WARN_ON_ONCE(1);
+		mask_ack_irq(desc, irq);
 		goto out_unlock;
 	}
+
 	desc->status &= ~IRQ_PENDING;
 	spin_unlock(&desc->lock);
 

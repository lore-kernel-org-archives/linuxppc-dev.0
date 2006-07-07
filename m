Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 15D0367B53
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:52:51 +1000 (EST)
Date: Fri, 7 Jul 2006 01:52:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: G5 troubles booting powerpc-git (July 6)
Message-Id: <20060707015237.68c768f2.akpm@osdl.org>
In-Reply-To: <1152260824.9862.57.camel@localhost.localdomain>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
	<1152226587.9862.19.camel@localhost.localdomain>
	<20060707012330.f1dea5ac.akpm@osdl.org>
	<1152260824.9862.57.camel@localhost.localdomain>
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

On Fri, 07 Jul 2006 18:27:04 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2006-07-07 at 01:23 -0700, Andrew Morton wrote:
> > On Fri, 07 Jul 2006 08:56:27 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > If you look at arch/powerpc/kernel/irq.c from line 479:
> > > 
> > > 	/* Check if mapping already exist, if it does, call
> > > 	 * host->ops->map() to update the flags
> > > 	 */
> > > 	virq = irq_find_mapping(host, hwirq);
> > > 	if (virq != IRQ_NONE) {
> > > 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
> > > 		host->ops->map(host, virq, hwirq, flags);
> > > 		return virq;
> > > 	}
> > > 
> > > What if you comment out the host->ops->map(...) call in there ? Does it
> > > help ?
> > 
> > No, there's no change in behaviour.
> 
> Doh ! Ok, looks like a different issue. Can you try this patch ? Please,
> do _not_ apply it to your tree as, as it is it will break non-powermac.
> It's some work I'm doing to clean up a couple of rough edges in my irq
> rework and fix a little misdesign.
> 
> If it doesn't fix it, then it's indeed a completely different issue that I'll have to track down tomorrow
> hopefully.

Needs this to compile:

diff -puN arch/powerpc/platforms/pseries/ras.c~a-fix arch/powerpc/platforms/pseries/ras.c
--- a/arch/powerpc/platforms/pseries/ras.c~a-fix
+++ a/arch/powerpc/platforms/pseries/ras.c
@@ -93,8 +93,7 @@ static void request_ras_irqs(struct devi
 		for (i = 0; i < opicplen; i++) {
 			if (count > 15)
 				break;
-			virqs[count] = irq_create_mapping(NULL, *(opicprop++),
-							 IRQ_TYPE_NONE);
+			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
 			if (virqs[count] == NO_IRQ)
 				printk(KERN_ERR "Unable to allocate interrupt "
 				       "number for %s\n", np->full_name);
diff -puN arch/powerpc/platforms/pseries/xics.c~a-fix arch/powerpc/platforms/pseries/xics.c
--- a/arch/powerpc/platforms/pseries/xics.c~a-fix
+++ a/arch/powerpc/platforms/pseries/xics.c
@@ -757,7 +757,7 @@ void xics_request_IPIs(void)
 {
 	unsigned int ipi;
 
-	ipi = irq_create_mapping(xics_host, XICS_IPI, 0);
+	ipi = irq_create_mapping(xics_host, XICS_IPI);
 	BUG_ON(ipi == NO_IRQ);
 
 	/*
diff -puN drivers/char/hvsi.c~a-fix drivers/char/hvsi.c
--- a/drivers/char/hvsi.c~a-fix
+++ a/drivers/char/hvsi.c
@@ -1299,7 +1299,7 @@ static int __init hvsi_console_init(void
 		hp->inbuf_end = hp->inbuf;
 		hp->state = HVSI_CLOSED;
 		hp->vtermno = *vtermno;
-		hp->virq = irq_create_mapping(NULL, irq[0], 0);
+		hp->virq = irq_create_mapping(NULL, irq[0]);
 		if (hp->virq == NO_IRQ) {
 			printk(KERN_ERR "%s: couldn't create irq mapping for 0x%x\n",
 				__FUNCTION__, irq[0]);
_

But it still doesn't help.


These:

arch/powerpc/sysdev/i8259.c:222: warning: initialization from incompatible pointer type
arch/powerpc/platforms/pseries/xics.c:555: warning: initialization from incompatible pointer type
arch/powerpc/platforms/pseries/xics.c:561: warning: initialization from incompatible pointer type

look like super-serious box-killers.  Hope I'm not using either of those.

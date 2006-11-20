Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46A7967EDB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 06:12:45 +1100 (EST)
Date: Mon, 20 Nov 2006 20:11:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
Message-ID: <20061120191149.GA32537@elte.hu>
References: <20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	<20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>
	<20061120172642.GA8683@elte.hu>
	<20061120175502.GA12733@elte.hu> <4561F43B.40000@ru.mvista.com>
	<20061120191013.GA30828@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061120191013.GA30828@elte.hu>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Ingo Molnar <mingo@elte.hu> wrote:

> >    Hmm, that just won't do for PPC threaded fasteoi flows! What you'll 
> > get is a threaded IRQ with EOI *never ever* issued, unless my PPC 
> > patch is also in...
> 
> ok, how about the patch below in addition?

or rather, the one below. Untested.

	Ingo

Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -392,11 +394,12 @@ handle_fasteoi_irq(unsigned int irq, str
 	desc->status |= IRQ_INPROGRESS;
 
 	/*
-	 * In the threaded case we fall back to a mask+ack sequence:
+	 * In the threaded case we fall back to a mask+eoi sequence:
 	 */
 	if (redirect_hardirq(desc)) {
-		mask_ack_irq(desc, irq);
-		goto out_unlock;
+		if (desc->chip->mask)
+			desc->chip->mask(irq);
+		goto out;
 	}
 
 	desc->status &= ~IRQ_PENDING;

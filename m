Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F06BE67BF7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 04:27:42 +1100 (EST)
Date: Mon, 20 Nov 2006 18:26:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
Message-ID: <20061120172642.GA8683@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	<20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4561DFE1.4020708@ru.mvista.com>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Ingo Molnar wrote:
> 
> >>>on PPC64, 'get the vector' initiates an ACK as well - is that done 
> >>>before handle_irq() is done?
> 
> >>  Exactly. How else do_IRQ() would know the vector?
> 
> >the reason i'm asking is that in this case masking is a bit late at this 
> >point and there's a chance for a repeat interrupt.
> 
>    How's that? Acknowledge != EOI on OpenPIC (as well as 8259). 
> Acknoledging sets the bit in the in-service register preventing all 
> the interrupts with same or lower prioriry from being accepted.

ah, ok. The x86 APIC does that automatically, and only an EOI has to be 
passed. So i guess we are in wild agreement ;)

i'm hacking up something now to see whether it makes sense to introduce 
a central threaded flow type, or whether it's better the branch off the 
current flow types (as the code does it right now).

	Ingo

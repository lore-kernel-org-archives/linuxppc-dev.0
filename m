Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC34867D24
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 07:09:40 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061120165621.GA1504@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	<20061120165621.GA1504@elte.hu>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 07:09:45 +1100
Message-Id: <1164053385.8073.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-20 at 17:56 +0100, Ingo Molnar wrote:
> * Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
> > >on PPC64, 'get the vector' initiates an ACK as well - is that done 
> > >before handle_irq() is done?
> > 
> >    Exactly. How else do_IRQ() would know the vector?
> 
> the reason i'm asking is that in this case masking is a bit late at this 
> point and there's a chance for a repeat interrupt.

What do you mean by a bit late ?

You can't mask before you know what interrupt occured so you don't
really have a choice there :-) I'm pretty sure that mask + eoi is what
Apple does on Darwin too though.

Cheers,
Ben.

Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4981367D93
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 13:44:31 +1000 (EST)
Date: Sun, 31 Jul 2005 20:44:28 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Daniel Ann <ktdann@gmail.com>
Message-ID: <20050801034428.GA1713@gate.ebshome.net>
References: <9b7ca6570507311900212f0179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b7ca6570507311900212f0179@mail.gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: openpic_init() functionality
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 01, 2005 at 11:00:29AM +0900, Daniel Ann wrote:
> Hi folks,
> 
> Just been reading openpic_init() function and found something weird,
> so I thought I might turn to pro.
> It's a part where it initialises all external sources. Code goes
> something like this,
> [begin]
>     /* Init all external sources, including possibly the cascade. */
>     for (i = 0; i < NumSources; i++) {
>         int sense;
> 
>         if (ISR[i] == 0)
>             continue;
> [snip]
>       openpic_initirq(i, 8, i+offset, (sense & IRQ_POLARITY_MASK),
>               (sense & IRQ_SENSE_MASK));
> [end]
> 
> I can see what openpic_initirq does. But what I dont see is enable
> part. openpic_initirq only configures interrupt but does not enable
> it. And going thru the rest of the code, nothing calls
> openpic_enable_irq().
> Can somebody tell me how should these interrupts get enabled ?
> 
> Reason is, if I dont force openpic_enable_irq() after
> openpic_initirq(), then at the end of booting, I see none of my
> interrupts enabled. Im sure somewhere down the line it should get
> enabled, but where ?

It's enabled when somebody calls request_irq, for example.

Generic IRQ code is linked to OpenPIC implementation through 
'struct hw_interrupt_type open_pic'.

Next time, try adding printk to a function at question and you'll 
easily see that it's being called.

-- 
Eugene

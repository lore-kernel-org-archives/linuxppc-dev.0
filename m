Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 710DFB6FA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 04:43:40 +1100 (EST)
Received: from mail123-va3 (localhost.localdomain [127.0.0.1])	by
	mail123-va3-R.bigfish.com (Postfix) with ESMTP id E0EE9D2812C	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2011 17:43:34 +0000 (UTC)
Message-ID: <4E8C9741.9010401@freescale.com>
Date: Wed, 5 Oct 2011 12:43:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: BUG: scheduling while atomic:
References: <40631E9A2581F14BA60888C87A76A1FE014A35@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE014A35@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/05/2011 06:24 AM, smitha.vanga@wipro.com wrote:
> Hi Scoot,
> 
>  When my  ISR gets exeuted I get a below BUG. Could let me what I am
> doing wrong in the ISR?
>  
>  
>  BUG: scheduling while atomic: IRQ-20/0x0fff0000/108
> Call Trace:
> [C3AEFEC0] [C0007CCC]  (unreliable)
> [C3AEFEF0] [C0017F10]
> [C3AEFF00] [C0268818]
> [C3AEFF50] [C0017F44]
> [C3AEFF60] [C0018044]
> [C3AEFF70] [C0046A90]
> [C3AEFF90] [C0046D90]
> [C3AEFFC0] [C0032AFC]
> [C3AEFFF0] [C000F5AC]

This trace is useless without debugging symbols from your kernel image.
Please enable kallsyms.

> Below is the code :
> *My ISR*
> 
> irqreturn_t cpld_irq_handler(int irq, void * dev_id, struct pt_regs *regs)
> 
> {
> 
> wake_up(&cpld_intr_wait);
> 
> atomic_inc(&cpld_intr_data); /* incrementing this will indicate the
> poll() that the interrupt is occured */

None of this should schedule when run in interrupt context.

The only thing that comes to mind is possibly wake_up(), if you're
running the RT patch but somehow the interrupt isn't in a thread.

> return 0;

Not related, but return IRQ_HANDLED;

-Scott

Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58513B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 10:13:17 +1100 (EST)
Message-ID: <4F272403.1020000@freescale.com>
Date: Mon, 30 Jan 2012 17:13:07 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
 <CALRxmdA9mh6x5YGK1oFHvgmV-RsnN6WkxhpZbcRJv1S8Y0RH1w@mail.gmail.com>
 <1327100755.2923.6.camel@pasglop> <4F1DB344.9030709@freescale.com>
 <1327351831.19850.9.camel@pasglop> <4F270FDC.8030906@freescale.com>
 <1327961726.28487.60.camel@pasglop>
In-Reply-To: <1327961726.28487.60.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/30/2012 04:15 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-01-30 at 15:47 -0600, Scott Wood wrote:
> 
>> Only the first one will happen in a context where we want to store.  The
>> issue is if we get another higher priority interrupt when we enable, and
>> that enables interrupts and we get the doorbell that wants to run the
>> saved irq.  If we get priorities out of order we'll EOI the wrong interrupt.
> 
> Hrm, ok, what about in handle_masked we just "save" it onto some kind of
> PACA local stack ? Then on enable, before actually turning EE back, we
> see if there's something there and we hit do_IRQ() if there is. Your
> get_irq() would preferrably pop things out of that little stack.
> 
> Any hole in that scheme ?

If we never enable EE, there's no need for a stack -- we disable EE on
the first interrupt and can leave it in EPR.  It's similar to my
original patch, but with the exception hack replaced with a call to
do_IRQ().  The quality of the regs you pass (if any) may suffer, which
is why I did the exception hack, but I can live with that if you can.

>> IIRC we now never enable interrupts while servicing one (are individual
>> handlers banned from doing this too?), 
> 
> No I think they still can.

OK.  Another option could be to use the doorbell and store EPR
somewhere, but make sure if we get a real interrupt and there's a
pending interrupt stored, we clear it out and process both in proper
order.  When the doorbell eventually fires it's a nop.  Testing this
would require some effort, though.  Better to stick with the simple
scheme where we never enable EE with a pending interrupt.

>>> However the main thing is that this significantly improves the quality
>>> of the samples obtained from performance interrupts which can now act as
>>> pseudo-NMI up to a certain point.
>>
>> Which is compensation for the hardware not doing it right with a proper
>> critical interrupt or equivalent, but yeah, that's a benefit.
> 
> Right, server has no concept really of critical interrupts.

Would be nice if the embedded version used critical, though (or could be
configured to do so).

-Scott

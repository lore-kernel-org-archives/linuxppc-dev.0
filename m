Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 319FEB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 06:21:54 +1100 (EST)
Message-ID: <4F1DB344.9030709@freescale.com>
Date: Mon, 23 Jan 2012 13:21:40 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
 <CALRxmdA9mh6x5YGK1oFHvgmV-RsnN6WkxhpZbcRJv1S8Y0RH1w@mail.gmail.com>
 <1327100755.2923.6.camel@pasglop>
In-Reply-To: <1327100755.2923.6.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
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

On 01/20/2012 05:05 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2012-01-19 at 13:29 -0600, Stuart Yoder wrote:
>> Also, Scott had posted an approach to do option #2 a while back,
>> but as I  recall there was some negative feedback about this.  See:
>> <http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-August/092103.html>
> 
> I see... the problems with doorbells are workable tho. A reject hcall
> could also raise the CPU priority to avoid lower priority interrupts for
> example. The decrementer option works too.
> 
> Another approach is to do an hcall into the interrupt re-enable path
> when an interrupt occurred while masked, which is what we do on i or
> ps3, which could then trigger a replay.

Here's what I previously wrote to you about this:
> If we never hard-enable with a pending interrupt (go straight to the
> exception entry), we can leave the interrupt in EPR.  If we hard-enable
> even briefly, we can't guarantee that another (higher priority)
> interrupt won't come in before the doorbell, so we need to be able to
> queue up a number of interrupts equal to the number of priorities in use.
> 
> Care will need to be taken to dequeue in proper order, whether the
> interrupt comes in via extirq or doorbell (e.g. if we take an extirq on
> hard-enable, and then the doorbell fires when that interrupt
> hard-enables, we don't want to run the lower-priority queued interrupt
> until after the high prio handler is done).
> 
> BTW, for non-booke, when is DEC checked when interrupts are hard-enabled
> as part of exception return?  Likewise with the PS3 HV thing.  I only
> see the iseries check in the exception path.

Perhaps the issues with a higher priority interrupt intervening can be
addressed by messing around with current task priority at the MPIC (with
an hcall introduced for the hv case, since currently task priority is
not exposed to the guest).  I haven't had time to revisit this, and
don't expect to soon.  If someone else wants to try, fine.  In the
meantime, lazy EE is causing problems.

I'd still like to know the answer to that last question.  It's difficult
to determine how to correctly implement this stuff for our hardware if
it looks like there are holes in the scheme for hardware that this is
supposed to already work with.

> Traditionally EE's have always been "level sensitive" on PowerPC,

You mean besides the places you already have to work around, such as
doorbells and book3s decrementers and other hypervisors... and you force
all functions that enable interrupts to create a stack frame to deal
with this.

> the way you changed that is arguably an utterly broken HW design

Just because you don't like it, and it doesn't play well with your hack,
doesn't make it "utterly broken".

> and I am not too keen on changing our core interrupt handling to deal with it via
> ifdef's if we can find a less invasive solution.

Wheras having to significantly change the way interrupts work because
the register size doubled is so totally reasonable...

What is the compelling reason for forcing lazy EE on us?  Why is it tied
to 64-bit?

-Scott

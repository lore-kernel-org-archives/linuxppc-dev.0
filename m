Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F3B521007D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2012 10:06:17 +1100 (EST)
Message-ID: <1327100755.2923.6.camel@pasglop>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuart Yoder <b08248@gmail.com>
Date: Sat, 21 Jan 2012 10:05:55 +1100
In-Reply-To: <CALRxmdA9mh6x5YGK1oFHvgmV-RsnN6WkxhpZbcRJv1S8Y0RH1w@mail.gmail.com>
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
 <CALRxmdA9mh6x5YGK1oFHvgmV-RsnN6WkxhpZbcRJv1S8Y0RH1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-01-19 at 13:29 -0600, Stuart Yoder wrote:
> Also, Scott had posted an approach to do option #2 a while back,
> but as I  recall there was some negative feedback about this.  See:
> <http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-August/092103.html>

I see... the problems with doorbells are workable tho. A reject hcall
could also raise the CPU priority to avoid lower priority interrupts for
example. The decrementer option works too.

Another approach is to do an hcall into the interrupt re-enable path
when an interrupt occurred while masked, which is what we do on i or
ps3, which could then trigger a replay.

Traditionally EE's have always been "level sensitive" on PowerPC, the
way you changed that is arguably an utterly broken HW design and I am
not too keen on changing our core interrupt handling to deal with it via
ifdef's if we can find a less invasive solution.

Cheers,
Ben.

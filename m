Return-Path: <timur.tabi@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 75A22DDE00
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 09:21:28 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so2082127and.39
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Mar 2009 14:21:26 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <025a01c99c8b$90afb030$6b03a8c0@sdelaney2>
References: <025a01c99c8b$90afb030$6b03a8c0@sdelaney2>
Date: Wed, 4 Mar 2009 16:21:26 -0600
Message-ID: <ed82fe3e0903041421h5163695cl17a8403c56fa0851@mail.gmail.com>
Subject: Re: mpc8349e-mitx 2.6.25 serial IRQ assigned wrong
From: Timur Tabi <timur@freescale.com>
To: onramp123@yahoo.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 3, 2009 at 11:39 PM, Steve DeLaney <onramp123@yahoo.com> wrote:

> For the mpc8349e-mitx this must be incorrect since there is no ISA?

That doesn't matter.  We want the code to be as common as possible.
The actual virtual IRQ value is irrelevant.  The OF code gives you a
virq number, and you just use that.  Any code or board design that
depends on any relationship between the virq and the hwirq is broken.

> Essentially all that is needed is a 1:1 mapping hirq:virq since

Needed for who?

> For now we simply define irq.h NUM_ISA_INTERRUPTS 0

This is a bad idea.  You will just break something else.

-- 
Timur Tabi
Linux kernel developer at Freescale

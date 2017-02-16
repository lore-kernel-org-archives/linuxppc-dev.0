Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP0k93z4jzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 13:40:01 +1100 (AEDT)
Subject: Re: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead
 of numbers in interrupt handler
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
 <f87a41d5-9647-67c4-735e-a7df86c4ff3a@ozlabs.org>
 <62c1a1c3-3a9e-2a9b-b7c1-c23d8d6efcb6@linux.vnet.ibm.com>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <7bac2667-9b7f-9f05-c444-79b1fad31a6a@ozlabs.org>
Date: Thu, 16 Feb 2017 10:40:00 +0800
MIME-Version: 1.0
In-Reply-To: <62c1a1c3-3a9e-2a9b-b7c1-c23d8d6efcb6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mukesh,

> The return value of an interrupt handler is the special type
> irqreturn_t. An interrupt handler can return two special values,
> IRQ_NONE or IRQ_HANDLED.

Yep, you can assume that the reader knows that level of the interrupt
handler API :) What we want to know is how that change in behaviour of
the handler code interacts with the core irq handler code.

The change you're proposing always returns IRQ_HANDLED, whereas the
previous code had cases where it returned:

  - IRQ_NONE, or
  - the (invalid) value -1.

Unless I'm mistaken, there are two things I can see happening with the
old code: if we hit the IRQ_NONE path enough, we'll report a "nobody
cared" error (see __report_bad_irq) and disable the interrupt, or for
the -1 case, we'll immediately log a "bogus return value" error (and, it
looks like a "no thread function available" error too, from
warn_no_thread).

So, it would be nice to mention that this change will fix errors that
result in those log messages. This means that someone debugging those
log messages in futures can find your patch, and see that it addresses
the issue.

> No, this is not user visible issue..

I consider the kernel log output to be user-visible.

> and also here it does not matter what we return from here as we
> are not handling the return value of the handler. 

*We* are not handling the return value of the handler, but the core IRQ
code is.

Regards,


Jeremy

Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWj1V0vT0zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 11:16:30 +1100 (AEDT)
Subject: Re: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead
 of numbers in interrupt handler
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
 <f87a41d5-9647-67c4-735e-a7df86c4ff3a@ozlabs.org>
 <62c1a1c3-3a9e-2a9b-b7c1-c23d8d6efcb6@linux.vnet.ibm.com>
 <7bac2667-9b7f-9f05-c444-79b1fad31a6a@ozlabs.org>
 <1164f7e0-3a0e-69f4-e501-0bc59554a8a4@linux.vnet.ibm.com>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <b46c8d11-66ec-7d6b-0b28-80cabac3d2e4@ozlabs.org>
Date: Mon, 27 Feb 2017 08:16:28 +0800
MIME-Version: 1.0
In-Reply-To: <1164f7e0-3a0e-69f4-e501-0bc59554a8a4@linux.vnet.ibm.com>
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

>> Unless I'm mistaken, there are two things I can see happening with the
>> old code: if we hit the IRQ_NONE path enough, we'll report a "nobody
>> cared" error (see __report_bad_irq) and disable the interrupt, or for
>> the -1 case, we'll immediately log a "bogus return value" error (and, it
>> looks like a "no thread function available" error too, from
>> warn_no_thread).
> 
> bogus return value" error will not come as
> 
> action_ret <= (IRQ_HANDLED | IRQ_WAKE_THREAD)
> i.e
>         0/-1 <= 3 (true)

Well, no. irqreturn_t is an enum, and is being treated as an unsigned
value (the signed/unsigned behaviour of an enum is
implementation-defined), and:

          0xffffffff > 3

so we will *probably* see the bogus return value warning here (based on
some brief experimentation with gcc), but that does depend on the
compiler.

I've submitted a patch to make that comparison more obvious and
explicit:

  https://marc.info/?l=linux-kernel&m=148721917302673

Cheers,


Jeremy

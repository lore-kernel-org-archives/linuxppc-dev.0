Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRklc0gNPzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:20:43 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KDJAuU054280
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:20:41 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28qyr0uxja-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:20:40 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 23:20:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2C0993578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:20:34 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1KDKQXM21627080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:20:34 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1KDK172011511
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:20:01 +1100
Subject: Re: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead
 of numbers in interrupt handler
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
 <f87a41d5-9647-67c4-735e-a7df86c4ff3a@ozlabs.org>
 <62c1a1c3-3a9e-2a9b-b7c1-c23d8d6efcb6@linux.vnet.ibm.com>
 <7bac2667-9b7f-9f05-c444-79b1fad31a6a@ozlabs.org>
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 18:49:42 +0530
MIME-Version: 1.0
In-Reply-To: <7bac2667-9b7f-9f05-c444-79b1fad31a6a@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <1164f7e0-3a0e-69f4-e501-0bc59554a8a4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 16 February 2017 08:10 AM, Jeremy Kerr wrote:
> Hi Mukesh,
>
>> The return value of an interrupt handler is the special type
>> irqreturn_t. An interrupt handler can return two special values,
>> IRQ_NONE or IRQ_HANDLED.
> Yep, you can assume that the reader knows that level of the interrupt
> handler API :)

Sorry i misunderstood your question.

>   What we want to know is how that change in behaviour of
> the handler code interacts with the core irq handler code.
>
> The change you're proposing always returns IRQ_HANDLED, whereas the
> previous code had cases where it returned:
>
>    - IRQ_NONE, or
>    - the (invalid) value -1.

Agree.

>
> Unless I'm mistaken, there are two things I can see happening with the
> old code: if we hit the IRQ_NONE path enough, we'll report a "nobody
> cared" error (see __report_bad_irq) and disable the interrupt, or for
> the -1 case, we'll immediately log a "bogus return value" error (and, it
> looks like a "no thread function available" error too, from
> warn_no_thread).

bogus return value" error will not come as

action_ret <= (IRQ_HANDLED | IRQ_WAKE_THREAD)
i.e
         0/-1 <= 3 (true)

and also "no thread function available" as
we are not returning IRQ_WAKE_THREAD from handler.

Changing the patch description in v2.

Regards,
Mukesh
>
> So, it would be nice to mention that this change will fix errors that
> result in those log messages. This means that someone debugging those
> log messages in futures can find your patch, and see that it addresses
> the issue.
>
>> No, this is not user visible issue..
> I consider the kernel log output to be user-visible.
>
>> and also here it does not matter what we return from here as we
>> are not handling the return value of the handler.
> *We* are not handling the return value of the handler, but the core IRQ
> code is.
>
> Regards,
>
>
> Jeremy
>

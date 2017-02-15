Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNb8N2k3tzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 21:27:48 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FA9D0B134196
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 05:27:46 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mmq21bt0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 05:27:45 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 15:57:42 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4EE58125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:57:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FAQcGL14942338
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:56:38 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FARdce001568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:57:39 +0530
Subject: Re: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead
 of numbers in interrupt handler
To: linuxppc-dev@lists.ozlabs.org, jk@ozlabs.org
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
 <f87a41d5-9647-67c4-735e-a7df86c4ff3a@ozlabs.org>
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 15:57:38 +0530
MIME-Version: 1.0
In-Reply-To: <f87a41d5-9647-67c4-735e-a7df86c4ff3a@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <62c1a1c3-3a9e-2a9b-b7c1-c23d8d6efcb6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeremy,


On Wednesday 15 February 2017 08:48 AM, Jeremy Kerr wrote:
> Hi Mukesh,
>
>> Converts all the return explicit number to a more proper IRQ_HANDLED,
>> which looks proper incase of interrupt handler returning case.
> This looks good to me, but can you describe the effects of those changes
> to the interrupt handler's return code? ie, what happened in the
> erroneous case where we returned 0 (== IRQ_NONE) - does this fix a
> user-visible issue?
>
> Cheers,

The return value of an interrupt handler is the special type 
irqreturn_t. An interrupt handler can return two special values,
IRQ_NONE or IRQ_HANDLED. The former is returned when the interrupt 
handler detects an interrupt for which its device was not
the originator. The latter is returned if the interrupt handler was 
correctly invoked, and its device did indeed cause the interrupt.

No, this is not user visible issue..and also here it does not matter 
what we return from here as we
are not handling the return value of the handler. This handler gets 
triggered when we get interrupt
from opal and in handler we do a opal call which on successful scenario 
disable the interrupt bit which
was set.

-Mukesh

>
>
> Jeremy
>

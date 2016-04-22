Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrlTN1vzdzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:05:12 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 11:35:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3M657Dx31588574
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 11:35:07 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MBX3Ig004460
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 17:03:06 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: Frederic Barrat <frederic.barrat@fr.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 Frank Haverkamp <HAVERKAM@de.ibm.com>,
 Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH 2/2] cxl: Poll for outstanding IRQs when detaching a
 context
In-Reply-To: <1461301069-12331-2-git-send-email-mikey@neuling.org>
References: <1461301069-12331-1-git-send-email-mikey@neuling.org>
 <1461301069-12331-2-git-send-email-mikey@neuling.org>
Date: Fri, 22 Apr 2016 11:35:02 +0530
Message-ID: <87twiu6uwh.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> When detaching contexts, we may still have interrupts in the system
> which are yet to be delivered to any CPU and be acked in the PSL.
> This can result in a subsequent unrelated process getting an spurious
> IRQ or an interrupt for a non-existent context.
>
> This polls the PSL to ensure that the PSL is clear of IRQs for the
> detached context, before removing the context from the idr.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

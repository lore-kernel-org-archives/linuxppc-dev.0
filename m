Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26F171A0634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 01:47:15 +1100 (AEDT)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 14:47:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1E037219005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 14:46:39 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1MEksXj44761124
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 14:46:54 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1MEkrAj009146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 07:46:54 -0700
Subject: Re: Fwd: [PATCH v4 08/18] cxl: IRQ allocation for guests
To: manoj@linux.vnet.ibm.com
References: <1455658751-16970-9-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CB1.5030105@linux.vnet.ibm.com> <56CA3A6F.9060402@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56CB1F5C.9000608@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2016 15:46:52 +0100
MIME-Version: 1.0
In-Reply-To: <56CA3A6F.9060402@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 21/02/2016 23:30, Manoj Kumar a écrit :
>> Subject: [PATCH v4 08/18] cxl: IRQ allocation for guests
>> Date: Tue, 16 Feb 2016 22:39:01 +0100
>> From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
>> mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
>>
>> The PSL interrupt is not going to be multiplexed in a guest, so an
>> interrupt will be allocated for it for each context.
>
> Not clear why this is the case. Why cannot the CXL later still
> multiplex this in a guest? Is this a design choice, an
> architectural issue, or the complexity of implementation did
> not warrant this? From an API perspective it would have been
> preferable to not cascade this change down to all consumers,
> and have consumers aware whether they are working in a
> bare-metal or a guest environment.


It was a design choice made by pHyp. We cannot multiplex the PSL 
interrupt with the current pHyp implementation.

But it doesn't affect the API: the behavior of the API specifying the 
number of interrupts for a context is consistent: the driver always 
expects the number of AFU interrupts on bare-metal and in a LPAR. The 
PSL interrupt is never included.

You can see a difference in the maximum number of attachable contexts 
between bare-metal and powerVM (if the limiting factor is the number of 
available interrupts). But there's no guarantee for that at the API level.

   Fred

Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F2191A05C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 06:02:28 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 12:02:26 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8D2151FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 11:50:32 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1MJ2MVd29884464
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 12:02:22 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1MJ2M9R030650
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 12:02:22 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: Fwd: [PATCH v4 08/18] cxl: IRQ allocation for guests
References: <1455658751-16970-9-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CB1.5030105@linux.vnet.ibm.com> <56CA3A6F.9060402@linux.vnet.ibm.com>
 <56CB1F5C.9000608@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CB5B50.8010106@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2016 13:02:40 -0600
MIME-Version: 1.0
In-Reply-To: <56CB1F5C.9000608@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/22/2016 8:46 AM, Frederic Barrat wrote:
> Le 21/02/2016 23:30, Manoj Kumar a écrit :
>>> Subject: [PATCH v4 08/18] cxl: IRQ allocation for guests
>>> Date: Tue, 16 Feb 2016 22:39:01 +0100
>>> From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>>> To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
>>> mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
>>>
>>> The PSL interrupt is not going to be multiplexed in a guest, so an
>>> interrupt will be allocated for it for each context.
>>
>> Not clear why this is the case. Why cannot the CXL later still
>> multiplex this in a guest? Is this a design choice, an
>> architectural issue, or the complexity of implementation did
>> not warrant this? From an API perspective it would have been
>> preferable to not cascade this change down to all consumers,
>> and have consumers aware whether they are working in a
>> bare-metal or a guest environment.
>
>
> It was a design choice made by pHyp. We cannot multiplex the PSL
> interrupt with the current pHyp implementation.

If that is the case, perhaps the commit message should be re-worded.
As currently written, it seems like it was a choice made by
this patch.

The PSL interrupt cannot be multiplexed in a guest, because blah...

--
Manoj Kumar

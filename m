Return-Path: <jallen@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkzqZ4P61zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 07:00:58 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Tue, 12 Apr 2016 15:00:55 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DE62619D8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 14:48:32 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u3CL0flb38273046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 14:00:41 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3CL0dlf005656
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 15:00:40 -0600
Subject: Re: [PATCH net-next] ibmvnic: Defer tx completion processing using a
 wait queue
To: Eric Dumazet <eric.dumazet@gmail.com>
References: <570D4EBC.60409@linux.vnet.ibm.com>
 <1460491940.6473.592.camel@edumazet-glaptop3.roam.corp.google.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: John Allen <jallen@linux.vnet.ibm.com>
Message-ID: <570D61E7.2090203@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 16:00:23 -0500
MIME-Version: 1.0
In-Reply-To: <1460491940.6473.592.camel@edumazet-glaptop3.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/12/2016 03:12 PM, Eric Dumazet wrote:
> On Tue, 2016-04-12 at 14:38 -0500, John Allen wrote:
>> Moves tx completion processing out of interrupt context, deferring work
>> using a wait queue. With this work now deferred, we must account for the
>> possibility that skbs can be sent faster than we can process completion
>> requests in which case the tx buffer will overflow. If the tx buffer is
>> full, ibmvnic_xmit will return NETDEV_TX_BUSY and stop the current tx
>> queue. Subsequently, the queue will be restarted in ibmvnic_complete_tx
>> when all pending tx completion requests have been cleared.
> 
> 1) Why is this needed ?

In the current ibmvnic implementation, tx completion processing is done in
interrupt context. Depending on the load, this can block further
interrupts for a long time. This patch just creates a bottom half so that
when a tx completion interrupt comes in, we can defer the majority of the
work and exit interrupt context quickly.

> 
> 2) If it is needed, why is this not done in a generic way, so that other
> drivers can use this ?

I'm still fairly new to network driver development so I'm not in tune with
the needs of other drivers. My assumption was that the wait queue data
structure was a reasonably generic way to handle something like this. Is
there a more appropriate/generic way of implementing a bottom half for
this purpose?

-John
> 
> Thanks.
> 
> 
> 
> 

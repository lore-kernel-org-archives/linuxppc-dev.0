Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ql5PT1HbFzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 11:12:10 +1000 (AEST)
Date: Tue, 12 Apr 2016 21:12:02 -0400 (EDT)
Message-Id: <20160412.211202.1299929008077475122.davem@davemloft.net>
To: jallen@linux.vnet.ibm.com
Cc: eric.dumazet@gmail.com, tlfalcon@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] ibmvnic: Defer tx completion processing using
 a wait queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <570D61E7.2090203@linux.vnet.ibm.com>
References: <570D4EBC.60409@linux.vnet.ibm.com>
 <1460491940.6473.592.camel@edumazet-glaptop3.roam.corp.google.com>
 <570D61E7.2090203@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Allen <jallen@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 16:00:23 -0500

> On 04/12/2016 03:12 PM, Eric Dumazet wrote:
>> On Tue, 2016-04-12 at 14:38 -0500, John Allen wrote:
>>> Moves tx completion processing out of interrupt context, deferring work
>>> using a wait queue. With this work now deferred, we must account for the
>>> possibility that skbs can be sent faster than we can process completion
>>> requests in which case the tx buffer will overflow. If the tx buffer is
>>> full, ibmvnic_xmit will return NETDEV_TX_BUSY and stop the current tx
>>> queue. Subsequently, the queue will be restarted in ibmvnic_complete_tx
>>> when all pending tx completion requests have been cleared.
>> 
>> 1) Why is this needed ?
> 
> In the current ibmvnic implementation, tx completion processing is done in
> interrupt context. Depending on the load, this can block further
> interrupts for a long time. This patch just creates a bottom half so that
> when a tx completion interrupt comes in, we can defer the majority of the
> work and exit interrupt context quickly.

You should use NAPI polling for this, not your own invented
mechanism.

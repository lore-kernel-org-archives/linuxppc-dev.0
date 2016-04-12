Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkylX1xNjzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 06:12:24 +1000 (AEST)
Received: by mail-pf0-x22b.google.com with SMTP id 184so19819813pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 13:12:24 -0700 (PDT)
Message-ID: <1460491940.6473.592.camel@edumazet-glaptop3.roam.corp.google.com>
Subject: Re: [PATCH net-next] ibmvnic: Defer tx completion processing using
 a wait queue
From: Eric Dumazet <eric.dumazet@gmail.com>
To: John Allen <jallen@linux.vnet.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Apr 2016 13:12:20 -0700
In-Reply-To: <570D4EBC.60409@linux.vnet.ibm.com>
References: <570D4EBC.60409@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-04-12 at 14:38 -0500, John Allen wrote:
> Moves tx completion processing out of interrupt context, deferring work
> using a wait queue. With this work now deferred, we must account for the
> possibility that skbs can be sent faster than we can process completion
> requests in which case the tx buffer will overflow. If the tx buffer is
> full, ibmvnic_xmit will return NETDEV_TX_BUSY and stop the current tx
> queue. Subsequently, the queue will be restarted in ibmvnic_complete_tx
> when all pending tx completion requests have been cleared.

1) Why is this needed ?

2) If it is needed, why is this not done in a generic way, so that other
drivers can use this ?

Thanks.

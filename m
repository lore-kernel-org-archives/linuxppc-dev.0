Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 647F3104792
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 11:00:13 +1100 (EST)
Message-ID: <4F2B1138.2090004@windriver.com>
Date: Thu, 2 Feb 2012 17:42:00 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: <leoli@freescale.com>
Subject: [RFC] Multi queue support in ethernet/freescale/ucc_geth.c
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Li,

A while back DaveM mentioned that it would be good to
break out the ring allocations[1] in this driver.

I was looking at it, and in the process noticed this:

$ grep 'numQueues.*=' drivers/net/ethernet/freescale/ucc_geth.c 
        .numQueuesTx = 1,
        .numQueuesRx = 1,
$ 

My interpretation of the above is that there is no way
(aside from a code edit) to enable multi queue support.
They are only ever assigned one time, to a value of one.

Assuming I'm not missing something obvious, is the multi
queue support functional and tested, or just old code
that never got tested and subsequently enabled?

The reason I ask, is that the ring allocation code gets rid
of the loop wrapping it, if the driver is really only meant
to ever have just single queues for Rx/Tx. And other areas
of the driver can also be simplified accordingly as well.

Thanks,
Paul.

[1] http://lists.openwall.net/netdev/2010/09/06/45

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EA8FDDED6
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 15:46:11 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Fixes memory leak in ibm_newemac ethernet
	driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: SathyaNarayanan <sathyan@teamf1.com>
In-Reply-To: <1946a170807012145v6e6d629cvea443f2b8462d708@mail.gmail.com>
References: <1214225712-25882-1-git-send-email-sr@denx.de>
	<1214263310.8011.280.camel@pasglop>
	<1946a170807012145v6e6d629cvea443f2b8462d708@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 15:46:00 +1000
Message-Id: <1214977560.21182.35.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> Actually the meachanism of stopping the queue and starting it is
> already there.  But even then due to some sync issue between the poll
> routine and xmit, we were resulted in using the slots of skb which was
> not actually got freed before. 
> I agree this could a bug , Since its not is not clear why buffers are
> not getting transferred timely?. But to handle this we should have a
> work around otherwise system may go out of memory. If we go for
> stopping the queue in these scenario also ( Where a unfreed skbs slot
> has been assigned  to another ), Then kernel may call tx timeout, And
> reset the driver. In that case handelling this special case here could
> lead us better performance as compared to stopping the queue
> Let me know your comments.

Well, if we have a bug, we need to fix it. ie, understand how it is that
the existing mechanism to stop the queue doesn't work, and prevent xmit
from overwriting a non-clear transmit slot (possibly displaying an error
to help us track down the bug).

I'll have to dig a bit, I'll see if I can find some time tomorrow.

Cheers,
Ben.

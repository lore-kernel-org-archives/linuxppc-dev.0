Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F80D68663
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 03:50:39 +1100 (EST)
In-Reply-To: <AHEILKONAKAEJPHNMOPNMEFBCDAA.hs@denx.de>
References: <AHEILKONAKAEJPHNMOPNMEFBCDAA.hs@denx.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e192e9e7fa764d69dc8e4f4d4391a447@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 1 Nov 2005 11:08:30 -0500
To: hs@dexn.de
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: Fix SCC Uart write problem after 2. open()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 1, 2005, at 2:17 AM, Heiko Schocher wrote:

> The following Patch will fix this problem.

This is wrong.  We should never have to reinitialize the
buffer descriptors (which I see the driver does in some cases)
and we certainly should never have to reinitialize the
SCC or SMC peripherals like this.

Once the driver has initialized the SCC or SMC and set up
the buffer descriptors during kernel start up, it should never
be done again.  The only thing we should do is stop/start
the transmitter or receiver, and they should continue operation
with the next buffer descriptor in the ring.

This patch just covers up a driver bug, find and fix the real bug.

Thanks.

	-- Dan

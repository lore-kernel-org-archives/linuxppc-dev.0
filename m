Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A568DE0E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Mar 2008 06:32:01 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JexpN-0004xI-0L
	for linuxppc-embedded@ozlabs.org; Thu, 27 Mar 2008 12:31:57 -0700
Message-ID: <16332251.post@talk.nabble.com>
Date: Thu, 27 Mar 2008 12:31:57 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx Temac Timer ?
In-Reply-To: <20080326194837.096A66A80EE@mail125-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <16306218.post@talk.nabble.com>
	<20080326194837.096A66A80EE@mail125-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




John Linn wrote:
> 
> Hi Kevin,
> 
> I didn't write the code but I know the driver somewhat.
> 
> I think the intention of stopping the timer is to prevent the reentrancy
> as the comment says because there is a function, gmii_poll, that is
> setup on the timer to go read the phy registers to see if anything
> changed in the phy. 
> 
> Stopping the timer prevents a phy read from happening in gmii_poll in
> the middle of the ioctl phy read which could hose things up.
> 
> I don't see why you couldn't change that timer stop to some other form
> of synchronization/mutual exclusion so that the phy reads don't collide.
> 
> As I look at it, it appears to me the spinlock should provide the
> synchronization needed without stopping the timer, but maybe I'm missing
> something. I CCed John Bonesio as he's the guy that developed this code
> I believe and maybe he'll have more insight here.
> 
> Thanks,
> John
> 
I removed the timer code, and it seems to be working correctly, hopefully
the spin lock is all I need to lock out the polling function.  Thanks for
you help

Kevin
-- 
View this message in context: http://www.nabble.com/Xilinx-Temac-Timer---tp16306218p16332251.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

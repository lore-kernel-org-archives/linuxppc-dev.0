Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8771DE462
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Apr 2008 08:08:39 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JmFnw-0001FK-3h
	for linuxppc-embedded@ozlabs.org; Wed, 16 Apr 2008 15:08:36 -0700
Message-ID: <16734685.post@talk.nabble.com>
Date: Wed, 16 Apr 2008 15:08:36 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: XLlTemac  soft lockup BUG
In-Reply-To: <42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <16711066.post@talk.nabble.com>
	<42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hugo Villeneuve-3 wrote:
> 
> Hi,
> we had a similar error message, which was caused by us selecting the wrong
> PHY type in the kernel configuration menu (latest linux-2.6-xlnx-git
> tree). In fact, we had to modify the lltemac driver to support our PHY
> (BCM5466). Once we did that, the error message went away.
> 
> Hugo V.
> 
I tried out all 3 configurations and it didn't seem to help.  We are using
the Marvell Phy on our prototype.  The weird thing is it seems to work
perfectly every once in awhile, but not very often.  I seem to have tracked
the problem to the FifoRecvHandler tasklet function in xlltemac_main.c it
gets stuck in this while loop:
while (XLlFifo_RxOccupancy(&lp->Fifo) != 0) {
the XLlFifo_RxOccupancy always reads the same value.
Any ideas?

Thanks
Kevin
-- 
View this message in context: http://www.nabble.com/XLlTemac--soft-lockup-BUG-tp16711066p16734685.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F90FDDFFA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 04:09:45 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JojPY-00025x-Iy
	for linuxppc-embedded@ozlabs.org; Wed, 23 Apr 2008 11:09:40 -0700
Message-ID: <16834738.post@talk.nabble.com>
Date: Wed, 23 Apr 2008 11:09:40 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XLlTemac  soft lockup BUG
In-Reply-To: <20080416225949.92427BD8076@mail18-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <16711066.post@talk.nabble.com>
	<42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
	<16734685.post@talk.nabble.com>
	<20080416225949.92427BD8076@mail18-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I have done some more digging and it seems like whenever the system works
the command XLlFifo_IsRxEmpty(&lp->Fifo)) returns a 1 meaning that the
RxFifo is empty.  I stuck this test in the xenet_open function right before
the fifo interupt gets enabled.

When ever this test comes back as 0 the ifconfig will get into the soft
lockup I described above.

Is there a function that empties out the fifo, I tried XLlFifo_RxReset but
that doesn't seem to work.

Thanks

Kevin
-- 
View this message in context: http://www.nabble.com/XLlTemac--soft-lockup-BUG-tp16711066p16834738.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

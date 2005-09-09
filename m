Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 1F50368213
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 06:20:22 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050909192739.GA5171@xyzzy.farnsworth.org>
References: <1126287092.21092.14.camel@excalibur.timesys.com>
	<20050909192739.GA5171@xyzzy.farnsworth.org>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 16:20:20 -0400
Message-Id: <1126297220.21092.45.camel@excalibur.timesys.com>
Mime-Version: 1.0
Subject: Re: Marvell MV64360 interrupt question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-09-09 at 12:27 -0700, Dale Farnsworth wrote:
> 
> No additional locking is necessary.  In fact, it seems to me that the 32-bit
> register reads and writes are already atomic and all of the locking using
> mv64x60_lock is superfluous.

Ah ha.  mv64x60.h also defines an mv64x60_modify() function that isn't
intrinsically atomic, so it needs the spinlock.  That in turn requires
mv64x60_read() and mv64x60_write() to play along too.

At least in the general case....



Walt

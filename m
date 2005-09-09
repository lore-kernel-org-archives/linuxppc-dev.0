Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 7F98B68220
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 05:52:20 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050909192739.GA5171@xyzzy.farnsworth.org>
References: <1126287092.21092.14.camel@excalibur.timesys.com>
	<20050909192739.GA5171@xyzzy.farnsworth.org>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 15:52:17 -0400
Message-Id: <1126295538.21092.39.camel@excalibur.timesys.com>
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


Thanks for your response, Dale!


Walt



On Fri, 2005-09-09 at 12:27 -0700, Dale Farnsworth wrote:
> On Fri, Sep 09, 2005 at 05:31:32PM +0000, Walter L. Wimer III wrote:
> >                         mv64x60_write(&bh,
> >                                       MV64x60_GPP_INTR_CAUSE,
> >                                       (1 << (irq - 64)));
> 
> You dropped a ~ on the above line.  It confused me for a bit.
> 

Ooops!  Sorry about that!!!  Yikes!


> > Hmmm...  There's an mv64x60_write() a little earlier in the code...  Is
> > the "extra" mv64x60_read() here to enforce ordering?  If so, should it
> > be moved inside the "if" statement so that it's only executed when
> > actually necessary?
> 
> Yes.  It's there to make sure that the clearing of the GPP interrupt
> is seen by the hardware and takes effect before we return from the function.
> 
> > And what about locking?  The mv64x60_xxxx() functions are protected by a
> > spinlock, but if we're trying to enforce ordering, shouldn't we hold the
> > lock during the entire write+read operation, rather than dropping and
> > reacquiring the lock in between?
> 
> No additional locking is necessary.  In fact, it seems to me that the 32-bit
> register reads and writes are already atomic and all of the locking using
> mv64x60_lock is superfluous.

I wondered about that, too....

> 
> -Dale
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

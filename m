Return-Path: <bwaite@irobot.com>
Received: from irobot.com (unknown [67.130.105.243])
	by ozlabs.org (Postfix) with ESMTP id 064CF68226
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 23:18:13 +1000 (EST)
From: Brian Waite <bwaite@irobot.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 12 Sep 2005 09:05:29 -0400
References: <1126287092.21092.14.camel@excalibur.timesys.com>
	<20050909204955.GA15260@xyzzy.farnsworth.org>
	<20050909211819.GB5034@mag.az.mvista.com>
In-Reply-To: <20050909211819.GB5034@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509120905.29835.bwaite@irobot.com>
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

On Friday 09 September 2005 5:18 pm, Mark A. Greer wrote:
> On Fri, Sep 09, 2005 at 01:49:55PM -0700, Dale Farnsworth wrote:
> > On Fri, Sep 09, 2005 at 08:20:20PM +0000, Walter L. Wimer III wrote:
> > > On Fri, 2005-09-09 at 12:27 -0700, Dale Farnsworth wrote:
> > > > No additional locking is necessary.  In fact, it seems to me that the
> > > > 32-bit register reads and writes are already atomic and all of the
> > > > locking using mv64x60_lock is superfluous.
Unless somthing has changed, on the get_irq case, the interrupts are only 
handled by CPU0. At least that is the way all the platforms have handled it 
in the past. I'd be wary of distributing across other cpus until you really 
look at the enet and mpsc drivers. I don't know of any races off the top of 
my head, but this code was tested and developed with boards only handling 
IRQs on one processor.
> > >
> > > Ah ha.  mv64x60.h also defines an mv64x60_modify() function that isn't
> > > intrinsically atomic, so it needs the spinlock.  That in turn requires
> > > mv64x60_read() and mv64x60_write() to play along too.

> >
> > Yes, the lock is needed for mv64x60_modify(), mv64x60_write().  I still
> > don't think it's needed for mv64x60_read().
>
> IMHO, the mv64x60_read/write/modify routines should be deleted and the
> locking + I/O done explicitly.  That makes it more obvious, more
> efficient in places where there are multiple writes, etc. in a row (not
> as much grabbing/releasing of the spinlock), and is the preferred way to do
> things in linux.
mv64360_read() need not be locked. The data is intrinsicly stale by the time 
the read has completed. The action on the Marvell to write the register is 
atomic, so you will not get partial reads, thus the data is only accurate at 
the instant it is read. By the time code sees it, the data, is not accurate.

Mark is right, locking must be abstracted. The basic r/w functions should do 
locking whatsoever, it is a performance hit on SMP and has no benefit. 
mv64360_modify() is right out. It should never have been included (no insult 
intended Mark), because it appears to have the same behavior (ie atomicity) 
as the mv64360_{read,write}() but it does not. I say the the IO be locked and 
bit twiddled explicity by the user. 

Just my 2 cents. 

Thanks
Brian 
 

>
> A few times now, I almost started to do that...looked at it and went off
> to do something else.  :)  Yes, I'm lazy.  Yes, I should do it.
> Eventually, I will (however, if you want to, I won't complain ;).
>
> Mark
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id A0FC56823C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 07:17:29 +1000 (EST)
Date: Fri, 9 Sep 2005 14:18:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050909211819.GB5034@mag.az.mvista.com>
References: <1126287092.21092.14.camel@excalibur.timesys.com>
	<20050909192739.GA5171@xyzzy.farnsworth.org>
	<1126297220.21092.45.camel@excalibur.timesys.com>
	<20050909204955.GA15260@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050909204955.GA15260@xyzzy.farnsworth.org>
Cc: linuxppc-embedded@ozlabs.org
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

On Fri, Sep 09, 2005 at 01:49:55PM -0700, Dale Farnsworth wrote:
> On Fri, Sep 09, 2005 at 08:20:20PM +0000, Walter L. Wimer III wrote:
> > On Fri, 2005-09-09 at 12:27 -0700, Dale Farnsworth wrote:
> > > 
> > > No additional locking is necessary.  In fact, it seems to me that the 32-bit
> > > register reads and writes are already atomic and all of the locking using
> > > mv64x60_lock is superfluous.
> > 
> > Ah ha.  mv64x60.h also defines an mv64x60_modify() function that isn't
> > intrinsically atomic, so it needs the spinlock.  That in turn requires
> > mv64x60_read() and mv64x60_write() to play along too.
> 
> Yes, the lock is needed for mv64x60_modify(), mv64x60_write().  I still
> don't think it's needed for mv64x60_read().

IMHO, the mv64x60_read/write/modify routines should be deleted and the
locking + I/O done explicitly.  That makes it more obvious, more
efficient in places where there are multiple writes, etc. in a row (not
as much grabbing/releasing of the spinlock), and is the preferred way to do
things in linux.

A few times now, I almost started to do that...looked at it and went off
to do something else.  :)  Yes, I'm lazy.  Yes, I should do it.
Eventually, I will (however, if you want to, I won't complain ;).

Mark

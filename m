Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 4D23268237
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 06:49:57 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 9 Sep 2005 13:49:55 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050909204955.GA15260@xyzzy.farnsworth.org>
References: <1126287092.21092.14.camel@excalibur.timesys.com>
	<20050909192739.GA5171@xyzzy.farnsworth.org>
	<1126297220.21092.45.camel@excalibur.timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126297220.21092.45.camel@excalibur.timesys.com>
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

On Fri, Sep 09, 2005 at 08:20:20PM +0000, Walter L. Wimer III wrote:
> On Fri, 2005-09-09 at 12:27 -0700, Dale Farnsworth wrote:
> > 
> > No additional locking is necessary.  In fact, it seems to me that the 32-bit
> > register reads and writes are already atomic and all of the locking using
> > mv64x60_lock is superfluous.
> 
> Ah ha.  mv64x60.h also defines an mv64x60_modify() function that isn't
> intrinsically atomic, so it needs the spinlock.  That in turn requires
> mv64x60_read() and mv64x60_write() to play along too.

Yes, the lock is needed for mv64x60_modify(), mv64x60_write().  I still
don't think it's needed for mv64x60_read().

-Dale

Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Sep 2007 12:05:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Heiko Schocher <hs@denx.de>
Subject: Re: SYSFS: need a noncaching read
Message-ID: <20070912020526.GD16001@localhost.localdomain>
References: <1189503798.6674.46.camel@Zeus.EmbLux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189503798.6674.46.camel@Zeus.EmbLux>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 11:43:17AM +0200, Heiko Schocher wrote:
> Hello,
> 
> I have developed a device driver and use the sysFS to export some
> registers to userspace. I opened the sysFS File for one register and did
> some reads from this File, but I alwas becoming the same value from the
> register, whats not OK, because they are changing. So I found out that
> the sysFS caches the reads ... :-(
> 
> Is there a way to retrigger the reads (in that way, that the sysFS
> rereads the values from the driver), without closing and opening the
> sysFS Files? Or must I better use the ioctl () Driver-interface for
> exporting these registers?
> 
> I am asking this, because I must read every 10 ms 2 registers, so
> doing a open/read/close for reading one registers is a little bit too
> much overhead.
> 
> I made a sysFS seek function, which retriggers the read, and that works
> fine, but I have again 2 syscalls, whats also is not optimal.
> 
> Or can we make a open () with a (new?)Flag, that informs the sysFS to
> always reread the values from the underlying driver?
> 
> Or a new flag in the "struct attribute_group" in include/linux/sysfs.h,
> which let the sysfs rereading the values?

This sounds more like sysfs is really not the right interface for
polling your registers.  You would probably be better off having your
driver export a character device from which the register values could
be read.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

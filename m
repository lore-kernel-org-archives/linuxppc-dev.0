Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C3616DDF68
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 02:22:44 +1000 (EST)
Date: Thu, 7 Aug 2008 12:22:42 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Josh Boyer
	<jwboyer@linux.vnet.ibm.com>
Subject: [RFC] Driver helper functions.....
Message-ID: <20080807122242.63a9f156@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The design of the warp is basically a processor, an FPGA, some RAM,
some flash, and some glue logic. As the number of drivers rapidly
expands... we are starting to hit inter-driver conflicts with a select
few FPGA registers.

So we need a few "helper" functions to handle locking. Basically
something like this:

static DEFINE_SPINLOCK(fpga_lock);

void warp_fpga_set_imr(imr)
{ /* imr = interrupt mask register */
	lock
	read/modify/write imr
	unlock
}

void warp_fpga_clear_imr(imr);
int warp_fpga_indirect_read();
int warp_fpga_indirect_write();

Maybe a couple more, but I think it would basically be four functions.

So I see a few solutions:

1) Write an fpga driver. That seems overkill for basically exporting
four functions.

2) Add a non-static spinlock to the platform code and export that. This
adds minimal code to the platform code but gives eveybody a lock that
is always there.

3) Add the above functions to the platform code.

So my questions are, what would be best practice? Would adding the
functions and/or spinlock to the platform code be kosher?

And if I did add the spinlock and/or functions to the platform code,
where would I put the include file to export them from? In the arch
code itself? i.e. arch/powerpc/platforms/44x/warp.h?

Cheers,
   Sean

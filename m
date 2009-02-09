Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A71D6DDDA0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 11:11:42 +1100 (EST)
Subject: Re: [patch] powerpc/ps3: Use hard coded values for LV1 device type
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1234092590.10240.4.camel@localhost>
References: <498C6C49.1010200@in.ibm.com>  <498CF52E.4040903@am.sony.com>
	<1234092590.10240.4.camel@localhost>
Content-Type: text/plain
Date: Mon, 09 Feb 2009 11:11:07 +1100
Message-Id: <1234138267.31963.77.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linuxppc-dev@ozlabs.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-02-08 at 22:29 +1100, Michael Ellerman wrote:
> On Fri, 2009-02-06 at 18:42 -0800, Geoff Levand wrote:
> > Change the PS3 platform code to use hard coded numbers for its
> > LV1 device types.
> > 
> > The PS3 platform code was incorrectly using some scsi block
> > constants for the device type returned from the LV1 hypervisor.
> > 
> > Fixes build errors like these when CONFIG_BLOCK=n:
> > 
> >   In file included from include/scsi/scsi.h:12,
> >                    from arch/powerpc/platforms/ps3/platform.h:25,
> >                    from arch/powerpc/platforms/ps3/setup.c:36:
> >   include/scsi/scsi_cmnd.h:27:25: warning: "BLK_MAX_CDB" is not defined
> >   include/scsi/scsi_cmnd.h:28:3: error: #error MAX_COMMAND_SIZE can not be bigger than BLK_MAX_CDB

Adding Jens and James on CC since I think a proper fix lies in blkdev.h
or scsi*.h

So basically, the whole of blkdev.h is inside a big ifdef
CONFIG_BLOCK... which means that scsi_cmnd.h can't build which in turn
makes scsi.h fail.

The PS3 platform code wants to use some of the standard SCSI types from
there though, as they are part of the hypervisor ABI. (And in fact it
can be argued that non-block devices using SCSI do exist, such as
scanners, no ?)

Any reason other than pre-historical to have blkdev.h shielded like
that ?

Cheers,
Ben.

> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> > ---
> > Ben,
> > 
> > Please send upstream for 2.6.29.
> > 
> > -Geoff
> > 
> >  arch/powerpc/platforms/ps3/platform.h |    8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > --- a/arch/powerpc/platforms/ps3/platform.h
> > +++ b/arch/powerpc/platforms/ps3/platform.h
> > @@ -22,8 +22,6 @@
> >  #define _PS3_PLATFORM_H
> >  
> >  #include <linux/rtc.h>
> > -#include <scsi/scsi.h>
> > -
> >  #include <asm/ps3.h>
> >  
> >  /* htab */
> > @@ -83,12 +81,12 @@ enum ps3_bus_type {
> >  };
> >  
> >  enum ps3_dev_type {
> > -	PS3_DEV_TYPE_STOR_DISK = TYPE_DISK,	/* 0 */
> > +	PS3_DEV_TYPE_STOR_DISK = 0, /* TYPE_DISK */
> >  	PS3_DEV_TYPE_SB_GELIC = 3,
> >  	PS3_DEV_TYPE_SB_USB = 4,
> > -	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
> > +	PS3_DEV_TYPE_STOR_ROM = 5, /* TYPE_ROM */
> >  	PS3_DEV_TYPE_SB_GPIO = 6,
> > -	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
> > +	PS3_DEV_TYPE_STOR_FLASH = 14, /* TYPE_RBC */
> 
> This looks like you're just papering over the bug, by hardcoding the
> same values that are in the scsi header. Or are they really independent,
> in which case I'd say the comments are confusing.
> 
> cheers
> 

Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id E3CDADDFE8
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 20:46:23 +1100 (EST)
Date: Wed, 31 Jan 2007 10:46:15 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] PS3: Move system bus to platform directory
In-Reply-To: <20070131084946.GD5596@lst.de>
Message-ID: <Pine.LNX.4.62.0701311045190.12153@pademelon.sonytel.be>
References: <45BFD2BB.1030008@am.sony.com> <20070131084946.GD5596@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 31 Jan 2007, Christoph Hellwig wrote:
> On Tue, Jan 30, 2007 at 03:20:27PM -0800, Geoff Levand wrote:
> > @@ -22,6 +22,9 @@
> >  #define _PS3_PLATFORM_H
> >  
> >  #include <linux/rtc.h>
> > +#include <scsi/scsi.h>
> 
> > +enum ps3_dev_type {
> > +	PS3_DEV_TYPE_STOR_DISK = TYPE_DISK,	/* 0 */
> > +	PS3_DEV_TYPE_SB_GELIC = 3,
> > +	PS3_DEV_TYPE_SB_USB = 4,
> > +	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
> > +	PS3_DEV_TYPE_SB_GPIO = 6,
> > +	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
> > +};
> 
> I don't think you should take some of the values from the scsi device
> types but reuse others.  Just do an enum of your own and if you ever
> have to translate to scsi types somewhere use a lookup table.

Actually the HyperVisor uses the SCSI values for DISK, ROM, and FLASH.
I just wanted to make that clear.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

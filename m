Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 792A0DDECB
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 19:50:03 +1100 (EST)
Date: Wed, 31 Jan 2007 09:49:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 1/4] PS3: Move system bus to platform directory
Message-ID: <20070131084946.GD5596@lst.de>
References: <45BFD2BB.1030008@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45BFD2BB.1030008@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2007 at 03:20:27PM -0800, Geoff Levand wrote:
> @@ -22,6 +22,9 @@
>  #define _PS3_PLATFORM_H
>  
>  #include <linux/rtc.h>
> +#include <scsi/scsi.h>

> +enum ps3_dev_type {
> +	PS3_DEV_TYPE_STOR_DISK = TYPE_DISK,	/* 0 */
> +	PS3_DEV_TYPE_SB_GELIC = 3,
> +	PS3_DEV_TYPE_SB_USB = 4,
> +	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
> +	PS3_DEV_TYPE_SB_GPIO = 6,
> +	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
> +};

I don't think you should take some of the values from the scsi device
types but reuse others.  Just do an enum of your own and if you ever
have to translate to scsi types somewhere use a lookup table.

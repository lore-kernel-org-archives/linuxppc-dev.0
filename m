Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E5B2DE037
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 00:45:36 +1000 (EST)
Date: Mon, 14 Apr 2008 16:47:23 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] FCC: fix confused base / offset
Message-ID: <20080414144723.GD8704@pengutronix.de>
References: <20080409130610.GE10465@pengutronix.de>
	<20080409161110.GA5296@ld0162-tx32.am.freescale.net>
	<20080409165324.GF10465@pengutronix.de>
	<47FCFF64.9050109@freescale.com>
	<20080410104655.GH10465@pengutronix.de>
	<47FE4268.2000504@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FE4268.2000504@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 11:38:00AM -0500, Scott Wood wrote:

Hi Scott,

Thank you for your help so far

> Sascha Hauer wrote:
>> See bottom of this mail. The board really is a 8260 based board. Our
>> bootloader does not fill in the clock values, so they are hardcoded. I'm
>> not very sure about the muram entries because the dpram is organized
>> slightly different on the 8260. It has some dedicated FCC space and I
>> don't know how to properly encode this in the device tree.
>
> I think the FCC space should just be left out.

The old binding used the dpram offset 0xb080 for fcc2 while the new
binding uses cpm_dpalloc which returns 0x80. When I use the old binding
and change the hardcoded value from 0xb080 to 0x80 the fcc stopped
working. I then hardcoded the value for the new binding to the same
value as the old binding used, 0xb080, but no success.

>
>>> Does the PHY negotiate OK?
>>
>> Well I put some printks into the phy_read/write functions so I can say
>> that it at least properly talks to the phy.
>
> Do you get a console message indicating that the link came up?

No, but I didn't get a message for the old binding, too.

I changed the device tree as you suggested, but still no success.

BTW there is one thing I forgot to mention which could throw some light
into this. This commit broke the FCC driver for me although it does the
right thing:

commit c6565331b7162a8348c70c37b4c33bedb6d4f02d
Author: Scott Wood <scottwood@freescale.com>
Date:   Mon Oct 1 14:20:50 2007 -0500

    fs_enet: mac-fcc: Eliminate __fcc-* macros.

    These macros accomplish nothing other than defeating type checking.

    This patch also fixes one instance of the wrong register size being
    used that was revealed by enabling type checking.

    Signed-off-by: Scott Wood <scottwood@freescale.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

It fixes an access to the ftodr register in tx_kickstart(). After ftodr
access the next console message is truncated and my bdi2000 shows me that
the processor doesn't get out of cpm_uart_console_write(). Something
strange is going on here...

Sascha



-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-

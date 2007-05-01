Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 30B19DDFAC
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 00:08:46 +1000 (EST)
Date: Tue, 1 May 2007 15:45:31 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Stefan Roese <sr@denx.de>
Subject: Re: IEEE1588 Precision Time Protocol (PTP) driver for AMCC 405EZ
Message-ID: <20070501134531.GX22585@pengutronix.de>
References: <200704301641.32686.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200704301641.32686.sr@denx.de>
Sender: Robert Schwebel <rsc@pengutronix.de>
Cc: netdev@vger.kernel.org, Jan Kiszka <kiszka@rts.uni-hannover.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2007 at 04:41:32PM +0200, Stefan Roese wrote:
> I'm in the stage of integrating an IEEE1588 PTP driver for the AMCC 405EZ PPC 
> and looking for the correct location to place this driver in the Linux source 
> tree. The driver is a character-driver that enables the user space 
> applications to configure the time stamping unit and to read/write the 
> timestamps.

Could you elaborate your overall concept for this class of drivers? I
assume it makes no sense to write an IEEE1588 driver especially for the
AMCC chip, because there will probably be a need to support it on any
capable hardware; for example the netX has 1588 support for precise
timestamping as well and so do others.

I'd prefer to discuss the needed functionality first, then find a common
set of lowlevel APIs and move most of the IEEE1588 related stuff into
userspace. It might also be a good idea to involve the RTnet in this
discusson.

> Is "drivers/net/ptp" or "drivers/net/ieee1588" a good solution? Or
> should it go to "drivers/char/ptp" because of the chrdev nature of the
> driver?

Please start with discussing the concept, not the names. It might end
being a part of the network drivers, without any special directory.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 575DBDDE23
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 22:21:53 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KLdLp-0006oO-Uz
	for linuxppc-embedded@ozlabs.org; Wed, 23 Jul 2008 05:21:49 -0700
Message-ID: <18609501.post@talk.nabble.com>
Date: Wed, 23 Jul 2008 05:21:49 -0700 (PDT)
From: WITTROCK <jwittrock@maginst.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [OT] write flash on MPC5200 board via jtag
In-Reply-To: <1216753011l.5683l.0l@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <1216753011l.5683l.0l@antares>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I am using  http://urjtag.org/ UrJtag  to do accomplish this.  I have used it
with both a Wiggler clone and an Altera UsbBlaster as the physical JTAG
interface on both a Linux and Windows (cygwin) host.  The only problem is
that this approach is very slow, so I wrote a small (~8kb) "bootstrap"
program which is first put into flash.  This small program then handles
programming u-boot to flash over a serial interface.  Once u-boot is in
place, I use it to program the rest of flash.

Some JTAG tools actually place a small application in the target devices
ram, then this application allows much faster programming of an attached
flash device.  This requires more information about the COP/BDM interface
than is published in the MPC5200B user manual or data sheet.  I haven't used
the Abatron tools, so maybe they do this.  In the case of UrJtag, it is
simply fiddling with bus signals using boundry scan, so it is excruciatingly
slow.

-WITTROCK
-- 
View this message in context: http://www.nabble.com/-OT--write-flash-on-MPC5200-board-via-jtag-tp18596887p18609501.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

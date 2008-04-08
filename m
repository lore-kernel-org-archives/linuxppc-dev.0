Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC79BDDEF9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 02:48:35 +1000 (EST)
Date: Tue, 8 Apr 2008 11:48:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
Message-ID: <20080408164853.GH2552@loki.buserror.net>
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB7822.6090401@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FB7822.6090401@matrix-vision.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 08, 2008 at 03:50:26PM +0200, Andre Schwarz wrote:
> after building a debug kernel and attaching the bdi2000 it looks like  
> the crash occurs during "console_init()" ...

Does your device tree have a /chosen node after u-boot is done with it? 
find_legacy_serial_ports() can crash otherwise (we really should fix that).

> Since we're using a dtb I omit the "console=..." argument for the  
> kernel. Is this correct ?

It's OK if you have /chosen/linux,stdout-path.

> If "console=/dev/ttyS0,115200N8" argument is given the serial console  
> stops working after console_init....
>
>
> On other PowerPC system I could see something like this during boot :
>
> -> find_legacy_serial_port()
> stdout is /soc8568@e0000000/serial@4600
> legacy_serial_console = 1
> default console speed = 115340
> <- find_legacy_serial_port()
>
>
> Should I see this message also ?

Only if you enable debug messages in legacy_serial.c.

> Have I misconfigured anything ?

One thing that sticks out from the above is that you ask for ttyS0, but the
stdout you list from the other system corresponds to ttyS1.  Is this just a
difference between the two systems?

-Scott

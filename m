Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4165DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 10:59:46 +1100 (EST)
Date: Tue, 19 Feb 2008 15:55:54 -0800
From: Greg KH <greg@kroah.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v7 3/4] USB: add Cypress c67x00 OTG controller HCD driver
Message-ID: <20080219235554.GA13304@kroah.com>
References: <20080219150916.263032000@sunsite.dk>
	<20080219151149.684610000@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080219151149.684610000@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 19, 2008 at 04:09:19PM +0100, Peter Korsgaard wrote:
> This patch adds HCD support for the Cypress c67x00 family of devices.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

And it doesn't build:

  CC [M]  drivers/usb/c67x00/c67x00-hcd.o
distcc[2413] ERROR: compile /home/gregkh/.ccache/c67x00-hcd.tmp.mini.2409.i on localhost failed
drivers/usb/c67x00/c67x00-hcd.c:345: error: redefinition of 'c67x00_hcd_probe'
drivers/usb/c67x00/c67x00-hcd.h:119: error: previous definition of 'c67x00_hcd_probe' was here
drivers/usb/c67x00/c67x00-hcd.c:402: error: redefinition of 'c67x00_hcd_remove'
drivers/usb/c67x00/c67x00-hcd.h:126: error: previous definition of 'c67x00_hcd_remove' was here
make[2]: *** [drivers/usb/c67x00/c67x00-hcd.o] Error 1
make[1]: *** [drivers/usb/c67x00] Error 2
make: *** [_module_drivers/usb] Error 2

This is _after_ removing the obviously incorrect usb_disabled()
function that you included in your .h file.

I'm going to hold off applying any of these for now, as it doesn't look
like something is configured properly here.

thanks,

greg k-h

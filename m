Return-Path: <jacmet@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id A9EFBDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 20:01:47 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 25so806047wfa.15
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 01:01:45 -0800 (PST)
To: Greg KH <greg@kroah.com>
Subject: Re: [patch v7 3/4] USB: add Cypress c67x00 OTG controller HCD driver
References: <20080219150916.263032000@sunsite.dk>
	<20080219151149.684610000@sunsite.dk>
	<20080219235554.GA13304@kroah.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 20 Feb 2008 10:01:40 +0100
In-Reply-To: <20080219235554.GA13304@kroah.com> (Greg KH's message of "Tue\,
	19 Feb 2008 15\:55\:54 -0800")
Message-ID: <87bq6cf1cb.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
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

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

 Greg> On Tue, Feb 19, 2008 at 04:09:19PM +0100, Peter Korsgaard wrote:
 >> This patch adds HCD support for the Cypress c67x00 family of devices.
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Greg> And it doesn't build:

 Greg>   CC [M]  drivers/usb/c67x00/c67x00-hcd.o
 Greg> distcc[2413] ERROR: compile /home/gregkh/.ccache/c67x00-hcd.tmp.mini.2409.i on localhost failed
 Greg> drivers/usb/c67x00/c67x00-hcd.c:345: error: redefinition of 'c67x00_hcd_probe'
 Greg> drivers/usb/c67x00/c67x00-hcd.h:119: error: previous definition of 'c67x00_hcd_probe' was here
 Greg> drivers/usb/c67x00/c67x00-hcd.c:402: error: redefinition of 'c67x00_hcd_remove'
 Greg> drivers/usb/c67x00/c67x00-hcd.h:126: error: previous definition of 'c67x00_hcd_remove' was here
 Greg> make[2]: *** [drivers/usb/c67x00/c67x00-hcd.o] Error 1
 Greg> make[1]: *** [drivers/usb/c67x00] Error 2
 Greg> make: *** [_module_drivers/usb] Error 2

Huh, that doesn't make any sense to me. The dumy definitions of
c67x00_hcd_{probe,remove} are protected by an ifndef
CONFIG_USB_C67X00_HCD, and c67x00-hcd.c which contains the real
definitions only gets compiled if CONFIG_USB_C67X00_HCD is
enabled. Could you perhaps provide some more details?

Anyway, the conditional hcd stuff isn't really needed at this point in
the patch series, so I have moved it into patch 4 in the v8 series
I'll post in a minute.

 Greg> This is _after_ removing the obviously incorrect usb_disabled()
 Greg> function that you included in your .h file.

That was again for conditional hcd/udc support. I have now moved the
check into _hcd_probe() instead.

 Greg> I'm going to hold off applying any of these for now, as it
 Greg> doesn't look like something is configured properly here.

Could you give the v8 series a try please?

-- 
Bye, Peter Korsgaard

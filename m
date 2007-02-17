Return-Path: <david-b@pacbell.net>
Received: from smtp102.sbc.mail.mud.yahoo.com (smtp102.sbc.mail.mud.yahoo.com
	[68.142.198.201]) by ozlabs.org (Postfix) with SMTP id D945EDDDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 12:34:00 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] ps3: don't call ps3_system_bus_driver_register on other
	platforms
Date: Fri, 16 Feb 2007 17:33:55 -0800
References: <200702140704.l1E74IqP013586@toshiba.co.jp>
	<45D36285.2010102@am.sony.com>
In-Reply-To: <45D36285.2010102@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702161733.56506.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, greg@kroah.com,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 14 February 2007 11:27 am, Geoff Levand wrote:
> Ishizaki Kou wrote:
> > ps3_system_bus_driver_register is PS3 platform specific function.
> > On other platforms, it triggers WARN_ON in kref_get.
> 
> > +++ linux-powerpc-git/drivers/usb/host/ehci-hcd.c
> > +++ linux-powerpc-git/drivers/usb/host/ohci-hcd.c
> 
> I would think we only need to modify ps3_system_bus_driver_register()
> and ps3_system_bus_driver_unregister() to do the proper thing, not the
> usb host drivers that make those calls.  I'll look into that solution.

Right, that seems like the real bug.  When that's fixed, this patch
can/should be backed out...

- Dave

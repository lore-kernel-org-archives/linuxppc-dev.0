Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAEFFDDF0D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 08:45:03 +1000 (EST)
Date: Mon, 13 Aug 2007 15:28:58 -0700
From: Greg KH <greg@kroah.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH, RFC] wake up from a serial port
Message-ID: <20070813222858.GA16748@kroah.com>
References: <Pine.LNX.4.60.0708130015430.3895@poirot.grange>
	<20070813155734.GB17535@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.60.0708132207530.5643@poirot.grange>
	<46C0C419.6060009@freescale.com>
	<Pine.LNX.4.60.0708132307200.5643@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0708132307200.5643@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 13, 2007 at 11:14:22PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 13 Aug 2007, Scott Wood wrote:
> 
> > Guennadi Liakhovetski wrote:
> > > 
> > > # ls -l /sys/devices/platform/serial8250.0/tty*
> > > lrwxrwxrwx 1 root root 0 Aug 13 22:05
> > > /sys/devices/platform/serial8250.0/tty:ttyS0 -> ../../../class/tty/ttyS0
> > > lrwxrwxrwx 1 root root 0 Aug 13 22:05
> > > /sys/devices/platform/serial8250.0/tty:ttyS1 -> ../../../class/tty/ttyS1
> > > 
> > > And placing some wakeup file under the class/tty/ directory doesn't seem
> > > very consistent with the current policy - until now they only live under
> > > devices/... (Greg added to cc:).
> > 
> > Hmm... I'd assumed each port would have its own device directory.  Would
> > anything break horribly if it were changed so that each tty:ttySx is a
> > directory, which contains both a wakeup file and the symlink?

No, you are already in the tty device directory in the first place, the
tty:ttyS1 is just a symlink to the class in case you need the thing.

Let's follow things around:

	~ $ cd /sys/class/tty
	/sys/class/tty $ ls -l | grep ttyS
	lrwxrwxrwx 1 root root 0 Aug 12 20:12 ttyS0 -> ../../devices/platform/serial8250/tty/ttyS0
	lrwxrwxrwx 1 root root 0 Aug 12 20:12 ttyS1 -> ../../devices/platform/serial8250/tty/ttyS1
	lrwxrwxrwx 1 root root 0 Aug 12 20:12 ttyS2 -> ../../devices/platform/serial8250/tty/ttyS2
	lrwxrwxrwx 1 root root 0 Aug 12 20:12 ttyS3 -> ../../devices/platform/serial8250/tty/ttyS3
	/sys/class/tty $ cd ../../devices/platform/serial8250/tty/ttyS0
	/sys/devices/platform/serial8250/tty/ttyS0 $ ls
	dev  device  power  subsystem  uevent
	/sys/devices/platform/serial8250/tty/ttyS0 $ cd ..
	/sys/devices/platform/serial8250/tty $ $ ls -l
	total 0
	drwxr-xr-x 3 root root 0 Aug 12 20:12 ttyS0
	drwxr-xr-x 3 root root 0 Aug 12 20:12 ttyS1
	drwxr-xr-x 3 root root 0 Aug 12 20:12 ttyS2
	drwxr-xr-x 3 root root 0 Aug 12 20:12 ttyS3
	/sys/devices/platform/serial8250/tty $ cd ..
	gregkh@mini /sys/devices/platform/serial8250 $ ls -l
	total 0
	lrwxrwxrwx 1 root root    0 Aug 12 20:13 driver -> ../../../bus/platform/drivers/serial8250
	-r--r--r-- 1 root root 4096 Aug 13 15:24 modalias
	drwxr-xr-x 2 root root    0 Aug 13 15:24 power
	lrwxrwxrwx 1 root root    0 Aug 12 20:13 subsystem -> ../../../bus/platform
	drwxr-xr-x 6 root root    0 Aug 12 20:12 tty
	-rw-r--r-- 1 root root 4096 Aug 12 20:12 uevent

So, the serial8250 device is the "bridge" for the 4 different serial
ports in my machine.  You have the tty:ttyS? symlinks in that directory
as you have CONFIG_SYSFS_DEPRECATED still enabled, but the directory
structure should all still be the same for you.

So, if you want to put things into the tty device's directory, you can,
they will just show up in the proper place, under
/sys/devices/platform/serial8250/tty/ttyS0 for the first serial port.

Does that make sense?

thanks,

greg k-h

Return-Path: <david-b@pacbell.net>
Received: from smtp111.sbc.mail.mud.yahoo.com (smtp111.sbc.mail.mud.yahoo.com
	[68.142.198.210]) by ozlabs.org (Postfix) with SMTP id CB9E067C3B
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 12:21:29 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [Bulk] Re: NTP time sync
Date: Sun, 26 Nov 2006 17:21:23 -0800
References: <20061126202148.190d5b4b@inspiron>
	<00b301c711a3$07cf3530$020120ac@Jocke>
	<20061126235317.5d40d22c@inspiron>
In-Reply-To: <20061126235317.5d40d22c@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611261721.25473.david-b@pacbell.net>
Cc: akpm@osdl.org, 'Andi Kleen' <ak@muc.de>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, paulus@samba.org, kkojima@rr.iij4u.or.jp,
	davem@davemloft.net, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 26 November 2006 2:53 pm, Alessandro Zummo wrote:
> On Sun, 26 Nov 2006 22:37:10 +0100
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:
> 
> > >  the concept of static numbers is quite old...
> > 
> > Yes it is old, but is the old way unsupported now? I have an embedded target
> > which is using the old static /dev directory, do I need to make
> > it udev aware to use newer features like the rtc subsystem?
> 
>  That can be a good option. 

And it's simple enough.  You might not even need to run "udevd"
if you don't have hotpluggable devices ... just the startup stuff,
which you might not need after the first boot.  (Since the set of
devices will be stable, /dev/* won't change, and you can speed up
system boot by that small delta.)

I certainly run udev on some small systems, with /sbin/hotplug as
appended.  Getting udev set up, and handling coldplug, is left as
an exercise for the reader.  :)

- Dave

#!/bin/ash
#
# "hotplug" initializes devices ... hardware drivers get modprobed and
# create class devices.  then later udev handles /dev node creation and
# invokes programs that make userspace aware of the new device node.
#
# install as /sbin/hotplug

if [ ! -d /sys ]
then
	exit 1
fi
cd /sys

if [ "$ACTION" = "add" -a "$SUBSYSTEM" = "mmc" ]
then
	# MMC doesn't support modalias yet, but this is
	# the only choice until we have SDIO support.
	MODALIAS=mmc_block
fi

if [ "$ACTION" = "add" -a -n "$MODALIAS" -a ! -L $DEVPATH/driver ]
then
	# most important subsystems now have $MODALIAS support:
	modprobe -q $MODALIAS
fi

if [ -n "$DEVPATH" ]
then
	/sbin/udevsend $1
fi

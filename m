Message-ID: <3E24240B.4000404@embeddededge.com>
Date: Tue, 14 Jan 2003 09:51:55 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: markc@mail.com,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Control-C in bash ???
References: <200301131409.00113.markc@mail.com> <1042551106.8605.109.camel@zambia>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Zeffertt wrote:


> I had exactly the same problem with ash (busybox version), but I found
> it went away when I replaced
>
> ttyS0::respawn:-/bin/sh
>
> in /etc/inittab with
>
> ttyS0::respawn:/sbin/login
>
> I have no idea why....

If all of you would look back into the mailing list archives you would
notice this discussion before.  The reason ctl-C won't work is you need
a "controlling tty" device.

The program that is started as process ID 1 is a special program (expected
to be '/sbin/init') and can't be used as a 'controlling tty'.  Signals to
this process are managed differently in the kernel.  Any program you start
in this process ID slot, which is you favorite shell or busybox or whatever,
can't assign a controlling tty and get the ctl-C signals.  It doesn't matter
how it is built or what ioctls you try to send to the driver.

If you start up init, or run /bin/login or any of a variety of things you
can do to actually configure a controlling tty and spawn a shell will
obivously work as expected.  Starting up a shell as 'init=/bin/sh', or some
other program in the 'init' PID 1 slot is considered a recovery method and
will lose some of its tty functions.  Even for a shell not in the PID 1 slot,
you have to do something along the path to configure a driver as a "controlling
tty", using /bin/login or the methods Wolfgang described in past messages.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

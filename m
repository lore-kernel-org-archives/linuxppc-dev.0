Date: Mon, 12 Nov 2001 19:55:37 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <3BF012CA.287A76A@mvista.com>
Message-ID: <Pine.GSO.3.96.1011112194341.24771M-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 Nov 2001, Jun Sun wrote:

> The /dev/rtc interface is highly influenced by MC146818 chip, which not all
> RTC devices are alike.  The only fundamental thing in the driver is really the
> read and write time.

 You need only to keep the interface, which is:

static struct file_operations rtc_fops = {
	owner:		THIS_MODULE,
	llseek:		no_llseek,
	read:		rtc_read,
#if RTC_IRQ
	poll:		rtc_poll,
#endif
	ioctl:		rtc_ioctl,
	open:		rtc_open,
	release:	rtc_release,
	fasync:		rtc_fasync,
};

Of these you probably must only implement open() and ioctl() -- you may
provide others as hardware permits -- see how these functions are
implemented in drivers/char/rtc.c.  The interface is pretty generic, IMHO.

> If their abstraction is reasonable, perhaps they can all converge to a better,
> more generic rtc interface.

 Just implement the ioctls given hardware permits and return -EINVAL for
others.  Again, they are pretty generic: get/set the time, alarm, epoch,
disable/enable various interrupts, etc. -- see include/linux/rtc.h.  You
may propose additional ioctls if they would be useful for particular
hardware.

--
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

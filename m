Date: Wed, 18 Sep 2002 14:39:46 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: Ricardo Scop <scop@plugin.com.br>
Message-ID: <9610.020918@plugin.com.br>
To: Atm account <linux2@cdotd.ernet.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: help needed for porting linux-2.5 to a ppc custom board
In-reply-To: <Pine.OSF.4.10.10209181158001.6582-100000@moon.cdotd.ernet.in>
References: <Pine.OSF.4.10.10209181158001.6582-100000@moon.cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Piyush,

I'm not really an expert, so I'll help only with what I know. Read
below.

I'm also relaying this message to the public list, so they can help
you further, possibly correcting me if I'm wrong :o)

[]'s, Scop                            mailto:scop@digitel.com.br

------------------------------------------------------------------
It might look like I'm doing nothing, but at the cellular level I'm
really quite busy.

Wednesday, September 18, 2002, 4:49:15 AM, you wrote:


Aa> Hello Ricardo,

Aa>     Thanks a lot for your replies.

<snip>

Aa> Actually my requirement is to have printk messages and kgdb prints coming
Aa> from this uart. Is this possible to have printk-msgs while running kernel
Aa> in kgdb mode?
Sorry, I never used kgdb on my custom board (we have a BDI2000!).

Aa> Sometimes my requirement is to connect some other serial device to the
Aa> uart and that time i want to store printk messages some where else or
Aa> dump through network-interface.
AFAIK, you can always get printk messages through /proc/kmsg. I don't
know if there's an already implemented way of inhibiting them from
going to the debug console.

Aa>  After going through the arch/ppc/8*_io/uart.c files, I have the
Aa> following doubts :-
Aa> 1. After rs_8xx_init() is called, do the printk messages come out
Aa>   of this port using serial_console_write() function?
No, AFAIK.

Aa>    rs_8xx_init() is called from tty_init() from chr_dev_init()
Aa>   which will also call init's() of other character drivers, whose
Aa>   debugging printk's i want to come through this port.

Aa> 2. If not, is it the case that this uart is unregistered from list
Aa>   of consoles?
No, neither that. The uart port is used for both purposes
concurrently.

Aa> Regards,
Aa> Piyush.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

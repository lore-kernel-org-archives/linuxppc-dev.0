Subject: Re: GT64260_eth (Ethernet) Driver
From: David Woodhouse <dwmw2@infradead.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40DCBE32.2030008@mvista.com>
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>
	 <40DA06BE.204@mvista.com>
	 <1088066228.18627.3352.camel@hades.cambridge.redhat.com>
	 <40DB2199.2050006@mvista.com>
	 <1088147437.4636.114.camel@imladris.demon.co.uk>
	 <40DCA1A3.6000401@mvista.com>
	 <1088207000.4636.136.camel@imladris.demon.co.uk>
	 <40DCBE32.2030008@mvista.com>
Content-Type: text/plain
Message-Id: <1088518106.14216.1415.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 15:08:27 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-25 at 17:07 -0700, Mark A. Greer wrote:
> Let me know how it goes.

I have memory probing working at last. I don't quite understand what I
was doing wrong there -- I think I was just being stupid and/or the code
to move the GT64x60 internal registers doesn't work. If I leave it where
the bootloader put it, it's OK.

Automatic detection of the chip type still isn't working, because it
tries to work it out from its own PCI ident, but the MV64360 doesn't
seem to appear on the PCI bus -- there _is_ no device 0.

The memory windows aren't right -- you have base_bits == 20 but those 20
bits actually hold bits 16-35 of the address. That's not a typo, so
setting base_bits to 16 seems to be the correct thing to do unless we're
going to handle 'extended address mode'.

Also we disable all the memory windows for I/O and only re-enable them
later. That breaks if we actually try to access any of the I/O in the
meantime -- which we do if we enable MV64x60 debugging, because it keeps
calling printk() :)

Is there a reason we need to disable the windows? Could we pass an array
of the desired settings to mv64x60_init() and have them set up
immediately, rather than just disabled and then fixed again later?

I could register my console later, I suppose, and live without printk
until after setup_arch()... but that sucks.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

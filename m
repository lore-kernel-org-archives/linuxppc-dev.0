Subject: Re: mv6360 support in mv64x60.c (was Re: GT64260_eth (Ethernet)
	Driver)
From: David Woodhouse <dwmw2@infradead.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linux-emb <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40E1E94B.9060204@mvista.com>
References: <40E1E94B.9060204@mvista.com>
Content-Type: text/plain
Message-Id: <1088590981.4636.200.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Wed, 30 Jun 2004 11:23:01 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-06-29 at 15:12 -0700, Mark A. Greer wrote:
> You mean in the arch/ppc/boot/simple code, right?  You may need to do
> something like what is in arch/ppc/boot/simple/misc-ev64260.S to move
> the dev windows for your uart (if you're using an external uart).  I
> successfully change the internal registers base addr on the ev64260.

No, the UART is fine (except if we play with its windows as discussed
later). It's the GT64360 which isn't where it should be. I'm told that
sometimes they don't accept being moved more than once -- and I'm happy
enough with it at 0xEFF00000 where it starts off anyway; it's just that
I inherited the default setting of 0xF1000000 for
CONFIG_GT64x60_NEW_BASE.

> >Automatic detection of the chip type still isn't working, because it
> >tries to work it out from its own PCI ident, but the MV64360 doesn't
> >seem to appear on the PCI bus -- there _is_ no device 0.
>
> Strange...according to the manual, you figure it out the same way no
> matter what bridge it is and it works for the 260 on my ev64260.  Are
> you sure your setup_info is correct?

Well I can see all the other devices on the PCI bus, and when I boot the
2.4 kernel it doesn't seem to have a device 0 either. So yes, fairly
sure. I'm staring at the docs trying to find out if there's a bit in a
register somewhere which makes the chip hide from its own PCI buses.

> >The memory windows aren't right -- you have base_bits == 20 but those 20
> >bits actually hold bits 16-35 of the address. That's not a typo, so
> >setting base_bits to 16 seems to be the correct thing to do unless we're
> >going to handle 'extended address mode'.
>
> Yes, 20 bits in the reg starting at bit 0 (LSB) correspond to bits
> 35:16 of the window.  As long as the 'base' you pass into
> mv64x60_set_32bit_window() is correct, it should work I think (or be
> close)--but, of course, I haven't tested it yet :)
>
> Would you turn on DEBUG and send me the dump (along with your
> setup_info) or give me a reg dump from you bdi (or whatever) or a dump
> of what's in __log_buf.

It used to say this:

set 32bit window: 4, base: 0xe0010000, size: 0x10000, other: 0x0
shift right val: 0xe0010000, num_bits: 20 == 0xe0010
would change base_reg from 0000e001 to 000e0010

... and then nothing else, because it had just broken the UART.

Now with base_bits == 16 it says this:

set 32bit window: 4, base: 0xe0010000, size: 0x10000, other: 0x0
shift right val: 0xe0010000, num_bits: 16 == 0xe001
would change base_reg from 0000e001 to 0000e001


> >Also we disable all the memory windows for I/O and only re-enable them
> >later. That breaks if we actually try to access any of the I/O in the
> >meantime -- which we do if we enable MV64x60 debugging, because it keeps
> >calling printk() :)
>
> Well, I've been burned in the past by "dangling windows" so I was
> trying to be as safe as possible.  BTW, prink() isn't atually the
> issue since console_init() isn't called for some time after
> setup_arch().

It's definitely printk. I don't have a hardware debugger so I don't like
waiting till console_init() - I register a console in platform_init().

> Okay, I think we're in agreement.  Just to make sure, the solution is
> to add an array to setup_info that contains the dev bus window ranges
> and have the core code set those up when its setting up the PCI
> windows.  Agree?

Possibly. Although it seems like overkill -- we could live with just a
bitmap of those windows we want the init to leave as they were -- we
don't need it to set _everything_ up for us; just not destroy the
windows we're actually using right now.

> >I could register my console later, I suppose, and live without printk
> >until after setup_arch()... but that sucks.
>
> You must have some other issue.  printk() isn't going to actually try
> to access the uart/mpsc until console_init() is called in
> start_kernel().

Console_init() is just an earlier round of initcalls than the normal
ones, and there's absolutely no need to wait that long. For debugging
early boot crashes, add something like this to gen550_dbg.c and call
gen550_console_register() in platform_init()...

#include <linux/console.h>
static void gen550_console_write(struct console *con, const char *s, unsigned n) {
        unsigned int progress_debugport;
        int i;

        progress_debugport = serial_init(1, NULL);

        for(i=0; i<n; i++) {
                if (s[i] == 10)
                serial_putc(progress_debugport, 13);
                serial_putc(progress_debugport, s[i]);
        }
}

struct console gen550_console = {
        .name = "gen550",
        .write = gen550_console_write,
        .flags = CON_PRINTBUFFER,
        .index = -1
};

void gen550_console_register(void)
{
        register_console(&gen550_console);
}


--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

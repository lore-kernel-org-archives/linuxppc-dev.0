Message-ID: <40E1E94B.9060204@mvista.com>
Date: Tue, 29 Jun 2004 15:12:27 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: mv6360 support in mv64x60.c (was Re: GT64260_eth (Ethernet) Driver)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>On Fri, 2004-06-25 at 17:07 -0700, Mark A. Greer wrote:

>>> Let me know how it goes.
>
>
>
>I have memory probing working at last. I don't quite understand what I
>was doing wrong there -- I think I was just being stupid and/or the code
>to move the GT64x60 internal registers doesn't work.  If I leave it where
>the bootloader put it, it's OK.

You mean in the arch/ppc/boot/simple code, right?  You may need to do something like what is in arch/ppc/boot/simple/misc-ev64260.S to move the dev windows for your uart (if you're using an external uart).  I successfully change the internal registers base addr on the ev64260.

>Automatic detection of the chip type still isn't working, because it
>tries to work it out from its own PCI ident, but the MV64360 doesn't
>seem to appear on the PCI bus -- there _is_ no device 0.

Strange...according to the manual, you figure it out the same way no matter what bridge it is and it works for the 260 on my ev64260.  Are you sure your setup_info is correct?

>The memory windows aren't right -- you have base_bits == 20 but those 20
>bits actually hold bits 16-35 of the address. That's not a typo, so
>setting base_bits to 16 seems to be the correct thing to do unless we're
>going to handle 'extended address mode'.

Yes, 20 bits in the reg starting at bit 0 (LSB) correspond to bits 35:16 of the window.  As long as the 'base' you pass into mv64x60_set_32bit_window() is correct, it should work I think (or be close)--but, of course, I haven't tested it yet :)

Would you turn on DEBUG and send me the dump (along with your setup_info) or give me a reg dump from you bdi (or whatever) or a dump of what's in __log_buf.

>Also we disable all the memory windows for I/O and only re-enable them
>later. That breaks if we actually try to access any of the I/O in the
>meantime -- which we do if we enable MV64x60 debugging, because it keeps
>calling printk() :)

Well, I've been burned in the past by "dangling windows" so I was trying to be as safe as possible.  BTW, prink() isn't atually the issue since console_init() isn't called for some time after setup_arch().  However, it is an issue for progress & KGDB.  Good point, though, I missed that one.  What if we extend the setup_info to include dev bus windows and make a routine to set those up when we're setting up the pci windows??

>Is there a reason we need to disable the windows? Could we pass an array
>of the desired settings to mv64x60_init() and have them set up
>immediately, rather than just disabled and then fixed again later?

Okay, I think we're in agreement.  Just to make sure, the solution is to add an array to setup_info that contains the dev bus window ranges and have the core code set those up when its setting up the PCI windows.  Agree?

>I could register my console later, I suppose, and live without printk
>until after setup_arch()... but that sucks.

You must have some other issue.  printk() isn't going to actually try to access the uart/mpsc until console_init() is called in start_kernel().  Before console_init() is called, the msgs are just being put into __log_buf.  If you are panic'ing in console_init() then you may be missing a window setup call in your board's setup_arch routine or the address you specified for the uart is wrong (or something like that).  If you're using progress or KGDB, that's a different story.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

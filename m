Date: Wed, 11 Jun 2003 09:11:21 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Bill Fink <billfink@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: init does not run on 405GP system
Message-ID: <20030611071121.GY9379@pengutronix.de>
References: <20030610232157.2f012435.billfink@mindspring.com> <20030611045351.GA20132@pengutronix.de> <20030611022215.572055d2.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20030611022215.572055d2.billfink@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 11, 2003 at 02:22:15AM -0400, Bill Fink wrote:
> One other simple thing to try if you haven't already is the kernel
> boot parameter init=/bin/bash.

Well, I've replaced init by a statically linked hello-world program. So
there should be no need for any shared library besides ld.so.1, the ELF
processor, but that one is loaded correctly and as far as I can see it
interprets the ELF file right; the right code is loaded (compared the
binary mem content at the entry point with objdump output) and the
correct entry point is called, but exactly after that I don't get an
answer any more. Unfortunately this is the point where the BDI doesn't
help any more because it cannot follow the user space memory mapping.

> gwiz% ldd /sbin/init
>         libc.so.6 => /lib/libc.so.6 (0x0fea0000)
>         /lib/ld.so.1 => /lib/ld.so.1 (0x30000000)

metis:/tftpboot/solidcard/sbin# file init
init: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), statically linked, stripped

And I don't see any call to the open() system call.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

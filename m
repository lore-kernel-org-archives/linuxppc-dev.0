To: "Francis Yu <francisy@luxn.com>" <francisy@luxn.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hung inside execve 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Nov 2002 11:55:29 PST."
             <B0CD235912AED411B69800D0B7C9F60F1DF88A@mail>
Date: Tue, 26 Nov 2002 21:40:29 +0100
Message-Id: <20021126204034.87211C614B@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B0CD235912AED411B69800D0B7C9F60F1DF88A@mail> you wrote:
>
> I have been going through the LinuxPPC archives, looking for answers to my
> problem, but still could not proceed ahead. My problem is that the Linux
> will hang after the line 'execve("bin/sh", argv_init, envp_init);' inside
> the init function of the file main.c. I have added the printk statements
> preceding each of the execve calls. The last prink should be right before
> the panic statement but it did not get executed, therefore I suspect that
> the culprit is 'execve("bin/sh", argv_init, envp_init);' .

Ummm... in situations like this life is _much_ easier  when  you  can
use a debugger. Get yourself a BDI2000!

> My hardware is a custom 860T cpu with 16M RAM running at 50Mhz. I have
> ported PPCboot 1.2.0 on the hardware. The linux I am trying to load is the
> TMQ860L from DENX's development package. The Ramdisk image I am using is
> also from DENX's ftp site. From that site there are two samples of Ramdisk,
> one is "simple_ramdisk", the other is "ramdisk_2048". I have tried both and
> got the same result. I am sure that I must have missed something, but I do
> not know what I have overlooked. Could some body please help me out on this.

A ramdisk environment is noce for a target  system,  but  a  hell  to
debug.  Configure  your  system to mount the root filesystem over NFS
instead. Then run a network sniffer (like "ethereal") and you can see
pretty well which binaries and libraries are being loaded, and  which
other files are accessed.

This is much, much more efficient that  using  a  ramdisk  where  you
cannot  see  anything. Especially if you don't use a BDI2000, but I'm
repeating myself.

> By the way, I can see a lot of people posting questions and receiving a lot
> of answers or suggestions. But I seldom see the originator of the questions
> follows up with the final solution of how the problem got fixed. In this

Ah, someone who remembers good old usenet netiquette!

...
> ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
> PCMCIA slot @: phys mem ffffffff...00000000 (size 00000001)
> PCMCIA slot has not been defined! Using A as default
> No card in slot A: PIPR=ff00ff00

Be careful when your system is NOT a TQM860L module! The PCMCIA  code
does  some  pretty hardware specific things like enabling / disabling
bus drivers and switching the power to the PCMCIA slot - at least  it
does  so  on  the TQM8xxL. I habe no idea what might be connected to
those pins on your board...

...
> JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
> JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
> AB.
> CFI: Found no TQM8xxL Bank 0 device at location zero
> CFI: Found no TQM8xxL Bank 1 device at location zero
> CFI: Found no TQM8xxL Bank 2 device at location zero
> CFI: Found no TQM8xxL Bank 3 device at location zero
> TQM8xxL: No support flash chips found!

You should probably disable features that don;t exist on your  board,
or that are not compatible.

>  /sbini/init
^^^^^^^^^^^^^^   Really??? Is this really /sbini ?
>  /etc/init
>  /bin/init
>  /bin/sh

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Programmer's Lament: (Shakespeare, Macbeth, Act I, Scene vii)
        "That we but teach bloody instructions,
        which, being taught, return to plague the inventor..."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: curt brune <curt@acm.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: booting on embedded planet RPX_LITE-DW (823e) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Sep 2002 22:14:30 PDT."
             <20020910051430.GA1543@lenin.net>
Date: Tue, 10 Sep 2002 08:57:07 +0200
Message-Id: <20020910065712.2B2EBFA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Curt,

in message <20020910051430.GA1543@lenin.net> you wrote:
>
> Note, however that I jump to 0x410000, not the 0x400000 where I loaded
> the image.  A kind soul informed me that I had to start execution at
> an offset of 0x10000 from where I load the image.  That really helped
> me a lot, since trying to execute at 0x400000 would just hang at the go.
>
> Does anyone know a reason for the 0x10000 offset?  Can you point me to

It seems you are loading a file in ELF format. 0x10000  is  64  kB  -
this  size  of  the ELF file header. In the Pre-PPCBoot times when we
still used this  bootstrap  loader  method  for  booting  we  alsways
stipped  this  header  - this saves 64 kB (more than 10% of the image
size!) in flash:

	dd if=zImage of=zImage.raw bs=64k skip=1

> the documentation ?  Also what do the two columns of addresses mean in
> the above output ?  Subsequent to this break through, however, I am

These are the start and end addresses of the respective memory  areas
used by your bootstrap loader code.

> stuck at the "Linux/PPC load:" line.  The system just hangs here.  I
> would have expected to see messages like:
>
> >> Uncompressing Linux...done.
> >> Now booting the kernel
> >> Linux version 2.4.4 ....
> >> .....
>
> But I get nothing.  It is as if the uncompression code is not being
> run.  Anyone have any ideas on how to get past this step?

Attach a debugger? Do you have access to a BDI2000?

> I thought it might be my serial port is not configured properly.
> Maybe the system is booting, but I'm not seeing anything over the
> serial line.  In the documentation for my board it says the serial
> port is SMC1 and the ethernet is SMC2.  In the kernel config I see

This is impossible. The SMC ports cannot be used for Ethernet. I  bet
you mistake this for SCCx.

> options for setting the ethernet to SMC1-SMC3, but I do not see

No, again, this is SCCx - there is not even a SMC3.

> anything about setting the serial port to SMC1.  Could that be a
> problem?

SMC1 is enabled as serial console port by default.  In  the  standard
kernel there is no configuration option for this.

> I do appreciate your time, really.  I'm doing this as a hobby --
> nobody is going to get rich if I can get this board to boot :)

Good luck!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
At the source of every error which is blamed on the computer you will
find at least two human errors, including the error of blaming it  on
the computer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

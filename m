Message-Id: <200010152004.WAA22222@denx.local.net>
To: Konstantin <konstantin.sabodash@fnc.fujitsu.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mbxboot->head.S 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 15 Oct 2000 14:30:57 EDT."
             <39E9F7E1.523E3693@fnc.fujitsu.com>
Date: Sun, 15 Oct 2000 22:04:00 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <39E9F7E1.523E3693@fnc.fujitsu.com>
Konstantin Sabodash wrote:
>
> I try to port Kernel to custom MPC860 board.
> BSEIP architecture is close to my board.

What firmware do you have on your board?

> I used  pROBE   to load zvmImage on my board . ELF loader put   .text
> section straight into 0x180000.

First, the code in mbxboot/head.S  expects  that  some  configuration
parameters  are  being  passed  from  the  firmware in a "board info"
structure. Make sure you feed correct values into the code,  or  this
won't work.

Also, make sure that you don't just load the  standard  ELF  sections
(text,  data,  bss),  but  also the Linux specific extensions (image,
ramdisk).

> I fixed it  and I pass to Kernel R3 through R7 registers with valid
> context.
>
> Still, nothing  happen.  In log_buf I see that kernel  reports 0 K ( and
> some negative values ) memory allocation for its buffers and pages.

Seems you have problems with parameter passing.

> The question is what else, besides R3-R7 wee need to pass to kernel  to
> make it work?

Simply put, youneed to pass correctly  initialized  hardware,  and  a
board info structure with correct values.

> Any idea are welcome.

If you have some firmware on your board, adapt the pre-kernel code in
mbxboot/ to your needs. If you don't have firmware yet,  or  find  it
not ideal for use with Linux, have a look at PPCBoot which was speci-
fically  designed and implemented with Linux in mind (see the project
page at http://ppcboot.sourceforge.net , or get a tarball with source
code from ftp://ftp.denx.de/pub/ppcboot/ ).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Accident: A condition in which presence of mind is good, but  absence
of body is better.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

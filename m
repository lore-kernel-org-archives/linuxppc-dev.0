To: Richard Danter <richard.danter@ntlworld.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Simple module, but won't build 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 May 2004 20:46:55 BST."
             <4097F32F.6090504@ntlworld.com>
Date: Tue, 04 May 2004 22:19:18 +0200
Message-Id: <20040504201923.46320C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4097F32F.6090504@ntlworld.com> you wrote:
> Hi Wolfgang,
>
> Wolfgang Denk wrote:
> >
> > Seems you are missing to include some necessary header  files  and/or
> > to provide the necessary compiler options.
>
> I am taking a driver I wrote for a 2.4.2 kernel, built with 2.95.x
> compiler and trying to port it to 82xx from 8xx and use the new ELDK.
>
> Since it is so simple, it just writes to a mem mapped I/O port to set
> some LED's on/off, I assumed it would be pretty simple. But alas, that
> was probably a bad assumption on my part.
>
> The main module includes the following:
>
Insert:

	#include <linux/kernel.h>
	#include <linux/init.h>

>    linux/module.h
>    linux/fs.h

Probably needed:

	#include <asm/types.h>

>    asm/io.h
>    asm/uaccess.h
>
> in that order.
>
> I have grep'ed for CONFIG_KERNEL_START and CONFIG_TASK_SIZE and the only
> place I can find them defined is in the kernel source .config (and
> default config files for each board). Not in any of the header files.

Grep after configuring the kernel, and you should find them in

	include/linux/autoconf.h:#define CONFIG_KERNEL_START 0xc0000000
	include/config/kernel/start.h:#define CONFIG_KERNEL_START 0xc0000000
resp.
	include/linux/autoconf.h:#define CONFIG_TASK_SIZE 0x80000000
	include/config/task/size.h:#define CONFIG_TASK_SIZE 0x80000000

> Maybe I am sposed to #define them myself - I tried that and it worked -
> but would like a more automagic solution if there is one!

There is no magic involved ;-)

> Command line options are:
>
>    -D__KERNEL__ -DMODULE -Wall -fno-builtins -O -c

This is not good either. You may try running a "make modules" in  you
kernel  source  directory and see what CFLAGS are needed; for me this
looks for example like this:

CFLAGS="-D__KERNEL__ -I/work/TQM860L/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/work/TQM860L/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE"

Some of the options (like -msoft-float) are not optional at all ;-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If A equals success, then the formula is A = X + Y + Z. X is work.  Y
is play. Z is keep your mouth shut.                 - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

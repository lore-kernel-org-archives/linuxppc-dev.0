Message-Id: <200005101410.QAA21548@denx.local.net>
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
cc: "'duncanp@research.canon.com.au'" <duncanp@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: flash drivers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 May 2000 09:41:50 EDT."
             <BE1C564723B3D21191FD0000F840E39801D81514@rfcmx2.rfc.comm.harris.com>
Date: Wed, 10 May 2000 16:10:36 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BE1C564723B3D21191FD0000F840E39801D81514@rfcmx2.rfc.comm.harris.com> you wrote:
>
> I'm planning to use drivers/char/amd_flash.c myself, as a flat stream
> "file".

This works fine, and if you have just a  bit  of  configuration  data
which  can  be  mapped  to corresponding erase regions this is a very
straightforward approach. [Maybe you noted that the flash driver does
auto-erase when the length of data written per write() is exactly the
corresponding erase block size. So usually you sill just need to  do:
open   (/dev/flash???),  lseek(specific  erase  region),  write(data,
region size).]

> The ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz sources also include a
> flash translation layer (ftl.c) so flash can be used as a read/write
> filesystem.  I won't be using that though, since I noticed a patent
> reference in drivers/block/ftl.c, which an exemption for PCMCIA drivers.  In

Yes, this is a handicap. I tried several times to  get  a  permission
from  M-Systems similar to that they gave for PCMCIA use, but I never
received any repoly.

> linuxppc we're usually talking about on-board flash, so be careful.  I'd
> guess that such encumbered code won't make the standard kernel.

No, and it's not intended to. In fact, this code is more or less just
for demo purposes, not for use in a real product.

> It would be nice if we could have something like drivers/block/ftl.c without
> using patented methods.  If that's not possible, the next best thing would
> be a specific exemption for use on the linuxppc kernels, even if flash is
> on-board instead of PCMCIA.

Have a look  at  ftp://ftp.linux-mtd.infradead.org/pub/mtd/  -  David
Woodhouse  has  provided  some  code  there  which is at least a good
starting point. That's what I will use as  base  if  I  need  such  a
feature in a project.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When it is incorrect, it is, at least *authoritatively* incorrect.
- Hitchiker's Guide To The Galaxy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

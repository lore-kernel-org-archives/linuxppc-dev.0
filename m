Message-Id: <200101191606.f0JG6qH09060@denx.local.net>
To: Francois Tremblay <francois.tremblay@ieee.org>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel on MPC850FADS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Jan 2001 10:15:11 EST."
             <200101191515.KAA04626@hermes.usherb.ca>
Date: Fri, 19 Jan 2001 17:06:52 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Francois,

in message <200101191515.KAA04626@hermes.usherb.ca> you wrote:
>
> I try to put the linux kernel 2.2-18 on a MPC850FADS of Motorola.

I'm not sure which kernel you are using - but the plain 2.2.18 kernel
from ftp.kernel.org etc. is probably NOT a good  starting  point  for
the embedded PowerPC systems.

> In arch/ppc/mbxboot/head.S file, there a ILAP_ADDRESS that is used to
> decompress the kernel at boot.
> The ILAP_ADDRESS refer to NVRAM of MBX and is not exist on a FADS board.
>
> Someone know to fix this problem?

Well, one possible approach could be to use PPCBoot to load and start
Linux. PPCBoot has been ported to the FADS boards, so it's more or or
less an compile & install & run issue. See the PPCBoot  project  page
at Sourceforge. Source is available using anon-CVS at Sourceforge, or
for FTP on ftp://ftp.denx.de/pub/ppcboot/

With PPCboot, all the stuff inthe mbxboot directory becomes  obsolete
since  PPCBoot  knows  how  to  load,  uncompress a Linux kernel, and
possibly also load a ramdisk image.  Kernel  boot  arguments  can  be
saved  in  flash, so you don't have to enter them each time you boot,
or recompile the kernel to change them. Network booting and a  couple
of other goodies are available, too.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When all else fails, read the instructions.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

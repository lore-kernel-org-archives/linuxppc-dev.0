Message-ID: <3783A613.EEB26616@broadlink.com>
Date: Wed, 07 Jul 1999 12:10:11 -0700
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RPX Lite kernel
References: <37823F71.2BD5AF5F@broadlink.com> <3782515B.471DCEBE@broadlink.com> <37834109.17B9FDC3@switchboard.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks...  mkdep was taking over all my CPU/RAM on my machine, but it worked fine on another RedHat-5.2 box.  Now all I need is a
cross-compiler... any idea where I can get ppc-linux-gcc?

Marcus Sundberg wrote:
> 
> Scott Wood wrote:
> > I'd still like to know if anyone has a working 2.2 kernel on the RPX Lite...  I'd compile one myself, but my B&W G3 LinuxPPC box
> > is getting its guts replaced and I've heard horror stories about cross-compling the kernel...
> 
> Well, I've heard horror stories about compiling "hello world" too,
> but that doesn't mean it's particularly complicated. ;)
> 
> If "cross-compiling" from PPC I can't see why you should need to do
> anything else than configure the kernel properly.
> And this diff is all that is needed to cross-compile from ix86 Linux:
> 
> diff -urN linux-2.2.10.orig/Makefile embedded-2.2.10/Makefile
> --- linux-2.2.10.orig/Makefile  Sat May 29 03:10:19 1999
> +++ embedded-2.2.10/Makefile    Tue Jul  6 18:32:40 1999
> @@ -3,7 +3,8 @@
>  SUBLEVEL = 10
>  EXTRAVERSION =
> 
> -ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
> +ARCH := ppc
> +#ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
> 
>  .EXPORT_ALL_VARIABLES:
> 
> @@ -18,7 +19,7 @@
>  HOSTCC         =gcc
>  HOSTCFLAGS     =-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> 
> -CROSS_COMPILE  =
> +CROSS_COMPILE  = ppc-linux-
> 
>  AS     =$(CROSS_COMPILE)as
>  LD     =$(CROSS_COMPILE)ld
> 
> //Marcus
> --
> -------------------------------+------------------------------------
>         Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
>  Royal Institute of Technology |       Phone: +46 707 295404
>        Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se
-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Thu, 18 Sep 2003 11:31:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <waite@skycomputers.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BOOT_TARGET pImage & uImage ???
Message-ID: <20030918183146.GF6692@ip68-0-152-218.tc.ph.cox.net>
References: <3F65917D.1020502@imc-berlin.de> <20030915150935.GB29517@ip68-0-152-218.tc.ph.cox.net> <3F699255.4050000@imc-berlin.de> <200309180952.29699.waite@skycomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309180952.29699.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 18, 2003 at 09:52:29AM -0400, Brian Waite wrote:

> Here  is the patch I have been using myself. I am embarrassed to say that I
> was the 2nd person to ask and I forgot to post the patch for inclusion. I
> don;t have a version for 2.5/6 but this works for 2.4 (based on
> 2.4.22-pre10). Tom, I am not sure this is exactly what yoou wanted when we
> initially talked about it so let me know if you would like a better method.

That looks alright.  I've got one comment:
[snip]
> diff -Nru a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
> --- a/arch/ppc/boot/Makefile	Thu Sep 18 09:45:53 2003
> +++ b/arch/ppc/boot/Makefile	Thu Sep 18 09:45:53 2003
> @@ -17,7 +17,7 @@
>  AFLAGS	+= -D__BOOTER__
>  OBJCOPY_ARGS = -O elf32-powerpc
>
> -MKIMAGE				:= ./utils/mkimage.wrapper
> +MKIMAGE				:= $(TOPDIR)/scripts/mkuboot.sh
>
>  lib/zlib.a: lib/zlib.c
>  	$(MAKE) -C lib
> @@ -67,12 +67,18 @@
>  	gzip $(GZIP_FLAGS) images/vmapus
>  endif
>
> +mkuboot: $(MKIMAGE)
> +	cp $< $@
> +	chmod 755 $@

Add this to the clean target, and then don't rm it at the end of
'uImage' so that we only 'build' this once.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

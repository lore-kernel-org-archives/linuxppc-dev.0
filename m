Message-ID: <6D4DC8B4AD16D6118E8200D0B76FE2620231973C@ONT06EXM01>
From: "D'Abbraccio Joe-ljd015" <Joe.D'abbraccio@motorola.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>,
	"'Hollis Blanchard'" <hollis@austin.ibm.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: cross-compiler and stdarg.h
Date: Fri, 11 Oct 2002 11:55:04 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Doesn't this patch simply negate the -nostdinc switch (i.e. the resulting switch is something like "-I /usr/opt/eldk-1.0.1/usr/lib/gcc-lib/ppc-linux/2.95.3/include" which is part of stdinc) ?

> -----Original Message-----
> From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
> Sent: Friday, October 11, 2002 6:46 AM
> To: Hollis Blanchard
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: cross-compiler and stdarg.h
>
>
> I had this problem too. A while ago. On 2002/09/13 I posted
> to this list but
> with no success.
>
> I found the problem in the main Makefile:
>
> ---------------
> @@ -261,7 +262,7 @@
>  # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code
> and you are not
> UML
>  # then your code is broken!  KAO.
>
> -kbuild_2_4_nostdinc    := -nostdinc -iwithprefix include
> +kbuild_2_4_nostdinc    := -nostdinc $(shell $(CC)
> -print-search-dirs | sed -ne
> 's/install: \(.*\)/-I \1include/gp')
>  export kbuild_2_4_nostdinc
>
>  export CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL
> ---------------
>
> I have no idea why... :o(
>
> Cheers,
>
> Steven
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

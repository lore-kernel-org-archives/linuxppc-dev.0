Message-Id: <5.1.0.14.0.20010815231251.00ab60a0@spudcentral.com>
Date: Wed, 15 Aug 2001 23:41:26 -0600
To: Mark Hatle <fray@mvista.com>
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: cross compiling 8xx glibc on x86
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B7B3DDE.6603AFF@mvista.com>
References: <5.1.0.14.0.20010815184517.00ab30c0@spudcentral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark,

Thanks for the speedy reply, do you guys sleep over there?



At 10:28 PM 8/15/2001 -0500, Mark Hatle wrote:
>> ../sysdeps/powerpc/fclrexcpt.c:20: fenv_libc.h: No such file or directory
>
>That error is due to glibc not being setup to run w/o floating point on
>PowerPC.
>> I fooled around a bit trying to pass the Ipath to gcc for fenv_libc.h. But didn't figure that out.
>
>Look at the patch titled "hhl-powerpc-fpu.patch".  This will move the
>files to where they need to be for it to work right.  It will also
>remove the floating point loads/saves in the setjmp/longjmp call.

Are you saying that applying hhl-powerpc-fpu.patch to 2.2.3 then configuring with

CC=$TARGET-gcc CFLAGS="-msoft-float -D_SOFT_FLOAT -mcpu=860" \
../$GLIBVERSION/configure $TARGET --build=i586-linux \
--prefix=$PREFIX/$TARGET \
--enable-add-ons \
-without-fp

should work?

Patching 2.2.3 with hhl-powerpc-fpu.patch succeeds but configure fails with

make[2]: *** No rule to make target `../sysdeps/powerpc/fpu_control.h', needed by `/root/cross/builds/powerpc-linux-glibc/csu/init-first.d'.  Stop.

See next statement

>To find out the order of the patches that we apply, just look at the
>%build section, they are layed out in the order in which they are
>applied for our product.

Are you talking about this?
Patch3: manual-texinfo4.dpatch
Patch4: ldd.dpatch
Patch5: glibcbug.dpatch
Patch6: hurd-ldflags.dpatch
Patch7: fhs-linux-paths.dpatch
Patch8: pthread_create-manpage.dpatch
Patch9: string2-pointer-arith.dpatch
Patch10: glibc22-nss-upgrade.dpatch
Patch11: glibc22-disable-static.dpatch
Patch12: glibc22-eo_EO.dpatch
Patch13: glibc22-getaddrinfo.dpatch
Patch30: glibc-rpc-cross.patch
Patch31: hhl-powerpc-fpu.patch
Patch32: hhl-powerpc-altivec.patch
Patch33: glibc-223pre1-fe_invalid.patch
Patch34: glibc-mips-abi.patch
Patch35: glibc22-27.patch
Patch36: hhl-mips-siginfo.patch
Patch37: hhl-glibc-2.2.3-config.patch
Patch38: glibc-2.2.3-sh.patch
Patch39: 405-atomicity.patch

A lot of these patches fail when applied to 2.2.3. I'm somewhat inexperienced here but I want to learn what's going on.



The easiest way is to build bash and use the builtin (shell) printf
>command and see if it prints out "nan" or the number.  If you get the
>number it is working correctly.

Hmm, sounds simple but last night's all nighter is making me stupid. Can you
give an example of a floating point divide in bash using the printf statement?



>One side note, you don't really need the no floating point patches, if
>you are willing to live with the emulation overhead it works fine in the
>kernel.

Are you talking about setting this CONFIG_MATH_EMULATION=y?



>However, on the 8xx there is one thing that you can not "live w/o"
>doing.  Specifically you must either "fix" or (easy way) delete the
>sysdeps/powerpc/memset.S file.  This file is hard coded to 8 word wide
>cache lines.. and the 8xx only has 4 words wide cache.
>
>So...  if you can live w/ emulation, do that it's easier.....
>but regardless you will need to delete the sysdeps/powerpc/memset.S
>file.

I can live with emulation. If so, should I just go back and recompile the tools,
after I remove all the fpu flags and remove memset.S? After that, do you think
a C program with printf("%f",22.0/7.0) will work?

Thanks again!
Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

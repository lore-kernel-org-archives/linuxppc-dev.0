Message-ID: <3B7BDB23.9DD16CE4@mvista.com>
Date: Thu, 16 Aug 2001 09:39:31 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cross compiling 8xx glibc on x86
References: <5.1.0.14.0.20010815184517.00ab30c0@spudcentral.com> <5.1.0.14.0.20010815231251.00ab60a0@spudcentral.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dr. Craig Hollabaugh" wrote:
>
> Mark,
>
> Thanks for the speedy reply, do you guys sleep over there?

No.. we don't.. <grin>

> Are you saying that applying hhl-powerpc-fpu.patch to 2.2.3 then configuring with
>
> CC=$TARGET-gcc CFLAGS="-msoft-float -D_SOFT_FLOAT -mcpu=860" \
> ../$GLIBVERSION/configure $TARGET --build=i586-linux \
> --prefix=$PREFIX/$TARGET \
> --enable-add-ons \
> -without-fp
>
> should work?

yes it should.

>
> Patching 2.2.3 with hhl-powerpc-fpu.patch succeeds but configure fails with
>
> make[2]: *** No rule to make target `../sysdeps/powerpc/fpu_control.h', needed by `/root/cross/builds/powerpc-linux-glibc/csu/init-first.d'.  Stop.

I just compared our 2.2.3pre1 and 2.2.3 release hhl-powerpc-fpu.patch
and they are identical.  Obviously I am not getting that error.  The
expanded configure line we use comes out be:

./configure --host=powerpc-hardhat-linux --build=i686-pc-linux-gnu
--prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin
--sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include
--libdir=/usr/lib --libexecdir=/usr/libexec --localstatedir=/var
--sharedstatedir=/usr/share --mandir=/usr/share/man
--infodir=/usr/share/info --libexecdir=/usr/lib
--build=i686-pc-linux-gnu --enable-add-ons --without-cvs --without-fp

Obviously you will not need most of the things setting the various
prefixes..  but you will need the --host, --build, --enable-add-ons,
--without-fp  (ignore the second --build above.. configure evaluates the
last --build passed in..  it's an artifact of our build system...)

As for the CC, we set it to our compiler as the norm...  and we do not
set CFLAGS, but we have slightly modified gcc to default to
-msoft-float.

>
> See next statement
>
> >To find out the order of the patches that we apply, just look at the
> >%build section, they are layed out in the order in which they are
> >applied for our product.
>
> Are you talking about this?
> Patch3: manual-texinfo4.dpatch
> ...
> Patch39: 405-atomicity.patch
>
> A lot of these patches fail when applied to 2.2.3. I'm somewhat inexperienced here but I want to learn what's going on.

No.. go further down and look for "%prep".  This section of the .spec
file indicates what to do to "prep" the package for building.

As I said, the released version is 2.2.3pre1, very few changes have been
made to 2.2.3 release, so you may have to manually apply some of the
patches.

Also the patches 30-39 are the montavista specific patches.  The other
ones you probably do not need.

> The easiest way is to build bash and use the builtin (shell) printf
> >command and see if it prints out "nan" or the number.  If you get the
> >number it is working correctly.
>
> Hmm, sounds simple but last night's all nighter is making me stupid. Can you
> give an example of a floating point divide in bash using the printf statement?

Don't even need to do a floating point divide.  Just using floating
point.. i.e. "printf %f 1.01" will return "nan" (or crash) if
soft-floating point is not working..  it will return 1.010000 if
floating point is working right.

>
> >One side note, you don't really need the no floating point patches, if
> >you are willing to live with the emulation overhead it works fine in the
> >kernel.
>
> Are you talking about setting this CONFIG_MATH_EMULATION=y?

yes.

>
> >However, on the 8xx there is one thing that you can not "live w/o"
> >doing.  Specifically you must either "fix" or (easy way) delete the
> >sysdeps/powerpc/memset.S file.  This file is hard coded to 8 word wide
> >cache lines.. and the 8xx only has 4 words wide cache.
> >
> >So...  if you can live w/ emulation, do that it's easier.....
> >but regardless you will need to delete the sysdeps/powerpc/memset.S
> >file.
>
> I can live with emulation. If so, should I just go back and recompile the tools,
> after I remove all the fpu flags and remove memset.S? After that, do you think
> a C program with printf("%f",22.0/7.0) will work?

It should.  One thing to keep in mind.  -msoft-float changes the ABI, so
you can not switch back and forth while running the system.  Either
everything has to be -msoft-float, or nothing should be -msoft-float.

As you can see, building/reproducing a working toolchain with everything
configured "just right" isn't exactly the easiest thing to do.  :)  It
is fairly straight forward, but once you have done it a few thousand
times it becomes much easier.


--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: xiaogeng_jin@agilent.com
Message-ID: <9153F74610B7D311B83900902771C871124D939C@axcs07.cos.agilent.com>
To: porter@cox.net, brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Trying to use ELDK to build Ebony/440GP
Date: Thu, 30 Jan 2003 14:53:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> /opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:10
> : stdarg.h: No
> > such file or directory
Change the following macro in root Makefile. This will get correct include directory. I'm not sure if this is a bug for new Makefile since 2.4.20. I believe that 2.4.19 uses the second definition. But I don't know why it is changed.

#kbuild_2_4_nostdinc	:= -nostdinc -iwithprefix include
kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

>
> Interesting, it's not picking up stdarg.h from down in the gcc-lib/
> hierarchy.  Probably an ELDK install problem...hopefully Wolfgang
> is reading this thread since he should have a suggestion on what have
> might gone wrong with your installation.

Also I'm not sure if it's related to ELDK's cross compiler. Hopefully Wolfgang will clarify this.

Regards,

Shawn.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

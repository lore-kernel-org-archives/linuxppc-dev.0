Subject: Re: proposed patch for cross compiling from Solaris 2.8
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1089121664.31278.264.camel@fr-jdubois1.ad.mc.com>
References: <Pine.LNX.4.44.0407060823120.2040-100000@spider.ancor.com>
	 <1089121664.31278.264.camel@fr-jdubois1.ad.mc.com>
Content-Type: text/plain
Message-Id: <1089125860.18578.12.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Date: Tue, 06 Jul 2004 16:57:40 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-07-06 at 15:47, Jean-Christophe Dubois wrote:
> Sorry but stdint.h is not present on my Solaris 2.8 system. There is
> little I can do about this. So maybe Solaris doesn't respect the
> standard somewhere but ...
>

I guess the problem here is that Solaris 2.8 is not necessarily
compliant with "The Open Group Base Specifications Issue 6"/IEEE Std
1003.1-2001-conforming systems. But should it disqualify it as an host
platform?

http://www.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html

On the other hand Solaris 2.8 does support <inttypes.h> which could do
the trick

http://www.opengroup.org/onlinepubs/009695399/basedefs/inttypes.h.html

> > Even
> > the getopt changes shouldn't be required, you should be using the
> > version of getopt that came with your package.
>
> Same here getopt.h is not part of solaris headers. Solaris does not seem
> to support getopt_long() and getopt() prototype is part of stdio.h,
> stdlib.h or unistd.h. But no getopt.h on the horizon ... Should use one
> of the other mentioned files.

getopt_long() is not part of any IEEE standard (AFAIK) and getopt.h is
not part of IEEE Std 1003.1-2001-conforming systems. This seems to be
very GNU specific and not part of Solaris base system (so far).

http://www.opengroup.org/onlinepubs/009695399/functions/getopt.html

>
> >
> > Are you sure that you've specified -nostdinc -nostdlib and given the
> > proper list of locations for the cross-compile system includes when
> > compiling?
>
> For what I understand these programs (the ones build from the source I
> modified) should not be cross-compiled but build for the host platform
> (here Solaris) with the native compiler. Am I wrong?
>
> Oh and I didn't specify any particular -nostdinc -nostdlib flag
> anywhere. I am just using the standard Linux 2.6.7 Makefile. The command
> used is:
>
> make ARCH=ppc CROSS_COMPILE=powerpc-7400-linux-gnu-
>
> JC
>
> >
> > -Bret
>
>
--
Jean-Christophe Dubois <jdubois@mc.com>
Mercury Computer Systems


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 13 Jun 2002 17:27:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC and PATCH] Move the m68k genrtc driver into 2.5 and use on PPC
Message-ID: <20020614002731.GC13541@opus.bloom.county>
References: <20020613190646.GT13541@opus.bloom.county> <20020614003143.C1230@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614003143.C1230@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 12:31:43AM +0200, Richard Zidlicky wrote:
> On Thu, Jun 13, 2002 at 12:06:46PM -0700, Tom Rini wrote:
> Hi,
>
> > Secondly to the m68k people, does anyone have an objection (or would
> > like to do it themselves?) with me trying to get Linus to take the
> > changes to include/linux/rtc.h?  radeonfb.c currently conflicts with the
> > 'pll_info' struct, but Ani Joshi is renaming it.
>
> I will be happy whoever gets it in. The pll_info stuff could be
> renamed in genrtc.c as well.

It could...  But I imagine it'll be fun getting that in either way. :)

> > 	Also, CONFIG_GEN_RTC
> > used to be define_bool'ed to y on CONFIG_SUN3, but I'm not sure if that
> > looks nice in a common file.  Any idea on how to solve this nicely?
>
> m68k doesn't source drivers/chars/Config.in so just don't do
> anything about it?

Ah, it doesn't?  I suppose that will work too.. :)

> > diff -Nru a/drivers/char/Config.help b/drivers/char/Config.help
> > --- a/drivers/char/Config.help	Thu Jun 13 12:03:49 2002
> > +++ b/drivers/char/Config.help	Thu Jun 13 12:03:49 2002
> > @@ -1058,6 +1058,34 @@
> >    The module is called rtc.o. If you want to compile it as a module,
> >    say M here and read <file:Documentation/modules.txt>.
> >
> > +Generic Real Time Clock Support
> > +CONFIG_GEN_RTC
> > +  If you say Y here and create a character special file /dev/rtc with
> > +  major number 10 and minor number 135 using mknod ("man mknod"), you
> > +  will get access to the real time clock (or hardware clock) built
> > +  into your computer.
> > +
> > +  In 2.4 and later kernels this is the only way to set and get rtc
> > +  time on m68k systems so it is highly recommended.
> > +
> > +  It reports status information via the file /proc/driver/rtc and its
> > +  behaviour is set by various ioctls on /dev/rtc. If you enable the
> > +  "extended RTC operation" below it will also provide an emulation
> > +  for RTC_UIE which is required by some programs and may improve
> > +  precision in some cases.
> > +
> > +  This driver is also available as a module ( = code which can be
> > +  inserted in and removed from the running kernel whenever you want).
> > +  The module is called rtc.o. If you want to compile it as a module,
> 			 ^^^^^^^
> genrtc.o ... I could swear I fixed it in m68k CVS ;)

I might have grabbed too old a version of that.  Fixing it now.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 7 Jan 2004 12:27:26 +0100
To: debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Volunteer needed : Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040107112726.GA26193@iliana>
References: <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107075151.GH14918@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040107075151.GH14918@plato.local.lan>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 06, 2004 at 10:51:51PM -0900, Ethan Benson wrote:
> On Wed, Jan 07, 2004 at 06:22:25PM +1100, Benjamin Herrenschmidt wrote:
> >
> > > BTW, i didn't manage to get the generic RTC code working on my pegasos,
> > > and i am actually a bit pressed for time.
> > >
> > > Do you think a workaround, for the debian powerpc packages, would be to
> > > add a test for the presence of a pmac in the CONFIG_RTC code, and abort
> > > if one is found ?
> > >
> > > If so, what would be the best way to test for a pmac subarch in the
> > > drivers/char/rtc.c code ?
> >
> > will the kernel let you build both drivers in ?
>
> yes, which will cause all powermacs to hang on bootup when hwclock is run.

Yeah, that i know, and want to workaround.

> > then you can do, in 2.4, something ugly like that:
> >
> > #ifdef CONFIG_ALL_PPC
> > if (_machine == _MACH_Pmac)
> > 	return -ENODEV;
> > #endif
>
> which im betting will instead cause hwclock to fail on all powermacs
> with: hwclock: /dev/rtc: No such device

Mmm, notice that this is the rtc_init code, not the rtc ioctl's
themself. In my understanding this is launched when the kernel is
loaded, and is used to setup the rtc clock. If it fails, then no harm
should be done, since the generic rtc driver should take over, not sure
though.

> but i could be missing something obvious with your suggestion.

Maybe. i need someone who would like to test this. Do you volunteer ?

Below is my current patch. Please someone with pmac hardware, please
build a kernel with this applied and the CONFIG_RTC enabled in the
character driver section and report back to me. It would be nice if i
could upload a package which includes this fix today yet.

------------------- patch ------------------------
--- drivers/char/rtc.c.orig	2003-11-29 18:54:39.000000000 +0100
+++ drivers/char/rtc.c	2004-01-07 08:59:28.000000000 +0100
@@ -707,6 +707,12 @@
 #endif
 #endif

+#ifdef CONFIG_ALL_PPC
+	/* This driver will make pmac hardware die horribly */
+	if (_machine == _MACH_Pmac)
+		return -EIO;
+#endif
+
 #ifdef __sparc__
 	for_each_ebus(ebus) {
 		for_each_ebusdev(edev, ebus) {
------------------- patch ------------------------

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

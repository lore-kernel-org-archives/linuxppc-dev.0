Date: Wed, 7 Jan 2004 03:28:28 -0900
From: Ethan Benson <erbenson@alaska.net>
To: debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Volunteer needed : Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040107122828.GJ14918@plato.local.lan>
References: <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107075151.GH14918@plato.local.lan> <20040107112726.GA26193@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040107112726.GA26193@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 12:27:26PM +0100, Sven Luther wrote:
>
> Mmm, notice that this is the rtc_init code, not the rtc ioctl's
> themself. In my understanding this is launched when the kernel is
> loaded, and is used to setup the rtc clock. If it fails, then no harm
> should be done, since the generic rtc driver should take over, not sure
> though.

sounds iffy to me.  especially if both are compiled as modules, in
which case the rtc module will be loaded, fail and im betting the
whole thing stops right there.

debian used to ship kernels with both PPC_RTC and RTC as modules,
hoping the right one would magically load and work on the right
hardware, of couse this was not the case, RTC was always loaded, and
broke powermacs.

> > but i could be missing something obvious with your suggestion.
>
> Maybe. i need someone who would like to test this. Do you volunteer ?

i don't have time, sorry.

> Below is my current patch. Please someone with pmac hardware, please
> build a kernel with this applied and the CONFIG_RTC enabled in the
> character driver section and report back to me. It would be nice if i
> could upload a package which includes this fix today yet.
>
> ------------------- patch ------------------------
> --- drivers/char/rtc.c.orig	2003-11-29 18:54:39.000000000 +0100
> +++ drivers/char/rtc.c	2004-01-07 08:59:28.000000000 +0100
> @@ -707,6 +707,12 @@
>  #endif
>  #endif
>
> +#ifdef CONFIG_ALL_PPC
> +	/* This driver will make pmac hardware die horribly */
> +	if (_machine == _MACH_Pmac)
> +		return -EIO;
> +#endif
> +
>  #ifdef __sparc__
>  	for_each_ebus(ebus) {
>  		for_each_ebusdev(edev, ebus) {
> ------------------- patch ------------------------
>
> Friendly,
>
> Sven Luther
>

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

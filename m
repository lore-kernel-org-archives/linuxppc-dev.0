Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: xfree86/fbdevhw not sending right mode to radeonfb.c
Date: Wed, 21 Nov 2001 14:42:03 -0500
Cc: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>,
	<linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.33.0111191248340.10443-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.33.0111191248340.10443-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <20011121193918.PTJS24249.tomts11-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

FYI: Well I finally figured out what was up.  It seems the first thing the
special code for "DFPValidateModes" in radeon_driver.c does is delete all
modes since the timing info is technically not needed by them for DFP.

That is just a pisser since it removes the completely valid mode I had
placed into the XF86Config-4 for just that reason.

So no great mystery but I just don't think they should do that when using
fbdevhw.

That is only part of the problem, the other is that if you change the
depth from what is used by the frame buffer it does mess up as others have
reported.

Kevin

On November 19, 2001 06:00, Kostas Gewrgiou wrote:
> On Sun, 18 Nov 2001, Kevin B. Hendricks wrote:
> > I am willing to dig deeper to track this one down if someone can point
> > me to the code that parses the mode info from the XF86Config-4 file
> > and loads it into the mode structure.
>
> Hello Kevin,
>
> Take a look at xf86parseModesSection(),xf86parseModeLine() etc
> in xc/programs/Xserver/hw/xfree86/parser/Monitor.c
> and also at configMonitor()
> in xc/programs/Xserver/hw/xfree86/common/xf86Config.c
>
> You might want to take a look at the  *Mode*.c files in ..../common
> as well.
>
> Good luck.
>
> Kostas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

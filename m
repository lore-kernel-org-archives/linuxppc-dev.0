Date: Mon, 19 Nov 2001 10:28:14 -0500
Subject: Re: xfree86/fbdevhw not sending right mode to radeonfb.c
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michdaen@iiic.ethz.ch>,
	<linuxppc-dev@lists.linuxppc.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Message-Id: <0C3CA45D-DD02-11D5-8379-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

> > I am willing to dig deeper to track this one down if someone can point
> > me to the code that parses the mode info from the XF86Config-4 file
> and
> > loads it into the mode structure.
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

Okay, I looked at that code and unless the xf86getSubToken is
broken somehow, then the correct info is being placed in the
linked list of modes.

So something is either stepping on that memory after that point
or  maybe the ValidateMode routine is messing it up somehow.

By the way, this has nothing to do with fbdevHW since I can see the
same missing mode information in RADEONModeInit when I do *NOT*
use useFBDev.  It is just that RADEONModeInit is better at filling in the
blanks properly given its access to the info structure timing info used
for
DFP.

Can anyone else confirm this?

To check, simply turn on DEBUG in xfree86 in the fbdevhw.c file and
include
your own custom modeline or mode and set useFBDev in your XF86Config-4
and
compare what xfree86 hands to fbdevhw.c in the form of the mode to your
original mode line.

I just want to make sure others are seeing the problem too before I jump
in
farther and try to find out why or how the mode info is being stepped on.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

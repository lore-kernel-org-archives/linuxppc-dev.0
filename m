From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: Some issues to resolve with XFree 4.0 yet
Date: Sat, 25 Mar 2000 18:50:09 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.10.10003230911180.6826-100000@shell.unixbox.com> <00032313263100.01328@localhost.localdomain>
In-Reply-To: <00032313263100.01328@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <00032519041300.00635@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

Okay, with the patch I posted last night for setting crtc.pitch in aty128fb.c,
mode switching now works fine but the "panning" ioctl is on the "todo" list yet.
Thanks to Geert for pointing out you can't change virtual resolutions on the
fly with XFree (I was about to try! ;-)

You then asked me to look at getting it to work without using the FBDev.  Given
my earlier patch which calculates XCLK using OF supplied values in the pll
registers, all you need to do to use it without FBDev is to simply comment out
the calls to vgaHWSave and vgaHWRestore in r128_driver.c.

>From that point on, everything works like a charm.

My question is as follows, under ppc should we ever be doing anything with
vgaHWSave and vgaHWRestore.  Can I simply ifdef them out for all __powerpc__
machines?

If not, is there any way to determine under which powerpc machines that an r128
card actually can use vgaHWSave and vgaHWRestore.

I think the only outstanding issue on r128 is the damn flashing white square
when cursor images are changed.  I have looked and looked at this but I can't
figure out why this is happening unless a big white square is someone's
idea of a transparent cursor! ;-)

I have to start spending time on some other projects for awhile (i.e. real
life research project that needs to get underway) so I wanted to wrap things up
with the r128 driver for awhile.

If and when I get some time, I would be happy to take a shot at taking the r128
source and making it a mach64 source just in case you think that would be of
use (i.e. someone else hasn't done that yet and the old ati driver has not been
converted to work yet).

Thanks,

Kevin




--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

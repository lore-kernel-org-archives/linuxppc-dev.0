Date: Mon, 27 Mar 2000 14:09:03 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Ani Joshi <ajoshi@shell.unixbox.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet
In-Reply-To: <00032519041300.00635@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0003260204250.15969-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 25 Mar 2000, Kevin Hendricks wrote:

> Hi Kostas,
>
> Okay, with the patch I posted last night for setting crtc.pitch in aty128fb.c,
> mode switching now works fine but the "panning" ioctl is on the "todo" list yet.
> Thanks to Geert for pointing out you can't change virtual resolutions on the
> fly with XFree (I was about to try! ;-)
>

  The aty128fb in the linus 2.3.x tree has panning working so you can try
that and see if its working ok.

> You then asked me to look at getting it to work without using the FBDev.  Given
> my earlier patch which calculates XCLK using OF supplied values in the pll
> registers, all you need to do to use it without FBDev is to simply comment out
> the calls to vgaHWSave and vgaHWRestore in r128_driver.c.
>

  You will also need to add code to switch the framebuffer in the right
endian for the depth and probably disable the int10 module.

> >From that point on, everything works like a charm.
>
> My question is as follows, under ppc should we ever be doing anything with
> vgaHWSave and vgaHWRestore.  Can I simply ifdef them out for all __powerpc__
> machines?
>

  vgahw will not work under powerpc right now (iobase and vga memory aren't
handled right), once its working it will probably be usefull for prep/chrp
but for now you have to disable it.

> If not, is there any way to determine under which powerpc machines that an r128
> card actually can use vgaHWSave and vgaHWRestore.
>

  Thats a good question, right now they don't work at all under ppc for
drivers that don't switch vgahw to MMIO.

> I think the only outstanding issue on r128 is the damn flashing white square
> when cursor images are changed.  I have looked and looked at this but I can't
> figure out why this is happening unless a big white square is someone's
> idea of a transparent cursor! ;-)
>
  This is strange, from what i see in the driver it hides the cursor before
loading the image so i can't imagine why you get the artifacts

> I have to start spending time on some other projects for awhile (i.e. real
> life research project that needs to get underway) so I wanted to wrap things up
> with the r128 driver for awhile.
>
> If and when I get some time, I would be happy to take a shot at taking the r128
> source and making it a mach64 source just in case you think that would be of
> use (i.e. someone else hasn't done that yet and the old ati driver has not been
> converted to work yet).
>

  There is an ati driver in 4.0 (not accelerated much though) it just needs
fbdev support and prabably some endian changes before its usable under ppc,
it shouln't be much harder than what you did to add fbdev support in r128


   Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

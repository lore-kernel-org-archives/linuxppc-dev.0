To: gewrgiou@imbc.gr
Cc: khendricks@ivey.uwo.ca, ajoshi@shell.unixbox.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet
In-Reply-To: Your message of "Mon, 27 Mar 2000 14:09:03 +0300 (EEST)"
	<Pine.LNX.4.21.0003260204250.15969-100000@idd-01.imbc.gr>
References: <Pine.LNX.4.21.0003260204250.15969-100000@idd-01.imbc.gr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000328024133B.roikawa@rr.iij4u.or.jp>
Date: Tue, 28 Mar 2000 02:41:33 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: Some issues to resolve with XFree 4.0 yet

> > You then asked me to look at getting it to work without using the FBDev.  Given
> > my earlier patch which calculates XCLK using OF supplied values in the pll
> > registers, all you need to do to use it without FBDev is to simply comment out
> > the calls to vgaHWSave and vgaHWRestore in r128_driver.c.
> >
>
>   You will also need to add code to switch the framebuffer in the right
> endian for the depth and probably disable the int10 module.
 Yes, you're right. The r128 driver is now working fine on my B&W G3 without
fbdev support in 8/15/16/24 bit depth so far, except one problem -- offb
console becomes blank screen on VT switch(I'm not using aty128fb). r128 driver
doesn't seem to restore the original state perfectly. But this isn't harmless
because I have running second and third head(with xinerama).


>   Thats a good question, right now they don't work at all under ppc for
> drivers that don't switch vgahw to MMIO.
 So I disabled all vgahw access to prevent seg. fault. I think Rage128
VGA register access is not necessary at least for powermacs.


> > I think the only outstanding issue on r128 is the damn flashing white square
> > when cursor images are changed.  I have looked and looked at this but I can't
> > figure out why this is happening unless a big white square is someone's
> > idea of a transparent cursor! ;-)
> >
>   This is strange, from what i see in the driver it hides the cursor before
> loading the image so i can't imagine why you get the artifacts
 Though I could be wrong, it may not be strange. R128LoadCursorImage()
starts display cursor immediately after the cursor image is written
to the frame buffer, but rage128 frame buffer write is always FIFO'ed
while CRTC write is never FIFO'ed. So it'll be possible to start display
cursor before the image write is complete.
 In my case I commented out cursor ON/OFF code in R128LoadCursorImage()
since mid-level routine calls R128HideCursor/R128ShowCursor before and
after cursor image is loaded. I haven't seen this cursor flashing yet.

BTW, I noticed an interesting x11perf score. x11perf -scroll500 marked ~300/sec
for ATI Rage128RE connected to 66MHz bus on B&W G3 rev.1, but ~600/sec for an
old Matrox Millennium II to 33MHz bus, measured at 32bpp/24bit depth.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

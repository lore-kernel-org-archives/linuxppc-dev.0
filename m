MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <14796.52485.753924.552345@ipa.ne.mediaone.net>
Date: Sat, 23 Sep 2000 11:32:21 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: Michel Dänzer <daenzerm@student.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <39CCC5AB.C1C2E8B2@student.ethz.ch>
References: <14796.42915.582391.766766@ipa.ne.mediaone.net>
	<39CCC5AB.C1C2E8B2@student.ethz.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer writes:
 > > Specifics: with the ati driver selected, xf throws away my mode def,
 > > since it thinks (incorrectly) that there isn't enough vram,
 >
 > Does it probe the correct amount of VRAM? Do you use Option "UseFBDev" ?

The xf probe says 2MB, but in fact I have 4MB.  The dmesg line says:

atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 4M SGRAM, 14.31818
MHz XTAL, 230 MHz PLL, 75 Mhz MCLK


I tried both UseFBDev on and off.  It didn't seem to make any
difference.  Btw, which is correct setting if I'm not using the fbdev
driver?


 > > and then quits since it can't find any valid modes. In both cases I'm
 > > running 4.0.1 from Franz Sirl's linuxppc page.
 >
 > While we're at it, can you please send me the URL of those?


 ftp://devel.linuxppc.org/users/fsirl/xf4/RPMS/


 > I thought they contained the necessary stuff from Ani Joshi's rsync tree. If
 > you try to build yourself, you absolutely need that.

I just rebuilt it myself, with the rsync xfree, on the G4.  The
rebuilt version works fine there (I'm using it now) with the r128
driver.  I won't be able to test the newly built ati driver on the G3s
until Monday.  Can I just move that driver to the drivers diretory of
the current installation on the two G3s, or do I need to do a complete
rebuild/reinstall on each of them?


 > > The rev. a machine is running 2.2.15pre3 from the 2000 cd, booted via
 > > BootX with "no video driver" checked.
 >
 > I don't think this can work with the ati driver, it needs atyfb.

OK, I'll uncheck that box.  What about the "force video" BootX option
-- on or off?  I did try all four combinations of these two and never
got anything to work with ati.  Unchecking the box seemed to confuse
MOL on the console, so I left it checked.



 > > I can run xf 4.0.x using the fbdev driver, more or less, with an
 > > otherwise identical XF86Config, though xf with fbdev is noticably
 > > slower than Xpmac.rev10.
 >
 > No big surprise as the fbdev driver doesn't have any hardware acceleration.


That's what I figured.  If I can get it going properly, and get it to
support multiple monitors (especially xinerama mode - that would be
ideal), I'm happy to live with the slight decrease in speed.  But of
course real ati support would be nicer....

 >
 > That should work if you have multiple framebuffer devices. Use
 >
 >     Option	"fbdev" "/dev/fb1"
 >
 > for the second one etc.

Ah ha, I didn't think of that.  I'll make the change in the Device
entries.

Speaking of configs, I have a Device entry and a Screen entry for each
physical display but they're all sharing the same Monitor entry (all
three physical monitors are identical).   It that likely to work?



Many thanks for the quick and thorough reply.

--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

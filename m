Date: Thu, 6 Sep 2001 11:32:21 -0700
From: Matt Porter <mporter@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Brian Waite <bwaite@cspi.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 and bugboot fails
Message-ID: <20010906113221.B15037@beef.az.mvista.com>
References: <85256ABF.00549667.00@pine.cspi.com> <200109061544.LAA11977@orchid.cspi.com> <20010906085639.F21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906070358.A9316@cx258813-a.chnd1.az.home.com> <20010906104830.K21172@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010906104830.K21172@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Sep 06, 2001 at 10:48:30AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 06, 2001 at 10:48:30AM -0700, Tom Rini wrote:
> On Thu, Sep 06, 2001 at 07:03:58AM -0700, Matt Porter wrote:
> > On Thu, Sep 06, 2001 at 08:56:39AM -0700, Tom Rini wrote:
> > >
> > > On Thu, Sep 06, 2001 at 11:36:39AM -0400, Brian Waite wrote:
> > >
> > > > I tried that and I was unable to relocate just the initrd. Right now, I just
> > > > tested to see:
> > > > if  ((zImage_start >= 0xf0000000) || (zImage_start <= 0x00800000))
> > > >
> > > > That seems to work for now, but I'll take a peek at the gemeni and see how
> > > > they do it.
> > >
> > > Er, after re-reading, it's wrong too.  I'll send you a patch
> > > privately, if you can test it.
> >
> > This location checking logic is all a hack...I've already stared at this
> > a while to make it work for someone.  I recommend we _always_ relocate
> > both zImage and initrd (if present).
>
> Right, but if the initrd happens to start off at below the 16 mb barrier,
> why do it?  For example anyhow, my PowerStack doesn't need to relocate the
> zimage (and if I can make it happily netboot, I'll test initrd, but that
> might need it..)

Because it's simpler than having a lot of checks.  Also, it doesn't
really waste noticeable time in the memcpy since the bootloader has
to timeout at the load: prompt anyway.

BTW, try pbooting a zImage.initrd from a block device and you'll see
that PPCBUG locates the images from top of memory down I believe.  Only
when netbooting (with PReP netboot enabled) does it load staticly at
0x5000.

If you want the checks that's fine as long as it works.  Just don't
doing anything board specific like in the patch above.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 6 Sep 2001 11:45:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@mvista.com>
Cc: Brian Waite <bwaite@cspi.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 and bugboot fails
Message-ID: <20010906114513.Q21172@cpe-24-221-152-185.az.sprintbbd.net>
References: <85256ABF.00549667.00@pine.cspi.com> <200109061544.LAA11977@orchid.cspi.com> <20010906085639.F21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906070358.A9316@cx258813-a.chnd1.az.home.com> <20010906104830.K21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906113221.B15037@beef.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010906113221.B15037@beef.az.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 06, 2001 at 11:32:21AM -0700, Matt Porter wrote:
> On Thu, Sep 06, 2001 at 10:48:30AM -0700, Tom Rini wrote:
> > On Thu, Sep 06, 2001 at 07:03:58AM -0700, Matt Porter wrote:
> > > On Thu, Sep 06, 2001 at 08:56:39AM -0700, Tom Rini wrote:
> > > >
> > > > On Thu, Sep 06, 2001 at 11:36:39AM -0400, Brian Waite wrote:
> > > >
> > > > > I tried that and I was unable to relocate just the initrd. Right now, I just
> > > > > tested to see:
> > > > > if  ((zImage_start >= 0xf0000000) || (zImage_start <= 0x00800000))
> > > > >
> > > > > That seems to work for now, but I'll take a peek at the gemeni and see how
> > > > > they do it.
> > > >
> > > > Er, after re-reading, it's wrong too.  I'll send you a patch
> > > > privately, if you can test it.
> > >
> > > This location checking logic is all a hack...I've already stared at this
> > > a while to make it work for someone.  I recommend we _always_ relocate
> > > both zImage and initrd (if present).
> >
> > Right, but if the initrd happens to start off at below the 16 mb barrier,
> > why do it?  For example anyhow, my PowerStack doesn't need to relocate the
> > zimage (and if I can make it happily netboot, I'll test initrd, but that
> > might need it..)
>
> Because it's simpler than having a lot of checks.  Also, it doesn't
> really waste noticeable time in the memcpy since the bootloader has
> to timeout at the load: prompt anyway.

The timeout will (maybe) be configurable later on.  Does checking if the
initrd is above 16mb and then relocating it, at least on 'prep' make sense?
Always relocating sounds like it'll fix other problems (like FLASH).  I guess
I'll try and see if I can notice a difference here w/ just a zImage on 'prep',
just so to keep the code consistant..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

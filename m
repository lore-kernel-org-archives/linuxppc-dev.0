Date: Sat, 17 Nov 2001 10:34:18 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X works somewhat on DFP with latest radeonfb.c
In-Reply-To: <20011117165341.FRIS24249.tomts11-srv.bellnexxia.net@there>
Message-ID: <Pine.BSF.4.32.0111171032170.68997-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kevin,

Yes, this is a problem with the latest macs and their 3 pci busses,
anyhow, you shouldn't have any problems with current CVS since I've merged
most all of the PPC/BE radeon bits into CVS a while ago.  I will try a
build and see if anything fails today.


ani

On Sat, 17 Nov 2001, Kevin B. Hendricks wrote:

> Hi Ani,
>
> I found you XF410 patch at ftp.linuxppc.org/users/ajoshi/radeon/.
>
> Your diff adds the following vga call:
>
> vgaHWGetIOBase
>
> which casues an immediate SEGFAULT of the Xserver.
>
> Does this call need any special attention under ppc linux?  Do we even
> need to make this call at all is we have the useFBDev option set?
>
> Also, your diff does not add the "fbPictureInit" symbol to the list of
> symbols which need to be loaded from the fb code (fbSymbols[]).
>
> I had to add that symbol to get XF 410 with your patch to start up at all.
>
> Any ideas here?  That patch is old (from June or July?).  Did I grab the
> wrong patch?
>
> Thanks,
>
> Kevin
>
> On November 17, 2001 11:23, Kevin B. Hendricks wrote:
> > Hi Ani,
> >
> > Ben mentioned below that you might have some patches to handle BigEndian
> > issues for radeon.
> >
> > Any help would be greatly appreciated.
> >
> > Thanks,
> >
> > Kevin
> >
> > On November 17, 2001 11:07, Benjamin Herrenschmidt wrote:
> > > >Hi Ben,
> > > >
> > > >Thought you might like to know.  I took a look at the XF410
> > > >radeon_driver.c and compared it to the latest versions of
> > > > radeon_driver.c in XFreee86 CVS HEAD and they are quite different.
> > > >
> > > >CVS HEAD has a *lot* more support for DFP but since I had the
> > > > radeonfb working on the DFP I thought what the hell, and started to
> > > > try to use XF 4.1.0 radeon_driver.c with only a few small tweaks
> > > > (ignoring all of the Flat Panel code which is old and not-working in
> > > > XF410) with the UseFBDev Option so all the DFP register stuff is
> > > > handled by the radeonfb.c driver.
> > > >
> > > >X actually starts up with depths of 8 and depths of 24 (32bpp), and
> > > > works but the colors are all wrong:  too many pinks in the 8 bit
> > > > version and seemingly random colors in the 24 depth.
> > > >
> > > >So I am going to try and play around with the pallette setting.
> > >
> > > Ask Ani for his patches. I think the engine must be properly
> > > configured for big endian.
> > >
> > > Ben.
> >
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

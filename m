Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20011204095651.01b2b6b8@falcon.si.com>
Date: Tue, 04 Dec 2001 10:07:14 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: programming ppcboot onto an sbc8260 with a vision ice
In-Reply-To: <3C0CE281.2E0F451C@seranoa.com>
References: <3C0BD4F1.DB6591F3@seranoa.com>
 <3C0BDBB4.68EB3E72@chinook.com>
 <5.1.0.14.2.20011203165059.01c83e20@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:49 AM 12/4/2001 -0500, Andrew Dixon wrote:

>Jerry Van Baren wrote:
> >
> > Your PPCBoot image is linked at 0x40000000 and your convert defaults are
> > converting from 0xfe000000..0xfe020000 (this is where EST puts the boot
> > memory unless you've changed the HRCW to ORG it at 0x00000000 -- glossing
> > over quite a few details here).  Anyway, there ain't no data in that range,
> > which is exactly what the error message is telling you.
> >
> > The EST convert utility doesn't allow you to relocate the code, only to set
> > the lower and upper boundaries of the conversion.  You can use an elf tool
> > (objcopy) to re-org the code or change your link mechanism to re-org your
> > code.  You can also leave it at 0x40000000 and change your visionICE setup
> > to map the ROM into that memory area (hmm, isn't that the secondary
> > flash?  Maybe you just need to program it and switch your CS0/CS6 jumper).
>
>Yes that is the start of Flash.  For our final product we want our
>bootloader to live in Flash but I'm rethinking that for the EST board.
> >From what I've read on the list is sounds like PPCBoot wants to live in
>ROM on the sbc8260 right?
>
>Is the above documented anywhere?  I don't feel the need to reinvent the
>wheel for this board and I'd rather start off the right way.

Yes, PPCBoot wants to run out of ROM.  It is a boot/loader, and thus its
whole purpose in life is to run out of ROM starting at Power On
Reset.  While it is theoretically possible to run it other ways, and this
is discussed periodically, it is (arguably) silly to do anything else (one
side of the argument part is running out of RAM for debug, but the other
side of the argument is that it should just work, or nearly work, and you
might as well get it working in ROM before addressing RAM issues which can
be a Real Bitch).

I have a copy of PPCBoot running on a EST board and it works well.  I
loaded it with the Abatron debugger which is easier to use than the
visionICE (I've used both).

I've used the EST vxWorks-based BootROM (disclaimer: not the latest
version) and it is nearly functional... if you use vxWorks, it works just
fine.  If you warp your non-vxWorks world just right, it also works
fine.  But there comes a point where you simply get sick of living in a
warped world, throw away vxWorks, and load PPCBoot.  PPCBoot is MUCH easier
to use and more functional (the only thing EST's BootROM has that PPCBoot
doesn't is the ability to load via FTP instead of TFTP -- this simplifies
the server configuration, but not a big deal).

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

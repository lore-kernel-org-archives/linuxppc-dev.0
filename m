Message-ID: <369F68F7.F983C816@mucmot.muenchen.europe.mcd.mot.com>
Date: Fri, 15 Jan 1999 17:12:39 +0100
From: Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>
MIME-Version: 1.0
To: Alexander Gustav Deucher <agd5f@unix.mail.virginia.edu>
CC: Gabriel Paubert <paubert@iram.es>, Troy Benjegerdes <hozer@drgw.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to Nubus PowerMacs
References: <Pine.HPP.3.96.990115120015.2338T-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
> 
> On Fri, 15 Jan 1999, Troy Benjegerdes wrote:
> 
> > On Thu, 14 Jan 1999, Gabriel Paubert wrote:
> > > On Thu, 14 Jan 1999, Alexander Gustav Deucher wrote:
> > >
> > > >
> > > > While we are on the subject of porting, How hard would it be to
> > > > get linux ppc to boot on machines with NT firmware?  Does
> > > > anyone know why this firmware is so problematic? Is there
> > > > anywhere one could find documentation on it, etc.
> >
> > Is this Open Firmware or some derivative of PPCbug?? I though NT required
> > Open Firmware (which would mean the preploader wouldn't work too well)
> >
It is something called "Motorola PowerPC firmware.
During the "PPC NT period" there where three different kinds of firmware
on Motorola products:
   PPCBug
   Motorola PowerPC firmware 	- Used on boxes shipped with NT
   PowerPC Open Firmware

Alexander can you please give me the version of the firmware (something
like 3.0x.0x.
I hasitate to make to much noise about my findings because
1) I'm struggeling a problem with different versions of this Firmware;
   one boots the floppy but the other one refuses this.
2) I'm not shure how many potential systems there are.
3) To get the kernel running with the standard IDE equipment I had to add
   some changes which according to Cort will break IDE on IBM.

Please also cc responses to alois_fertl@TalkNet.de
   Alois
> 
> This is a message I got from Alois Fertl:
> 
> AF> I tried the preploader on a Motorola Pro2000/200. This is a system
> AF> originally developed to run Windows NT. It has a 603ev, IBM660 PCI
> AF> bridge and a WINBOND chip (no SCSI, E-Net and VGA on the mainboard).
> AF> This system by default was shipped with the Motorola PowerPC firmware
> AF> (not PPCBug) which claims to be able to boot PReP operating Systems
> AF> but I never got this Firmware to boot ppclinux.
> AF>
> AF> With some small changes to misc.c of the normal boot code I got it
> AF> to successfully load, uncompress but "Now booting the Kernel"
> AF> was the last message I ever got from this system. After many hours
> AF> of poking around I found the reason why this happens. The Firmware
> AF> uses one IBAT and all DBAT registers but does not deinitialize them
> AF> before it calles the loaded core. I think the kernel code than
> AF> initializes those BAT entries it wants to use and enables the MMU.
> AF> This will also reactivate the remainding BAT entries which are
> AF> never invalidated. This and residual related items also keep the
> AF> preploader from working correctly.
> 
> I have added code to invalidate BATs early in my latest preploader,
> so yes I think it's still worth testing on more machines. There are
> other issues on which I'm still waiting for patches from Alois
> (residual data and PCI configuration related) but he got it to boot.
> 
>         Gabriel.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

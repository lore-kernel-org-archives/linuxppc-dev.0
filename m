Date: Fri, 15 Jan 1999 12:09:03 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Alexander Gustav Deucher <agd5f@unix.mail.virginia.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to Nubus PowerMacs
In-Reply-To: <Pine.LNX.4.04.9901150301480.632-100000@narn.local.drgw.net>
Message-ID: <Pine.HPP.3.96.990115120015.2338T-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 15 Jan 1999, Troy Benjegerdes wrote:

> On Thu, 14 Jan 1999, Gabriel Paubert wrote:
> > On Thu, 14 Jan 1999, Alexander Gustav Deucher wrote:
> > 
> > > 
> > > While we are on the subject of porting, How hard would it be to
> > > get linux ppc to boot on machines with NT firmware?  Does
> > > anyone know why this firmware is so problematic? Is there
> > > anywhere one could find documentation on it, etc.
> 
> Is this Open Firmware or some derivative of PPCbug?? I though NT required
> Open Firmware (which would mean the preploader wouldn't work too well)
> 

This is a message I got from Alois Fertl:

AF> I tried the preploader on a Motorola Pro2000/200. This is a system
AF> originally developed to run Windows NT. It has a 603ev, IBM660 PCI
AF> bridge and a WINBOND chip (no SCSI, E-Net and VGA on the mainboard).
AF> This system by default was shipped with the Motorola PowerPC firmware
AF> (not PPCBug) which claims to be able to boot PReP operating Systems
AF> but I never got this Firmware to boot ppclinux.
AF>
AF> With some small changes to misc.c of the normal boot code I got it
AF> to successfully load, uncompress but "Now booting the Kernel"
AF> was the last message I ever got from this system. After many hours
AF> of poking around I found the reason why this happens. The Firmware
AF> uses one IBAT and all DBAT registers but does not deinitialize them
AF> before it calles the loaded core. I think the kernel code than
AF> initializes those BAT entries it wants to use and enables the MMU.
AF> This will also reactivate the remainding BAT entries which are
AF> never invalidated. This and residual related items also keep the
AF> preploader from working correctly.

I have added code to invalidate BATs early in my latest preploader,
so yes I think it's still worth testing on more machines. There are 
other issues on which I'm still waiting for patches from Alois
(residual data and PCI configuration related) but he got it to boot. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

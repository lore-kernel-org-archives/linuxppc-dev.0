Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F0545CA3E@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Daniel Gonzalez'" <daniel.gonzalez@pandora.be>,
        LinuxPPC Dev List
	 <linuxppc-dev@lists.linuxppc.org>,
        Linux usb <linux-usb@suse.com>
Subject: RE: [linux-usb] USB problems on Lombard Powerbook ... and more
Date: Wed, 19 Apr 2000 17:06:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'll try to answer some of these.  I expect linuxcare.au
to jump in here also.

  v
  v (below)
  v

> From: Daniel Gonzalez [mailto:daniel.gonzalez@pandora.be]

> I am struggling with my USB port (I have a 1999 Lombard PowerBook G3
> (PPC 750)).
> What I want to have is a connection to my cool 250 Zip USB.
>
> I have the following problems:
>
> 1.
>
> (kernel 2.2.15pre17 compiles fine, with usb modules. I think
> the kernel I am using
> has a USB backport coming from 2.3. Actually I got these sources from
> linuxcare - see point 2)

Some things below make me think that whatever you have
is not very recent, so the Linux USB Guide and
current email threads don't necessarily apply to your
USB source code.

> When I try to mount the Zip drive, it fails:
>
[snip]
>
> [root]# cat drivers
> usb_scsi  <<<<<<<<<<<<<<<<<<<<<<<< OLD driver name
> hub
>
> I check the scsi tree:
> [root]# cat /proc/scsi/scsi
> Attached devices: none
> Since nothing is there, I issue the command mentioned in
> "The Linux USB sub-system" document:
> [root]#  echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
> [root]# cat /proc/scsi/scsi
> Attached devices: none
>
> ... So the command had no effect (sb knows why???)

Do you have SCSI support in your kernel?  You'll need it.
That seems to be the piece that's missing (along with
more recent USB code).

> More output in case it is useful:
>
[snip]
>
> [root]# lsmod
> Module                  Size  Used by
> usb-scsi               16068   1
> usb-ohci-hcd           21916   0  (unused) <<<<<< You DON'T need both
> usb-ohci               27236   1           <<<<<< of these.
> hub                     5100   0  (unused) <<<<<< This is no longer
                                             <<<<<< its own module.
> usbcore                31456   0  [usb-scsi usb-ohci-hcd usb-ohci hub]
>
> I also attach the /var/log/messages output.
>
[snip]
>
> 2. <<<snip>>>(For the PPC people)
>
> 3.  The so often-mentioned usbdevfs is not available in my system.
> In the The Linux USB sub-system" document they mention that
> I should issue the command:
>
> mount -t usbdevfs none /proc/bus/usb

Your USB code isn't recent.  This Linux USB HOWTO (Guide)
is very up-to-date.  It doesn't apply to the USB code that
you are using.  And you don't need to use this command
since you already have /proc/bus/usb/{devices,drivers}.

> I can not because I don't have usbdevfs (you can see that in
> a previous output).
> But this seems not to be an issue since my /proc/bus/usb
> directory looks fine.
>
> Here you have a list of my mounted volumes. Why is/proc/bus/usb not
> mentioned?

Maybe because your USB source code doesn't implement usbdevfs ???

> [root]# mount
> /dev/hda8 on / type ext2 (rw)
> none on /proc type proc (rw)
> none on /dev/pts type devpts (rw,mode=0622)
> /dev/hda10 on /mnt/shared type hfs (rw)
>
> 4. <<<snip>>>
>
> 5. Curiosity:
> Is the linux tree completely centralized? I mean, the intel,
> Alpha, PPC ... sources
> are all kept, mantained and developed in a centralized way, or do we
> have several linuxes wandering around ?

Yes (centralized).  Yes (several wandering around).
Linus maintains the blessed tree for all architectures.
Development trees can and do also exist elsewhere,
like PPC, Sparc, ARM, etc.  They will eventually get merged
back into the Linus tree.

>
> Regards and have a nice night ...
>
> Daniel

HTH.
~Randy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 24 Apr 2000 22:50:55 -0700 (PDT)
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
To: Daniel Gonzalez <daniel.gonzalez@pandora.be>
cc: Sheldon Easterbrook <sheldie@hotmail.com>, linuxppc-dev@lists.linuxppc.org,
        linux-usb@suse.com
Subject: Re: [linux-usb] Close to a solution. Please help !
In-Reply-To: <3904AB7F.A042F986@pandora.be>
Message-ID: <Pine.LNX.4.10.10004242247540.14006-100000@ziggy.one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a definate endian-ness problem.  I just tested a fix on a bronze
powerbook (lumbard) and it seems to work.

The fix will be in the next patch I send, tho that may be a while as I'm
converting the entire driver to URBs to allow proper handling of timeouts.

Matt

On Mon, 24 Apr 2000, Daniel Gonzalez wrote:

> Matthew Dharm wrote:
>
> > On Mon, 24 Apr 2000, Daniel Gonzalez wrote:
> >
> > > THE DESCRIPTION:
> > > I have the following /etc/fstab entry for the Zip
> > >
> > > /dev/sdb4  /mnt/usbzip  auto noauto,user 0 0
> > >
> > > I have also tried with sda4.
> >
> > Do you have support for SCSI disks available (either compiled in or as a
> > module)?
> >
>
> Yes. I have done everything I considered necessary to enable SCSI (my machine
> has a real SCSI interface also, though I do not use it)
>
> >
> > > THE GOOD SIGNS
> > > [root scsi]# cat /proc/scsi/usb-storage-0/2
> > > Host scsi2: usb-storage
> > >     Vendor: Iomega
> > >    Product: USB Zip 250
> > >   Protocol: Bulk only
> > >  Transport: Transparent SCSI
> > >       GUID: 059b0030059b003003005fc1
> >
> > This is a very good sign.  It shows that the driver has identified the
> > device, and attempted to communicate that information to the SCSI layer.
> >
> > > [root scsi]# cat /proc/filesystems
> >
> > This isn't needed for debugging.
> >
> > > THE BAD SIGNS
> > > [root scsi]# cat /proc/scsi/scsi
> > > Attached devices: none
> >
> > Hrm... so the SCSI layer probed for the device, but didn't find
> > anything....
> >
> > > This after I have issued a:
> > > [root scsi]# echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
> >
> > This command isn't really needed anymore.  Generally, when you attach a
> > device, it will appear immediately.
> >
> > > But it could be that the creation of /proc/scsi/usb-storage-0/2 was caused
> > > by that last command. I did not pay attention to that.
> >
> > No, it wasn't.  usb-storage-0/2 is created by connecting the device.
> >
> > What you need to do now is set syslogd to save kern.* to a logfile, and
> > then attach the device and load all the drivers, and send me the logfile.
> > You also need to enable USB Mass Storage debugging.
> >
>
> Done. Find the log attached.
> The activity which the logs includes is:
> - connecting the Zip drive to a USB port.
> - loading manually the usb-storage module (insmod)
> - disconnecting and connectingthe Zip.
>
>
> >
> > I'm suspecting that this is an endian-ness problem.  I should be able to
> > identify that relatively quickly once you send me the logfile.
> >
>
> Thanks for your interest. I am not familiar with the USB specification, and
> also
> not with the linux usb code. Are you the mantainer of that subsystem?
>
> BTW, I have sent half an hour ago another message regarding this problem.
> Most of the information is duplicated, though.

--
Matthew Dharm                              Home: mdharm@one-eyed-alien.net
Senior Engineer, QCP Inc.                        Work: mdharm@qualcomm.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3904AB7F.A042F986@pandora.be>
Date: Mon, 24 Apr 2000 16:15:59 -0400
From: Daniel Gonzalez <daniel.gonzalez@pandora.be>
MIME-Version: 1.0
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
CC: Sheldon Easterbrook <sheldie@hotmail.com>, linuxppc-dev@lists.linuxppc.org,
        linux-usb@suse.com
Subject: Re: [linux-usb] Close to a solution. Please help !
References: <Pine.LNX.4.10.10004240512510.12997-100000@ziggy.one-eyed-alien.net>
Content-Type: multipart/mixed;
 boundary="------------E4DDF1182AF6218258638E11"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------E4DDF1182AF6218258638E11
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Matt,


Matthew Dharm wrote:

> On Mon, 24 Apr 2000, Daniel Gonzalez wrote:
>
> > THE DESCRIPTION:
> > I have the following /etc/fstab entry for the Zip
> >
> > /dev/sdb4  /mnt/usbzip  auto noauto,user 0 0
> >
> > I have also tried with sda4.
>
> Do you have support for SCSI disks available (either compiled in or as a
> module)?
>

Yes. I have done everything I considered necessary to enable SCSI (my machine
has a real SCSI interface also, though I do not use it)

>
> > THE GOOD SIGNS
> > [root scsi]# cat /proc/scsi/usb-storage-0/2
> > Host scsi2: usb-storage
> >     Vendor: Iomega
> >    Product: USB Zip 250
> >   Protocol: Bulk only
> >  Transport: Transparent SCSI
> >       GUID: 059b0030059b003003005fc1
>
> This is a very good sign.  It shows that the driver has identified the
> device, and attempted to communicate that information to the SCSI layer.
>
> > [root scsi]# cat /proc/filesystems
>
> This isn't needed for debugging.
>
> > THE BAD SIGNS
> > [root scsi]# cat /proc/scsi/scsi
> > Attached devices: none
>
> Hrm... so the SCSI layer probed for the device, but didn't find
> anything....
>
> > This after I have issued a:
> > [root scsi]# echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
>
> This command isn't really needed anymore.  Generally, when you attach a
> device, it will appear immediately.
>
> > But it could be that the creation of /proc/scsi/usb-storage-0/2 was caused
> > by that last command. I did not pay attention to that.
>
> No, it wasn't.  usb-storage-0/2 is created by connecting the device.
>
> What you need to do now is set syslogd to save kern.* to a logfile, and
> then attach the device and load all the drivers, and send me the logfile.
> You also need to enable USB Mass Storage debugging.
>

Done. Find the log attached.
The activity which the logs includes is:
- connecting the Zip drive to a USB port.
- loading manually the usb-storage module (insmod)
- disconnecting and connectingthe Zip.


>
> I'm suspecting that this is an endian-ness problem.  I should be able to
> identify that relatively quickly once you send me the logfile.
>

Thanks for your interest. I am not familiar with the USB specification, and
also
not with the linux usb code. Are you the mantainer of that subsystem?

BTW, I have sent half an hour ago another message regarding this problem.
Most of the information is duplicated, though.



>
> Matt Dharm
>
> --
> Matthew Dharm                              Home: mdharm@one-eyed-alien.net
> Senior Engineer, QCP Inc.                        Work: mdharm@qualcomm.com
>
> DP: And judging from the scores, Stef has the sma...
> T:  LET'S NOT GO THERE!
>                                         -- Dust Puppy and Tanya
> User Friendly, 12/11/1997

--------------E4DDF1182AF6218258638E11
Content-Type: text/plain; charset=us-ascii;
 name="kern"
Content-Disposition: inline;
 filename="kern"
Content-Transfer-Encoding: 7bit

Apr 24 16:03:07 dhcp-213-224-12-204 kernel: hub.c: port 2 connection change
Apr 24 16:03:07 dhcp-213-224-12-204 kernel: hub.c: portstatus 100, change 3, High Speed
Apr 24 16:03:07 dhcp-213-224-12-204 kernel: usb.c: USB disconnect on device 2
Apr 24 16:03:07 dhcp-213-224-12-204 kernel: hub.c: port 2 enable change, status 100
Apr 24 16:03:08 dhcp-213-224-12-204 kernel: hub.c: port 1 connection change
Apr 24 16:03:08 dhcp-213-224-12-204 kernel: hub.c: portstatus 101, change 1, High Speed
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: hub.c: portstatus 103, change 10, High Speed
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: usb.c: USB new device connect, assigned device number 2
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: usb.c: kmalloc IF c2189d60, numif 1
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: usb.c: new device strings: Mfr=1, Product=2, SerialNumber=5
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: usb.c: USB device number 2 default language ID 0x409
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: Manufacturer: Iomega
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: Product: USB Zip 250
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: SerialNumber: 059B003003005FC1
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: usb.c: unhandled interfaces on device
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: usb.c: This device is not recognized by any installed USB driver.
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   Length              = 18
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   DescriptorType      = 01
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   USB version         = 1.10
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   Vendor:Product      = 059b:0030
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   MaxPacketSize0      = 64
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   NumConfigurations   = 1
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   Device version      = 1.00
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   Device Class:SubClass:Protocol = 00:00:00
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     Per-interface classes
Apr 24 16:03:09 dhcp-213-224-12-204 kernel: Configuration:
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   bLength             =    9
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   bDescriptorType     =   02
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   wTotalLength        = 0027
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   bNumInterfaces      =   01
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   bConfigurationValue =   01
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   iConfiguration      =   03
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   bmAttributes        =   c0
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   MaxPower            =    0mA
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   Interface: 0
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:   Alternate Setting:  0
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     bLength             =    9
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     bDescriptorType     =   04
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     bInterfaceNumber    =   00
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     bAlternateSetting   =   00
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     bNumEndpoints       =   03
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     bInterface Class:SubClass:Protocol =   08:06:50
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     iInterface          =   04
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     Endpoint:
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bLength             =    7
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bDescriptorType     =   05
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bEndpointAddress    =   01 (out)
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bmAttributes        =   02 (Bulk)
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       wMaxPacketSize      = 0040
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bInterval           =   00
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     Endpoint:
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bLength             =    7
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bDescriptorType     =   05
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bEndpointAddress    =   82 (in)
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bmAttributes        =   02 (Bulk)
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       wMaxPacketSize      = 0040
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bInterval           =   00
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:     Endpoint:
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bLength             =    7
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bDescriptorType     =   05
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bEndpointAddress    =   83 (in)
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bmAttributes        =   03 (Interrupt)
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       wMaxPacketSize      = 0002
Apr 24 16:03:09 dhcp-213-224-12-204 kernel:       bInterval           =   20
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb.c: registered new driver usb-storage
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: USB Mass Storage device detected
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Endpoints In 2 Out 1 Int 3
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Result from usb_set_interface is 0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: New GUID 059b0030059b003003005fc1
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Transport: Bulk
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Protocol: Transparent SCSI
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Apr 24 16:04:30 dhcp-213-224-12-204 kernel:
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: scsi : 3 hosts.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage:   00 00 00 00 00 00 00 0d c2 7d
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command S 0x43425355 T 0x15 LUN 0 L 0 F 0 CL 6
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command transfer result=0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0010280
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: -- transport indicates transport failure
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: scsi cmd done, result=0x70000
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage:   00 00 00 00 00 00 00 0d c2 7d
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command S 0x43425355 T 0x16 LUN 0 L 0 F 0 CL 6
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command transfer result=-32
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0008200
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0010280
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: -- transport indicates transport failure
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: scsi cmd done, result=0x70000
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage:   00 00 00 00 00 00 00 0d c2 7d
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command S 0x43425355 T 0x17 LUN 0 L 0 F 0 CL 6
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command transfer result=-32
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0008200
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0010280
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: -- transport indicates transport failure
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: scsi cmd done, result=0x70000
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage:   00 00 00 00 00 00 00 0d c2 7d
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command S 0x43425355 T 0x18 LUN 0 L 0 F 0 CL 6
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command transfer result=-32
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0008200
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0010280
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: -- transport indicates transport failure
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: scsi cmd done, result=0x70000
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage:   00 00 00 00 00 00 00 0d c2 7d
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command S 0x43425355 T 0x19 LUN 0 L 0 F 0 CL 6
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bulk command transfer result=-32
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0008200
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: clearing endpoint halt for pipe 0xc0010280
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: -- transport indicates transport failure
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: scsi cmd done, result=0x70000
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bad device number (1/0) or dev 0xc3640ea0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bad device number (2/0) or dev 0xc3640ea0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bad device number (3/0) or dev 0xc3640ea0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bad device number (4/0) or dev 0xc3640ea0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bad device number (5/0) or dev 0xc3640ea0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bad device number (6/0) or dev 0xc3640ea0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: us_queuecommand() called
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread awakened.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: Bad device number (7/0) or dev 0xc3640ea0
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb-storage: *** thread sleeping.
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: WARNING: USB Mass Storage data integrity not assured
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: USB Mass Storage device found at 2
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: usb.c: usb-storage driver claimed interface c2189d60
Apr 24 16:04:30 dhcp-213-224-12-204 kernel: USB Mass Storage support registered.
Apr 24 16:08:04 dhcp-213-224-12-204 kernel: hub.c: port 1 connection change
Apr 24 16:08:05 dhcp-213-224-12-204 kernel: hub.c: portstatus 100, change 3, High Speed
Apr 24 16:08:05 dhcp-213-224-12-204 kernel: usb.c: USB disconnect on device 2
Apr 24 16:08:05 dhcp-213-224-12-204 kernel: usb-storage: storage_disconnect() called
Apr 24 16:08:05 dhcp-213-224-12-204 kernel: hub.c: port 1 enable change, status 100
Apr 24 16:08:06 dhcp-213-224-12-204 kernel: hub.c: port 1 connection change
Apr 24 16:08:06 dhcp-213-224-12-204 kernel: hub.c: portstatus 101, change 1, High Speed
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: hub.c: portstatus 103, change 10, High Speed
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb.c: USB new device connect, assigned device number 2
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb.c: kmalloc IF c21892e0, numif 1
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb.c: new device strings: Mfr=1, Product=2, SerialNumber=5
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb.c: USB device number 2 default language ID 0x409
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: Manufacturer: Iomega
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: Product: USB Zip 250
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: SerialNumber: 059B003003005FC1
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb-storage: USB Mass Storage device detected
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb-storage: Endpoints In 2 Out 1 Int 3
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb-storage: Result from usb_set_interface is 0
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb-storage: Found existing GUID 059b0030059b003003005fc1
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: WARNING: USB Mass Storage data integrity not assured
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: USB Mass Storage device found at 2
Apr 24 16:08:07 dhcp-213-224-12-204 kernel: usb.c: usb-storage driver claimed interface c21892e0

--------------E4DDF1182AF6218258638E11--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

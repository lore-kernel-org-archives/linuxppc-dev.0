Subject: Re: LaCie USB HD not working... (more info)
From: Bastien Nocera <hadess@hadess.net>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1024432158.509.8.camel@dozo>
References: <1024432158.509.8.camel@dozo>
Date: 19 Jun 2002 00:13:17 +0100
Message-Id: <1024441998.522.15.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bad, replying to myself,

Here's more debug though:
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
hub.c: USB new device connect on bus1/1, assigned device number 3
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 32
usb-storage: Array length appears to be: 86
usb-storage: Vendor: LaCie
usb-storage: Product: USB Hard Disk
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xc8cc34a0 Out: 0xc8cc34b4 Int: 0xc8cc34c8
(Period 100)
usb_control/bulk_msg: timeout
usb.c: error getting string descriptor 0 (error=-110)
usb_control/bulk_msg: timeout
usb.c: error getting string descriptor 0 (error=-110)
usb-storage: New GUID 059fa6010000000000000000
usb-storage: Transport: Control/Bulk
usb-storage: Protocol: Reduced Block Commands (RBC)
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 00 00 00 00 00 01
usb-storage: command_abort() called
usb-storage: Call to usb_stor_control_msg() returned -104
usb-storage: -- transport indicates error, resetting
usb-storage: CB_reset() called
usb_control/bulk_msg: timeout
usb-storage: CB[I] soft reset failed -110
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: usb_stor_exit() called
usb-storage: -- calling usb_deregister()
usb.c: deregistering driver usb-storage

That's what happens when I plug in/unplug my HD.

On Tue, 2002-06-18 at 21:29, Bastien Nocera wrote:
>
> I'm getting another stab at this. I've had this drive for about a year,
> never got it to work on my PPC boxes.
>
> Here's the lowdown:
> LaCie USB 20G hard-drive, 0x59f/0xa601 ID (it's in the unusual_devs.h)
> Some people got it to work it seems:
> http://www.qbik.ch/usb/devices/showdev.php?id=68
>
> Here's the log when I plug the device in:
> Jun 18 21:04:26 dozo kernel: hub.c: USB new device connect on bus1/1,
> assigned device number 2
> Jun 18 21:04:26 dozo kernel: usb.c: USB device 2 (vend/prod
> 0x59f/0xa601) is not claimed by any active driver.
> Jun 18 21:04:27 dozo kernel: Initializing USB Mass Storage driver...
> Jun 18 21:04:27 dozo kernel: usb.c: registered new driver usb-storage
> Jun 18 21:04:30 dozo kernel: usb_control/bulk_msg: timeout
> Jun 18 21:04:33 dozo kernel: usb_control/bulk_msg: timeout
> Jun 18 21:04:33 dozo kernel: scsi0 : SCSI emulation for USB Mass Storage
> devicesJun 18 21:04:44 dozo kernel: usb_control/bulk_msg: timeout
>
> Did anybody got this drive to work on an OHCI controller or even better,
> on a PPC ?

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

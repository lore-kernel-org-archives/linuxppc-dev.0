Message-ID: <3904DA19.E105A181@dynamite.com.au>
Date: Mon, 24 Apr 2000 23:34:49 +0000
From: Brad Hards <bradh@dynamite.com.au>
MIME-Version: 1.0
To: Daniel Gonzalez <daniel.gonzalez@pandora.be>
CC: Sheldon Easterbrook <sheldie@hotmail.com>, linuxppc-dev@lists.linuxppc.org,
        linux-usb@suse.com
Subject: Re: [linux-usb] Close to a solution. Please help !
References: <20000424010537.73861.qmail@hotmail.com> <39048829.EA283A23@pandora.be> <390490A9.2D8EB962@pandora.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Gonzalez wrote:
> After a very long week, I think I am close to actually access my 250 Usb Zip drive.
> I have now 2.3.99-pre6.
You should feel priviliged. It took me months on and off to think I
might be close.
I do have some bad news though - you probably should have stayed with
Paulus' tree,
since Matt did think that there was some endian bugs, and I am pretty
sure
Paul had at least a floppy disk working.

> THE PROBLEM: I am not able to mount my Zip drive:
>
> [root scsi]# mount /mnt/usbzip/
> mount: /dev/sdb4 has wrong major or minor number
weird

> THE DESCRIPTION:
> I have the following /etc/fstab entry for the Zip
>
> /dev/sdb4  /mnt/usbzip  auto noauto,user 0 0
>
> I have also tried with sda4.
Which should be the right device - this Powerbook is IDE, right? No SCSI
attached? Then it should be on /dev/sda. But maybe /dev/sda1 if it is
HFS disk? What does fdisk show as the partitions?

> How do I get the major and minor numbers for a given device?
>
> THE GOOD SIGNS
> [root scsi]# cat /proc/scsi/usb-storage-0/2
> Host scsi2: usb-storage
>     Vendor: Iomega
>    Product: USB Zip 250
>   Protocol: Bulk only
>  Transport: Transparent SCSI
>       GUID: 059b0030059b003003005fc1
Looks good, although mine shows up slightly differently:
bradh@isp651:~ > more /proc/scsi/usb-storage-0/0
Host scsi0: usb-storage
    Vendor: Iomega
   Product: USB Zip 100
  Protocol: Bulk only
 Transport: Transparent SCSI
      GUID: 059b00010000000000f41dea


> BTW, what is shm ?
SysV shared memory. You need to mount it on /var/shm

> THE BAD SIGNS
> [root scsi]# cat /proc/scsi/scsi
> Attached devices: none
This is definately not so good.

> This after I have issued a:
> [root scsi]# echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
I don't need to do this any more. Do you get anything without it?

> But it could be that the creation of /proc/scsi/usb-storage-0/2 was caused
> by that last command. I did not pay attention to that.
>
> What should I do know ?
This is showing up correctly in /proc/bus/usb/devices and
/proc/bus/usb/drivers, right? The drive shows up and the usb-storage
driver is associated with it?
Any more kernel debug messages?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

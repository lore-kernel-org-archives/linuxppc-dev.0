Return-Path: <gnomeza@imap.cc>
Received: from smtp003.mail.ukl.yahoo.com (smtp003.mail.ukl.yahoo.com
	[217.12.11.34]) by ozlabs.org (Postfix) with SMTP id BE7D02BE83
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 23:45:15 +1100 (EST)
Message-ID: <41AC69C8.1000201@imap.cc>
Date: Tue, 30 Nov 2004 12:38:32 +0000
From: Mark Ferry <gnomeza@imap.cc>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
References: <200411301206.44403.isidoro@qassessorament.net>
In-Reply-To: <200411301206.44403.isidoro@qassessorament.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Mounting usb pendrive
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Have you compiled in PC BIOS (DOS) partition table support?

CONFIG_MSDOS_PARTITION=y

menuconfig: File Systems | Partition Types | PC BIOS (MS DOS partition 
tables) support.

I assume your ipod may well have been fat formatted.

Also note that it's using the UB driver introduced in 2.6.9(?) rather 
than the older scsi usb_storage driver.

Many of the features in the old driver may not yet have been implemented 
in the UB driver (CONFIG_SCSI_MULTI_LUN equivalent ?!).

The solution is to remove the UB driver from the kernel...
  (CONFIG_BLK_DEV_UB)

- Mark

Isidoro Reyes de Zuloaga wrote:

> Hi folks,
> I'm trying to mount my usb pendrive device and i'm getty a strange error 
> message. I compiled my kernel with the scsi modules and all the stuff, and i 
> can mount it on my x86, but in the powerbook i can't.
> this is the /var/log/messages:
> 
> Nov 30 12:01:18 yoda kernel: usb 2-1.1: new full speed USB device using 
> address 11
> Nov 30 12:01:18 yoda kernel: usb 2-1.1: new full speed USB device using 
> address 12
> Nov 30 12:02:04 yoda kernel: ohci_hcd 0001:10:1b.1: wakeup
> Nov 30 12:02:04 yoda kernel: usb 3-1: new full speed USB device using address 
> 5
> Nov 30 12:02:05 yoda kernel: uba: device 5 capacity nsec 50 bsize 512
> Nov 30 12:02:05 yoda kernel: uba: made changed
> Nov 30 12:02:05 yoda kernel: uba: device 5 capacity nsec 50 bsize 512
> Nov 30 12:02:05 yoda kernel: uba: device 5 capacity nsec 50 bsize 512
> Nov 30 12:02:05 yoda kernel:  /dev/ub/a:end_request: I/O error, dev uba, 
> sector 0
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 2
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 4
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 6
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 6
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 4
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 2
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 0
> Nov 30 12:02:05 yoda kernel:  unable to read partition table
> Nov 30 12:02:05 yoda kernel:  /dev/ub/a:end_request: I/O error, dev uba, 
> sector 2
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 4
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 6
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 0
> Nov 30 12:02:05 yoda kernel:  unable to read partition table
> Nov 30 12:02:05 yoda usb.agent[4698]:      ub: already loaded
> 
> I don't know what's happening, it's the same when i try to mount the ipod. my 
> modules are: 
> usb_storage           107772  0
> scsi_mod               69856  3 sd_mod,sg,usb_storage
> usbhid                 46592  0
> hci_usb                11104  2
> bluetooth              44100  7 rfcomm,l2cap,hci_usb
> usbcore               105204  9 
> ehci_hcd,ub,ohci_hcd,usb_storage,uhci_hcd,usbhid,hci_usb
> 

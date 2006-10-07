Return-Path: <jsteve17@yahoo.com>
Received: from web33402.mail.mud.yahoo.com (web33402.mail.mud.yahoo.com
	[68.142.206.134]) by ozlabs.org (Postfix) with SMTP id 36F8967B77
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Oct 2006 07:01:10 +1000 (EST)
Message-ID: <20061007210105.23485.qmail@web33402.mail.mud.yahoo.com>
Date: Sat, 7 Oct 2006 14:01:05 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: USB Disk Support
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having issues getting a uDiskOnChip to mount or
fdisk under linux.  I have a board running U-Boot on a
AMCC 440SP platform.  Linux seems to find the
uDiskOnChip fine, however, when I try to fdisk or
mount the device, the console hangs.  I have added
SCSI, SCSI storage, USB, USB OHCI, USB EHCI, USB Mass
Storage.  Here is my dmesg:

bash-3.00# dmesg | grep -i usb
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbmon: debugfs is not available
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ehci_hcd 0002:02:08.2: new USB bus registered,
assigned bus number 1
ehci_hcd 0002:02:08.2: supports USB remote wakeup
ehci_hcd 0002:02:08.2: USB 2.0 started, EHCI 0.95,
driver 10 Dec 2004
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2,
SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17.9 ehci_hcd
usb usb1: SerialNumber: 0002:02:08.2
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
drivers/usb/core/inode.c: creating file '001'
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller
(OHCI) Driver (PCI)
drivers/usb/core/inode.c: creating file '002'
ohci_hcd 0002:02:08.0: new USB bus registered,
assigned bus number 2
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2,
SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17.9 ohci_hcd
usb usb2: SerialNumber: 0002:02:08.0
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: no power switching (usb 1.0)
usb 1-1: new high speed USB device using ehci_hcd and
address 2
usb 1-1: default language 0x0409
usb 1-1: new device strings: Mfr=1, Product=2,
SerialNumber=3
usb 1-1: Product: uDiskOnChip
usb 1-1: Manufacturer: M-Systems
usb 1-1: SerialNumber: 98B0FB510031E86E
usb 1-1: configuration #1 chosen from 1 choice
drivers/usb/core/inode.c: creating file '001'
drivers/usb/core/inode.c: creating file '003'
ohci_hcd 0002:02:08.1: new USB bus registered,
assigned bus number 3
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
drivers/usb/core/inode.c: creating file '002'
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2,
SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17.9 ohci_hcd
usb usb3: SerialNumber: 0002:02:08.1
usb usb3: configuration #1 chosen from 1 choice
usb usb3: adding 3-0:1.0 (config #1, interface 0)
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: no power switching (usb 1.0)
drivers/usb/core/inode.c: creating file '001'
Initializing USB Mass Storage driver...
usb-storage 1-1:1.0: usb_probe_interface
usb-storage 1-1:1.0: usb_probe_interface - got id
usb-storage: USB Mass Storage device detected
usb-storage: -- associate_dev
usb-storage: Vendor: 0x08ec, Product: 0x1000,
Revision: 0x0200
usb-storage: Interface Subclass: 0x06, Protocol: 0x50
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: *** thread sleeping.
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before
scanning
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1
value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is 1, data is 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F
128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 36
bytes, 1 entries
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat
0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0
Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x2 R 0 Stat
0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage:  25 00 00 00 00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x3 L 8 F 128
Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 8
bytes, 1 entries
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB


-------------------------------------------------------
And a few other things:

bash-3.00# cat /proc/bus/usb/devices

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1
Spd=12  MxCh= 1
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64
#Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17.9 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0002:02:08.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1
Spd=12  MxCh= 1
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64
#Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17.9 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0002:02:08.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1
Spd=480 MxCh= 2
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64
#Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17.9 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0002:02:08.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2
Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64
#Cfgs=  1
P:  Vendor=08ec ProdID=1000 Rev= 2.00
S:  Manufacturer=M-Systems
S:  Product=uDiskOnChip
S:  SerialNumber=98B0FB510031E86E
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=140mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50
Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

bash-3.00# cat /proc/scsi/scsi
Attached devices:


It's probably just a kernel config issue, but I'm not
sure what else to try.  I would appreciate any input!

Thanks,
   Jeff

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

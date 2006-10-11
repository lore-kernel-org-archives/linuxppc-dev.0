Return-Path: <jsteve17@yahoo.com>
Received: from web33405.mail.mud.yahoo.com (web33405.mail.mud.yahoo.com
	[68.142.206.137]) by ozlabs.org (Postfix) with SMTP id 003BD67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 20:54:07 +1000 (EST)
Message-ID: <20061011105405.14367.qmail@web33405.mail.mud.yahoo.com>
Date: Wed, 11 Oct 2006 03:54:05 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: Re: USB Disk Support...FIXED
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

For those interested, I figured out the issue.  It was an incorrect PCIX PI=
M setting.  Even though the comment on the PIM windows that are setup in lu=
an.c (the board specific platform file in the kernel) says 2GB window, the =
actual register setting is only for a 512MB window.  I happend to have 1GB =
of memory in my system, and it must have been allocating an address above t=
he 512MB.  In the Luan board, I only had 512MB, so that is why it worked th=
ere.=0A=0AMaybe in the next kernel release, the comment should be fixed to =
match the register setting.=0A=0A-Jeff Stevens=0A=0A----- Original Message =
----=0AFrom: Jeff Stevens <jsteve17@yahoo.com>=0ATo: Jeff Stevens <jsteve17=
@yahoo.com>; linuxppc-embedded@ozlabs.org=0ASent: Sunday, October 8, 2006 1=
2:26:17 PM=0ASubject: Re: USB Disk Support=0A=0AI have more information.  I=
 am using a Phillips=0AISP1562 USB host controller.  I ran the same kernel=
=0Aconfig on the actual Luan board (with an ISP1563 PCI=0Aeval board from P=
hillips), and the USB storage works=0Afine.  I compared the dmesg from both=
 the Luan board=0Aand our 440SP custom system, and here are the=0Adifferenc=
es:=0A=0AThe custom system stops at:=0A...=0Ausb-storage: Command READ_CAPA=
CITY (10 bytes)=0Ausb-storage:  25 00 00 00 00 00 00 00 00 00=0Ausb-storage=
: Bulk Command S 0x43425355 T 0x3 L 8 F 128=0ATrg 0 LUN 0 CL 10=0Ausb-stora=
ge: usb_stor_bulk_transfer_buf: xfer 31 bytes=0Ausb-storage: Status code 0;=
 transferred 31/31=0Ausb-storage: -- transfer complete=0Ausb-storage: Bulk =
command transfer result=3D0=0Ausb-storage: usb_stor_bulk_transfer_sglist: x=
fer 8=0Abytes, 1 entries=0Ausb-storage: Status code 0; transferred 8/8=0Aus=
b-storage: -- transfer complete=0Ausb-storage: Bulk data transfer result 0x=
0=0Ausb-storage: Attempting to get CSW...=0Ausb-storage: usb_stor_bulk_tran=
sfer_buf: xfer 13 bytes=0Ausb-storage: command_abort called=0Ausb-storage: =
usb_stor_stop_transport called=0Ausb-storage: -- cancelling URB=0A=0AIt see=
ms to fail on Attempting to get CSW...  On the=0ALuan board it gets passed =
this:=0A=0Ausb-storage: Command READ_CAPACITY (10 bytes)=0Ausb-storage:  25=
 00 00 00 00 00 00 00 00 00=0Ausb-storage: Bulk Command S 0x43425355 T 0x3 =
L 8 F 128=0ATrg 0 LUN 0 CL 10=0Ausb-storage: usb_stor_bulk_transfer_buf: xf=
er 31 bytes=0Ausb-storage: Status code 0; transferred 31/31=0Ausb-storage: =
-- transfer complete=0Ausb-storage: Bulk command transfer result=3D0=0Ausb-=
storage: usb_stor_bulk_transfer_sglist: xfer 8=0Abytes, 1 entries=0Ausb-sto=
rage: Status code 0; transferred 8/8=0Ausb-storage: -- transfer complete=0A=
usb-storage: Bulk data transfer result 0x0=0Ausb-storage: Attempting to get=
 CSW...=0Ausb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes=0Ausb-stor=
age: Status code 0; transferred 13/13=0Ausb-storage: -- transfer complete=
=0Ausb-storage: Bulk status result =3D 0=0Ausb-storage: Bulk Status S 0x534=
25355 T 0x3 R 0 Stat=0A0x0=0Ausb-storage: scsi cmd done, result=3D0x0=0Ausb=
-storage: *** thread sleeping.=0Ausb-storage: queuecommand called=0Ausb-sto=
rage: *** thread awakened.=0Ausb-storage: Command MODE_SENSE (6 bytes)=0Aus=
b-storage:  1a 00 3f 00 c0 00=0Ausb-storage: Bulk Command S 0x43425355 T 0x=
4 L 192 F=0A128 Trg 0 LUN 0 CL 6=0Ausb-storage: usb_stor_bulk_transfer_buf:=
 xfer 31 bytes=0Ausb-storage: Status code 0; transferred 31/31=0A... <conti=
nues>=0A=0ACould this be a noisy usb port?  The USB controller=0Aused is th=
e same, the only difference is that on the=0Acustom board, the USB controll=
er is onboard, where as=0Aon the Luan board it is a PCI card.  U-boot is al=
so=0Ausing practically the same board specific config file=0Aand board file=
, other than the flash and DDR stuff. =0AOn the custom board, the card read=
er never ends up in=0A/proc/scsi/scsi, but it does on the luan board.=0A=0A=
Thanks,=0A   Jeff Stevens=0A=0A=0A--- Jeff Stevens <jsteve17@yahoo.com> wro=
te:=0A=0A> I am having issues getting a uDiskOnChip to mount or=0A> fdisk u=
nder linux.  I have a board running U-Boot on=0A> a=0A> AMCC 440SP platform=
.  Linux seems to find the=0A> uDiskOnChip fine, however, when I try to fdi=
sk or=0A> mount the device, the console hangs.  I have added=0A> SCSI, SCSI=
 storage, USB, USB OHCI, USB EHCI, USB=0A> Mass=0A> Storage.  Here is my dm=
esg:=0A> =0A> bash-3.00# dmesg | grep -i usb=0A> usbcore: registered new dr=
iver usbfs=0A> usbcore: registered new driver hub=0A> usbmon: debugfs is no=
t available=0A> drivers/usb/core/inode.c: creating file 'devices'=0A> drive=
rs/usb/core/inode.c: creating file '001'=0A> ehci_hcd 0002:02:08.2: new USB=
 bus registered,=0A> assigned bus number 1=0A> ehci_hcd 0002:02:08.2: suppo=
rts USB remote wakeup=0A> ehci_hcd 0002:02:08.2: USB 2.0 started, EHCI 0.95=
,=0A> driver 10 Dec 2004=0A> usb usb1: default language 0x0409=0A> usb usb1=
: new device strings: Mfr=3D3, Product=3D2,=0A> SerialNumber=3D1=0A> usb us=
b1: Product: EHCI Host Controller=0A> usb usb1: Manufacturer: Linux 2.6.17.=
9 ehci_hcd=0A> usb usb1: SerialNumber: 0002:02:08.2=0A> usb usb1: configura=
tion #1 chosen from 1 choice=0A> usb usb1: adding 1-0:1.0 (config #1, inter=
face 0)=0A> hub 1-0:1.0: usb_probe_interface=0A> hub 1-0:1.0: usb_probe_int=
erface - got id=0A> hub 1-0:1.0: USB hub found=0A> drivers/usb/core/inode.c=
: creating file '001'=0A> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host=0A> C=
ontroller=0A> (OHCI) Driver (PCI)=0A> drivers/usb/core/inode.c: creating fi=
le '002'=0A> ohci_hcd 0002:02:08.0: new USB bus registered,=0A> assigned bu=
s number 2=0A> usb usb2: default language 0x0409=0A> usb usb2: new device s=
trings: Mfr=3D3, Product=3D2,=0A> SerialNumber=3D1=0A> usb usb2: Product: O=
HCI Host Controller=0A> usb usb2: Manufacturer: Linux 2.6.17.9 ohci_hcd=0A>=
 usb usb2: SerialNumber: 0002:02:08.0=0A> usb usb2: configuration #1 chosen=
 from 1 choice=0A> usb usb2: adding 2-0:1.0 (config #1, interface 0)=0A> hu=
b 2-0:1.0: usb_probe_interface=0A> hub 2-0:1.0: usb_probe_interface - got i=
d=0A> hub 2-0:1.0: USB hub found=0A> hub 2-0:1.0: no power switching (usb 1=
.0)=0A> usb 1-1: new high speed USB device using ehci_hcd=0A> and=0A> addre=
ss 2=0A> usb 1-1: default language 0x0409=0A> usb 1-1: new device strings: =
Mfr=3D1, Product=3D2,=0A> SerialNumber=3D3=0A> usb 1-1: Product: uDiskOnChi=
p=0A> usb 1-1: Manufacturer: M-Systems=0A> usb 1-1: SerialNumber: 98B0FB510=
031E86E=0A> usb 1-1: configuration #1 chosen from 1 choice=0A> drivers/usb/=
core/inode.c: creating file '001'=0A> drivers/usb/core/inode.c: creating fi=
le '003'=0A> ohci_hcd 0002:02:08.1: new USB bus registered,=0A> assigned bu=
s number 3=0A> usb 1-1: adding 1-1:1.0 (config #1, interface 0)=0A> drivers=
/usb/core/inode.c: creating file '002'=0A> usb usb3: default language 0x040=
9=0A> usb usb3: new device strings: Mfr=3D3, Product=3D2,=0A> SerialNumber=
=3D1=0A> usb usb3: Product: OHCI Host Controller=0A> usb usb3: Manufacturer=
: Linux 2.6.17.9 ohci_hcd=0A> usb usb3: SerialNumber: 0002:02:08.1=0A> usb =
usb3: configuration #1 chosen from 1 choice=0A> usb usb3: adding 3-0:1.0 (c=
onfig #1, interface 0)=0A> hub 3-0:1.0: usb_probe_interface=0A> hub 3-0:1.0=
: usb_probe_interface - got id=0A> hub 3-0:1.0: USB hub found=0A> hub 3-0:1=
.0: no power switching (usb 1.0)=0A> drivers/usb/core/inode.c: creating fil=
e '001'=0A> Initializing USB Mass Storage driver...=0A> usb-storage 1-1:1.0=
: usb_probe_interface=0A> usb-storage 1-1:1.0: usb_probe_interface - got id=
=0A> usb-storage: USB Mass Storage device detected=0A> usb-storage: -- asso=
ciate_dev=0A> usb-storage: Vendor: 0x08ec, Product: 0x1000,=0A> Revision: 0=
x0200=0A> usb-storage: Interface Subclass: 0x06, Protocol:=0A> 0x50=0A> usb=
-storage: Transport: Bulk=0A> usb-storage: Protocol: Transparent SCSI=0A> s=
csi0 : SCSI emulation for USB Mass Storage devices=0A> usb-storage: *** thr=
ead sleeping.=0A> usbcore: registered new driver usb-storage=0A> USB Mass S=
torage support registered.=0A> usb-storage: device found at 2=0A> usb-stora=
ge: waiting for device to settle before=0A> scanning=0A> usb-storage: usb_s=
tor_control_msg: rq=3Dfe rqtype=3Da1=0A> value=3D0000 index=3D00 len=3D1=0A=
> usb-storage: GetMaxLUN command result is 1, data is=0A> 0=0A> usb-storage=
: queuecommand called=0A> usb-storage: *** thread awakened.=0A> usb-storage=
: Command INQUIRY (6 bytes)=0A> usb-storage:  12 00 00 00 24 00=0A> usb-sto=
rage: Bulk Command S 0x43425355 T 0x1 L 36 F=0A> 128 Trg 0 LUN 0 CL 6=0A> u=
sb-storage: usb_stor_bulk_transfer_buf: xfer 31=0A> bytes=0A> usb-storage: =
Status code 0; transferred 31/31=0A> usb-storage: -- transfer complete=0A> =
usb-storage: Bulk command transfer result=3D0=0A> usb-storage: usb_stor_bul=
k_transfer_sglist: xfer 36=0A> bytes, 1 entries=0A> usb-storage: Status cod=
e 0; transferred 36/36=0A> usb-storage: -- transfer complete=0A> usb-storag=
e: Bulk data transfer result 0x0=0A> usb-storage: Attempting to get CSW...=
=0A> usb-storage: usb_stor_bulk_transfer_buf: xfer 13=0A> bytes=0A> usb-sto=
rage: Status code 0; transferred 13/13=0A> usb-storage: -- transfer complet=
e=0A> usb-storage: Bulk status result =3D 0=0A> usb-storage: Bulk Status S =
0x53425355 T 0x1 R 0 Stat=0A> 0x0=0A> usb-storage: scsi cmd done, result=3D=
0x0=0A> usb-storage: *** thread sleeping.=0A> usb-storage: queuecommand cal=
led=0A> usb-storage: *** thread awakened.=0A> usb-storage: Command TEST_UNI=
T_READY (6 bytes)=0A> usb-storage:  00 00 00 00 00 00=0A> usb-storage: Bulk=
 Command S 0x43425355 T 0x2 L 0 F 0=0A> Trg 0 LUN 0 CL 6=0A> usb-storage: u=
sb_stor_bulk_transfer_buf: xfer 31=0A> bytes=0A> usb-storage: Status code 0=
; transferred 31/31=0A> usb-storage: -- transfer complete=0A> usb-storage: =
Bulk command transfer result=3D0=0A> usb-storage: Attempting to get CSW...=
=0A> usb-storage: usb_stor_bulk_transfer_buf: xfer 13=0A> bytes=0A> usb-sto=
rage: Status code 0; transferred 13/13=0A> usb-storage: -- transfer complet=
e=0A> usb-storage: Bulk status result =3D 0=0A> usb-storage: Bulk Status S =
0x53425355 T 0x2 R 0 Stat=0A> 0x0=0A> usb-storage: scsi cmd done, result=3D=
0x0=0A> usb-storage: *** thread sleeping.=0A> usb-storage: queuecommand cal=
led=0A> usb-storage: *** thread awakened.=0A> usb-storage: Command READ_CAP=
ACITY (10 bytes)=0A> usb-storage:  25 00 00 00 00 00 00 00 00 00=0A> usb-st=
orage: Bulk Command S 0x43425355 T 0x3 L 8 F=0A> 128=0A> Trg 0 LUN 0 CL 10=
=0A> usb-storage: usb_stor_bulk_transfer_buf: xfer 31=0A> bytes=0A> usb-sto=
rage: Status code 0; transferred 31/31=0A> usb-storage: -- transfer complet=
e=0A> usb-storage: Bulk command transfer result=3D0=0A> usb-storage: usb_st=
or_bulk_transfer_sglist: xfer 8=0A> bytes, 1 entries=0A> usb-storage: Statu=
s code 0; transferred 8/8=0A> usb-storage: -- transfer complete=0A> usb-sto=
rage: Bulk data transfer result 0x0=0A> usb-storage: Attempting to get CSW.=
..=0A> usb-storage: usb_stor_bulk_transfer_buf: xfer 13=0A> bytes=0A> usb-s=
torage: command_abort called=0A> usb-storage: usb_stor_stop_transport calle=
d=0A> usb-storage: -- cancelling URB=0A> =0A> =0A>=0A----------------------=
---------------------------------=0A> And a few other things:=0A> =0A> bash=
-3.00# cat /proc/bus/usb/devices=0A> =0A> T:  Bus=3D03 Lev=3D00 Prnt=3D00 P=
ort=3D00 Cnt=3D00 Dev#=3D  1=0A> Spd=3D12  MxCh=3D 1=0A> B:  Alloc=3D  0/90=
0 us ( 0%), #Int=3D  0, #Iso=3D  0=0A> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=
=3D00 Prot=3D00 MxPS=3D64=0A> #Cfgs=3D  1=0A> P:  Vendor=3D0000 ProdID=3D00=
00 Rev=3D 2.06=0A> S:  Manufacturer=3DLinux 2.6.17.9 ohci_hcd=0A> S:  Produ=
ct=3DOHCI Host Controller=0A> S:  SerialNumber=3D0002:02:08.1=0A> C:* #Ifs=
=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA=0A> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 =
Cls=3D09(hub  ) Sub=3D00=0A> Prot=3D00=0A> Driver=3Dhub=0A> E:  Ad=3D81(I) =
Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms=0A> =0A> T:  Bus=3D02 Lev=3D00 Prnt=
=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1=0A> Spd=3D12  MxCh=3D 1=0A> B:  Alloc=
=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0=0A> D:  Ver=3D 1.10 Cls=3D09(hu=
b  ) Sub=3D00 Prot=3D00 MxPS=3D64=0A> #Cfgs=3D  1=0A> P:  Vendor=3D0000 Pro=
dID=3D0000 Rev=3D 2.06=0A> S:  Manufacturer=3DLinux 2.6.17.9 ohci_hcd=0A> S=
:  Product=3DOHCI Host Controller=0A> S:  SerialNumber=3D0002:02:08.0=0A> C=
:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA=0A> I:  If#=3D 0 Alt=3D 0 #EP=
s=3D 1 Cls=3D09(hub  ) Sub=3D00=0A> Prot=3D00=0A> Driver=3Dhub=0A> E:  Ad=
=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms=0A> =0A> T:  Bus=3D01 Lev=
=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1=0A> Spd=3D480 MxCh=3D 2=0A> B=
:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0=0A> D:  Ver=3D 2.00 Cls=
=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D64=0A> #Cfgs=3D  1=0A> P:  Vendor=3D=
0000 ProdID=3D0000 Rev=3D 2.06=0A> S:  Manufacturer=3DLinux 2.6.17.9 ehci_h=
cd=0A> S:  Product=3DEHCI Host Controller=0A> S:  SerialNumber=3D0002:02:08=
.2=0A> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA=0A> I:  If#=3D 0 Alt=
=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00=0A> Prot=3D00=0A> Driver=3Dhub=0A>=
 E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms=0A> =0A> T:  Bus=3D0=
1 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2=0A> Spd=3D480 MxCh=3D 0=
=0A> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64=0A> #Cfgs=
=3D  1=0A> P:  Vendor=3D08ec ProdID=3D1000 Rev=3D 2.00=0A> S:  Manufacturer=
=3DM-Systems=0A> S:  Product=3DuDiskOnChip=0A> S:  SerialNumber=3D98B0FB510=
031E86E=0A> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D140mA=0A> I:  If#=3D 0=
 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06=0A> Prot=3D50=0A> Driver=3Dusb=
-storage=0A> E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A> E:  Ad=
=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms=0A> =0A> bash-3.00# cat /proc=
/scsi/scsi=0A> Attached devices:=0A> =0A> =0A> It's probably just a kernel =
config issue, but I'm=0A> not=0A> sure what else to try.  I would appreciat=
e any=0A> input!=0A> =0A> Thanks,=0A>    Jeff=0A> =0A> ____________________=
______________________________=0A> Do You Yahoo!?=0A> Tired of spam?  Yahoo=
! Mail has the best spam=0A> protection around =0A> http://mail.yahoo.com =
=0A> _______________________________________________=0A> Linuxppc-embedded =
mailing list=0A> Linuxppc-embedded@ozlabs.org=0A>=0Ahttps://ozlabs.org/mail=
man/listinfo/linuxppc-embedded=0A> =0A=0A=0A_______________________________=
___________________=0ADo You Yahoo!?=0ATired of spam?  Yahoo! Mail has the =
best spam protection around =0Ahttp://mail.yahoo.com =0A=0A=0A=0A=0A

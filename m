Date: Fri, 6 Sep 2002 17:01:52 -0500
From: Robert Serphillips <rserphillips@austin.rr.com>
To: Linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: aic7xxx data overrun
Message-Id: <20020906170152.648f1ef8.rserphillips@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a Yamaha ext 2100 cdrw connected to an adaptec 2930 SCSI card.
Using kernel 2.4.19 with the aic7xxx driver. All in a PowerMac 8500.
The
drive is fully functional but after a while of inactivity I can't
mount
a cd with it. I can still erase and burn but when I try to mount a cd
I
get an Input/Output error and must specify system type. When I reboot
the drive starts working normally for a while  (on the order of
weeks).

root@Hawg<352>linux: cat /proc/pci
Bus  0, device  14, function  0:
SCSI storage controller: Adaptec AHA-7850 (rev 3).
IRQ 24.
Master Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
I/O at 0x1000 [0x10ff].
Non-prefetchable 32 bit memory at 0x80800000 [0x80800fff].

##################################################
root@Hawg<354>linux: cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 6.2.4
aic7850: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
Channel A Target 0 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)
Channel A Target 1 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)
Channel A Target 2 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)
	Goal: 5.000MB/s transfers (5.000MHz, offset 7)
	Curr: 5.000MB/s transfers (5.000MHz, offset 7)
	Channel A Target 2 Lun 0 Settings
		Commands Queued 123508
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 3 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)
Channel A Target 4 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)
Channel A Target 5 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)
Channel A Target 6 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)
Channel A Target 7 Negotiation Settings
	User: 5.000MB/s transfers (5.000MHz, offset 255)

############################################
root@Hawg<355>linux: cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: YAMAHA   Model: CRW2100S         Rev: 1.0N
  Type:   CD-ROM                           ANSI SCSI revision: 02

############################################
/var/log/messeages

Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 4096.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x089ed000 : Length 4096
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x2.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 4096.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x089ed000 : Length 4096
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x3.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 4096.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x089ed000 : Length 4096
Sep  5 22:01:14 Hawg kernel: SCSI cdrom error : host 0 channel 0 id 2
lun 0 return code = 70000
Sep  5 22:01:14 Hawg kernel:  I/O error: dev 0b:00, sector 0
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x2.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 2048.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x089ed800 : Length 2048
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x3.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 2048.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x089ed800 : Length 2048
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x2.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 2048.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x089ed800 : Length 2048
Sep  5 22:01:14 Hawg kernel: SCSI cdrom error : host 0 channel 0 id 2
lun 0 return code = 70000
Sep  5 22:01:14 Hawg kernel:  I/O error: dev 0b:00, sector 4
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x3.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 2048.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x0c7a0000 : Length 2048
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x2.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 2048.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x0c7a0000 : Length 2048
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): data overrun detected in
Data-in phase.  Tag == 0x3.
Sep  5 22:01:14 Hawg kernel: (scsi0:A:2:0): Have seen Data Phase.
Length = 2048.  NumSGs = 1.
Sep  5 22:01:14 Hawg kernel: sg[0] - Addr 0x0c7a0000 : Length 2048
Sep  5 22:01:14 Hawg kernel: SCSI cdrom error : host 0 channel 0 id 2
lun 0 return code = 70000
Sep  5 22:01:14 Hawg kernel:  I/O error: dev 0b:00, sector 0
Sep  5 22:01:14 Hawg kernel: FAT: unable to read boot sector

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

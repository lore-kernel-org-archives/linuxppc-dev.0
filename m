Date: Wed, 1 Sep 1999 17:16:38 +0200 (MET DST)
From: Geert Uytterhoeven <geert@sonycom.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Sym53c8xx in 2.3.now
Message-ID: <Pine.GSO.4.10.9909011709520.5612-100000@oleander.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Anybody who has the sym53c8xx or ncr53c8xx driver working with the latest 2.3.x kernels?

I get:

| sym53c8xx: at PCI bus 0, device 6, function 0
| sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
| sym53c8xx: setting PCI_COMMAND_MASTER PCI_COMMAND_PARITY...(fix-up)
| sym53c8xx: 53c875 detected 
| sym53c875-0: rev=0x04, base=0xc3000000, io_port=0x1400, irq=31
| sym53c875-0: NCR clock is 40218KHz, 40218KHz
| sym53c875-0: ID 7, Fast-20, Parity Checking
| sym53c875-0: on-chip RAM at 0xc3001000
| sym53c875-0: restart (scsi reset).
| sym53c875-0: Downloading SCSI SCRIPTS.
| ncr53c8xx: at PCI bus 0, device 6, function 0
| ncr53c8xx: IO region 0x1400 to 0x147f is in use
| mesh: assuming 50MHz clock frequency
| scsi0 : sym53c8xx - version 1.3c
| scsi1 : MESH
| scsi : 2 hosts.
| scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
| sym53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1

And then the system hangs in a wait loop...

My devices (from 2.3.6 dmesg):

|   Vendor: QUANTUM   Model: VIKING II 4.5WLS  Rev: 3506
|   Type:   Direct-Access                      ANSI SCSI revision: 02
| Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
|   Vendor: PLEXTOR   Model: CD-ROM PX-12TS    Rev: 1.02
|   Type:   CD-ROM                             ANSI SCSI revision: 02
|   Vendor: HP        Model: HP35480A          Rev: T503
|   Type:   Sequential-Access                  ANSI SCSI revision: 02
| sym53c875-0-<0,0>: tagged command queue depth set to 8
|   Vendor: QUANTUM   Model: FIREBALL_TM3200S  Rev: 300X
|   Type:   Direct-Access                      ANSI SCSI revision: 02
| Detected scsi disk sdb at scsi1, channel 0, id 5, lun 0
| scsi : detected 2 SCSI disks total.
| sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
| SCSI device sda: hdwr sector= 512 bytes. Sectors= 8910423 [4350 MB] [4.4 GB]
| SCSI device sdb: hdwr sector= 512 bytes. Sectors= 6281856 [3067 MB] [3.1 GB]

Disabling sym53c8xx and using ncr53c8xx instead doesn't fix the problem.

Greetings,

						Geert

--
Geert Uytterhoeven                   Geert.Uytterhoeven@sonycom.com
Sony Suprastructure Center Europe (SUPC-E) --- Brussels --- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Message-ID: <007701bfec22$aed1c710$a66d34c0@oleane.com>
From: "Lionel TAILLURAT" <Lionel.TAILLURAT@ecrin.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: -= MVME 2300 =-
Date: Wed, 12 Jul 2000 19:00:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have some problems using Linux with the MVME 2300.

I'm using the debian potato for Prep (http://www.debian.org/~porter/).
The installation and boot are ok. The problems are  :

1- Universe VME driver.

I have used these drivers :
http://lisa2.physik.uni-bonn.de/~hannappe/software/index.html
http://www.vmelinux.org/

- The first could be loaded but when I'm looking at /dev/vme_stat the
informations are bad (fffffff ...)
- The second don't load and return me an error with PCI_ID

So I had decided to try the MVME2600 kernel image of Gabriel Paubert, this
one don't boot (PC keyb error, there is no keyboard controller on the
mvme2300! ).

Seeing that, I try to compile a new kernel using the kernel patch created by
Gabriel Paubert, and the second second problem appears !

2- SCSI drivers.

I'm using a Technobox 2044 PMC (ncr53c875) as SCSI device.
The kernel provided by Debian see well my SCSI device.

When I want to compile a new kernel using the NCR53c8xx driver, this one
don't  seem to see my SCSI device ( the scsi driver is compiled in the
kernel and not as a module).

The only message I have is :
scsi : 0 hosts.
scsi : detected total.

And I should have that :
...
ncr53c8xx: at PCI bus 0, device 16, function 0
ncr53c8xx: 53c875 detected
ncr53c875-0: rev=0x04, base=0x2ffeee00, io_port=0xfffde00, irq=25
ncr53c875-0: NCR clock is 40218KHz, 40218KHz
ncr53c875-0: ID 7, Fast-20, Parity Checking
ncr53c875-0: on-chip RAM at 0x2ffed000
ncr53c875-0: restart (scsi reset).
ncr53c875-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - version 3.2a-2
scsi : 1 host.
  Vendor: IBM       Model: DNES-309170       Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: IBM       Model: DNES-309170       Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
ncr53c875-0-<0,0>: tagged command queue depth set to 4
ncr53c875-0-<1,0>: tagged command queue depth set to 4
scsi : detected 2 SCSI disks total.
ncr53c875-0-<0,*>: FAST-5 SCSI 5.0 MB/s (200 ns, offset 16)
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7
GB]
ncr53c875-0-<1,*>: FAST-5 SCSI 5.0 MB/s (200 ns, offset 16)
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7
GB]
...

I had tested differents configurations of the scsi drivers and low SCSI
NCR53c8xx driver : No way !


How can I do to make my MVME 2300 work with Linux ?

Thank's in advance.
-------------------------------------------------------
Lionel TAILLURAT
TECHNICAL SERVICE

ECRIN AUTOMATISMES -industrial computer's-
Rue du pré-de-l'Horme
B.P 15
38921 CROLLES CEDEX
FRANCE
Tel :(33) 4 76 92 20 01
Fax :(33) 4 76 08 03 18
Email: Lionel.TAILLURAT@ecrin.com
---------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

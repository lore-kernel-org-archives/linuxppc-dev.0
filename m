Message-Id: <200103251635.KAA16519@lists.linuxppc.org>
Subject: Re: st corruption
From: Guillaume Laures <guillaume.laures@noos.fr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <v04003a18b6e035380f3f@[24.70.162.12]>
Content-Type: text/plain; charset=ISO-8859-1
Date: 25 Mar 2001 17:08:04 +0200
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Time to try out the DDS-2 that came with my ANS 700 :-)


Le 22 Mar 2001 17:14:01 -0600, Tony Mantler a écrit :
>
> At 1:41 PM -0600 3/22/2001, Geert Uytterhoeven wrote:
> [...]
> >Just create some large files, make md5sums, tar them to tape,
> >untar them from tape, and verify the md5sums. I see approx. 7 blocks of
> >corrupted data for 256 MB of data.
>

> merida:/home/nicoya# cat /proc/scsi/scsi

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: CD-ROM CR-8005A  Rev: 4.0i
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: HP       Model: C1533A           Rev: 9503
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST15150W_APL     Rev: 9503
  Type:   Direct-Access                    ANSI SCSI revision: 02

scsi0 is :
sym53c8xx: at PCI bus 0, device 17, function 0
sym53c8xx: setting PCI_COMMAND_IO...
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c825a detected
sym53c8xx: at PCI bus 0, device 18, function 0
sym53c8xx: setting PCI_COMMAND_IO...
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c825a detected
sym53c825a-0: rev 0x11 on pci bus 0 device 17 function 0 irq 22
sym53c825a-0: ID 7, Fast-10, Parity Checking
sym53c825a-1: rev 0x11 on pci bus 0 device 18 function 0 irq 26
sym53c825a-1: ID 7, Fast-10, Parity Checking
scsi0 : sym53c8xx-1.7.1-20000726
scsi1 : sym53c8xx-1.7.1-20000726
scsi2 : 53C94
scsi : 3 hosts.

> merida:/home/nicoya# mt status

SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 0 bytes. Density code 0x13 (DDS (61000 bpi)).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN

> merida:/home/nicoya# dd if=/dev/cdrom of=testfile bs=1024k count=256

256+0 records in
256+0 records out

> merida:/home/nicoya# md5sum testfile

13b37214355ea84d906a54bb14c1c0be  testfile

> merida:/home/nicoya# tar -c testfile >/dev/st0
> merida:/home/nicoya# mv testfile testfile.1
> merida:/home/nicoya# tar -x </dev/st0
> merida:/home/nicoya# md5sum testfile

13b37214355ea84d906a54bb14c1c0be  testfile

uname -a :
Linux shiner.gom.net 2.2.18-snd-bkport #26 Wed Feb 28 23:19:57 CET 2001
ppc unknown

So no prob here either with close hardware.

Cheers



--
GoM


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

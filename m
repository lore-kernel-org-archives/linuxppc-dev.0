Message-Id: <v04003a18b6e035380f3f@[24.70.162.12]>
In-Reply-To: <Pine.LNX.4.05.10103222032400.552-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 22 Mar 2001 17:14:01 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: st corruption
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:41 PM -0600 3/22/2001, Geert Uytterhoeven wrote:
[...]
>Just create some large files, make md5sums, tar them to tape,
>untar them from tape, and verify the md5sums. I see approx. 7 blocks of
>corrupted data for 256 MB of data.

merida:/home/nicoya# modprobe mesh
merida:/home/nicoya# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL ST4300S Rev: 0F0D
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: MATSHITA Model: CD-ROM CR-8012   Rev: 1.0f
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: ARCHIVE  Model: Python 25501-XXX Rev: 2.96
  Type:   Sequential-Access                ANSI SCSI revision: 02
merida:/home/nicoya# mt status
drive type = Generic SCSI-2 tape
drive status = 318767616
sense key error = 0
residue count = 0
file number = 0
block number = 0
Tape block size 512 bytes. Density code 0x13 (DDS (61000 bpi)).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN
merida:/home/nicoya# dd if=/dev/cdrom of=testfile bs=1024k count=256
256+0 records in
256+0 records out
merida:/home/nicoya# md5sum testfile
118c94df7aae2df0fb26dce3b13312f9  testfile
merida:/home/nicoya# tar -c testfile >/dev/st0
merida:/home/nicoya# mv testfile testfile.1
merida:/home/nicoya# tar -x </dev/st0
merida:/home/nicoya# md5sum testfile
118c94df7aae2df0fb26dce3b13312f9  testfile
merida:/home/nicoya# uname -a
Linux merida 2.4.1 #1 SMP Mon Feb 5 17:32:52 CST 2001 ppc unknown


This is with my 9600/200mp. (For the curious, the CD in the drive was my
copy of the Marathon trilogy)


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 41CBBB6F1E
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2011 04:50:16 +1000 (EST)
Received: by pvg16 with SMTP id 16so1037163pvg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Apr 2011 11:50:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4D9CAD1F.6060500@garzik.org>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
	<4D9CAD1F.6060500@garzik.org>
Date: Wed, 6 Apr 2011 20:50:12 +0200
Message-ID: <BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Tejun Heo <htejun@gmail.com>, "Moffett,
	Kyle D" <Kyle.D.Moffett@boeing.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Jeff, all,

On Wed, Apr 6, 2011 at 8:12 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 04/06/2011 01:48 PM, Moffett, Kyle D wrote:
>> On Apr 06, 2011, at 13:00, Leon Woestenberg wrote:
>>> after investigating problems with sata_sil24.c on a freescale p2020
>>> soc, I wonder if this driver works on powerpc at all?
>>>
>>> Does anyone know of a working setup of sata_sil24 on a big endian
>>> powerpc system?
>>
>> Our P2020 boards work fine with legacy PCI interrupts (I think it's a
>> sil3124 over PCI-E); the only deficiency is that MSI does not seem to work.
>>
>
> We've definitely had issues with sata_sil24 + MSI, also...
>
> sata_sil24 does work on big endian in general.
>

On my system, I have the contrary to Kyle's experience (thanks for sharing).

PowerPC P2020RDB
vanilla 2.6.38
Sil3132 on mini-PCI Express card


Enabling msi gets me further than disabling it (default).

modprobe sata_sil

[    8.834613] sata_sil24 0001:03:00.0: version 1.1
[    8.885581] scsi0 : sata_sil24
[    8.901420] scsi1 : sata_sil24
[    8.904642] ata1: SATA max UDMA/100 host m128@0xc0000000 port
0xc0004000 irq 16
[    8.911961] ata2: SATA max UDMA/100 host m128@0xc0000000 port
0xc0006000 irq 16
[   11.095127] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   14.906986] eth0: no IPv6 routers present
[   16.099016] ata1.00: qc timeout (cmd 0xec)
[   16.103128] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   18.299050] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   28.303026] ata1.00: qc timeout (cmd 0xec)
[   28.307139] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   28.313233] ata1: limiting SATA link speed to 1.5 Gbps
[   30.523059] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)


modprobe sata_sil msi=1

[   92.984120] sata_sil24 0001:03:00.0: version 1.1
[   92.988897] irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to
virtual irq 41
[   92.996229] sata_sil24 0001:03:00.0: Using MSI
[   93.000675] sata_sil24 0001:03:00.0: enabling bus mastering
[   93.011628] scsi2 : sata_sil24
[   93.022463] scsi3 : sata_sil24
[   93.025695] ata3: SATA max UDMA/100 host m128@0xc0000000 port
0xc0004000 irq 41
[   93.033023] ata4: SATA max UDMA/100 host m128@0xc0000000 port
0xc0006000 irq 41
[   95.203029] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   95.209045] ata3: spurious interrupt (slot_stat 0x0 active_tag
-84148995 sactive 0x0)
[   95.217171] ata3.00: ATA-7: INTEL SSDSA2M080G2GN, 2CV102HD, max UDMA/133
[   95.223882] ata3.00: 156301488 sectors, multi 1: LBA48 NCQ (depth 31/32)
[   95.230905] ata3.00: configured for UDMA/100
[   95.235399] scsi 2:0:0:0: Direct-Access     ATA      INTEL
SSDSA2M080 2CV1 PQ: 0 ANSI: 5
[   95.244002] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   95.252041] sd 2:0:0:0: [sda] 156301488 512-byte logical blocks:
(80.0 GB/74.5 GiB)
[   95.260219] sd 2:0:0:0: [sda] Write Protect is off
[   95.265063] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   95.270500] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   95.283779]  sda: sda1 sda2 sda3 sda4
[   95.289482] sd 2:0:0:0: [sda] Attached SCSI disk
[   95.965897] EXT3-fs: barriers not enabled
[   95.977279] kjournald starting.  Commit interval 5 seconds
[   95.983296] EXT3-fs (sda2): using internal journal
[   95.988143] EXT3-fs (sda2): recovery complete
[   95.992504] EXT3-fs (sda2): mounted filesystem with writeback data mode
[   96.111587] NTFS volume version 3.1.
[   97.331005] ata4: SATA link down (SStatus 0 SControl 0)

root@p1020rdb:~# dd if=/dev/sda of=/dev/null bs=4k count=1000
1000+0 records in
1000+0 records out
4096000 bytes (4.1 MB) copied, 0.0315629 s, 130 MB/s
root@p1020rdb:~# dd if=/dev/sda of=/dev/null bs=4k count=10000
10000+0 records in
10000+0 records out
40960000 bytes (41 MB) copied, 0.471802 s, 86.8 MB/s

root@p1020rdb:~# dd if=/dev/sda of=/dev/null bs=4k count=100000

That stalls, I see the controller fail. See dmesg below:

^C^Cdd: reading `/dev/sda': Input/output error
51804+0 records in
51804+0 records out
212189184 bytes (212 MB) copied, 85.6537 s, 2.5 MB/s
dd: closing input file `/dev/sda': Bad file descriptor


[   92.984120] sata_sil24 0001:03:00.0: version 1.1
[   92.988897] irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to
virtual irq 41
[   92.996229] sata_sil24 0001:03:00.0: Using MSI
[   93.000675] sata_sil24 0001:03:00.0: enabling bus mastering
[   93.011628] scsi2 : sata_sil24
[   93.022463] scsi3 : sata_sil24
[   93.025695] ata3: SATA max UDMA/100 host m128@0xc0000000 port
0xc0004000 irq 41
[   93.033023] ata4: SATA max UDMA/100 host m128@0xc0000000 port
0xc0006000 irq 41
[   95.203029] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   95.209045] ata3: spurious interrupt (slot_stat 0x0 active_tag
-84148995 sactive 0x0)
[   95.217171] ata3.00: ATA-7: INTEL SSDSA2M080G2GN, 2CV102HD, max UDMA/133
[   95.223882] ata3.00: 156301488 sectors, multi 1: LBA48 NCQ (depth 31/32)
[   95.230905] ata3.00: configured for UDMA/100
[   95.235399] scsi 2:0:0:0: Direct-Access     ATA      INTEL
SSDSA2M080 2CV1 PQ: 0 ANSI: 5
[   95.244002] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   95.252041] sd 2:0:0:0: [sda] 156301488 512-byte logical blocks:
(80.0 GB/74.5 GiB)
[   95.260219] sd 2:0:0:0: [sda] Write Protect is off
[   95.265063] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   95.270500] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   95.283779]  sda: sda1 sda2 sda3 sda4
[   95.289482] sd 2:0:0:0: [sda] Attached SCSI disk
[   95.965897] EXT3-fs: barriers not enabled
[   95.977279] kjournald starting.  Commit interval 5 seconds
[   95.983296] EXT3-fs (sda2): using internal journal
[   95.988143] EXT3-fs (sda2): recovery complete
[   95.992504] EXT3-fs (sda2): mounted filesystem with writeback data mode
[   96.111587] NTFS volume version 3.1.
[   97.331005] ata4: SATA link down (SStatus 0 SControl 0)
[  285.891036] ata3.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
[  285.898099] ata3.00: failed command: READ FPDMA QUEUED
[  285.903250] ata3.00: cmd 60/00:00:e0:53:06/01:00:00:00:00/40 tag 0
ncq 131072 in
[  285.903255]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  285.918028] ata3.00: status: { DRDY }
[  285.921689] ata3.00: failed command: READ FPDMA QUEUED
[  285.926836] ata3.00: cmd 60/00:08:e0:52:06/01:00:00:00:00/40 tag 1
ncq 131072 in
[  285.926841]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  285.941615] ata3.00: status: { DRDY }
[  285.945281] ata3: hard resetting link
[  288.055034] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  293.058999] ata3.00: qc timeout (cmd 0xec)
[  293.063106] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  293.069198] ata3.00: revalidation failed (errno=-5)
[  293.074077] ata3: hard resetting link
[  295.259018] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)

What can I do next to investigate and help fix this issue?


Regards,
-- 
Leon

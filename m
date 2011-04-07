Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62636B6F44
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 02:53:00 +1000 (EST)
Received: by pvg16 with SMTP id 16so1530887pvg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Apr 2011 09:52:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87416BDD0@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
	<4D9CAD1F.6060500@garzik.org>
	<BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416BDD0@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Thu, 7 Apr 2011 18:52:55 +0200
Message-ID: <BANLkTin1KoJ8EsV49naEAZjmq=EZLHXZpQ@mail.gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Tejun Heo <htejun@gmail.com>,
	Jeff Garzik <jeff@garzik.org>, "Moffett,
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

Hello Prabhakar,

thanks for your response. My answer below:

On Thu, Apr 7, 2011 at 6:48 AM, Kushwaha Prabhakar-B32579
<B32579@freescale.com> wrote:
> Hi Leon,
>
> Can you please check p2020rdb.dts for IDSEL entries for pci0/1 node?
>
> In order to work in legacy mode, IDSEL entries are required.
>
No, the p1020rdb and p2020rdb do not have the IDSEL entries:

http://lxr.linux.no/#linux+v2.6.38/arch/powerpc/boot/dts/p2020rdb.dts

whereas the p2020ds has:

http://lxr.linux.no/#linux+v2.6.38/arch/powerpc/boot/dts/p2020ds.dts


What would the correct IDSEL entries be?

Also, did you see the reference to Felix' thread?
"Problem with mini-PCI-E slot on P2020RDB"

Best regards,

Leon.


> --Prabhakar
>
>> -----Original Message-----
>> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>> owner@vger.kernel.org] On Behalf Of Leon Woestenberg
>> Sent: Thursday, April 07, 2011 12:20 AM
>> To: Jeff Garzik
>> Cc: Moffett, Kyle D; Linux PPC; linux-ide@vger.kernel.org; Tejun Heo
>> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>>
>> Hello Jeff, all,
>>
>> On Wed, Apr 6, 2011 at 8:12 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> > On 04/06/2011 01:48 PM, Moffett, Kyle D wrote:
>> >> On Apr 06, 2011, at 13:00, Leon Woestenberg wrote:
>> >>> after investigating problems with sata_sil24.c on a freescale p2020
>> >>> soc, I wonder if this driver works on powerpc at all?
>> >>>
>> >>> Does anyone know of a working setup of sata_sil24 on a big endian
>> >>> powerpc system?
>> >>
>> >> Our P2020 boards work fine with legacy PCI interrupts (I think it's a
>> >> sil3124 over PCI-E); the only deficiency is that MSI does not seem to
>> work.
>> >>
>> >
>> > We've definitely had issues with sata_sil24 + MSI, also...
>> >
>> > sata_sil24 does work on big endian in general.
>> >
>>
>> On my system, I have the contrary to Kyle's experience (thanks for
>> sharing).
>>
>> PowerPC P2020RDB
>> vanilla 2.6.38
>> Sil3132 on mini-PCI Express card
>>
>>
>> Enabling msi gets me further than disabling it (default).
>>
>> modprobe sata_sil
>>
>> [ =A0 =A08.834613] sata_sil24 0001:03:00.0: version 1.1
>> [ =A0 =A08.885581] scsi0 : sata_sil24
>> [ =A0 =A08.901420] scsi1 : sata_sil24
>> [ =A0 =A08.904642] ata1: SATA max UDMA/100 host m128@0xc0000000 port
>> 0xc0004000 irq 16
>> [ =A0 =A08.911961] ata2: SATA max UDMA/100 host m128@0xc0000000 port
>> 0xc0006000 irq 16
>> [ =A0 11.095127] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [ =A0 14.906986] eth0: no IPv6 routers present
>> [ =A0 16.099016] ata1.00: qc timeout (cmd 0xec)
>> [ =A0 16.103128] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
>> [ =A0 18.299050] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [ =A0 28.303026] ata1.00: qc timeout (cmd 0xec)
>> [ =A0 28.307139] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
>> [ =A0 28.313233] ata1: limiting SATA link speed to 1.5 Gbps
>> [ =A0 30.523059] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
>>
>>
>> modprobe sata_sil msi=3D1
>>
>> [ =A0 92.984120] sata_sil24 0001:03:00.0: version 1.1
>> [ =A0 92.988897] irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to
>> virtual irq 41
>> [ =A0 92.996229] sata_sil24 0001:03:00.0: Using MSI
>> [ =A0 93.000675] sata_sil24 0001:03:00.0: enabling bus mastering
>> [ =A0 93.011628] scsi2 : sata_sil24
>> [ =A0 93.022463] scsi3 : sata_sil24
>> [ =A0 93.025695] ata3: SATA max UDMA/100 host m128@0xc0000000 port
>> 0xc0004000 irq 41
>> [ =A0 93.033023] ata4: SATA max UDMA/100 host m128@0xc0000000 port
>> 0xc0006000 irq 41
>> [ =A0 95.203029] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [ =A0 95.209045] ata3: spurious interrupt (slot_stat 0x0 active_tag
>> -84148995 sactive 0x0)
>> [ =A0 95.217171] ata3.00: ATA-7: INTEL SSDSA2M080G2GN, 2CV102HD, max
>> UDMA/133
>> [ =A0 95.223882] ata3.00: 156301488 sectors, multi 1: LBA48 NCQ (depth
>> 31/32)
>> [ =A0 95.230905] ata3.00: configured for UDMA/100
>> [ =A0 95.235399] scsi 2:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0INTE=
L
>> SSDSA2M080 2CV1 PQ: 0 ANSI: 5
>> [ =A0 95.244002] sd 2:0:0:0: Attached scsi generic sg0 type 0
>> [ =A0 95.252041] sd 2:0:0:0: [sda] 156301488 512-byte logical blocks:
>> (80.0 GB/74.5 GiB)
>> [ =A0 95.260219] sd 2:0:0:0: [sda] Write Protect is off
>> [ =A0 95.265063] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [ =A0 95.270500] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>> [ =A0 95.283779] =A0sda: sda1 sda2 sda3 sda4
>> [ =A0 95.289482] sd 2:0:0:0: [sda] Attached SCSI disk
>> [ =A0 95.965897] EXT3-fs: barriers not enabled
>> [ =A0 95.977279] kjournald starting. =A0Commit interval 5 seconds
>> [ =A0 95.983296] EXT3-fs (sda2): using internal journal
>> [ =A0 95.988143] EXT3-fs (sda2): recovery complete
>> [ =A0 95.992504] EXT3-fs (sda2): mounted filesystem with writeback data
>> mode
>> [ =A0 96.111587] NTFS volume version 3.1.
>> [ =A0 97.331005] ata4: SATA link down (SStatus 0 SControl 0)
>>
>> root@p1020rdb:~# dd if=3D/dev/sda of=3D/dev/null bs=3D4k count=3D1000
>> 1000+0 records in
>> 1000+0 records out
>> 4096000 bytes (4.1 MB) copied, 0.0315629 s, 130 MB/s root@p1020rdb:~# dd
>> if=3D/dev/sda of=3D/dev/null bs=3D4k count=3D10000
>> 10000+0 records in
>> 10000+0 records out
>> 40960000 bytes (41 MB) copied, 0.471802 s, 86.8 MB/s
>>
>> root@p1020rdb:~# dd if=3D/dev/sda of=3D/dev/null bs=3D4k count=3D100000
>>
>> That stalls, I see the controller fail. See dmesg below:
>>
>> ^C^Cdd: reading `/dev/sda': Input/output error
>> 51804+0 records in
>> 51804+0 records out
>> 212189184 bytes (212 MB) copied, 85.6537 s, 2.5 MB/s
>> dd: closing input file `/dev/sda': Bad file descriptor
>>
>>
>> [ =A0 92.984120] sata_sil24 0001:03:00.0: version 1.1
>> [ =A0 92.988897] irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to
>> virtual irq 41
>> [ =A0 92.996229] sata_sil24 0001:03:00.0: Using MSI
>> [ =A0 93.000675] sata_sil24 0001:03:00.0: enabling bus mastering
>> [ =A0 93.011628] scsi2 : sata_sil24
>> [ =A0 93.022463] scsi3 : sata_sil24
>> [ =A0 93.025695] ata3: SATA max UDMA/100 host m128@0xc0000000 port
>> 0xc0004000 irq 41
>> [ =A0 93.033023] ata4: SATA max UDMA/100 host m128@0xc0000000 port
>> 0xc0006000 irq 41
>> [ =A0 95.203029] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [ =A0 95.209045] ata3: spurious interrupt (slot_stat 0x0 active_tag
>> -84148995 sactive 0x0)
>> [ =A0 95.217171] ata3.00: ATA-7: INTEL SSDSA2M080G2GN, 2CV102HD, max
>> UDMA/133
>> [ =A0 95.223882] ata3.00: 156301488 sectors, multi 1: LBA48 NCQ (depth
>> 31/32)
>> [ =A0 95.230905] ata3.00: configured for UDMA/100
>> [ =A0 95.235399] scsi 2:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0INTE=
L
>> SSDSA2M080 2CV1 PQ: 0 ANSI: 5
>> [ =A0 95.244002] sd 2:0:0:0: Attached scsi generic sg0 type 0
>> [ =A0 95.252041] sd 2:0:0:0: [sda] 156301488 512-byte logical blocks:
>> (80.0 GB/74.5 GiB)
>> [ =A0 95.260219] sd 2:0:0:0: [sda] Write Protect is off
>> [ =A0 95.265063] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [ =A0 95.270500] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>> [ =A0 95.283779] =A0sda: sda1 sda2 sda3 sda4
>> [ =A0 95.289482] sd 2:0:0:0: [sda] Attached SCSI disk
>> [ =A0 95.965897] EXT3-fs: barriers not enabled
>> [ =A0 95.977279] kjournald starting. =A0Commit interval 5 seconds
>> [ =A0 95.983296] EXT3-fs (sda2): using internal journal
>> [ =A0 95.988143] EXT3-fs (sda2): recovery complete
>> [ =A0 95.992504] EXT3-fs (sda2): mounted filesystem with writeback data
>> mode
>> [ =A0 96.111587] NTFS volume version 3.1.
>> [ =A0 97.331005] ata4: SATA link down (SStatus 0 SControl 0)
>> [ =A0285.891036] ata3.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0=
x6
>> frozen [ =A0285.898099] ata3.00: failed command: READ FPDMA QUEUED [
>> 285.903250] ata3.00: cmd 60/00:00:e0:53:06/01:00:00:00:00/40 tag 0 ncq
>> 131072 in
>> [ =A0285.903255] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:00=
/00 Emask
>> 0x4 (timeout)
>> [ =A0285.918028] ata3.00: status: { DRDY } [ =A0285.921689] ata3.00: fai=
led
>> command: READ FPDMA QUEUED [ =A0285.926836] ata3.00: cmd
>> 60/00:08:e0:52:06/01:00:00:00:00/40 tag 1 ncq 131072 in
>> [ =A0285.926841] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:00=
/00 Emask
>> 0x4 (timeout)
>> [ =A0285.941615] ata3.00: status: { DRDY } [ =A0285.945281] ata3: hard
>> resetting link [ =A0288.055034] ata3: SATA link up 3.0 Gbps (SStatus 123
>> SControl 0) [ =A0293.058999] ata3.00: qc timeout (cmd 0xec) [ =A0293.063=
106]
>> ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x4) [ =A0293.069198]
>> ata3.00: revalidation failed (errno=3D-5) [ =A0293.074077] ata3: hard
>> resetting link [ =A0295.259018] ata3: SATA link up 3.0 Gbps (SStatus 123
>> SControl 0)
>>
>> What can I do next to investigate and help fix this issue?
>>
>>
>> Regards,
>> --
>> Leon
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
>
>
>



--=20
Leon

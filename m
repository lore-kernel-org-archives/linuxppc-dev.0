Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id D7CFFDE4B3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 22:10:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH]: [MPC5200] Add ATA DMA support
Date: Wed, 6 Aug 2008 11:58:26 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB03202EDF@is-hdq-exchange.marel.net>
In-Reply-To: <792f5f410806170128k7e435743x9892b559bd32b157@mail.gmail.com>
References: <792f5f410806170128k7e435743x9892b559bd32b157@mail.gmail.com>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Tim Yamin" <plasm@roo.me.uk>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Tim Yamin wrote:
> This patch adds MDMA/UDMA support (using BestComm for DMA) on the
> MPC5200 platform.=20
>=20
> Based heavily on previous work by Freescale (Bernard Kuhn, John
> Rigby) and Domen Puncer.=20
>=20
> Using a SanDisk Extreme IV CF card I get read speeds of approximately
> 26.70 MB/sec.=20
>=20
> The BestComm ATA task priority was changed to maximum in
> bestcomm_priv.h; this fixes a deadlock issue I was experiencing when
> heavy DMA was occuring on both the ATA and Ethernet BestComm tasks,
> e.g. when downloading a large file over a LAN to disk.  =20
>=20
> There's also what I believe to be a hardware bug if you have high
> levels of BestComm ATA DMA activity along with heavy LocalPlus Bus
> activity; the address bus seems to sometimes get corrupted with ATA
> commands while the LocalPlus Bus operation is still active (i.e. Chip
> Select is asserted).   =20
>=20
> I've asked Freescale about this but have not received a reply yet --
> if anybody from Freescale has any ideas please contact me; I can
> supply some analyzer traces if needed. Therefore, for now, do not
> enable DMA if you need reliable LocalPlus Bus unless you do a fixup
> in your driver as follows:  =20
>=20
> Locking example:
>=20
>         while (test_and_set_bit(0, &pata_mpc52xx_ata_dma_lock) !=3D 0)
>         {
>                 struct bcom_task_2 *tsk =3D pata_mpc52xx_ata_dma_task;
>=20
>                 if(bcom_buffer_done_2(tsk))
>                         return 1;
>         }
>=20
> 	return 0;
>=20
> (Save the return value to `flags`)
>=20
> Unlocking example:
>=20
>         if(flags =3D=3D 0)
>                 clear_bit(0, &pata_mpc52xx_ata_dma_lock);
>=20
> Comments and testing would of course be very welcome.
>=20
> Thanks,
>=20
> Signed-off-by: Tim Yamin <plasm@roo.me.uk>

Sorry for testing this patch so late, but I get these if I apply your
patch to 2.6.24.7 and use it with my Sandisk Extreme IV 4GB card:

...
[    0.999514] ata: MPC52xx IDE/ATA libata driver
[    1.006666] scsi0 : mpc52xx_ata
[    1.010969] ata1: PATA max UDMA/33 ata_regs 0xf0003a00 irq 135
[    1.168588] ata1.00: CFA: SanDisk SDCFX3-4096, HDX 4.31, max MWDMA2
[    1.175156] ata1.00: 8027712 sectors, multi 0: LBA
[    1.181098] ata1.00: configured for MWDMA2
[    1.196589] scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFX3-4
HDX  PQ: 0 ANSI: 5
[    1.206949] sd 0:0:0:0: [sda] 8027712 512-byte hardware sectors (4110
MB)
[    1.214281] sd 0:0:0:0: [sda] Write Protect is off
[    1.219803] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    1.230407] sd 0:0:0:0: [sda] 8027712 512-byte hardware sectors (4110
MB)
[    1.237678] sd 0:0:0:0: [sda] Write Protect is off
[    1.243129] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    1.252684]  sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
[   31.260361] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
dma 4096 in
[   31.260377]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[   31.275689] ata1.00: status: { DRDY }
[   31.279545] ata1: soft resetting link
[   31.435535] ata1.00: configured for MWDMA2
[   31.439933] ata1: EH complete
[   61.443060] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
[   61.450451] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
dma 4096 in
[   61.450467]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[   61.465777] ata1.00: status: { DRDY }
[   61.469632] ata1: soft resetting link
[   61.625541] ata1.00: configured for MWDMA2
[   61.629938] ata1: EH complete

...
[  363.394140] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
[  363.401534] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
dma 4096 in
[  363.401550]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  363.416889] ata1.00: status: { DRDY }
[  363.420717] ata1: soft resetting link
[  363.576538] ata1.00: configured for MWDMA1
[  363.580927] sd 0:0:0:0: [sda] Result: hostbyte=3D0x00 =
driverbyte=3D0x08
[  363.587499] sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
[  363.594157] Descriptor sense data with sense descriptors (in hex):
[  363.600593]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[  363.607248]         00 00 00 00
[  363.610615] sd 0:0:0:0: [sda] ASC=3D0x0 ASCQ=3D0x0
[  363.615334] end_request: I/O error, dev sda, sector 0
[  363.620600] Buffer I/O error on device sda, logical block 0
[  363.626475]  unable to read partition table
[  363.631014] ata1: EH complete
[  363.635081] sd 0:0:0:0: [sda] Attached SCSI removable disk


And if I boot via NFS, the kernel can continue to boot after that point.

With a non-DMA card everything is fine.


Best regards,

Daniel.

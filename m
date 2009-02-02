Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail2.HSTX.com (mail2.hstx.com [64.95.133.110])
	by ozlabs.org (Postfix) with ESMTP id 16991DDFAC
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 07:39:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Can not get PATA to work for Compact Flash with 2.6.28 kernel
Date: Mon, 2 Feb 2009 12:39:33 -0800
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B9@exchtxus2.HSTX.global.vpn>
In-Reply-To: <49872152.1050902@harris.com>
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
	<49870A66.8030302@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B7@exchtxus2.HSTX.global.vpn>
	<49872152.1050902@harris.com>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: "Steven A. Falco" <sfalco@harris.com>,
	"Aaron Pace" <kodiakuppercut@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven/Aaron,

I found the problem. On my board, the CF is on a 16 bit interface on bus
of MPC8248. The HW is connected in Big Endian format. PPC Bit D0 is
connected to CF Bit D15, and PPC D1 to CF Bit D14, till PPC D0 to CF
D15. I had to swap the bytes in u-boot. I forgot to do it in Kernel.=20

After making the change, CF is detected. But I can not access /dev/hda
or any scsi/sda devices under /dev.=20

# cd /dev
# ls *hd*
hda    hda10  hda12  hda14  hda16  hda3   hda5   hda7   hda9
hda1   hda11  hda13  hda15  hda2   hda4   hda6   hda8
# ls *sda*
ls: *sda*: No such file or directory
# ls *scsi*
ls: *scsi*: No such file or directory
# mount -t msdos /dev/hda /mnt
mount: mounting /dev/hda on /mnt failed: No such device or address

Any insights/suggestions?

I am not sure if I need to use CONFIG_BLK_DEV_SD=3Dy. I use it anyway, =
and
saw
Driver 'sd' needs updating - please use bus_type methods
On console.=20

I don't know how to fix this.

This is the console output about ATA:

Driver 'sd' needs updating - please use bus_type methods
ata_host_alloc: ENTER
ata_port_alloc: ENTER
__ata_port_freeze: ata4294967295 port frozen
scsi0 : pata_platform
ata1: PATA max PIO6 no IRQ, using PIO polling mmio cmd 0x30000000 ctl
0x4000000c
ata_host_register: probe begin
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
ata_sff_softreset: ENTER
ata_sff_softreset: about to softreset, devmask=3D3
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_sff_softreset: EXIT, classes[0]=3D1 [1]=3D9
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xA0
ata_sff_exec_command: ata1: cmd 0xEC
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_dump_id: 49=3D=3D0x0300  53=3D=3D0x0003  63=3D=3D0x0407  =
64=3D=3D0x0003  75=3D=3D0x0000
ata_dump_id: 80=3D=3D0x0400  81=3D=3D0x0000  82=3D=3D0x0000  =
83=3D=3D0x0000  84=3D=3D0x0000
ata_dump_id: 88=3D=3D0x0000  93=3D=3D0x0000
ata1.00: CFA: SanDisk SDCFJ-128, HDX 2.27, max MWDMA2
ata1.00: 250880 sectors, multi 0: LBA
ata1.00: configured for PIO
ata_eh_recover: EXIT, rc=3D0
ata_scsi_error: EXIT
ata_host_register: host probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 00 00 00
ata_scsiop_inq_std: ENTER
scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFJ-12 HDX  PQ: 0
ANSI: 5
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
sd 0:0:0:0: [sda] 250880 512-byte hardware sectors: (128 MB/122 MiB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write Protect is off
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DP
O or FUA
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 01 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
sd 0:0:0:0: [sda] 250880 512-byte hardware sectors: (128 MB/122 MiB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write Protect is off
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DP
O or FUA
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0x20
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
 sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ics1893_config_init() successful
ADDRCONF(NETDEV_UP): eth0: link is not ready
ics1893_config_init() successful
IP-Config: Complete:
     device=3Deth0, addr=3D172.20.16.150, mask=3D255.255.255.0,
gw=3D172.20.16.1,
     host=3Dtr5000v2, domain=3D, nis-domain=3D(none),
     bootserver=3D10.15.34.196, rootserver=3D10.15.34.196, rootpath=3D
Looking up port of RPC 100003/2 on 10.15.34.196
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Looking up port of RPC 100005/1 on 10.15.34.196
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 164k init
### Application running ...
#


These are the changes I had to make in drivers/ata/libata-sff.c.
TR5000V2 is my board config define.

#if defined(CONFIG_TR5000V2)
static void inline ide_outb (u8 val, void __iomem *addr)
{
   asm("eieio");
   *(ushort *)addr =3D val;
   asm("eieio");
   asm("sync");
}

static unsigned char inline ide_inb(void __iomem *addr)
{
   ushort data16;
   data16 =3D *(volatile ushort *)(addr);
   asm("eieio");=20
   asm("sync");
   return data16;
}


static void ide_read16_rep(void __iomem *addr, void *dst, unsigned long
ulcount)
{
   const volatile u16 __iomem *port =3D addr;
   void *buf =3D dst;
   long count =3D ulcount;
   u16 *tbuf =3D buf;
   u16 tmp;

   if (unlikely(count <=3D 0))
      return;
   asm volatile("sync");
   do {
      tmp =3D *port;
      eieio();
      *tbuf++ =3D tmp>>8 | tmp<<8;
   } while (--count !=3D 0);
   asm volatile("twi 0,%0,0; isync" : : "r" (tmp));
}

static void ide_write16_rep(void __iomem *addr, const void *src,
unsigned long ulcount)
{
   volatile u16 __iomem *port =3D addr;
   const void *buf =3D src;
   long count =3D ulcount;  =20
   const u16 *tbuf =3D buf;

   if (unlikely(count <=3D 0))
      return;
   asm volatile("sync");
   do {
      *port =3D *tbuf<<8 | *tbuf>>8;
      tbuf++;
   } while (--count !=3D 0);
   asm volatile("sync");
}

#define ioread8(X) ide_inb(X)
#define iowrite8(X, Y) ide_outb(X, Y)
#define ioread16_rep(X, Y, Z) ide_read16_rep(X, Y, Z)
#define iowrite16_rep(X, Y, Z) ide_write16_rep(X, Y, Z)
#endif

=20
Thanks very much!

Lixin

-----Original Message-----
From: Steven A. Falco [mailto:sfalco@harris.com]=20
Sent: Monday, February 02, 2009 11:38 AM
To: Lixin Yao
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28
kernel

Lixin Yao wrote:
> Hello, Steven,
>=20
> I realized that and made change, I use reg-shift of 1 which u-boot
uses
> and works for the CF.
>=20
> localbus@f0010100 {
>       #address-cells =3D <2>;                  =20
>       #size-cells =3D <1>;
>       compatible =3D "fsl,mpc8248-localbus",   =20
>                    "fsl,pq2-localbus",
>                    "simple-bus";=20
>       reg =3D <0xf0010100 0x40>;               =20
>       ranges =3D <0x3 0x0 0x30000000 0x10000   =20
>                 0x4 0x0 0x40000000 0x10000>; =20
>=20
>       pata@3,0 {
>          compatible =3D "fsl,tr5000v2-pata", "ata-generic";
>          reg =3D <0x3 0x0 0x10 0x4 0xC 0x2>;  =20
>          reg-shift =3D <1>;                   =20
>          pio-mode =3D <6>;                    =20
>          // interrupts =3D <0x19 0x8>;        =20
>          // interrupt-parent =3D <&PIC>;      =20
>       };
>=20
>=20
> U-Boot (1.3.4) shows this:
>=20
> bus 0: OK
>   Device 0: Model: SanDisk SDCFJ-128 Firm: HDX 2.27 Ser#:
> 116904C2505X4026
>             Type: Removable Hard Disk
>             Capacity: 122.5 MB =3D 0.1 GB (250880 x 512)
>=20
>=20
> This is the console output after setting reg =3D <0x3 0x0 0x10 0x4 0xC
> 0x2>:
>=20
> ata_host_alloc: ENTER
> ata_port_alloc: ENTER
> __ata_port_freeze: ata4294967295 port frozen
> scsi0 : pata_platform
> ata1: PATA max PIO6 no IRQ, using PIO polling mmio cmd 0x30000000 ctl
> 0x4000000c

On my board, I get the following:

ata1: PATA max PIO6 mmio cmd 0x1c1000000 ctl 0x1c1000098 irq 32

Note that the addresses I provided got turned into 36-bit addresses
because I am using a PPC440EPx chip.

I am suspicious of the addresses you got, but I don't know enough
about how the mpc8248 sets up its memory map.  Perhaps someone with
knowledge of that chip can comment.

Have you hooked a logic analyzer to the device?  You should be sure
that the chip selects are really responding at the reported addresses.

Since the CF works with Uboot, at least we know the hardware is good.

	Steve


> ata_host_register: probe begin
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_link_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata1 port frozen
> ata_sff_softreset: ENTER
> ata_sff_softreset: about to softreset, devmask=3D0
> ata_bus_softreset: ata1: bus reset via SRST
> ata_sff_softreset: EXIT, classes[0]=3D9 [1]=3D9
> ata_eh_thaw_port: ata1 port thawed
> ata_std_postreset: ENTER
> ata_std_postreset: EXIT
> ata_sff_postreset: EXIT, no device
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=3D0
> ata_scsi_error: EXIT
> ata_host_register: host probe begin
> TCP cubic registered
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> ics1893_config_init() successful
> ADDRCONF(NETDEV_UP): eth0: link is not ready
> ics1893_config_init() successful
> IP-Config: Complete:
>      device=3Deth0, addr=3D172.20.16.150, mask=3D255.255.255.0,
> gw=3D172.20.16.1,
>      host=3Dtr5000v2, domain=3D, nis-domain=3D(none),
>      bootserver=3D10.15.34.196, rootserver=3D10.15.34.196, rootpath=3D
> Looking up port of RPC 100003/2 on 10.15.34.196
> ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> Looking up port of RPC 100005/1 on 10.15.34.196
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 164k init
> ### Application running ...
>=20
> =20
> The San Disk CF is still not found.
>=20
> Any more insights/ideas?
>=20
> Thank you and I appreciate your help!
>=20
> Lixin

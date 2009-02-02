Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail.hstx.com (mail.hstx.com [64.95.133.106])
	by ozlabs.org (Postfix) with ESMTP id B52ECDDDED
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 02:52:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Can not get PATA to work for Compact Flash with 2.6.28 kernel
Date: Mon, 2 Feb 2009 07:52:32 -0800
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B7@exchtxus2.HSTX.global.vpn>
In-Reply-To: <49870A66.8030302@harris.com>
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
	<49870A66.8030302@harris.com>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: "Steven A. Falco" <sfalco@harris.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, Steven,

I realized that and made change, I use reg-shift of 1 which u-boot uses
and works for the CF.

localbus@f0010100 {
      #address-cells =3D <2>;                  =20
      #size-cells =3D <1>;
      compatible =3D "fsl,mpc8248-localbus",   =20
                   "fsl,pq2-localbus",
                   "simple-bus";=20
      reg =3D <0xf0010100 0x40>;               =20
      ranges =3D <0x3 0x0 0x30000000 0x10000   =20
                0x4 0x0 0x40000000 0x10000>; =20

      pata@3,0 {
         compatible =3D "fsl,tr5000v2-pata", "ata-generic";
         reg =3D <0x3 0x0 0x10 0x4 0xC 0x2>;  =20
         reg-shift =3D <1>;                   =20
         pio-mode =3D <6>;                    =20
         // interrupts =3D <0x19 0x8>;        =20
         // interrupt-parent =3D <&PIC>;      =20
      };


U-Boot (1.3.4) shows this:

bus 0: OK
  Device 0: Model: SanDisk SDCFJ-128 Firm: HDX 2.27 Ser#:
116904C2505X4026
            Type: Removable Hard Disk
            Capacity: 122.5 MB =3D 0.1 GB (250880 x 512)


This is the console output after setting reg =3D <0x3 0x0 0x10 0x4 0xC
0x2>:

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
ata_sff_softreset: about to softreset, devmask=3D0
ata_bus_softreset: ata1: bus reset via SRST
ata_sff_softreset: EXIT, classes[0]=3D9 [1]=3D9
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_sff_postreset: EXIT, no device
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=3D0
ata_scsi_error: EXIT
ata_host_register: host probe begin
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

=20
The San Disk CF is still not found.

Any more insights/ideas?

Thank you and I appreciate your help!

Lixin

-----Original Message-----
From: Steven A. Falco [mailto:sfalco@harris.com]=20
Sent: Monday, February 02, 2009 10:00 AM
To: Lixin Yao
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28
kernel

Lixin Yao wrote:
>=20
>=20
> I use a San Disk compact flash (CF) card on a board with MPC8248
> processor. The CF is connected to data and address bus of the
processor
> and operates in TRUE IDE mode. The registers are memory mapped. I can
> read the file system on the CF in u-boot (1.3.4). U-boot can identify
> the CF and mount file system correctly.
>=20
> The hardware is known good hardware.
>=20
> I use 2.6.28 kernel and configured support for PATA for the CF.

The second register set does not start at register 0.  It starts
at register 6.  We are using 1 chip select from the processor,
and generate two chip selects to the CF that are 0x80 apart (on
a sequoia board).

So here is what I am using on the modified sequoia board.  Note
the 0x00000098 - you might think it should be 0x00000080 as per
the discussion above, but because the second register set starts
at 6, you have to build that into the address. =20

pata@1,0 {
compatible =3D "harris,hydra_temp-pata", "ata-generic";
bank-width =3D <2>;
reg =3D <0x00000001 0x00000000 0x00000020 0x00000001 0x00000098
0x00000004>;
reg-shift =3D <2>;
pio-mode =3D <6>;
interrupt-parent =3D <&UIC0>;
interrupts =3D <0x1b 0x4>;
};

	Steve
